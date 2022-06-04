import Data.List (sort)


type Pos = (Int, Int)


dins :: Pos -> Bool
dins (x, y) = dins' x && dins' y
  where dins' i = 1 <= i && i <= 8


moviments :: Pos -> [Pos]
moviments (f, c) =
  filter
    dins
    [ (f + 2, c - 1),
      (f + 2, c + 1),
      (f - 2, c - 1),
      (f - 2, c + 1),
      (f + 1, c - 2),
      (f + 1, c + 2),
      (f - 1, c - 2),
      (f - 1, c + 2)
    ]


potAnar3 :: Pos -> Pos -> Bool
potAnar3 p q = q `elem` destins
  where destins = concatMap moviments $ concatMap moviments $ moviments p


potAnar3' :: Pos -> Pos -> Bool
potAnar3' p q = q `elem` destins
  where destins = moviments p >>= moviments >>= moviments
  
 