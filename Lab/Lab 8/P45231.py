def fibs():
    a = 0
    yield a
    b = 1
    while True:
        yield b
        a, b = b, a + b

def roots(n):
    a = n
    yield a
    b = 0.5 * (a + n / a)
    while True:
        yield b
        a, b = b, 0.5 * (b + n / b)


# Return a boolean that indicates if the given number is prime or not
def isPrime(x):
    if (x <= 1):
        return False
    for i in range(2, x):
        if (x % i == 0):
            return False
    return True

def primes():
    a = 1
    while True:
        if isPrime(a):
            yield a
        a += 1

def isHammings(n):
    if (n == 1):
        return True
    elif (n % 2 == 0):
        return isHammings(n / 2)
    elif (n % 3 == 0):
        return isHammings(n / 3)
    elif (n % 5 == 0):
        return isHammings(n / 5)
    else:
        return False

def hammings():
    a = 1
    while True:
        if isHammings(a):
            yield a
        a += 1