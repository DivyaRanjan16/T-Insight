import requests
o=input("Enter organism name:")
print("Enter the GFF file name:")
gbfile = input().strip()

try:
    with open(gbfile, 'r') as fh:
        data = fh.readlines()
except IOError:
    print("Unable to open the file. Try again.")
    exit()
pos=[]
for i in range(len(data)):
    if("##gff-version 3" in data[i]):
       pos.append(i)
       pos.append(i+1)

data = [elem for index, elem in enumerate(data) if index not in pos]
uid=[]
region=[]
tr1=[]
tr2=[]
for i in range(len(data)):
    a=data[i].split("\n")
    b=a[0].split("\t")
    try:
        uid.append(b[0])
        region.append(b[2])
        tr1.append(int(b[3]))
        tr2.append(int(b[4]))
    except(IndexError):
        continue

uid=[item for item in uid if item.strip()]

trans_reg=[]
start=[]
end=[]
diff=[]
tr_uid=[]
for j in range(len(uid)):
    if('Transmembrane' in region[j]):
        tr_uid.append(uid[j])
        trans_reg.append(region[j])
        start.append(tr1[j])
        end.append(tr2[j])
        
seq=[]
for i in range(len(tr_uid)):
    link2 = f"https://rest.uniprot.org/uniprotkb/{tr_uid[i]}.fasta" 
    response2 = requests.get(link2)
    fasta = response2.text
    fasta1=fasta.split("\n")
    fasta2=fasta1.pop(0)
    fasta3=''.join([str(elem) for elem in fasta1])
    seq.append(fasta3)


da=[]      
for k in range(len(start)):
    for m in range(start[k]-1,end[k]):
        da.append(f"{seq[k][m]}")
    da.append("\n")

trans_seq = []
group = []

for char in da:
    if char != '\n':
        group.append(char) 
    else:
        trans_seq.append("".join(group))
        group = []  
if group:
    trans_seq.append("".join(group))
    
hyd = {
    "A": 1.800, "R": -4.500, "N": -3.500, "D": -3.500, "C": 2.500,
    "E": -3.500, "Q": -3.500, "G": -0.400, "H": -3.200, "I": 4.500,
    "L": 3.800, "K": -3.900, "M": 1.900, "F": 2.800, "P": -1.600,
    "S": -0.800, "T": -0.700, "W": -0.900, "Y": -1.300, "V": 4.200
}

add=0
hydro=[]
for i in range(len(trans_seq)):
    for j in range(len(trans_seq[i])):
        base=trans_seq[i][j]
        add=add+hyd[f"{base}"]
    hydro.append(add)
    add=0
f2=open(f"trans{o}.tsv", "w")
f2.write(f"trans_region\ttrans_id\tStart_position\tEnd_position\tDifference\tHydropathy\tPart\tSequence\n")
for j in range(len(trans_reg)):
    f2.write(f"{trans_reg[j]}\t{tr_uid[j]}\t{start[j]}\t{end[j]}\t{end[j]-start[j]+1}\t{hydro[j]}\t{hydro[j]/(end[j]-start[j]+1)}\t{trans_seq[j]}\n")

