#defining a dictionary
a = {}
print a
print type(a)
print "#"*75
a['x'] = 10
a['y'] = 20
a['z'] = 30
print a
print "#"*75
print 'x' in a
print 10 in a
print "#"*75
#Dicttionary functions
print a.keys()
print a.values()
print len(a)
del a['x']
print a
a.clear()
print a
print "#"*75
#for loop
c = {'y': 20, 'x': 10, 'z': 30}
for key in c :
    print key,c[key]
    
