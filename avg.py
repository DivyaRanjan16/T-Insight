
print("Enter your Genbank file name:")
gbfile = input().strip()

try:
    with open(gbfile, 'r') as fh:
        data = fh.readlines()
except IOError:
    print("Unable to open the file. Try again.")
    exit()

part=[]
hyd=[]
diff=[]
for i in range(len(data)):
    a=data[i].split("\n")
    b=a[0].split("\t")
    try:
        part.append(float(b[6]))
        hyd.append(float(b[5]))
        diff.append(int(b[4]))
    except(ValueError):
        part.append(b[5])
        hyd.append(b[4])
        diff.append(b[3])

part1= [i for i in part if isinstance(i, float)]
hyd1= [i for i in hyd if isinstance(i, float)]
diff1= [i for i in diff if isinstance(i, int)]


avpart=avhyd=avdiff=0

for i in range(len(part1)):
    avpart=avpart+part1[i]
    avhyd=avhyd+hyd1[i]
    avdiff=avdiff+diff1[i]

print("Avarage of partition =" , avpart/len(part1))
print("Avarage of hydropathy =" , avhyd/len(hyd1))
print("Avarage of difference =" , avdiff/len(diff1))
