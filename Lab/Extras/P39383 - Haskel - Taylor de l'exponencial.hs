exps :: Float -> [Float]
exps x = serie
    where
    serie = 1 : zipWith f serie [1..]
    f num i = num * x / i

exponencial :: Float -> Float -> Float
exponencial x e = foldl (+) 0 (takeWhile (>=e) (exps x))