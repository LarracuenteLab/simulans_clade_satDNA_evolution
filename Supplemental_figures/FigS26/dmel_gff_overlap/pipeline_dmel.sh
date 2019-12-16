#!/bin/bash
#SBATCH -J dmel_pipeline
#SBATCH -p debug
#SBATCH -t 00-01:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH -c 1
#SBATCH --mem=4gb
#SBATCH --mail-user=negm@rochester.edu
#SBATCH --mail-type=ALL

module load R

Rscript attribute_analysis.R

sed -i -e 's/i=1/i=2/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_1/dmel_analysis_motif_2/g' attribute_analysis.R
sed -i -e 's/name<-1/name<-2/g' attribute_analysis.R

Rscript attribute_analysis.R


sed -i -e 's/i=2/i=3/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_2/dmel_analysis_motif_3/g' attribute_analysis.R
sed -i -e 's/name<-2/name<-3/g' attribute_analysis.R

Rscript attribute_analysis.R

sed -i -e 's/i=3/i=4/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_3/dmel_analysis_motif_4/g' attribute_analysis.R
sed -i -e 's/name<-3/name<-4/g' attribute_analysis.R

Rscript attribute_analysis.R


sed -i -e 's/i=4/i=5/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_4/dmel_analysis_motif_5/g' attribute_analysis.R
sed -i -e 's/name<-4/name<-5/g' attribute_analysis.R

Rscript attribute_analysis.R

sed -i -e 's/i=5/i=6/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_5/dmel_analysis_motif_6/g' attribute_analysis.R
sed -i -e 's/name<-5/name<-6/g' attribute_analysis.R

Rscript attribute_analysis.R

sed -i -e 's/i=6/i=7/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_6/dmel_analysis_motif_7/g' attribute_analysis.R
sed -i -e 's/name<-6/name<-7/g' attribute_analysis.R

Rscript attribute_analysis.R

sed -i -e 's/i=7/i=8/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_7/dmel_analysis_motif_8/g' attribute_analysis.R
sed -i -e 's/name<-7/name<-8/g' attribute_analysis.R

Rscript attribute_analysis.R


sed -i -e 's/i=8/i=9/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_8/dmel_analysis_motif_9/g' attribute_analysis.R
sed -i -e 's/name<-8/name<-9/g' attribute_analysis.R

Rscript attribute_analysis.R

sed -i -e 's/i=9/i=10/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_9/dmel_analysis_motif_10/g' attribute_analysis.R
sed -i -e 's/name<-9/name<-10/g' attribute_analysis.R

Rscript attribute_analysis.R

sed -i -e 's/i=10/i=11/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_10/dmel_analysis_motif_11/g' attribute_analysis.R
sed -i -e 's/name<-10/name<-11/g' attribute_analysis.R

Rscript attribute_analysis.R

sed -i -e 's/i=11/i=12/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_11/dmel_analysis_motif_12/g' attribute_analysis.R
sed -i -e 's/name<-11/name<-12/g' attribute_analysis.R

Rscript attribute_analysis.R

sed -i -e 's/i=12/i=13/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_12/dmel_analysis_motif_13/g' attribute_analysis.R
sed -i -e 's/name<-12/name<-13/g' attribute_analysis.R

Rscript attribute_analysis.R

sed -i -e 's/i=13/i=14/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_13/dmel_analysis_motif_14/g' attribute_analysis.R
sed -i -e 's/name<-13/name<-14/g' attribute_analysis.R

Rscript attribute_analysis.R


sed -i -e 's/i=14/i=15/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_14/dmel_analysis_motif_15/g' attribute_analysis.R
sed -i -e 's/name<-14/name<-15/g' attribute_analysis.R

Rscript attribute_analysis.R


sed -i -e 's/i=15/i=16/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_15/dmel_analysis_motif_16/g' attribute_analysis.R
sed -i -e 's/name<-15/name<-16/g' attribute_analysis.R

Rscript attribute_analysis.R


