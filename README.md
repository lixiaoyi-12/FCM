# FCM
identify conserved elements across all non-vocal learners
------
first download genomes from NCBI via wget<br>
create a dictionary<br>
```shell
mkdir nvl
mkdir genomes
cd genomes
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/002/315/GCF_000002315.6_GRCg6a/GCF_000002315.6_GRCg6a_genomic.fna.gz
gunzip GCF_000002315.6_GRCg6a_genomic.fna.gz
mv GCF_000002315.6_GRCg6a_genomic.fna GCF_000002315.6_chicken.fasta
```
clean the genomes<br>
```shell
python clean.py
```
put genomes into their own dictionaries<br>
```shell
for critter in *; do mkdir ${critter%.*}; mv $critter ${critter%.*}; done
```
convert genomes into 2bit format<br>
```shell
for critter in *; 
	do 
	faToTwoBit $critter/$critter.fasta $critter/${critter%.*}.2bit; 
done;
```
simulate reads from the respective genomes<br>
create a dictionary of simulated reads<br>
```shell
cd ..
mkdir reads
cd reads
for i in blue_crowned_manakin chimney_swift common_cuckoo crested_ibis downy_woodpecker elegant_crested_tinamou emperor_penguin emu golden_collared_manakin golden_eagle greater_rhea hoatzin many-colored_rush_tyrant rock_pigeon ostrich pekingduck royal_flycatcher peregrine_falcon spotted_owl thick-billed_guillemot white_breasted_antbird white-winged_piprites woodland_kingfisher;
	do
	art_illumina --in ../genomes/$i/$i.fasta --out $i-reads --len 100 --fcov 20  -ir 0.0 -dr 0.0 -qs 100 -na;
done;
```
align simulated reads to reference genome<br>
prepare reference genome<br>
```shell
cd ..
mkdir base
cd base
python ~/stampy-1.0.32/stampy.py --species="chicken" --assembly="chicken" -G chicken ~/uce-nonvocal/genome/chicken/chicken.fasta
python ~/stampy-1.0.32/stampy.py -g chicken -H chicken
```
map reads to reference genome using stampy<br>
```shell
cd ..
mkdir alignments
cd alignments
for i in blue_crowned_manakin chimney_swift common_cuckoo crested_ibis downy_woodpecker elegant_crested_tinamou emperor_penguin emu golden_collared_manakin golden_eagle greater_rhea hoatzin many-colored_rush_tyrant rock_pigeon ostrich pekingduck royal_flycatcher peregrine_falcon spotted_owl thick-billed_guillemot white_breasted_antbird white-winged_piprites woodland_kingfisher;
	do
	bwa aln -q10 -t12 ../genomes/chicken/chicken.fasta ../reads/$i-reads.fq > 1.sai
	bwa samse ../genomes/chicken/chicken.fasta 1.sai ../reads/$i-reads.fq | samtools view -Sb - > $i-bwa.bam
	python ~/stampy-1.0.32/stampy.py --maxbasequal 93 --substitutionrate=0.05 -g ../base/chicken -h ../base/chicken -t12 --bamkeepgoodreads -M $i-bwa.bam | samtools view -Sb - > $i-to-chicken.bam
done;
```
filter the mapping results, keep the regions mapped successfully (uniq mapping)，run the following code for every species<br>
```shell
samtools view -h -F 4 -b blue_crowned_manakin-to-chicken.bam > blue_crowned_manakin-to-chicken-MAPPING.bam
samtools view -q 1 -h -b blue_crowned_manakin-to-chicken-MAPPING.bam > blue_crowned_manakin-to-chicken-MAPPING.uniq.bam
```
adjust the format of mapping results and filter<br>
```shell
cd ..
mkdir beds
cd beds
for i in ../alignments/all/*.bam; 
	do 
	echo $i; 
	bedtools bamtobed -i $i -bed12 > `basename $i`.bed; 
done;
```
sort the bed file<br>
```shell
for i in *.bed; do echo $i; bedtools sort -i $i > ${i%.*}.sort.bed; done
```
merge regions with the distance smaller than 20bp<br>
```shell
for i in *.bam.sort.bed; do echo $i; bedtools merge -d 20 -i $i > ${i%.*}.merge.bed; done
```
remove repetitive intervals<br>
```shell
for i in *.sort.merge.bed;
  do
      phyluce_probe_strip_masked_loci_from_set \
          --bed $i \
          --twobit ../genomes/chicken/chicken.2bit \
          --output ${i%.*}.strip.bed \
          --filter-mask 0.25 \
          --min-length 0
  done;
```
Determining locus presence in multiple genomes<br>
```shell
sh create_conserved_elements.sh
```
then you will get a file called 'conserved_elements.bed', with the coordinates of all conserved elements shared by the species above<br>
then you repeat the whole process using genomes of vocal learners and get conserved elements across all vocal learners<br>

identify conserved elements lost in at least one vocal learners
-----
extract FCM based on two sets of conserved elements<br>
```shell
mkdir fcm
cd fcm
cp ../nvl/beds/conserved_elements.bed ./
cp ../vl/beds/conserved_elements.bed conserved_elements_vl.bed
bedtools intersect -a conserved_elements.bed -b conserved_elements_vl.bed -v > nsce.txt
```
then run the script 'pipeline_create_nsuce_table.sh' to calculate the number of fast evolving conserved elements in vocal learning lineages mapped to each vocal learners we choose<br>
```shell
sh pipeline_create_nsuce_table.sh
```
we can then write the script 'create_nsuce_list_0.sh' and 'create_nsuce_list_1.sh' based on the results of running the last script by changing the number of intersection and species name<br>
then run the scripts<br>
```shell
sh create_nsuce_list_0.sh
sh create_nsuce_list_1.sh
sh create_nsuce_list.sh
```
then you will get a table with each fast evolved conserved elements in it, if the fast evolved conserved elements can mapped to the corresponding vocal learner, it will be 1 recorded in the table. Otherwise it will be 0 recorded<br>
then you can choose your own strategy to extract FCM, here we consider fast evolved conserved elements lost in at least two lineages as FCM (if a fast evolved conserved element is unmapped in more than 16 songbirds, it is considered lost in songbirds)<br>
by running the following script, we extract FCM under this strategy<br>
```shell
sh pipeline_create_fecel.sh
```
then you will get a file called 'fcm.txt' with all the FCM in it<br>

identify FCM-associated genes
----
to get genes close to FCM, run the following script<br>
```shell
sh annotation.sh
```
