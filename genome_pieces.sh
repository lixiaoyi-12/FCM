for i in blue_crowned_manakin chimney_swift common_cuckoo crested_ibis downy_woodpecker elegant_crested_tinamou emperor_penguin emu golden_collared_manakin golden_eagle greater_rhea hoatzin many-colored_rush_tyrant rock_pigeon ostrich pekingduck royal_flycatcher falcon spotted_owl thick-billed_guillemot white_breasted_antbird white-winged_piprites woodland_kingfisher;
	do
	mkdir $i;
	cd $i;
	cp ../../genomes/$i/$i.fasta;
	seqkit faidx $i.fasta;
	cp ../generate_bed.sh ./;
	sed -i "s/species/${i}/g" generate_bed.sh;
	sh generate_bed.sh;
	sh generate_seq.sh;
	sh add_name.sh;
	mkdir bed;
	mv *.bed bed/;
	cd bed;
	cat * > generate_window.bed;
	mv generate_window.bed ../;
	cd ..;
	cat generate_window.bed | tr " " "\t" | awk '{print$1,$2,$2+100}' | tr " " "\t" > generate_window2.bed;
	mv generate_window2.bed generate_window.bed;
	bedtools getfasta -fi $i.fasta -bed generate_window.bed -fo $i.window.fasta;
	cd ..;
done;


