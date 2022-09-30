sh pipeline_create_nsuce_table.sh > text
sed -i 's/-intersect1.txt/-create_1.sh/g' text
sed -i 's/-no.txt/-create_0.sh/g' text
sed -i "s/^/sed -i 's\/number\//g" text
sed -i "s/ /\/g'  /g" text
sed -i "s/\/g'  -i\/g'  / -i /g" text
cat generate_create.sh text generate_run.sh > awk_all.sh
sh awk_all.sh
sh create-nsuce-list.sh
sh fcm_threshold.sh

