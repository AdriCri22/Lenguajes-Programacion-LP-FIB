import math


# Returns the length of the given list
def myLength(L):
    return len(L)


# Returns the maximum element of the list
def myMaximum(L):
    return max(L)


# Returns the average of the list
def average(L):
    return sum(L) / len(L)


# Returns the polindrome that starts with the reverse of list
def buildPalindrome(L):
    return L[::-1] + L


# Given a list L1 and a list L2, returns the list L1 after removing the
# occurrences of the elements in L2.
def remove(L1, L2):
    L1 = [ x for x in L1 if not x in L2 ]
    return L1


# Recursively flattens a list whose elements may also be lists of different levels
def flatten(L):
    if len(L) == 0:
        return L
    if isinstance(L[0], list):
        return flatten(L[0]) + flatten(L[1:])
    return L[:1] + flatten(L[1:])


# given a list of integers, returns two lists, one with all the odd numbers and
# one with all the even numbers, in the same relative order than the original.
def oddsNevens(L):
    odds = []
    evens = []
    for i in L:
        if (i % 2 == 0):
            evens.append(i)
        else:
            odds.append(i)
    return odds, evens


# Returns the list of all prime divisors of a non-zero positive integer
def primeDivisors(n):
    values = []

    # Divide by 2 until the given number is odd
    while n % 2 == 0:
        if 2 not in values:
            values.append(2)
        n /= 2

    # Search all odd numbers between 3 and sqrt(n) the prime numbers
    for i in range(3, int(math.sqrt(n)) + 1, 2):
        # Divide by the same number as long as divisible
        while (n % i == 0):
            # If the number isn't in the list values add it
            if i not in values:
                values.append(i)
            n /= i

    # Check if n, after all divisions, is a prime number and add it to the list
    if n > 2:
        values.append(int(n))

    return values
