instance Foldable Tree where
    foldr f z Empty = z
    foldr f z (Node k l r) = f k $ foldr f (foldr f z r) l

avg :: Tree Int -> Double
avg t = fromIntegral (sum t) / fromIntegral (length t)

cat :: Tree String -> String
cat Empty = ""
cat t = tail $ foldl (\acc x -> acc ++ " " ++ x) "" t
