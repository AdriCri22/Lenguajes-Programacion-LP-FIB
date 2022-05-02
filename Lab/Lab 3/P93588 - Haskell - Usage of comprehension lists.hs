myMap :: (a -> b) -> [a] -> [b] 
myMap func xs = [func x | x <- xs]

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter cond xs = [x | x <- xs, cond x]

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith func xs ys = [func x y | (x, y) <- zip xs ys]

thingify :: [Int] -> [Int] -> [(Int, Int)]
thingify xs ys = [(x, y) | x <- xs, y <- ys, mod x y == 0]

factors :: Int -> [Int]
factors n = [x | x <- [1..n], mod n x == 0]