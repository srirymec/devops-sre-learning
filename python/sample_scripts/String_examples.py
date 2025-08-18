#Strings and its functionalities

#Defining a string
a = "Hello world"
print a
print "#"*75
#Printing type of the srtring
print type(a)
print "#"*75
a = "Hello \n World"
print a
print "#"*75
a = """hello
world"""
print a
print "#"*75
a = '"hello" ,world'
print a
print "#"*75
a = "Hello world"
print len(a)
print a[0]
print a[5]
print a[-1]
print a[-5]
print "#"*75
#using for loop
a = "Hello world"
for ch in a :
    print ch
print "#"*75
#using while loop
a = "Hello world"
length = len(a)
index = 0
while (index<length):
    print a[index]
    index = index +1
print "#"*75
#String Slicing
print a[6:10]
print a [:5]
print a[6:]
print a[:]
print a[::2]
print a[::-1]
print "#"*75
#String Functions
print a.upper()
print a.lower()
print a.isupper()
print a.swapcase()
print a.endswith('rld')
print a.count('e')
print a.replace('world','universe')
print a
print "#"*75
print a.split()
