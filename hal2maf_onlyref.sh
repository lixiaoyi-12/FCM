#!/bin/bash
#SBATCH -o job.%j.out
#SBATCH -p amd-ep2
#SBATCH --qos=huge
#SBATCH -J hal_onlyref
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=50G

hal2maf ../363-avian-2020.hal 363-avian-2020_refGenome_chr16_onlyref.maf --refGenome Gallus_gallus --refSequence chr1 --targetGenomes Gallus_gallus
