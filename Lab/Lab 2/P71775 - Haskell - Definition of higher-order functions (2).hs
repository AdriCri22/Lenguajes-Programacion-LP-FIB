countIf :: (Int -> Bool) -> [Int] -> Int
countIf func xs = length([x | x <- xs, func x])

-- USING RECURSION:
-- countIf _ [] = 0
-- countIf func (x:xs)
--     | func x    = 1 + countIf func xs
--     | otherwise = countIf func xs

pam :: [Int] -> [Int -> Int] -> [[Int]]
pam _ [] = []
pam xs (y:ys) = map y xs : pam xs ys

pam2 :: [Int] -> [Int -> Int] -> [[Int]]
pam2 [] _ = []
pam2 (x:xs) ys = [y x | y <- ys] : pam2 xs ys

filterFoldl :: (Int -> Bool) -> (Int -> Int -> Int) -> Int -> [Int] -> Int
filterFoldl cond func n xs = foldl func n (filter cond xs)

-- ALTERNATIVE:
-- filterFoldl _ _ n [] = n
-- filterFoldl cond func n xs = foldl func n [x | x <- xs, cond x]

insert :: (Int -> Int -> Bool) -> [Int] -> Int -> [Int]
insert _ [] n = [n]
insert cond (x:xs) n
    | cond n x  = n:x:xs
    | otherwise = x:insert cond xs n

-- ALTERNATIVE:
-- insert f v x = takeWhile (flip f x) v ++ [x] ++ dropWhile (flip f x) v


insertionSort :: (Int -> Int -> Bool) -> [Int] -> [Int]
insertionSort _ [] = []
insertionSort cond xs = foldl (insert cond) [] xs

--             a   ->  b  ->   a    => molt similar al foldl
-- insert :: [Int] -> Int -> [Int]

-- foldl (insert cmp) [] l      on cmp -> <=    y   l = [4, 10, 1, 2]
-- 1) (insert cmp) []           4   = [4]
-- 2) (insert cmp) [4]          10  = [4, 10]
-- 3) (insert cmp) [4, 10]      1   = [1, 4, 10]
-- 4) (insert cmp) [1, 4, 10]   2   = [1, 2, 4, 10]