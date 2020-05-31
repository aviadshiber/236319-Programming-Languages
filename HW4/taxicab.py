
def cube(num):
    return num*num*num
def cube_root(num):
    return num**(1./3.)
def is_two_cubes(k, a):
    qr = cube_root(k-cube(a))
    return abs(round(qr)-qr) <= 0.00000001

def is_taxi_number(k):
    global count
    global a
    while cube(a) < (k/2):
        count += 1
        if is_two_cubes(k, a):
            return True
        a += 1
    return False


k = 3
count = 0
temp = 0
while True:
    count += 1
    a = 1
    if is_taxi_number(k):
        temp = a
        a += 1
        if is_taxi_number(k):
            if (cube(temp)+cube(a)) != k:
                print('the taxicab number is ', k)
                print('the counter is ', count)
                print('the number of conditions are', count)
                break

    k += 1








