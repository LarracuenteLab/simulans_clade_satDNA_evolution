#!/bin/bash
#SBATCH -J dsech_overlap
#SBATCH -p interactive
#SBATCH -t 00-10:30:00 
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH -c 22
#SBATCH --mem=44gb
#SBATCH --mail-user=negm@rochester.edu
#SBATCH --mail-type=ALL

module load R
Rscript dsech_overlapscript.R
