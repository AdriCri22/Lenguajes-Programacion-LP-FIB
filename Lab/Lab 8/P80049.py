from functools import reduce


def count_unique(list):
    return len(set(list))


def remove_duplicates(list):
    return set(list)


def flatten(list):
    if list == []:
        return []
    else:
        def concat(list1, list2): return list1 + list2
        return reduce(concat, list)


def flatten_rec(L):
    if L == []:
        return L
    elif isinstance(L[0], list):
        return flatten_rec(L[0]) + flatten_rec(L[1:])
    else:
        return L[:1] + flatten_rec(L[1:])
