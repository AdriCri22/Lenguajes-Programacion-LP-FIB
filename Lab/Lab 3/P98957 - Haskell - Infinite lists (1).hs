ones :: [Integer]
-- ones = repeat 1
-- ones = cycle [1]
-- ones = iterate id 1
ones = 1 : ones

nats :: [Integer]
-- nats = [0..]
-- nats = iterate (+1) 0
nats = 0 : map (+1) nats

ints :: [Integer]
-- ints = 0:concatMap(\x -> [x, -x]) (iterate (+1) 1)

ints = tail $ concat $ map f nats
    where
        f x = [x, -x]

-- ints = tail $ foldr (++) $ map f nats
--     where
--         f x = [x, -x]

triangulars :: [Integer]
-- triangulars = [q | x<-[1..], let q = div (x*(x-1)) 2]

-- triangulars = tail $ scanl (+) 0 nats 

-- triangulars = map f nats
--     where
--         f n = div (n * (n+1)) 2

triangulars = scanl (+) 0 [1..]

factorials :: [Integer]
factorials = scanl (*) 1 [1..]

-- factorials = 1 : zipWith (*) factorials [1..]

-- Es la suma de los elementos de fib + los elementos de fib 
-- desplazados 1 elemento hacia la derecha, es decir, quitando 
-- el primer elemento de la lista

-- Dado que los dos primeros elementos no los tenemos los tenemos 
-- que concatenar 
-- fibs         [0,1,1,2,3,5,  8,13]
-- tail fibs    [1,1,2,3,5,8, 13]
-- new fibs     [1,2,3,5,8,13,21]
fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

primes :: [Integer]
primes = garbell [2..]
    where
        garbell (p : xs) = p : garbell [x | x <- xs, x `mod` p /= 0]


hammings :: [Integer]
-- hammings = 1 : merge (merge (map (*2) hammings) (map (*3) hammings)) (map (*5) hammings)

merge :: Ord a => [a] -> [a] -> [a]
merge _ []  = []
merge [] _  = []
merge (x:xs) (y:ys)
    | y < x     = y : merge (x:xs) ys
    | y == x    = y : merge xs ys
    | otherwise = x : merge xs (y:ys)

hammings = 1 : merge3 (map (*2) hammings) (map (*3) hammings) (map (*5) hammings)
    where
        merge3 xs ys zs = merge xs (merge ys zs)

lookNsay :: [Integer]
lookNsay = map toInteger $ iterate next "1"
    where
        toInteger :: String -> Integer
        toInteger = read

        next :: String -> String
        next [] = []
        next x = convert prefix ++ next suffix
            where
                prefix = takeWhile (== head x) x
                suffix = dropWhile (== head x) x
                convert s = show (length s) ++ [head s]

--     1
--    1 1
--   1 2 1
--  1 3 3 1
-- 1 4 6 4 1

-- 1 3 3 1 0
-- 0 1 3 3 1 +
-- 1 3 4 3 1
tartaglia :: [[Integer]]
tartaglia = iterate next [1]
    where
        next xs = zipWith (+) (0:xs) (xs ++ [0])

-- tartaglia = func 0

-- func :: Integer -> [[Integer]]
-- func n = pascal n : func (n+1)

-- pascal :: Integer -> [Integer]
-- pascal x = [div (fac x) (fac y * fac (x-y)) | y <- [0..x]]

-- fac :: Integer -> Integer
-- fac 0 = 1
-- fac n = n * fac (n - 1)