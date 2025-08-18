import os
#File handling in python
path = os.getcwd()
#path = path + '\funtions_example.py'
f = open('funtions_example.py','r')
print "#"*75
m = f.read()
print m
f.close()
print "#"*75
h = open('funtions_example.py')
l = h.readlines()
print l
h.close()
print "#"*75
#Using for loop
k = open('funtions_example.py')
for line in k:
    print line
k.close()
print "#"*75
n = open('Test.txt','w')
n.write('hello i am writing')
n.close()
