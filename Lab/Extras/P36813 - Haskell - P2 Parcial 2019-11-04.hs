import Data.List

degree :: Eq a => [(a, a)] -> a -> Int
degree l n = degreeRec l n 0
    where
        degreeRec :: Eq a => [(a, a)] -> a -> Int -> Int
        degreeRec [] _ c = c
        degreeRec ((x, y):xs) n c
            | (x == n) || (y == n)    = degreeRec xs n c+1
            | otherwise               = degreeRec xs n c

degree' :: Eq a => [(a, a)] -> a -> Int
degree' l n = length([x | (x, y) <- l, x == n || y == n])

neighbors :: Ord a => [(a, a)] -> a -> [a]
neighbors l n = sort ([y | (x, y) <- l, x == n] ++ [x | (x, y) <- l, y == n])