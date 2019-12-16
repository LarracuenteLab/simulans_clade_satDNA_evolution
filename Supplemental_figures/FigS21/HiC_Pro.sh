#!/bin/bash
#SBATCH -J HiC
#SBATCH -e HiC.err
#SBATCH -o HiC.out
#SBATCH --mem-per-cpu=10GB
#SBATCH -c 10
#SBATCH -n 1
#SBATCH -t 24:00:00
#SBATCH -p gpu


module load hicpro/2.10.0
module load bowtie2/2.2.9
module load samtools/1.5
module load python
module load juicer/1.5.6
module load juicebox/1.8.8
module load cuda/8.0.61 
module load java


workingdir="HiC"
cd $workingdir || ( echo "can't open the $workingdir"; exit )
echo "Working in dir: $workingdir"


REFERENCEINDEX="dmel-all-chromosome-r6.03.fasta"
digest_site="dmel-all-chromosome-r6.03_dpnii.bed"
chromosome_size="dmel-all-chromosome-r6.03.sizes"
config_hicpro=$workingdir/config-hicpro.txt


if [ -f "$REFERENCEINDEX.1.bt2" ]; then
	echo "Reference index exists. Moving on..."
else
	echo "making index of reference"
	bowtie2-build -f $REFERENCEINDEX $REFERENCEINDEX
fi 


#Digest the reference genome by the provided restriction enzymes(s) and generate a BED file with the list of restriction fragments after digestion.
#Note that the cutting site of the restriction enzyme has to be specified using the ‘^’ character. multiple restriction enzymes can also be provided.
#The restriction enzymes HindIII, DpnII and BglII are encoded within the script and are therefore recognized if specified to the program.
if [ -f "$digest_site" ]; then
	echo "Restriction digestion sites file exits. Moving on..."
else
	echo "Making restriction digestion sites file: $digest_site"
	python /software/hicpro/2.10.0/bin/utils/digest_genome.py -r dpnii -o "$digest_site" "$REFERENCEINDEX"
fi


reads="HiC/embryo_Ogiyama/stage16"


name=$(echo "$reads" | awk -F'/' '{print $(NF-1)}')
samplename=$(echo "$reads" | awk -F'/' '{print $NF}') 
dir_path=$(echo "$reads" | awk -F'/' '{OFS="/"; $NF=""; print $0}')
output=$workingdir/$samplename
echo "Working on prefix $name and read files $samplename"
echo "read path is: $dir_path"

#Split reads is highly recommanded in HiC-pro parallel mode. --nreads default is 20M
python /software/hicpro/2.10.0/bin/utils/split_reads.py --results_folder "$reads" "${raw}_1.fastq.gz"
python /software/hicpro/2.10.0/bin/utils/split_reads.py --results_folder "$reads" "${raw}_2.fastq.gz"
gzip $reads/*

HiC-Pro -p -i "$dir_path" -o "$output" -c "$config_hicpro"

cd $workingdir/$samplename

#Try module load python inside it
sbatch HiCPro_step1_.sh

#wait untill step1 is finished, then run step2, also module load python inside it
sbatch HiCPro_step2_.sh



