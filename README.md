# FCM

to identify FCM based on original genomes of your target species and non-target species, you can run the command following the pipeline below<br>
these are the software you need to download and the version I have used within the pipeline:<br>

[phyluce-1.7.1](https://github.com/faircloth-lab/phyluce)<br>
[art-src-MountRainier-2016.06.05](https://www.niehs.nih.gov/research/resources/software/biostatistics/art/)<br>
[stampy-1.0.32](https://www.well.ox.ac.uk/research/research-groups/lunter-group/lunter-group/stampy)<br>
[bwa-0.7.17](https://github.com/lh3/bwa)<br>
[samtools-1.14](http://www.htslib.org)<br>
[bedtools-2.30.0](https://bedtools.readthedocs.io/en/latest/content/installation.html)<br>
[ucsc:fatotwobit](https://genome.ucsc.edu/goldenPath/help/twoBit.html)<br>
[biopython](https://biopython.org)<br>
there are also other part of the pipeline performed in R<br>
the part before "Determining locus presence in multiple genomes" is basically written according to the [phyluce pipeline](https://phyluce.readthedocs.io/en/latest/tutorials/tutorial-4.html), you can also refer to it when having trobles running the command<br>


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
tiling reads from the respective genomes
-------------
create a dictionary of simulated reads<br>
```shell
cd ..
mkdir reads
cd reads
```
we will combine [seqkit](https://github.com/shenwei356/seqkit), a very useful tool for FASTA/FASTQ format manipulation into our script<br>
```shell
sh genome_pieces.sh
```

align simulated reads to reference genome
--------
Then we will use stampy, a statistical algorithm especially for performing alignment between divergent species, first we need to make index and prepare reference genome, we use chicken genome for example here<br>
```shell
cd ..
mkdir base
cd base
python ~/stampy-1.0.32/stampy.py --species="chicken" --assembly="chicken" -G chicken chicken.fasta
python ~/stampy-1.0.32/stampy.py -g chicken -H chicken
```
map reads to reference genome using stampy<br>
```shell
cd ..
mkdir alignments
cd alignments
bwa index ../base/chicken.fasta
for i in <name list of all non-target species>;
	do
	bwa aln -q10 -t12 ../base/chicken.fasta ../reads/$i-reads.fq > 1.sai
	bwa samse ../base/chicken.fasta 1.sai ../reads/$i-reads.fq | samtools view -Sb - > $i-bwa.bam
	python ~/stampy-1.0.32/stampy.py --maxbasequal 93 --substitutionrate=0.05 -g ../base/chicken -h ../base/chicken -t12 --bamkeepgoodreads -M $i-bwa.bam | samtools view -Sb - > $i-to-chicken.bam
done;
```
Using the parameters above, we can perform the mapping using substitution rate equals to 0.05, 12 thread and only keep good reads<br>
see the details in the manual of stampy<br>
then we filter the mapping results, keep the regions uniquely mapped successfully，run the following code for every species<br>
```shell
for i in <name list of all non-target species>;
	do
	samtools view -q 1 -h -F 4 -b $i-to-chicken.bam > $i-to-chicken-MAPPING.bam;
done;
```
adjust the format of mapping results and filter
---------
to begin the filter process, we firstly need to convert the format of mapping results to bed file, which is the format contain the coordinates information and convenient for further manipulation<br>
```shell
cd ..
mkdir beds
cd beds
cp ../alignments/*-MAPPING.bam ./
for i in *.bam; 
	do 
	echo $i; 
	bedtools bamtobed -i $i -bed12 > `basename $i`.bed; 
done;
```
sort the bed file<br>
```shell
for i in *.bed; do echo $i; bedtools sort -i $i > ${i%.*}.sort.bed; done
```
merge regions with the distance smaller than 20bp, you can choose whether to do the merging and the merging length<br>
```shell
for i in *.bam.sort.bed; do echo $i; bedtools merge -d 20 -i $i > ${i%.*}.merge.bed; done
```
then we need to remove repetitive sites in shared regions extracted above<br>
```shell
for i in <name list of all non-target species>;
	do
	cp remove_repetitive_site.sh remove_repetitive_site-$i.sh;
	sed -i 's/species/$i/g' remove_repetitive_site-$i.sh;
	sh remove_repetitive_site.sh;
```
Determining locus presence in multiple genomes
---------
using the coordinates of every shared region between exampler species and reference species, we now can determine conserved elements shared by all species and reference genome by running a shell script<br>
noted that you need to change the species name in the scirpt into your specific species<br>
```shell
sh create_conserved_elements.sh
```
then you will get a file called 'conserved_elements.bed', with the coordinates of all conserved elements shared by the species above<br>
then you repeat the whole process using genomes of target species and get conserved elements across all target species called 'conserved_elements_vl.bed'<br>

identify conserved elements lost in at least one vocal learners
-----
```shell
mkdir fcm
cd fcm
cp ../nvl/beds/conserved_elements.bed ./
cp ../vl/beds/conserved_elements.bed conserved_elements_vl.bed
bedtools intersect -a conserved_elements.bed -b conserved_elements_vl.bed -v > nsuce.txt
```
then run the script 'generate_fcm.sh' to calculate the number of fast evolving conserved elements in vocal learning lineages mapped to each vocal learners we choose, and generate the final FCMs according to certain threshold<br>

```shell
sh generate_fcm.sh
```
then you will get a file called 'fcm.bed' with all the FCM in it<br>

identify FCM-associated genes
----
to get genes close to FCM, run the following script<br>
```shell
bedtools sort -i fcm.bed > fcm.sort.bed
sh annotation.sh
```
the closest gene of each FCM and the distance between them is written in the file 'fcm_annotation_genelist.txt'<br>

calculate phastcons scores of every element
----
to calculate the average PhastConst scores of each CEs, we can simply using bedtools map<br>
```shell
bedtools map -a conserved_elements.bed -b scores.bed -c 5 -o mean > scores_conserved_elements.txt
```
Script of other analysis
---
meme_commond.sh is used when predicted motifs in self-generated regions based on MEME package<br>
tomtom_command.sh is used when compared newly predicted motifs with known motifs<br>
rm_redundant_gallus.py is used before calculated species do not have alignment in WGA results <br>
