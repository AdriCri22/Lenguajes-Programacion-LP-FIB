class Tree:
     def __init__(self, x):
         self.rt = x
         self.child = []
 
     def add_child(self, a):
         self.child.append(a)
 
     def root(self):
         return self.rt
 
     def ith_child(self, i):
         return self.child[i]
 
     def num_children(self):
         return 1 + len(self.child)

class Pre(Tree):
    def preorder(self):
        list = []
        for child in self.child:
            list = list + child.preorder()

        return [self.root()] + list