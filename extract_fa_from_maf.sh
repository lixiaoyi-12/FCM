#!/bin/bash
#SBATCH -o job.%j.out
#SBATCH -p amd-ep2-short
#SBATCH --qos=huge
#SBATCH -J msa_view
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=200G

msa_view 363-avian-2020_refGenome_chr1_onlyref.maf --in-format MAF  > chr1_ref.fa
