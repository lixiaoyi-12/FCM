from Bio.AlignIO.MafIO import MafIndex
from Bio import AlignIO
import sys

#these tao files must be the same chrome

bedfile = sys.argv[1]
fh = open(bedfile,'r')
maffile = sys.argv[2]

# index a MAF file for specific chrom
chrom = bedfile.split('.')[-2]
#print (chrom)
#generate output file 
outfile = chrom + '.UCE_lacing_vocal_learners.xls'
outh = open(outfile,'w')
outh_2 = open(chrom + '.UCE_lacing_species.xls','w')

#generate idx for maf file
idx = AlignIO.MafIO.MafIndex(chrom + ".mafindex", maffile, "Gallus_gallus." + chrom)

###generate species list for vocal learners
songbird_list = ['Aphelocoma_coerulescens', 'Brachypodius_atriceps', 'Chlorodrepanis_virens', 'Copsychus_sechellarum', 'Corvus_brachyrhynchos', 'Corvus_cornix', 'Corvus_moneduloides', 'Erithacus_rubecula', 'Ficedula_albicollis', 'Geospiza_fortis', 'Hemignathus_wilsoni', 'Junco_hyemalis', 'Lonchura_striata', 'Loxia_curvirostra', 'Melospiza_melodia', 'Menura_novaehollandiae', 'Molothrus_ater', 'Parus_major', 'Passer_domesticus', 'Phylloscopus_trochilus', 'Poecile_atricapillus', 'Pseudopodoces_humilis', 'Rhodinocichla_rosea', 'Serinus_canaria', 'Setophaga_coronata', 'Sporophila_hypoxantha', 'Sturnus_vulgaris', 'Sylvia_atricapilla', 'Sylvietta_virens', 'Taeniopygia_guttata', 'Zonotrichia_albicollis', 'Zosterops_lateralis'] 
parrot = 'Melopsittacus_undulatus'
hummingbird = 'Calypte_anna'
###all species list
species_list = ['Aquila_chrysaetos', 'Anas_platyrhynchos', 'Calypte_anna', 'Chaetura_pelagica', 'Dromaius_novaehollandiae', 'Uria_lomvia', 'Columba_livia', 'Halcyon_senegalensis', 'Cuculus_canorus', 'Falco_peregrinus', 'Gallus_gallus', 'Opisthocomus_hoazin', 'Lepidothrix_coronata', 'Onychorhynchus_coronatus', 'Piprites_chloris', 'Rhegmatorhina_hoffmannsi', 'Tachuris_rubrigastra', 'Manacus_manacus', 'Aphelocoma_coerulescens', 'Brachypodius_atriceps', 'Chlorodrepanis_virens', 'Copsychus_sechellarum', 'Corvus_brachyrhynchos', 'Corvus_cornix', 'Corvus_moneduloides', 'Erithacus_rubecula', 'Ficedula_albicollis', 'Geospiza_fortis', 'Hemignathus_wilsoni', 'Junco_hyemalis', 'Lonchura_striata', 'Loxia_curvirostra', 'Melospiza_melodia', 'Menura_novaehollandiae', 'Molothrus_ater', 'Parus_major', 'Passer_domesticus', 'Phylloscopus_trochilus', 'Poecile_atricapillus', 'Pseudopodoces_humilis', 'Rhodinocichla_rosea', 'Serinus_canaria', 'Setophaga_coronata', 'Sporophila_hypoxantha', 'Sturnus_vulgaris', 'Sylvia_atricapilla', 'Sylvietta_virens', 'Taeniopygia_guttata', 'Zonotrichia_albicollis', 'Zosterops_lateralis', 'Nipponia_nippon', 'Picoides_pubescens', 'Melopsittacus_undulatus', 'Rhea_americana', 'Aptenodytes_forsteri', 'Strix_occidentalis', 'Struthio_camelus', 'Eudromia_elegans']

for line in fh:
    #chr3       938     953
    if line=="":break
    line_list = line.strip().split()
    start = int(line_list[1])
    end =  int(line_list[2])
    
    #generate a list to inculde all species in a UCE
    species_in_alignment = []
     
    #accepts a list of start and end positions, and yields MultipleSeqAlignment objects that overlap the given intervals 
    results = idx.search([start], [end])
    
    for multiple_alignment in results:
        for seqrec in multiple_alignment:
            #print (seqrec.seq)
            sequence_name = seqrec.id
            sequence_name_short = seqrec.id.split('.')[0]
            species_in_alignment.append(sequence_name_short)


    #get species list in the alignment         
    species_in_alignment = list(set(species_in_alignment))
    #get information of species not found in the species_list
    missing_species = list(set(species_list).difference(set(species_in_alignment)))
    #get number of lost vocal learners
    shared_vocal_species = set(songbird_list) & set(species_in_alignment)
    missing_vocal_learner_num = 32 - len(list(shared_vocal_species))   
    if parrot not in species_in_alignment:
        outh.write(':'.join(line_list) + '\n')
    elif hummingbird  not in species_in_alignment:
        outh.write(':'.join(line_list) + '\n')
    elif missing_vocal_learner_num >= 16 :
        outh.write(':'.join(line_list) + '\n')
    else:
        print (("%s have enough vocal learners") %(':'.join(line_list)))
        
    #get missing species list 
    if missing_species:
        outh_2.write(':'.join(line_list)  + '\t' + '\t'.join(missing_species) +'\n')

fh.close()    
outh_2.close()
outh.close()
