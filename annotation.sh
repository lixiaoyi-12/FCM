bedtools closest -a fcm.sort.bed -b ../../results/annotations/chicken-gene.sort.txt -d > fcm_annotation.txt
awk '{print$1,$2,$3,$12,$NF}' fcm_annotation.txt | tr " " "\t" > fcm_annotation_genelist.txt
awk '{print$4}' fcm_annotation_genelist.txt | tr ";" "\t" > fcm_annotation_genelist1.txt
awk '{print$1}' fcm_annotation_genelist1.txt > fcm_annotation_genelist2.txt 
sed -i 's/ID=gene-//g' fcm_annotation_genelist2.txt 
paste fcm_annotation_genelist.txt fcm_annotation_genelist2.txt > fcm_annotation_genelist3.txt
awk '{print$1,$2,$3,$6,$5}' fcm_annotation_genelist3.txt | tr " " "\t" > fcm_annotation_genelist4.txt
rm fcm_annotation_genelist3.txt fcm_annotation_genelist2.txt fcm_annotation_genelist.txt fcm_annotation_genelist1.txt
awk '{print$4}' fcm_annotation_genelist4.txt | uniq | wc -l
mv fcm_annotation_genelist4.txt fcm_annotation_genelist.txt

