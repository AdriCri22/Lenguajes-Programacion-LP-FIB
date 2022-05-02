data STree a = Nil | Node Int a (STree a) (STree a) deriving Show

div10 = flip div 10
t1 = Node 3 99 (Node 1 88 Nil Nil) (Node 1 22 Nil Nil)
t2 = Node 2 77 (Node 1 33 Nil Nil) Nil
t3 = Node 6 44 t1 t2
t4 = Node 7 55 t1 t2

isOk :: STree a -> Bool
isOk Nil = True
isOk (Node t _ l r) = isOk l && isOk r && (t == mida l + mida r + 1)

mida :: STree a -> Int
mida Nil = 0
mida (Node t _ _ _) = t

nthElement :: STree a -> Int -> Maybe a
nthElement Nil _ = Nothing 
nthElement (Node t a l r) n
    | n == sl + 1   = Just a
    | n <= sl       = nthElement l n
    | otherwise     = nthElement r (n - sl - 1)
    where
        sl = mida l

mapToElements :: (a -> b) -> STree a -> [Int] -> [Maybe b]
mapToElements f t ns = map (fmap f) (map (nthElement t) ns)

instance Functor STree where
    fmap func Nil              = Nil
    fmap func (Node t x l r)   = Node t (func x) (fmap func l) (fmap func r)
