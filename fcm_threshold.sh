echo "lost in hummingbird & at least 16 songbirds"
awk '{if($6==0&&$11==1&&$NF<=17) print$1,$2,$3}' nsuce_detail_table_summary.txt | tr " " "\t" > nsuce_lost_hummingbird_at_least_16_songbirds.txt
wc -l nsuce_lost_hummingbird_at_least_16_songbirds.txt
echo "lost in hummingbird & parrot & at least 16 songbirds"
awk '{if($6==0&&$11==0&&$NF<=16) print$1,$2,$3}' nsuce_detail_table_summary.txt | tr " " "\t" > nsuce_lost_hummingbird_parrot_at_least_16_songbirds.txt
wc -l nsuce_lost_hummingbird_parrot_at_least_16_songbirds.txt
echo "lost in hummingbird & parrot"
awk '{if($6==0&&$11==0&&$NF>16) print$1,$2,$3}' nsuce_detail_table_summary.txt | tr " " "\t" > nsuce_lost_hummingbird_parrot.txt
wc -l nsuce_lost_hummingbird_parrot.txt
echo "lost in parrot & at least 16 songbirds"
awk '{if($6==1&&$11==0&&$NF<=17) print$1,$2,$3}' nsuce_detail_table_summary.txt | tr " " "\t" > nsuce_lost_parrot_16_songbirds.txt
wc -l nsuce_lost_parrot_16_songbirds.txt

cat nsuce_lost_hummingbird_at_least_16_songbirds.txt nsuce_lost_hummingbird_parrot_at_least_16_songbirds.txt nsuce_lost_hummingbird_parrot.txt nsuce_lost_parrot_16_songbirds.txt > fcm.bed
