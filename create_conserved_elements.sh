#!/bin/sh
#___INFO__MARK_BEGIN__
# Welcome to use  EasyCluster V1.6 All Rights Reserved.
#
#___INFO__MARK_END__
#
#$ -S /bin/sh
#$ -N intersect 
#$ -j y
#$ -o ./
#$ -e ./
#$ -cwd
#$ -q normal.q,short.q,serial.q
#$ -pe thread 1-1 

source ~/.bash_profile
hash -r

#the elements identified
bedtools intersect -a blue_crowned_manakin-to-chicken-MAPPING.bam.sort.merge.strip.bed -b chimney_swift-to-chicken-MAPPING.bam.sort.merge.strip.bed > test.bed
bedtools intersect -a test.bed -b common_cuckoo-to-chicken-MAPPING.bam.sort.merge.strip.bed > test2.bed
bedtools intersect -a test2.bed -b crested_ibis-to-chicken-MAPPING.bam.sort.merge.strip.bed > test3.bed
bedtools intersect -a test3.bed -b downy_woodpecker-to-chicken-MAPPING.bam.sort.merge.strip.bed > test4.bed
bedtools intersect -a test4.bed -b elegant_crested_tinamou-to-chicken-MAPPING.bam.sort.merge.strip.bed > test5.bed
bedtools intersect -a test5.bed -b emperor_penguin-to-chicken-MAPPING.bam.sort.merge.strip.bed > test6.bed
bedtools intersect -a test6.bed -b emu-to-chicken-MAPPING.bam.sort.merge.strip.bed > test7.bed
bedtools intersect -a test7.bed -b golden_collared_manakin-to-chicken-MAPPING.bam.sort.merge.strip.bed > test8.bed
bedtools intersect -a test8.bed -b golden_eagle-to-chicken-MAPPING.bam.sort.merge.strip.bed > test9.bed
bedtools intersect -a test9.bed -b greater_rhea-to-chicken-MAPPING.bam.sort.merge.strip.bed > test10.bed
bedtools intersect -a test10.bed -b hoatzin-to-chicken-MAPPING.bam.sort.merge.strip.bed > test11.bed
bedtools intersect -a test11.bed -b many-colored_rush_tyrant-to-chicken-MAPPING.bam.sort.merge.strip.bed > test12.bed
bedtools intersect -a test12.bed -b rock_pigeon-to-chicken-MAPPING.bam.sort.merge.strip.bed > test13.bed
bedtools intersect -a test13.bed -b ostrich-to-chicken-MAPPING.bam.sort.merge.strip.bed > test14.bed
bedtools intersect -a test14.bed -b royal_flycatcher-to-chicken-MAPPING.bam.sort.merge.strip.bed > test15.bed
bedtools intersect -a test15.bed -b saker_falcon-to-chicken-MAPPING.bam.sort.merge.strip.bed > test16.bed
bedtools intersect -a test15.bed -b spotted_owl-to-chicken-MAPPING.bam.sort.merge.strip.bed > test17.bed
bedtools intersect -a test17.bed -b thick-billed_guillemot-to-chicken-MAPPING.bam.sort.merge.strip.bed > test18.bed
bedtools intersect -a test18.bed -b white-winged_piprites-to-chicken-MAPPING.bam.sort.merge.strip.bed > test19.bed
bedtools intersect -a test19.bed -b woodland_kingfisher-to-chicken-MAPPING.bam.sort.merge.strip.bed > test20.bed
bedtools intersect -a test20.bed -b pekingduck-to-chicken-MAPPING.bam.sort.merge.strip.bed> test22.bed
bedtools intersect -a test22.bed -b peregrine_falcon-to-chicken-MAPPING.bam.sort.merge.strip.bed > test23.bed
bedtools intersect -a test23.bed -b thick-billed_guillemot-to-chicken-MAPPING.bam.sort.merge.bed > test24.bed
bedtools intersect -a test24.bed -b white-winged_piprites-to-chicken-MAPPING.bam.sort.merge.bed > test25.bed
bedtools intersect -a test25.bed -b woodland_kingfisher-to-chicken-MAPPING.bam.sort.merge.bed > test26.bed
bedtools intersect -a test26.bed -b white_breasted_antbird-to-chicken-MAPPING.bam.sort.merge.strip.bed > test27.bed

cat test27.bed | sort | uniq | wc -l
bedtools sort -i test27.bed > test28.bed
awk '{print$1,$2,$3}' test28.bed | tr " " "\t" > conserved_elements.bed
#rename the elements
awk '$0=NR"\t"$0' conserved_elements.bed > conserved_elements_rename.bed
rm test*.bed 
awk '{if($4-$3>30) print$0}' conserved_elements_rename.bed > conserved_elements_rename_filter.bed
sed -i 's/^/conserved_elements&/g' conserved_elements_rename_filter.bed
awk '{print$2,$3,$4,$1}' conserved_elements_rename_filter.bed > conserved_elements.bed
rm conserved_elements_rename_filter.bed conserved_elements_rename.bed
