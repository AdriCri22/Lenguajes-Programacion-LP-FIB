fact1 :: Integer -> Integer
fact1 n = product [1..n]

fact2 :: Integer -> Integer
fact2 1 = 1
fact2 n = n * fact2 (n - 1)

fact3 :: Integer -> Integer
fact3 n
    | n == 1    = 1
    | otherwise = n * fact3 (n - 1)

fact4 :: Integer -> Integer
fact4 n = if n == 1 then 1 else n * fact4 (n - 1)

fact5 :: Integer -> Integer
fact5 n = foldl (*) 1 [1..n]

fact6 :: Integer -> Integer
fact6 n = foldr (*) 1 [1..n]

fact7 :: Integer -> Integer
fact7 n = foldl (\x y -> x * y) 1 [1..n]

fact8 :: Integer -> Integer
fact8 n = last $ scanl (*) 1 [1..n]

fact9 :: Integer -> Integer
fact9 n = head $ scanr (*) 1 [1..n]