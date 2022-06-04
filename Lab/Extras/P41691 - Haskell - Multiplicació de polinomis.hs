add :: [Double] -> [Double] -> [Double]
add xs [] = xs
add [] ys = ys
add (x:xs) (y:ys) = (x + y) : add xs ys 

mult' :: [Double] -> [Double] -> [Double]
mult' [] _ = []
mult' (x:xs) ys = add (map (*x) ys) (0 : mult' xs ys)

mult :: [Double] -> [Double] -> [Double]
mult xs ys = take (length xs + length ys) $ mult' xs ys ++ repeat 0