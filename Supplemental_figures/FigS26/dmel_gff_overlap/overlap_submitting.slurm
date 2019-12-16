#!/bin/bash
#SBATCH -J dmel_overlap
#SBATCH -p standard
#SBATCH -t 40:00:00 
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH -c 22
#SBATCH --mem=44gb
#SBATCH --mail-user=negm@rochester.edu
#SBATCH --mail-type=ALL

module load R
Rscript overlapscript.R
