data Tree a = Node a (Tree a) (Tree a) | Empty deriving (Show)

t7 = Node 7 Empty Empty
t6 = Node 6 Empty Empty
t5 = Node 5 Empty Empty
t4 = Node 4 Empty Empty
t3 = Node 3 t6 t7
t2 = Node 2 t4 t5
t1 = Node 1 t2 t3
t1' = Node 1 t3 t2

size :: Tree a -> Int
size Empty = 0
size (Node _ left right) = 1 + (size left) + (size right)

height :: Tree a -> Int
height Empty = 0
height (Node _ left right) = 1 + max (height left) (height right)

equal :: Eq a => Tree a -> Tree a -> Bool
equal Empty Empty = True
equal Empty _ = False
equal _ Empty = False
equal (Node a la ra) (Node b lb rb) = a == b && (equal la lb) && (equal ra rb)

isomorphic :: Eq a => Tree a -> Tree a -> Bool
isomorphic Empty (Node _ _ _)   = False
isomorphic (Node _ _ _) Empty   = False
isomorphic Empty Empty          = True
isomorphic (Node a la ra) (Node b lb rb)
    | a == b                    = ((isomorphic la lb) && (isomorphic ra rb)) || ((isomorphic la rb) && (isomorphic lb ra))
    | otherwise                 = False

preOrder :: Tree a -> [a]
preOrder Empty = []
preOrder (Node a left right) = a : (preOrder left) ++ (preOrder right)

postOrder :: Tree a -> [a]
postOrder Empty = []
postOrder (Node a left right) = (postOrder left) ++ (postOrder right) ++ [a]

inOrder :: Tree a -> [a]
inOrder Empty = []
inOrder (Node a left right) = (inOrder left) ++ [a] ++ (inOrder right)

build :: Eq a => [a] -> [a] -> Tree a 
build _ [] = Empty
build [] _ = Empty
build (x:xs) ys = Node x (build postOrderL inOrderL) (build postOrderR inOrderR) 
        where
            inOrderL = takeWhile (/=x) ys
            postOrderL = take (length inOrderL) xs
            inOrderR = drop 1 (dropWhile (/=x) ys) 
            postOrderR = drop (length inOrderL) xs

breadthFirst :: Tree a -> [a]
breadthFirst t = bf [t]
    where
        bf [] = []
        bf (Empty:xs) = bf xs
        bf ((Node x tl tr):xs) = [x] ++ bf (xs ++ [tl, tr])

overlap :: (a -> a -> a) -> Tree a -> Tree a -> Tree a
overlap _ Empty b = b
overlap _ a Empty = a
overlap func (Node a la ra) (Node b lb rb) = (Node (func a b) (overlap func la lb) (overlap func ra rb))