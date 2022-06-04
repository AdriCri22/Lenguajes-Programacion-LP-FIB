diffSqrs :: Integer -> Integer
diffSqrs n = x - y
    where 
        x = sum [1..n] ^2
        y = sum $ map (^2) [1..n]

pythagoreanTriplets :: Int -> [(Int, Int, Int)]
pythagoreanTriplets n = [(a, b, n - a - b) | a <- [1..n], b <- [a..n], a^2 + b^2 == (n - a - b)^2]

tartaglia :: [[Integer]]
tartaglia = iterate next [1]
    where
        next xs = zipWith (+) (0:xs) (xs ++ [0])

sumDigits :: Integer -> Integer
sumDigits n = sum $ digits n
    where
        digits :: Integer -> [Integer]
        digits 0 = []
        digits x = digits (div x 10) ++ [mod x 10]

digitalRoot :: Integer -> Integer
digitalRoot n = if n < 10 then n else digitalRoot (sumDigits n)