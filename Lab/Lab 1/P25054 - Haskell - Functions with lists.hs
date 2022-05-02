myLength :: [Int] -> Int
myLength = length

myMaximum :: [Int] -> Int
myMaximum = maximum

average :: [Int] -> Float
average xs = realToFrac (sum xs) / fromIntegral (length xs)

buildPalindrome :: [Int] -> [Int]
buildPalindrome xs = reverse xs ++ xs

remove :: [Int] -> [Int] -> [Int]
remove [] _ = []
remove (x:xs) ys
    |   x `elem` ys   = remove xs ys
    |   otherwise   = x : remove xs ys

--removeItem :: Int -> [Int] -> [Int]
--removeItem _ [] = []
--removeItem x (y:ys)
--  | x == y    = removeitem x ys
--  | otherwise y : (removeItem x ys)

--remove xs [] = xs
--remove xs (y:ys) = remove (removeItem y xs) ys


flatten :: [[Int]] -> [Int]
flatten = concat

--flatten [] = []
--flatten (x:xs) = x ++ flatten xs

oddsNevens :: [Int] -> ([Int], [Int])
oddsNevens [] = ([], [])
oddsNevens (x:xs)
    | odd x     = (x : xo, xe)
    | otherwise = (xo, x : xe)
    where
        (xo, xe) = oddsNevens xs

--oddsNevens [] = ([], [])
--oddsNevens (x:xs)
-- let (od, ev) = oddsNevens xs
-- in if odd x
--  then (x:od, ev)
--  else (od, x:ev)

isPrime :: Int -> Bool
isPrime n
    |   n <= 1      = False
    |   n == 2      = True
    |   otherwise   = null [ x | x <- [2..(ceiling (sqrt (fromIntegral n)))], n `mod` x == 0]

primeDivisors :: Int -> [Int]
primeDivisors n = [x | x <- [1..n], rem n x == 0 && isPrime x]