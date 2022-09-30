#create custom ATCG frequency
fasta-get-markov -m 0 -dna ~/uce-nonvocal/genome/chicken/chicken.fasta > background_frequency_whole_genome
fasta-get-markov -m 0 -dna chicken-intergenic.fasta > background_frequency_of_intergenic_genome
fasta-get-markov -m 0 -dna chicken-intron.fasta > background_frequency_of_intronic_genome
fasta-get-markov -m 0 -dna chicken-noncoding.fasta > background_frequency_of_noncoding_genome

#meme motif prediction
meme fecel_noncoding.fasta -dna -oc ./meme_noncoding_custom_background_frequency -nostatus -time 18000 -mod anr -nmotifs 1 -minw 6 -maxw 50 -objfun classic -revcomp -bfile background_frequency_of_noncoding_genome -markov_order 0
meme fecel_intergene.fasta -dna -oc ./meme_intergenic_custom_background_frequency -nostatus -time 18000 -mod anr -nmotifs 1 -minw 6 -maxw 50 -objfun classic -revcomp -bfile background_frequency_of_intergenic_genome -markov_order 0
meme fecel_intron.fasta -dna -oc ./meme_intronic_custom_background_frequency -nostatus -time 18000 -mod anr -nmotifs 1 -minw 6 -maxw 50 -objfun classic -revcomp -bfile background_frequency_of_intronic_genome -markov_order 0

#tomtom motif comparison
tomtom -no-ssc -oc . -verbosity 1 -min-overlap 5 -mi 1 -dist pearson -evalue -thresh 10.0 -time 300 query_motifs db/EUKARYOTE/jolma2013.meme db/JASPAR/JASPAR2018_CORE_vertebrates_non-redundant.meme db/MOUSE/uniprobe_mouse.meme
