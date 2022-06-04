-----------------------------------------------------------
-- Problema 1
-----------------------------------------------------------

eval1 :: String -> Int
eval1 s = eval1' (words s) []
    where
        eval1' :: [String] -> [Int] -> Int
        eval1' [] [x] = x
        eval1' (x:xs) (a:b:l)
            | x == "*"  = eval1' xs ([b * a] ++ l)
            | x == "/"  = eval1' xs ([div b a] ++ l)
            | x == "+"  = eval1' xs ([b + a] ++ l)
            | x == "-"  = eval1' xs ([b - a] ++ l)
            | otherwise = eval1' xs ([(read  x::Int)] ++ [a, b] ++ l)
        eval1' (x:xs) l = eval1' xs ([(read  x::Int)] ++ l)

-----------------------------------------------------------
-- Problema 2
-----------------------------------------------------------

eval2 :: String -> Int
eval2 s = head $ foldl eval2' [] (words s)
    where
        eval2' :: [Int] -> String -> [Int]
        eval2' (a:b:l) x
            | x == "*"  = [b * a] ++ l
            | x == "/"  = [div b a] ++ l
            | x == "+"  = [b + a] ++ l
            | x == "-"  = [b - a] ++ l
            | otherwise = [(read  x::Int)] ++ [a, b] ++ l
        eval2' l x = [(read  x::Int)] ++ l

-----------------------------------------------------------
-- Problema 3
-----------------------------------------------------------

fsmap :: a -> [a -> a] -> a
fsmap = foldl (flip ($))

-- Option 2

fsmap' :: a -> [a -> a] -> a
fsmap' a [] = a
fsmap' a (f:xs) = fsmap' (f a) xs

-----------------------------------------------------------
-- Problema 4
-----------------------------------------------------------

quickSort :: [Int] -> [Int]
quickSort = divideNconquer qBase qDivide qConquer
    where
        qBase :: [Int] -> Maybe [Int]
        qBase [] = Just []
        qBase [x] = Just [x]
        qBase _ = Nothing

        qDivide :: [Int] -> ([Int], [Int])
        qDivide (p:xs) = (lower, greater)
            where
                lower = [x | x <- xs, x < p]
                greater = [x | x <- xs, x >= p]

        qConquer :: [Int] -> ([Int], [Int]) -> ([Int], [Int]) -> [Int]
        qConquer (x:_) _ (ys1, ys2) = ys1 ++ [x] ++ ys2

divideNconquer :: (a -> Maybe b) -> (a -> (a, a)) -> (a -> (a, a) -> (b, b) -> b) -> a -> b
divideNconquer base divide conquer x =
    case base x of
        Just y  -> y
        Nothing -> conquer x (x1, x2) (y1, y2)
            where
                (x1, x2) = divide x
                y1 = divideNconquer base divide conquer x1
                y2 = divideNconquer base divide conquer x2

-----------------------------------------------------------
-- Problema 5
-----------------------------------------------------------

data Racional = Rational Integer Integer

instance Eq Racional where
    (Rational n1 d1) == (Rational n2 d2) = n1 * d2 == n2 * d1

instance Show Racional where
    show (Rational n d) = (show $ div n m) ++ "/" ++ (show $ div d m)
        where
            m = mcd n d

mcd :: Integer -> Integer -> Integer
mcd n d
    | n < d     = last [x | x <- [1..n], mod n x == 0 && mod d x == 0]
    | otherwise = last [x | x <- [1..d], mod n x == 0 && mod d x == 0]
    
racional :: Integer -> Integer -> Racional
racional n d = Rational n d

numerador :: Racional -> Integer
numerador (Rational n d) = div n (mcd n d)

denominador :: Racional -> Integer
denominador (Rational n d) = div d (mcd n d)

-----------------------------------------------------------
-- Problema 6
-----------------------------------------------------------

data Tree a = Node a (Tree a) (Tree a)

recXnivells :: Tree a -> [a]
recXnivells t = recXnivells' [t]
    where 
        recXnivells' ((Node x fe fd):ts) = x:recXnivells' (ts ++ [fe, fd])

racionals :: [Racional]
racionals = recXnivells calkinWilf

calkinWilf :: Tree Racional
calkinWilf = calkinWilf' (Rational 1 1)
    where
        calkinWilf' :: Racional -> Tree Racional
        calkinWilf' (Rational x y) = Node (racional x y) (calkinWilf' (racional x (y+x))) (calkinWilf' (racional (x+y) y))