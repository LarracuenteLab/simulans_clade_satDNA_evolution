
species="dmel" #change this as needed
awk '$1 ~ "RSP" && $2 >= 2' X_repeat_clusters_v4.txt > temp
sed -i 's/X://g' temp

while read line; do

	name="$(echo $line | awk 'BEGIN{OFS="."}{print $1,$12}')"
	

	start="$(echo $line | awk '{split($7,arr,"-")} {print arr[1]}')"
	end="$(echo $line | awk '{split($7,arr,"-")} {print arr[2]}')"

	testi="$(awk -v start="$start" -v end="$end" '{if($4>=start && $5<=end) print $1":"$4"-"$5}' /scratch/alarracu_lab/sim_clade_assemblies/0413/final_annotations/${species}/X_contig_final.gff | xargs samtools faidx /scratch/dkhost/dmel_r6.03/dmel-all-chromosome-r6.03.fasta | sed "s/>X:/>$name.X:/")" 
	echo $testi >> ${species}_Xchrom_rsp_clusters_min2_cytoband.fasta


done < temp

sed -i 's/ /\n/g' ${species}_Xchrom_rsp_clusters_min2_cytoband.fasta
