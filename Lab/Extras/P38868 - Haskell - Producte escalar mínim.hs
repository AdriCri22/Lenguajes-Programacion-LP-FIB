qsort :: [Int] -> [Int]
qsort [] = []
qsort (p:xs) = qsort lower ++ [p] ++ qsort greater
    where
        lower = [x | x <- xs, x < p]
        greater = [x | x <- xs, x >= p]

minProd :: [Int] -> [Int] -> Int
minProd l1 l2 = sum $ zipWith (*) l1' l2'
    where
        l1' = qsort l1
        l2' = reverse $ qsort l2