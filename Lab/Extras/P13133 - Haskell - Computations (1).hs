sumMul :: Integer -> Integer -> Integer
sumMul n f = f * n1 * (n1 + 1) `div` 2
  where
    n1 = (n - 1) `div` f

sumMultiples35 :: Integer -> Integer
sumMultiples35 n = f 3 + f 5 - f 15
    where
        f = sumMul n

-- Quickfib        fib
--     |            |
--     v            v
-- +-------+    +-------+    +-------------+
-- |  (:)  | ,->|  (:)  | ,->|   zipWith   |
-- +---+---+ |  +---+---+ |  +-----+---+---+
-- | 0 | o---'  | 1 | o---'  | (+) | o | o |
-- +---+---+    +---+---+    +-----+-|-+-|-+
--   ^            ^                  |   |
--   |            `------------------|---'
--   `-------------------------------'
quickFib :: [Integer]
quickFib = 0 : fib
    where
        fib = 1 : zipWith (+) quickFib fib

-- a!!1 (Haskell) ≡ a[1] (c++)
fibonacci :: Int -> Integer
fibonacci n = quickFib!!n

sumEvenFibonaccis :: Integer -> Integer
sumEvenFibonaccis n = sum $ filter even $ takeWhile (<n) quickFib

largestPrimeFactor :: Int -> Int
largestPrimeFactor 1 = 1
largestPrimeFactor n =
    let m = head $ filter (\x -> mod n x == 0) [2 .. n]
        q = div n m
    in if q == 1
        then m
        else largestPrimeFactor q

isPalindromic :: Integer -> Bool
isPalindromic n = reverse (show n) == show n
