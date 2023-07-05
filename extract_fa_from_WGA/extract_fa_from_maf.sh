After we download whole genome alignments from UCSC, we first need to transform the format from hal to maf by chromosomes<br>
take chr1 for example<br>
```shell
hal2maf 363-avian-2020.hal 363-avian-2020_refGenome_chr1.maf --refGenome Gallus_gallus --refSequence chr1 --targetGenomes species_list
```
then we need to remove redundant sequence in multiple genome alignment we download, because our script does't recognize those sequence and error will occur<br>
```shell
python rm_redundant_gallus.py 363-avian-2020_refGenome_chr1.maf
```
then we use the following python script to extract fasta for each block<br>
```shell
python extract_fasta_from_maf_format_for_each_block.py fcm.chr1.txt 363-avian-2020_refGenome_chr1.maf
```
