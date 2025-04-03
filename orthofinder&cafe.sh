# downloaded protein sequence of species in our study from ncbi
# As for species without protein sequence provided, generated protein sequences based on whole genomes downloaded from ncbi, and annotation files from Zoonomia
# use GFFRead to extract CDS and perform translation, use cdhit to remove reduntant
gffread species_geneAnnotation.gtf -g species.fasta -y species_protein.faa
cd-hit -i species_protein.faa -o  species_protein.faa.cdhit
# performed Orthofinder to identify orthologs and investigate copy number of each gene family
ulimit -n 65535
orthofinder -f ./protein_cdhit/ -t 16 -o ./Results -op
#or
orthofinder -b ./Results/WorkingDirectory/
