from functools import reduce


def evens_product(L):
    if L != []:
        L2 = list(filter(lambda x: x % 2 == 0, L))
        if L2 != []:
            return reduce(lambda x, y: x * y, L2)
    return 1


def reverse(L):
    return reduce(lambda x, y: [y] + x, L, [])


def zip_with(f, L1, L2):
    return [f(x, y) for (x, y) in zip(L1, L2)]


def count_if(f, L):
    return len([x for x in L if f(x)])