sed -i -e 's/i=16/i=17/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_16/dmel_analysis_motif_17/g' attribute_analysis.R
sed -i -e 's/name<-16/name<-17/g' attribute_analysis.R

Rscript attribute_analysis.R

sed -i -e 's/i=17/i=18/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_17/dmel_analysis_motif_18/g' attribute_analysis.R
sed -i -e 's/name<-17/name<-18/g' attribute_analysis.R

Rscript attribute_analysis.R

sed -i -e 's/i=18/i=19/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_18/dmel_analysis_motif_19/g' attribute_analysis.R
sed -i -e 's/name<-18/name<-19/g' attribute_analysis.R

Rscript attribute_analysis.R


sed -i -e 's/i=19/i=20/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_19/dmel_analysis_motif_20/g' attribute_analysis.R
sed -i -e 's/name<-19/name<-20/g' attribute_analysis.R

Rscript attribute_analysis.R



sed -i -e 's/i=20/i=21/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_20/dmel_analysis_motif_21/g' attribute_analysis.R
sed -i -e 's/name<-20/name<-21/g' attribute_analysis.R

Rscript attribute_analysis.R


sed -i -e 's/i=21/i=22/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_21/dmel_analysis_motif_22/g' attribute_analysis.R
sed -i -e 's/name<-21/name<-22/g' attribute_analysis.R

Rscript attribute_analysis.R


sed -i -e 's/i=22/i=23/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_22/dmel_analysis_motif_23/g' attribute_analysis.R
sed -i -e 's/name<-22/name<-23/g' attribute_analysis.R

Rscript attribute_analysis.R


sed -i -e 's/i=21/i=22/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_21/dmel_analysis_motif_22/g' attribute_analysis.R
sed -i -e 's/name<-21/name<-22/g' attribute_analysis.R

Rscript attribute_analysis.R

sed -i -e 's/i=22/i=23/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_22/dmel_analysis_motif_23/g' attribute_analysis.R
sed -i -e 's/name<-22/name<-23/g' attribute_analysis.R

Rscript attribute_analysis.R

sed -i -e 's/i=23/i=24/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_23/dmel_analysis_motif_24/g' attribute_analysis.R
sed -i -e 's/name<-23/name<-24/g' attribute_analysis.R

Rscript attribute_analysis.R

sed -i -e 's/i=24/i=25/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_24/dmel_analysis_motif_25/g' attribute_analysis.R
sed -i -e 's/name<-24/name<-25/g' attribute_analysis.R

Rscript attribute_analysis.R


sed -i -e 's/i=25/i=1/g' attribute_analysis.R
sed -i -e 's/dmel_analysis_motif_25/dmel_analysis_motif_1/g' attribute_analysis.R
sed -i -e 's/name<-25/name<-1/g' attribute_analysis.R



Rscript moti_all_analysis.R


rm dmel_analysis_motif_1.tsv
rm dmel_analysis_motif_2.tsv
rm dmel_analysis_motif_3.tsv
rm dmel_analysis_motif_4.tsv
rm dmel_analysis_motif_5.tsv
rm dmel_analysis_motif_6.tsv
rm dmel_analysis_motif_7.tsv
rm dmel_analysis_motif_8.tsv
rm dmel_analysis_motif_9.tsv
rm dmel_analysis_motif_10.tsv
rm dmel_analysis_motif_11.tsv
rm dmel_analysis_motif_12.tsv
rm dmel_analysis_motif_13.tsv
rm dmel_analysis_motif_14.tsv
rm dmel_analysis_motif_15.tsv
rm dmel_analysis_motif_16.tsv
rm dmel_analysis_motif_17.tsv
rm dmel_analysis_motif_18.tsv
rm dmel_analysis_motif_19.tsv
rm dmel_analysis_motif_20.tsv
rm dmel_analysis_motif_21.tsv
rm dmel_analysis_motif_22.tsv
rm dmel_analysis_motif_23.tsv
rm dmel_analysis_motif_24.tsv
rm dmel_analysis_motif_25.tsv
