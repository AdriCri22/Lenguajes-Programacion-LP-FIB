main = do
    nom <- getLine
    let l = head nom
    if (l == 'A') || (l == 'a') then do 
        putStrLn "Hello!" 
    else 
        putStrLn "Bye!"