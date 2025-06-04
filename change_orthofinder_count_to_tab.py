#! /usr/local/python2.7.11
import sys

myfile = sys.argv[1]
fh = open(myfile,'r')
outfile_1 = myfile.split('GeneCount')[0] + 'less.than.100.tsv'
outh_1 = open(outfile_1,'w')
outfile_2 = myfile.split('GeneCount')[0] + 'great.than.100.tsv'
outh_2 = open(outfile_2,'w')

first_line = fh.readline()
list_1 = first_line.split('\t')[:-1]
#print list_1
line_1 = 'Family' + '\t' + 'Desc' + '\t' + '\t'.join(list_1[1:])
outh_1.write(line_1 + '\n')
outh_2.write(line_1 + '\n')
#print line_1.split('\t')

for line in fh:
    #print  line
    list_2 = line.split('\t')[:-1]
    line_2 = 'Unknow'  + '\t' + '\t'.join(list_2)
    mark = 0
    #print mark
    for i in list_2[1:]:
        if int(i) >= 100:
            mark += 1
    #print mark
    if mark == 0:
        outh_1.write(line_2 + '\n')
    else:
        outh_2.write(line_2 + '\n')
    
fh.close()
outh_1.close()
outh_2.close()
