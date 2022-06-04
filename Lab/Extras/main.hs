quickSort :: [Int] -> [Int]
quickSort xs = divideNconquer qBase qDivide qConquer xs
    where
        qBase [] = Just []
        qBase [x] = Just [x]
        qBase _ = Nothing

        qDivide (p:xs) = ([x | x <- xs, x < p], [x | x <- xs, x >= p])

        qConquer (p:_) _ (y1, y2) = y1 ++ [p] ++ y2

divideNconquer :: (a -> Maybe b) -> (a -> (a, a)) -> (a -> (a, a) -> (b, b) -> b) -> a -> b
divideNconquer base divide conquer x = case base x of 
    Just n -> n
    Nothing -> conquer x (x1, x2) (y1, y2)
        where
            (x1, x2) = divide x
            y1 = divideNconquer base divide conquer x1
            y2 = divideNconquer base divide conquer x2