for i in akiapolaau american_crow anna_hummingbird black_capped_chickadee blackcap black_headed_bulbul brown_headed_cowbird budgerigar collared_flycatcher common_canary common_starling dark_eyed_junco european_robin great_tit green_crombec hawaii_amakihi hooded_crow house_sparrow magpie_robin medium_ground_finch new_caledonian_crow red_crossbill rosy_trush_tanager scrub_jay silver_eye song_sparrow superb_lyrebird tawny-bellied_seedeater tibetan_ground_tit white_rumped_munia white_throated_sparrow willow_warbler yellow_rumped_warbler zebra_finch;
do
paste $i-intersect1.txt $i-1.txt > $i-intersect2.txt;
paste $i-no.txt $i-0.txt > $i-no2.txt;
cat $i-intersect2.txt $i-no2.txt > $i-summary.txt;
bedtools sort -i $i-summary.txt > $i-summary2.txt;
awk '{print$4}' $i-summary2.txt > $i-summary3.txt;
done;

paste akiapolaau-summary2.txt american_crow-summary3.txt anna_hummingbird-summary3.txt black_capped_chickadee-summary3.txt blackcap-summary3.txt black_headed_bulbul-summary3.txt brown_headed_cowbird-summary3.txt budgerigar-summary3.txt collared_flycatcher-summary3.txt common_canary-summary3.txt common_starling-summary3.txt dark_eyed_junco-summary3.txt european_robin-summary3.txt great_tit-summary3.txt green_crombec-summary3.txt hawaii_amakihi-summary3.txt hooded_crow-summary3.txt house_sparrow-summary3.txt magpie_robin-summary3.txt medium_ground_finch-summary3.txt new_caledonian_crow-summary3.txt red_crossbill-summary3.txt rosy_trush_tanager-summary3.txt scrub_jay-summary3.txt silver_eye-summary3.txt song_sparrow-summary3.txt superb_lyrebird-summary3.txt tawny-bellied_seedeater-summary3.txt tibetan_ground_tit-summary3.txt white_rumped_munia-summary3.txt white_throated_sparrow-summary3.txt willow_warbler-summary3.txt yellow_rumped_warbler-summary3.txt zebra_finch-summary3.txt > nsuce_detail_table.txt

mkdir log-file
mv *_0* log-file/
mv *_1* log-file/
mv *-intersect* log-file/
mv *-no* log-file/
mv *-0.txt log-file/
mv *-1.txt log-file/
mv *-summary* log-file/
mv log-file/create_0.sh ./
mv log-file/create_1.sh ./
awk '{print$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$30,$31,$32,$33,$34,$35,$36,$37,$4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14+$15+$16+$17+$18+$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30+$31+$32+$33+$34+$35+$36+$37}' nsuce_detail_table.txt | tr " " "\t" > nsuce_detail_table_summary.txt
