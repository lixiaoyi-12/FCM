for i in akiapolaau american_crow anna_hummingbird black_capped_chickadee blackcap black_headed_bulbul brown_headed_cowbird budgerigar collared_flycatcher common_canary common_starling dark_eyed_junco european_robin great_tit green_crombec hawaii_amakihi hooded_crow house_sparrow magpie_robin medium_ground_finch new_caledonian_crow red_crossbill rosy_trush_tanager scrub_jay silver_eye song_sparrow superb_lyrebird tawny-bellied_seedeater tibetan_ground_tit white_rumped_munia white_throated_sparrow willow_warbler yellow_rumped_warbler zebra_finch;
	do 
	bedtools intersect -a nsuce.txt -b ../../vl/beds_200bp_40/$i-to_chicken-MAPPING_200bp_40.bam.sort.merge.strip.bed -wa > $i-intersect.txt;
	bedtools intersect -a nsuce.txt -b ../../vl/beds_200bp_40/$i-to_chicken-MAPPING_200bp_40.bam.sort.merge.strip.bed -v > $i-no.txt;
	cat $i-intersect.txt | uniq > $i-intersect1.txt;
	wc -l $i-intersect1.txt;
	wc -l $i-no.txt;
done;