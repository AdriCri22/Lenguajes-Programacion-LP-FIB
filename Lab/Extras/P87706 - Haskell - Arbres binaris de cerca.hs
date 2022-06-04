data BST a = E | N a (BST a) (BST a) deriving (Show)

insert :: Ord a => BST a -> a -> BST a
insert E a = N a E E
insert (N a l r) b
    | a > b     = N a (insert l b) r
    | a < b     = N a l (insert r b)
    | otherwise = N b l r

create :: Ord a => [a] -> BST a
create xs = foldl insert E xs

remove :: Ord a => BST a -> a -> BST a
remove E _ = E
remove (N a l r) b
    | a > b     = N a (remove l b) r
    | a < b     = N a l (remove r b)
    | otherwise = remove' l r
        where
            remove' :: BST a -> BST a -> BST a
            remove' E E = E
            remove' E (N a l r) = (N a l r)
            remove' (N a l r) E = (N a l r)
            remove' (N a1 l1 r1) (N a2 l2 r2) = modify (N a2 l2 r2) (N a1 l1 r1)
                where
                    modify :: BST a -> BST a -> BST a
                    modify E (N a l r) = (N a l r)
                    modify (N a1 l1 r1) (N a2 l2 r2) = N a1 (modify l1 (N a2 l2 r2)) r1

contains :: Ord a => BST a -> a -> Bool
contains E _ = False
contains (N a l r) b
    | a > b     = contains l b
    | a < b     = contains r b
    | otherwise = True

getmax :: BST a -> a
getmax (N a _ E) = a
getmax (N _ _ r) = getmax r

getmin :: BST a -> a
getmin (N a E _) = a
getmin (N _ l _) = getmin l

size :: BST a -> Int
size E = 0
size (N _ l r) = 1 + size l + size r

elements :: BST a -> [a]
elements E = []
elements (N a l r) = elements l ++ [a] ++ elements r