#the elements identified
bedtools intersect -a blue_crowned_manakin/blue_crowned_manakin-to-chicken-MAPPING.bysite.merge.bed -b chimney_swift/chimney_swift-to-chicken-MAPPING.bysite.merge.bed > test.bed
bedtools intersect -a test.bed -b common_cuckoo/common_cuckoo-to-chicken-MAPPING.bysite.merge.bed > test2.bed
bedtools intersect -a test2.bed -b crested_ibis/crested_ibis-to-chicken-MAPPING.bysite.merge.bed > test3.bed
bedtools intersect -a test3.bed -b downy_woodpecker/downy_woodpecker-to-chicken-MAPPING.bysite.merge.bed > test4.bed
bedtools intersect -a test4.bed -b elegant_crested_tinamou/elegant_crested_tinamou-to-chicken-MAPPING.bysite.merge.bed > test5.bed
bedtools intersect -a test5.bed -b emperor_penguin/emperor_penguin-to-chicken-MAPPING.bysite.merge.bed > test6.bed
bedtools intersect -a test6.bed -b emu/emu-to-chicken-MAPPING.bysite.merge.bed > test7.bed
bedtools intersect -a test7.bed -b golden_collared_manakin/golden_collared_manakin-to-chicken-MAPPING.bysite.merge.bed > test8.bed
bedtools intersect -a test8.bed -b golden_eagle/golden_eagle-to-chicken-MAPPING.bysite.merge.bed > test9.bed
bedtools intersect -a test9.bed -b greater_rhea/greater_rhea-to-chicken-MAPPING.bysite.merge.bed > test10.bed
bedtools intersect -a test10.bed -b hoatzin/hoatzin-to-chicken-MAPPING.bysite.merge.bed > test11.bed
bedtools intersect -a test11.bed -b many_colored_rush_tyrant/many_colored_rush_tyrant-to-chicken-MAPPING.bysite.merge.bed > test12.bed
bedtools intersect -a test12.bed -b rock_pigeon/rock_pigeon-to-chicken-MAPPING.bysite.merge.bed > test13.bed
bedtools intersect -a test13.bed -b ostrich/ostrich-to-chicken-MAPPING.bysite.merge.bed > test14.bed
bedtools intersect -a test14.bed -b royal_flycatcher/royal_flycatcher-to-chicken-MAPPING.bysite.merge.bed > test15.bed
bedtools intersect -a test15.bed -b spotted_owl/spotted_owl-to-chicken-MAPPING.bysite.merge.bed > test17.bed
bedtools intersect -a test17.bed -b thick_billed_guillemot/thick_billed_guillemot-to-chicken-MAPPING.bysite.merge.bed > test18.bed
bedtools intersect -a test18.bed -b white_winged_piprites/white_winged_piprites-to-chicken-MAPPING.bysite.merge.bed > test19.bed
bedtools intersect -a test19.bed -b white_breasted_antbird/white_breasted_antbird-to-chicken-MAPPING.bysite.merge.bed > test20.bed
bedtools intersect -a test20.bed -b woodland_kingfisher/woodland_kingfisher-to-chicken-MAPPING.bysite.merge.bed > test21.bed
bedtools intersect -a test21.bed -b pekingduck/pekingduck-to-chicken-MAPPING.bysite.merge.bed> test22.bed
bedtools intersect -a test22.bed -b falcon/falcon-to-chicken-MAPPING.bysite.merge.bed > test23.bed

cat test23.bed | sort | uniq | wc -l
bedtools sort -i test23.bed > test28.bed
mv test28.bed conserved_elements.bed
rm test*
