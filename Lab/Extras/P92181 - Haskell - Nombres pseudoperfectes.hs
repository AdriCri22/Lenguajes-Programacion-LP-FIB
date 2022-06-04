analyze :: Int -> Either Int Bool
analyze n
    | length divs > 12  = Left (length divs)
    | otherwise         = Right (pseudoperfecte divs n [])
        where
            divs = divisors n

divisors :: Int -> [Int]
divisors 1 = []
divisors n
    | raiz == fromIntegral raiz'    = divs ++ (tail $ reverse $ map (div n) (tail divs))
    | otherwise                     = divs ++ (reverse $ map (div n) (tail divs))
        where 
            raiz  = sqrt $ fromIntegral n
            raiz' = floor raiz
            divs  = [x | x <- [1 .. raiz'], mod n x == 0]

pseudoperfecte :: [Int] -> Int -> [Int] -> Bool
pseudoperfecte [] n l
    | sum l == n = True
    | otherwise  = False
pseudoperfecte (x:xs) n l
    | res > n = False
    | res == n = True
    | otherwise = pseudoperfecte xs n (l ++ [x]) || pseudoperfecte xs n l
        where
            res = sum l