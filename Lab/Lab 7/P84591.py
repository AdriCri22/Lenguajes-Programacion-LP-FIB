import math


# Return de absolute value of the given number
def absValue(x):
    if (x < 0):
        return -1 * x
    else:
        return x


# Returns x^p
def power(x, p):
    return x ** p


# Return a boolean that indicates if the given number is prime or not
def isPrime(x):
    if (x <= 1):
        return False
    for i in range(2, x):
        if (x % i == 0):
            return False
    return True


# Return the n-th element of the Fibonacci sequence of the given number
def slowFib(n):
    if (n == 0):
        return 0
    if (n == 1):
        return 1
    return slowFib(n - 1) + slowFib(n - 2)


# Return the n-th element of the Fibonacci sequence of the given number
def quickFib(n):
    if (n < 2):
        return n

    u = ((1 + math.sqrt(5)) / 2)
    j = ((u ** n - (1 - u) ** n) / math.sqrt(5))
    return round(j)
