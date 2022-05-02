absValue :: Int -> Int
absValue n
    |   n >= 0      = n
    |   otherwise   = -n

power :: Int -> Int -> Int
power _ 0 = 1
power x p = x * power x (p - 1)

isPrime :: Int -> Bool
isPrime n 
    |   n <= 1      = False
    |   n == 2      = True
    |   otherwise   =  null [ x | x <- [2..(ceiling (sqrt (fromIntegral n)))], n `mod` x == 0]

--divide :: Int -> [Int] -> Bool
-- divide x []      = False
-- divide x (y:ys)  = mod x y == 0 || divide x ys

--isPrime 0     = False
--isPrime 1     = False
--isPrime n     = not divide n [2..floor(sqrt(formIntegral(n)))]

--isPrime n
--    | n == 1    = False
--    | otherwise =isPrimeAux n (sqrt n)
--    where
--        isPrimeAux n m
--            | m == 1          = True 
--            | mod n m == 0    = False
--            | otherwise       = isPrimeAux n m-1


slowFib :: Int -> Int
slowFib 0 = 0
slowFib 1 = 1
slowFib n = slowFib(n - 1) + slowFib(n - 2)

quickFib :: Int -> Int
quickFib n
    |   n < 2       = n
    |   otherwise   = round ((u^n - (1 - u)^n) / sqrt 5)
        where
            u = (1 + sqrt 5) / 2

--quickFib' :: Int -> Int -> Int -> Int -> Int
--quickFib' c f1 f2 l   = if c >= l then f1 else quickFib' (c+1) f2 (f1+f2) l

--quickFib 0 = 0
--quickFib 1 = 1
--quickFib n = quickFib' 0 0 1 n