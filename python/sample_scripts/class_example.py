class calculator:
    def __init__(self,x,y):
        self.x = x
        self.y = y
    def addition(self):
        a = self.x
        b = self.y
        c = a+b
        return c
    def subtraction(self):
        a = self.x
        b = self.y
        c = a-b
        return c
    def multiplication(self):
        a = self.x
        b = self.y
        c = a*b
        return c
    def division(self):
        a = self.x
        b = self.y
        c = a/b
        return c
val = calculator(5,6)
add = val.addition()
print add
sub = val.subtraction()
print sub
mul = val.multiplication()
print mul
div = val.division()
print div
