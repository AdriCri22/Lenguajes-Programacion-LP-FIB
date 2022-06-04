import Data.List
import Data.Ord

serieCollatz :: Integer -> [Integer]
serieCollatz 1 = [1]
serieCollatz n
    | mod n 2 == 0  = [n] ++ serieCollatz (div n 2)
    | otherwise     = [n] ++ serieCollatz (n * 3 + 1)

collatzMesLlarga :: Integer -> Integer
collatzMesLlarga n = fromIntegral $ maximum [length $ serieCollatz x | x <- [1..n]]

representantsCollatz' :: [Integer] -> [(Integer, Integer)]
representantsCollatz' [] = []
representantsCollatz' (x:xs) = [(fromIntegral $ length l, fromIntegral $ minimum l)] ++ representantsCollatz' xs
    where
        l = serieCollatz x

representantsCollatz :: [Integer] -> [Integer]
representantsCollatz = map snd . sortBy (comparing fst) . representantsCollatz'

qsort :: [Integer] -> [Integer]
qsort [] = []
qsort (p:xs) = qsort lower ++ [p] ++ qsort greater
    where
        lower   = [x | x <- xs, x < p]
        greater = [x | x <- xs, x >= p]

classeCollatz :: Integer -> Either Int [Integer]
classeCollatz n
    | x > 35    = Left x
    | otherwise = Right serie
        where
            serie = serieCollatz n
            x = length serie