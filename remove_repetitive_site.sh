bedtools intersect -b species-to-chicken-MAPPING.bam.sort.merge.bed -a chicken_genoes_bysite.bed -wa > species-to-chicken-MAPPING.bysite.bed
bedtools getfasta -bed species-to-chicken-MAPPING.bysite.bed -fi chicken.fasta -fo species-to-chicken-MAPPING.bysite.fasta
sed -i 's/c/n/g' species-to-chicken-MAPPING.bysite.fasta 
sed -i 's/a/n/g' species-to-chicken-MAPPING.bysite.fasta
sed -i 's/g/n/g' species-to-chicken-MAPPING.bysite.fasta
sed -i 's/t/n/g' species-to-chicken-MAPPING.bysite.fasta
cat species-to-chicken-MAPPING.bysite.fasta | sed 'N; s/\n/\t/' > species-to-chicken-MAPPING.bysite.join.fasta
sed  '/n/d' species-to-chicken-MAPPING.bysite.join.fasta > species-to-chicken-MAPPING.bysite.delete.fasta
awk '{print$1}' species-to-chicken-MAPPING.bysite.delete.fasta | tr ":" "\t" > species-to-chicken-MAPPING.bysite.makebed.fasta 
sed -i 's/>//g' species-to-chicken-MAPPING.bysite.makebed.fasta
sed -i 's/-/ /g' species-to-chicken-MAPPING.bysite.makebed.fasta
cat species-to-chicken-MAPPING.bysite.makebed.fasta | tr " " "\t" > species-to-chicken-MAPPING.bysite.makebed2.fasta
mv species-to-chicken-MAPPING.bysite.makebed2.fasta species-to-chicken-MAPPING.bysite.makebed.fasta 
bedtools merge -i species-to-chicken-MAPPING.bysite.makebed.fasta > species-to-chicken-MAPPING.bysite.merge.bed
