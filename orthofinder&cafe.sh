# downloaded protein sequence of species in our study from ncbi
# As for species without protein sequence provided, generated protein sequences based on whole genomes downloaded from ncbi, and annotation files from Zoonomia
# use GFFRead to extract CDS and perform translation
gffread species_geneAnnotation.gtf -g species.fasta -y species_protein.faa
# use cdhit to remove reduntant
cd-hit -i species_protein.faa -o  species_protein.cdhit.faa
# use python script to edit name of transcripts and pick up the longest isoforms
python pick_the_longest_isoform_and_change_title_for_genomic.py species_protein.cdhit.faa

# performed Orthofinder to identify orthologs and investigate copy number of each gene family
ulimit -n 65535
orthofinder -f ./protein_cdhit/ -t 16 -o ./Results -op
#or
orthofinder -b ./Results/WorkingDirectory/

# perform cafe 
cafe cafe.sh

# translate cafe results
python cafetutorial_report_analysis.py -i out.cafe -o summary_run
