awk '{print$1}' species.fasta.fai > species.fasta.name
awk '{print$2}' species.fasta.fai > species.fasta.length
sed -i 's/^/seq 0 5 /g' species.fasta.length 
sed -i 's/$/ > /g' species.fasta.length
paste -d " " species.fasta.length species.fasta.name > generate_seq.sh
sed -i 's/$/.bed/g' generate_seq.sh
cp species.fasta.name species.fasta.name2
sed -i "s/^/sed -i 's\/\^\//g" species.fasta.name2
sed -i "s/$/ \/g' /g" species.fasta.name2
paste -d " " species.fasta.name2 species.fasta.name > add_name.sh
sed -i 's/$/.bed/g' add_name.sh
