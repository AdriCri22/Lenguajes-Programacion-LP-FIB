eql :: [Int] -> [Int] -> Bool
-- eql xs ys = xs == ys

eql xs ys = length xs == length ys && and (zipWith (==) xs ys)

prod :: [Int] -> Int
prod = foldl (*) 1
-- foldl (*) 1      ==      product

prodOfEvens :: [Int] -> Int
prodOfEvens xs = foldl (*) 1 (filter even xs)

powersOf2 :: [Int]
powersOf2 = iterate (*2) 1

scalarProduct :: [Float] -> [Float] -> Float
scalarProduct xs ys = foldl (+) 0 (zipWith (*) xs ys)