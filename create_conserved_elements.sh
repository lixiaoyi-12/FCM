# the elements identified
bedtools intersect -a species1/species1-to-chicken-MAPPING.merge.bed -b species2/species2-to-chicken-MAPPING.merge.bed > test.bed
bedtools intersect -a test.bed -b species3/species3-to-chicken-MAPPING,merge.bed > test2.bed
bedtools intersect -a test2.bed -b species4/species4-to-chicken-MAPPING.merge.bed > test3.bed
...
bedtools intersect -a test22.bed -b species24/species24-to-chicken-MAPPING.merge.bed > test23.bed

cat test23.bed | sort | uniq | wc -l
bedtools sort -i test23.bed > test28.bed
mv test28.bed conserved_elements.bed
rm test*

# you can also use the command like
bedtools intersect -a species1/species1-to-chicken-MAPPING.merge.bed \
    -b species2/species2-to-chicken-MAPPING.merge.bed.bed species3/species3-to-chicken-MAPPING.merge.bed.bed species4/species4-to-chicken-MAPPING.merge.bed.bed \
    ...
