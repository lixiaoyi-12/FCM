echo "lost in hummingbird & at least 16 songbirds"
awk '{if($4==0&&$5==1&&$NF<=16) print$1,$2,$3}' ce_detail_table_summary.txt | tr " " "\t" > ce_lost_hummingbird_at_least_16_songbirds.txt
wc -l ce_lost_hummingbird_at_least_16_songbirds.txt
echo "lost in hummingbird & parrot & at least 16 songbirds"
awk '{if($4==0&&$5==0&&$NF<=16) print$1,$2,$3}' ce_detail_table_summary.txt | tr " " "\t" > ce_lost_hummingbird_parrot_at_least_16_songbirds.txt
wc -l ce_lost_hummingbird_parrot_at_least_16_songbirds.txt
echo "lost in hummingbird & parrot"
awk '{if($4==0&&$5==0&&$NF>16) print$1,$2,$3}' ce_detail_table_summary.txt | tr " " "\t" > ce_lost_hummingbird_parrot.txt
wc -l ce_lost_hummingbird_parrot.txt
echo "lost in parrot & at least 16 songbirds"
awk '{if($4==1&&$5==0&&$NF<=16) print$1,$2,$3}' ce_detail_table_summary.txt | tr " " "\t" > ce_lost_parrot_16_songbirds.txt
wc -l ce_lost_parrot_16_songbirds.txt

cat ce_lost_hummingbird_at_least_16_songbirds.txt ce_lost_hummingbird_parrot_at_least_16_songbirds.txt ce_lost_hummingbird_parrot.txt ce_lost_parrot_16_songbirds.txt > fcm.bed
