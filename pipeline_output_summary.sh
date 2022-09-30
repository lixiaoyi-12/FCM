#!/bin/sh
#___INFO__MARK_BEGIN__
# Welcome to use  EasyCluster V1.6 All Rights Reserved.
#
#___INFO__MARK_END__
#
#$ -S /bin/sh
#$ -N intersect 
#$ -j y
#$ -o ./
#$ -e ./
#$ -cwd
#$ -q serial.q
#$ -pe thread 1-1 

source ~/.bash_profile
hash -r

#sperate the chr
awk '{if($1=="NC_006088.5") print$0}' conserved_elements.bed > each-chr/chr1.bed
awk '{if($1=="NC_006089.5") print$0}' conserved_elements.bed > each-chr/chr2.bed
awk '{if($1=="NC_006090.5") print$0}' conserved_elements.bed > each-chr/chr3.bed
awk '{if($1=="NC_006091.5") print$0}' conserved_elements.bed > each-chr/chr4.bed
awk '{if($1=="NC_006092.5") print$0}' conserved_elements.bed > each-chr/chr5.bed
awk '{if($1=="NC_006093.5") print$0}' conserved_elements.bed > each-chr/chr6.bed
awk '{if($1=="NC_006094.5") print$0}' conserved_elements.bed > each-chr/chr7.bed
awk '{if($1=="NC_006095.5") print$0}' conserved_elements.bed > each-chr/chr8.bed 
awk '{if($1=="NC_006096.5") print$0}' conserved_elements.bed > each-chr/chr9.bed
awk '{if($1=="NC_006097.5") print$0}' conserved_elements.bed > each-chr/chr10.bed
awk '{if($1=="NC_006098.5") print$0}' conserved_elements.bed > each-chr/chr11.bed
awk '{if($1=="NC_006099.5") print$0}' conserved_elements.bed > each-chr/chr12.bed
awk '{if($1=="NC_006100.5") print$0}' conserved_elements.bed > each-chr/chr13.bed
awk '{if($1=="NC_006101.5") print$0}' conserved_elements.bed > each-chr/chr14.bed
awk '{if($1=="NC_006102.5") print$0}' conserved_elements.bed > each-chr/chr15.bed
awk '{if($1=="NC_006103.5") print$0}' conserved_elements.bed > each-chr/chr16.bed
awk '{if($1=="NC_006104.5") print$0}' conserved_elements.bed > each-chr/chr17.bed
awk '{if($1=="NC_006105.5") print$0}' conserved_elements.bed > each-chr/chr18.bed
awk '{if($1=="NC_006106.5") print$0}' conserved_elements.bed > each-chr/chr19.bed
awk '{if($1=="NC_006107.5") print$0}' conserved_elements.bed > each-chr/chr20.bed
awk '{if($1=="NC_006108.5") print$0}' conserved_elements.bed > each-chr/chr21.bed
awk '{if($1=="NC_006109.5") print$0}' conserved_elements.bed > each-chr/chr22.bed
awk '{if($1=="NC_006110.5") print$0}' conserved_elements.bed > each-chr/chr23.bed
awk '{if($1=="NC_006111.5") print$0}' conserved_elements.bed > each-chr/chr24.bed
awk '{if($1=="NC_006112.5") print$0}' conserved_elements.bed > each-chr/chr25.bed
awk '{if($1=="NC_006113.5") print$0}' conserved_elements.bed > each-chr/chr26.bed
awk '{if($1=="NC_006114.5") print$0}' conserved_elements.bed > each-chr/chr27.bed
awk '{if($1=="NC_006115.5") print$0}' conserved_elements.bed > each-chr/chr28.bed
awk '{if($1=="NC_028739.2") print$0}' conserved_elements.bed > each-chr/chr30.bed
awk '{if($1=="NC_028740.2") print$0}' conserved_elements.bed > each-chr/chr31.bed
awk '{if($1=="NC_006119.4") print$0}' conserved_elements.bed > each-chr/chr32.bed
awk '{if($1=="NC_008465.4") print$0}' conserved_elements.bed > each-chr/chr33.bed
awk '{if($1=="NC_006126.5") print$0}' conserved_elements.bed > each-chr/chrw.bed
awk '{if($1=="NC_006127.5") print$0}' conserved_elements.bed > each-chr/chrz.bed
#calculate the length of each chr
#for i in each-chr/* ;
#	do
#	echo $i	
#	awk '{print$4-$3}' $i | egrep -v "^$" | paste -sd+ | bc 
#	done;
