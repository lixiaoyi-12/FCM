from Bio import SeqIO
with open("GCF_000002315.6_chicken.fasta", "rU") as infile:
with open("chicken.fasta", "w") as outf:
    for seq in SeqIO.parse(infile, 'fasta'):
        seq.name = ""
        seq.description = ""
        outf.write(seq.format('fasta'))
