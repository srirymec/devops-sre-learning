#list declaration
a = []
print a
print "#"*75
print type(a)
print list()
print "#"*75
ab =[10,20,'hello']
print a
b = [10,20,['a','b'],50,60]
print b
print "#"*75
print b[2]
b[2] ='replaced'
print b
print "#"*75
#two diamensional arrays
a = [[1,2],[3,4]]
print a[0]
print a[1]
print a[0][1]
print a[1][1]
print "#"*75
print 20 in ab
print ['a','b'] in b
#using for loop
for i in ab:
    print i
print "#"*75
#list operations
c = [1,2,3]
d = [4,5,6]
e = c+d
print e
f = e*4
print f
print "#"*75
print f[0]
print f[3:6]
print f[::-1]
print f[:4]
print "#"*75
m = []
m.append(100)
m.append(['a','b'])
m.append(200)
del m[0]
print "#"*75
h = [4,5,2,8,6,88,55,77,22,100]
h.sort()
print h
h.sort(reverse=True)
print h
print sum(h)
print len(h)

