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