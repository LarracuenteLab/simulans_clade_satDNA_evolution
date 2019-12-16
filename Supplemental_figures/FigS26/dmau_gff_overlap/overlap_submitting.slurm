#!/bin/bash
#SBATCH -J snegm_rstudio/1.1.456_2019-01-28
#SBATCH -p interactive
#SBATCH -t 00-10:30:00 
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH -c 22
#SBATCH --mem=44gb
#SBATCH --mail-user=negm@rochester.edu
#SBATCH --mail-type=ALL

module load R
Rscript overlapscript.R
