data Tree a = Node a (Tree a) (Tree a) | Empty

instance Show a => Show (Tree a) where
    show (Empty) = "()"
    show (Node p l r) = "(" ++ show l ++ "," ++ show p ++ "," ++ show r ++ ")"

doubleT :: Num a => Tree a -> Tree a
doubleT a = fmap (*2) a

instance Functor Tree where
    fmap func Empty = Empty
    fmap func (Node p l r) = Node (func p) (fmap func l) (fmap func r)

data Forest a = Forest [Tree a] deriving Show

instance Functor Forest where
    fmap = fmap

doubleF :: Num a => Forest a -> Forest a
doubleF (Forest l) = Forest $ map (fmap (*2)) l