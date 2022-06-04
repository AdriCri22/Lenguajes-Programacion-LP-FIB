closest :: [(Float,Float)] -> Float
closest [p1, p2] = dist p1 p2
closest (p:xs)
    | min > min' = min'
    | otherwise  = min
    where
        min' = closest xs
        min  = minimum [dist p p' | p' <- xs]

dist :: (Float,Float) -> (Float,Float) -> Float
dist (x1, y1) (x2, y2) = sqrt((x2 - x1)^2 + (y2 - y1)^2)