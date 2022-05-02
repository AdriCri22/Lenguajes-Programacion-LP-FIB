myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl _ n [] = n
myFoldl func n (x:xs) = myFoldl func (func n x) xs

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr _ n [] = n
myFoldr func n (x:xs) = func x (myFoldr func n xs)

myIterate :: (a -> a) -> a -> [a]
myIterate func n = n : myIterate func (func n)

myUntil :: (a -> Bool) -> (a -> a) -> a -> a
myUntil cond func n
    | cond n      = n
    | otherwise   = myUntil cond func (func n)

-- myUntil p f x = if p x then x else myUntil p f (f x)

myMap :: (a -> b) -> [a] -> [b]
myMap func xs = [func x | x <- xs]

-- USING RECURSION:
-- myMap _ [] = []
-- myMap func (x:xs) = func x : myMap func xs

myFilter :: (a -> Bool) -> [a] ->[a]
myFilter func xs = [x | x <- xs, func x]

-- USING RECURSION:
-- myFilter _ [] = []
-- myFilter func (x:xs)
--     | func x    = x : myFilter func xs
--     | otherwise = myFilter func xs

myAll :: (a -> Bool) -> [a] -> Bool
myAll func xs = null ([x | x <- xs, not (func x)])

-- USING RECURSION:
-- myAll _ [] = True
-- myAll func (x:xs) = func x && myAll func xs

-- myAll _ [] = True
-- myAll func (x:xs)
--     | func x    = myAll func xs
--     | otherwise = False

myAny :: (a -> Bool) -> [a] -> Bool
myAny func xs = not (null ([x | x <- xs, func x]))

-- USING RECURSION:
-- myAny _ [] = False
-- myAny func (x:xs) = func x || myAll func xs

-- myAny _ [] = False
-- myAny func (x:xs)
--     | func x    = True
--     | otherwise = myAny func xs

myZip :: [a] -> [b] -> [(a,b)]
myZip (x:xs) (y:ys) = (x,y) : myZip xs ys
myZip _ _ = []

-- ANOTHER OTION:
-- myZip _ [] = []
-- myZip [] _ = []
-- myZip (x:xs) (y:ys) = (x,y) : myZip xs ys

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith func xs ys = [func x y | (x, y) <- zip xs ys]

-- USING RECURSION:
-- myZipWith _ _ [] = []
-- myZipWith _ [] _ = []
-- myZipWith func (x:xs) (y:ys) = func x y : myZipWith func xs ys