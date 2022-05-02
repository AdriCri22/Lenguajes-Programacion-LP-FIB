data Queue a = Queue [a] [a]
     deriving (Show)

c = push 3 (push 2 (push 1 create))

create :: Queue a
create = Queue [] []

push :: a -> Queue a -> Queue a
push n (Queue f l) = Queue f (n:l)

pop :: Queue a -> Queue a
pop (Queue [] l)    = Queue (reverse $ init l) []
pop (Queue f l)     = Queue (tail f) l

top :: Queue a -> a
top (Queue [] l)    = last l
top (Queue f _)     = head f

empty :: Queue a -> Bool
empty (Queue [] []) = True
empty (Queue _ _) = False 


instance Eq a => Eq (Queue a)
     where
        (Queue [] []) == (Queue [] [])  = True
        (Queue f1 l1) == (Queue f2 l2)
            | f1 ++ (reverse l1) == f2 ++ (reverse l2)  = True
            | otherwise                                 = False

instance Functor Queue where
    fmap f (Queue l r) = Queue (fmap f l) (fmap f r)

translation :: Num b => b -> Queue b -> Queue b
translation op q = fmap (+op) q

-- qLlista :: Queue a -> [a]
-- qLlista (Queue l1 l2) = l1 ++ reverse l2

-- instance Applicative Queue where
--     pure x = Queue [] [x]
--     f <*> q = Queue(qLlista f <*> qLlista q) []

instance Applicative Queue where
    pure p = Queue [p] []
    (Queue l1 rl1) <*> (Queue l2 rl2) = Queue [f x | f <- l1 ++ reverse rl1, x <- l2 ++ reverse rl2] []

-- instance Monad Queue where
--     return x = Queue [] [x]
--     q >>= f = Queue(concatMap (qLlista . f) (qLlista q)) []

instance Monad Queue where
    return p = Queue [p] []
    (Queue l r) >>= f = foldl unio create $ map f $ l ++ reverse r

unio :: Queue a -> Queue a -> Queue a
unio (Queue l1 r1) (Queue l2 r2) = Queue (l1 ++ reverse r1 ++ l2 ++ reverse r2) []

kfilter :: (p -> Bool) -> Queue p -> Queue p
-- kfilter op q = do
--     x <- q
--     if op x then  
--         return x
--     else 
--         create

kfilter f q = q >>= g
    where
        g v = if f v then return v else create