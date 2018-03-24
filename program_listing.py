import json,os

desc_files = [x for x in os.listdir(".") if x.endswith(".description")]

#print desc_files

progs = []

for fn in desc_files:
	with open(fn) as f:
		prog = dict()
		prog["name"]=f.readline().strip()
		prog["location"]=f.readline().strip()
		prog["desc"]=f.readline().strip()
		progs.append(prog)

with open("list.json","w") as f:
	json.dump(dict(programs=progs),f)
