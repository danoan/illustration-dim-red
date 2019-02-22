#!/usr/bin/python3

import json
import numpy as np

DATA_FOLDER="data/treated-data"

json_files = ['2015_edit.json','2016_edit.json','2017_edit.json','2018_edit.json']
years = [2015,2016,2017,2018]

year_file = zip(years,json_files)

#print("*** Reading data...")

entries=[]
for year,filename in year_file:
	f = open( "%s/%s" % (DATA_FOLDER,filename) )
	temp = json.load(f)
	for t in temp:
		t['year']=year
	entries.extend(temp)

m=[]
m.append( [ e["price"] for e in entries] )
m.append( [ e["year"] for e in entries] )
m.append( [ e["square_feet"] for e in entries ] )

#print("***Computing SVD factorization...\n")

s,v,d = np.linalg.svd(m)

#print("S: ", s)
#print("V: ", v)


#print("\n***Projecting observations into the 2 first principal components...")

B = s[:,0:2]

P = np.dot( np.linalg.inv( np.dot(B.transpose(),B) ),B.transpose() )
Pu = np.dot(P,m)

#I have only positive quantities. Make sure that I am using the right normal vector direction.
s1 = -1 if Pu[0,0]<0 else 1
s2 = -1 if Pu[1,0]<0 else 1
#print("Error: ", np.linalg.norm( np.dot(B,Pu)-m ) )

coeffs = np.cross(B[:,0],B[:,1])
gnuplot="%.4f*x + %.4f*y" % (s1*coeffs[0]/coeffs[2],s2*coeffs[1]/coeffs[2])

print(gnuplot)
