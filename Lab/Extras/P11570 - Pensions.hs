data Avi = Avi {
    nom :: [Char],
    edat :: Int,
    despeses :: [Int]
    } deriving (Show)

promigDespeses :: Avi -> Int
promigDespeses (Avi _ _ d)
    | y - div l 2 > 0 = x + 1
    | otherwise   = x
        where
            x = div s l
            y = mod s l
            s = sum d
            l = length d

edatsExtremes :: [Avi] -> (Int, Int)
edatsExtremes ((Avi _ e _):xs) = edatsExtremes' e e xs
    where
        edatsExtremes' :: Int -> Int -> [Avi] -> (Int, Int)
        edatsExtremes' min max [] = (min, max)
        edatsExtremes' min max ((Avi _ e _):xs)
            | e < min   = edatsExtremes' e max xs
            | e > max   = edatsExtremes' min e xs
            | otherwise = edatsExtremes' min max xs

sumaPromig :: [Avi] -> Int
sumaPromig = sum . map promigDespeses

maxim :: [Int] -> Int
maxim (x:xs) = maxim' x xs
    where
        maxim' :: Int -> [Int] -> Int
        maxim' m [] = m
        maxim' m (x:xs)
            | x > m     = maxim' x xs
            | otherwise = maxim' m xs

maximPromig :: [Avi] -> Int
maximPromig = maxim . map promigDespeses

despesaPromigSuperior :: [Avi] -> Int -> ([Char], Int)
despesaPromigSuperior [] _ = ("", 0)
despesaPromigSuperior ((Avi nom edat despeses):xs) n
    | promigDespeses Avi { nom = nom, edat = edat, despeses = despeses} > n    = (nom, edat)
    | otherwise                 = despesaPromigSuperior xs n