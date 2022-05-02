flatten :: [[Int]] -> [Int]
flatten = foldl (++) []

-- flatten = concat

myLength :: String -> Int
myLength = sum . map(const 1)

-- myLength = length

-- USING RECURSION:
-- myLength [] = 0
-- myLength word = 1 + myLength (drop 1 word)

-- x1 : x2 : x3 : ... : xn : []     =>      xn : x(n-1) : ... : x3 : x2 : x1 : []
-- foldl (flip (:)) [] [x1, x2, x3]   =>  flip (:) (flip (:) (flip (:) [] x1) x2) x3    (al aplicar el flip) =>    [x1] -> [x2, x1] -> [x3, x2, x1]
myReverse :: [Int] -> [Int]
myReverse = foldl (flip (:)) []

-- myReverse a = foldl (flip (++)) [] (map (\x -> [x]) a)

-- myReverse a = foldl (\xy -> y ++ x) [] (map (\x -> [x]) a)

-- myReverse = reverse

countIn :: [[Int]] -> Int -> [Int]
countIn xs n = map countn xs
    where 
        countn = sum . map (\y -> if n == y then 1 else 0)

-- USING RECURSION:
-- countIn [] _ = []
-- countIn (x:xs) n
--     | null xs    = [length $ filter (==n) x]
--     | otherwise  = length (filter (==n) x) : countIn xs n

firstWord :: String -> String
firstWord word 
    | head word == ' '    = takeWhile (/=' ') (dropWhile (==' ') word)
    | otherwise           = takeWhile (/=' ') word