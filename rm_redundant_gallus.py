#! /usr/local/python
import sys
import os

infiles = sys.argv[1:]

def mkdir(path):
    folder = os.path.exists(path)
    if not folder:
        os.makedirs(path)
direct = "./remove_redundant_gallus/"
mkdir(direct)

for myfile in infiles:
    fh = open(myfile,'r')
    outh = open(direct + myfile,'w') 
    title_1 = fh.readline()
    title_2 = fh.readline()
    outh.write(title_1)
    outh.write(title_2)

    for line in fh:
        if line.startswith('a'):
            outh.write(line)
            ref = next(fh)
            outh.write(ref)
        else:
            if line.startswith('s	Gallus_gallus'):
                pass
            else:
                outh.write(line)
    fh.close()
    outh.close()
    

