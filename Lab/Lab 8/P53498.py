class Tree:
    def __init__(self, x):
        self.rt = x
        self.child = []

    def addChild(self, a):
        self.child.append(a)

    def root(self):
        return self.rt

    def ithChild(self, n):
        return self.child[n]

    def numChildren(self):
        return len(self.child)

    def __iter__(self):
        yield self.root()

        L = self.child

        for child in L:
            for subChild in range(0, child.numChildren()):
                L.append(child.ithChild(subChild))
            yield child.root()