#!/bin/bash
#SBATCH -J tree
#SBATCH -e tree.err%j
#SBATCH -o tree.out%j
#SBATCH --mem-per-cpu=10gb
#SBATCH -t 300:00:00
#SBATCH -n 1
#SBATCH -c 12
#SBATCH -p charlesworths --qos charlesworths
#SBATCH --mail-user=dkhost@ur.rochester.edu
#SBATCH --mail-type=ALL


module load raxml


raxmlHPC-PTHREADS -s allspecies_dere_Xchrom_1.688_clusters_min2_cytoband.MAAFT.phy -n allspecies_dere_Xchrom_1.688_clusters_min2_cytoband.MAAFT -m GTRGAMMA -T12 -p 12345 -# 100 -x 12345 -f a
