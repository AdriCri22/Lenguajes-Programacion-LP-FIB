import Text.Parsec.Token (GenTokenParser(operator))
import Distribution.Simple.Utils (xargs)
data Expr = Val Int | Add Expr Expr | Sub Expr Expr | Mul Expr Expr | Div Expr Expr

eval1 :: Expr -> Int
eval1 (Val a) = a
eval1 (Add x y) = eval1 x + eval1 y
eval1 (Sub x y) = eval1 x - eval1 y
eval1 (Mul x y) = eval1 x * eval1 y
eval1 (Div x y) = div (eval1 x) (eval1 y)

eval2 :: Expr -> Maybe Int
-- eval2 (Val a) = Just a
-- eval2 (Add x y) = operation (+) (eval2 x) (eval2 y)
-- eval2 (Sub x y) = operation (-) (eval2 x) (eval2 y)
-- eval2 (Mul x y) = operation (*) (eval2 x) (eval2 y)
-- eval2 (Div x y) 
--     | eval2 y == Just 0 = Nothing
--     | otherwise         = operation div (eval2 x) (eval2 y)

-- operation :: (Int -> Int -> Int) -> Maybe Int -> Maybe Int -> Maybe Int
-- operation op (Just x) (Just y) = Just (op x y)
-- operation _ _ _ = Nothing

eval2 (Val x) = Just x
eval2 (Add e1 e2) = eval2' (+) e1 e2
eval2 (Sub e1 e2) = eval2' (-) e1 e2
eval2 (Mul e1 e2) = eval2' (*) e1 e2
eval2 (Div e1 e2) = do
    exp1 <- eval2 e1
    exp2 <- eval2 e2
    case exp2 of
        0 -> Nothing 
        _ -> return (div exp1 exp2)

eval2' :: (Int -> Int -> b) -> Expr -> p -> Maybe b
eval2' op e1 e2 = do
    exp1 <- eval2 e1
    exp2 <- eval2 e1
    return (op exp1 exp2)


eval3 :: Expr -> Either String Int
-- eval3 (Val a) = Right a
-- eval3 (Add x y) = operation3 (+) (eval3 x) (eval3 y)
-- eval3 (Sub x y) = operation3 (-) (eval3 x) (eval3 y)
-- eval3 (Mul x y) = operation3 (*) (eval3 x) (eval3 y)
-- eval3 (Div x y)
--     | eval3 y == Right 0    = Left "div0"
--     | otherwise             = operation3 div (eval3 x) (eval3 y)

-- operation3 :: (Int -> Int -> Int) -> Either String Int -> Either String Int -> Either String Int
-- operation3 op (Right x) (Right y) = Right (op x y)
-- operation3 _ _ _ = Left "div0"

eval3 (Val x) = Right x
eval3 (Add e1 e2) = eval3' (+) e1 e2
eval3 (Sub e1 e2) = eval3' (-) e1 e2
eval3 (Mul e1 e2) = eval3' (*) e1 e2
eval3 (Div e1 e2) = do
    exp1 <- eval3 e1
    exp2 <- eval3 e2
    case exp2 of
        0 -> Left "div0" 
        _ -> return (div exp1 exp2)


eval3' :: (Int -> Int -> b) -> Expr -> p -> Either String b
eval3' op e1 e2 = do
    exp1 <- eval3 e1
    exp2 <- eval3 e1
    return (op exp1 exp2)