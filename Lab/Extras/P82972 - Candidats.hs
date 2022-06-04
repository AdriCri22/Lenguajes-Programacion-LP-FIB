import Data.List
import Data.Ord

votsMinim :: [([Char], Int)] -> Int -> Bool
votsMinim [] _ = False
votsMinim ((nom, vots):xs) n
    | vots <= n  = True
    | otherwise = votsMinim xs n

candidatMesVotat :: [([Char], Int)] -> [Char]
candidatMesVotat = fst . maximumBy (comparing snd)

votsIngressos :: [([Char], Int)] -> [([Char], Int)] -> [[Char]]
votsIngressos [] _ = []
votsIngressos ((nom, vots):xs) l = elem ++ votsIngressos xs l
    where 
        elem = if any (\(x, y) -> x == nom) l then [] else [nom]

rics :: [([Char], Int)] -> [([Char], Int)] -> [[Char]] 
rics lVots lIng = map fst $ take 3 $ reverse $ sortBy (comparing snd) l
    where
        l = map f lIng
        f (nom, vots) = if any (\(x, y) -> x == nom) lVots then (nom ++ "*", vots) else (nom, vots)