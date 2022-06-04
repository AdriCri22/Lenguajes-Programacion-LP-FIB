-------------------------------------------
-- Probelma 1
-------------------------------------------
multEq :: Int -> Int -> [Int]
multEq x y = iterate (*z) 1
    where
        z = x * y

-------------------------------------------
-- Probelma 2
-------------------------------------------
selectFirst :: [Int] -> [Int] -> [Int] -> [Int] 
selectFirst [] _ _ = []
selectFirst (x:xs) l2 l3
    | pos2 > -1 && (pos2 < pos3 || pos3 == -1)  = x : selectFirst xs l2 l3
    | otherwise                                 = selectFirst xs l2 l3
        where
            pos2 = returnPos l2 x 0
            pos3 = returnPos l3 x 0

            returnPos :: [Int] -> Int -> Int -> Int
            returnPos [] _ i = -1
            returnPos (x:xs) n i
                | x == n        = i + 1
                | otherwise     = returnPos xs n (i+1)

-------------------------------------------
-- Probelma 3
-------------------------------------------
myIterate :: (a -> a) -> a -> [a]
myIterate f n = scanl (\x _ -> f x) n [0..]

-- myIterate :: (a -> a) -> a -> [a]
-- myIterate f n = scanl f' n [0..]
--     where
--         f' a _ = f a

-- myIterate :: (a -> a) -> a -> [a]
-- myIterate f n = n : myIterate' f n
--     where
--         myIterate' :: (a -> a) -> a -> [a]
--         myIterate' f n = n' : myIterate' f n'
--             where
--                 n' = f n

-------------------------------------------
-- Probelma 4
-------------------------------------------
-- Igual a la definició donada a teoria de diccionaris
type SymTab a = String -> Maybe a

empty :: SymTab a
empty = const Nothing

get :: SymTab a -> String -> Maybe a
get = ($)

set :: SymTab a -> String -> a -> SymTab a
set table key value x
    | key == x      = Just value
    | otherwise     = table x

-------------------------------------------
-- Probelma 5
-------------------------------------------
data Expr a
     = Val a
     | Var String
     | Sum (Expr a) (Expr a)
     | Sub (Expr a) (Expr a)
     | Mul (Expr a) (Expr a)
     deriving Show

eval :: (Num a) => SymTab a -> Expr a -> Maybe a
eval _ (Val a) = Just a
eval table (Var s) = table s
eval table (Sum a b) = case eval table a of
    Nothing -> Nothing
    Just n -> case eval table b of 
        Nothing -> Nothing
        Just m -> Just (n + m)
eval table (Sub a b) = case eval table a of
    Nothing -> Nothing
    Just n -> case eval table b of 
        Nothing -> Nothing
        Just m -> Just (n - m)
eval table (Mul a b) = case eval table a of
    Nothing -> Nothing
    Just n -> case eval table b of 
        Nothing -> Nothing
        Just m -> Just (n * m)