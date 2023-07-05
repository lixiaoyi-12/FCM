#! /usr/local/python
from Bio import AlignIO
import sys

#these tao files must be the same chrome

bedfile = sys.argv[1]
fh = open(bedfile,'r')
maffile = sys.argv[2]

# index a MAF file for specific chrom
chrom = bedfile.split('.')[-2]
print (chrom)
idx = AlignIO.MafIO.MafIndex(chrom + ".mafindex", maffile, "Gallus_gallus." + chrom)



for line in fh:
    #chr3	938	953
    if line=="":break
    line_list = line.strip().split()
    start = int(line_list[1])
    end =  int(line_list[2])
    outh = open('.'.join(line_list) + '.percent.xls','w')
     
    species_in_alignment = []
     
    #print (start,end)
    #accepts a list of start and end positions, and yields MultipleSeqAlignment objects that overlap the given intervals 
    results = idx.search([start], [end])
    
    ###This part can generate fasta file for each block within bed coordinates
    i =1 
    for alignments in results:
         output_align = './alignment_for_each_block/' + '.'.join(line_list)
         output_align = output_align  + '.' + str(i) + '.fas'
         AlignIO.write(alignments,output_align, "fasta")
         i = i + 1
    
fh.close()    
