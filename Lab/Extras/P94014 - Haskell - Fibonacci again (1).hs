-- quickFib      quickFib'
--     |            |
--     v            v
-- +-------+    +-------+    +-------------+
-- |  (:)  | ,->|  (:)  | ,->|   zipWith   |
-- +---+---+ |  +---+---+ |  +-----+---+---+
-- | 0 | o---'  | 1 | o---'  | (+) | o | o |
-- +---+---+    +---+---+    +-----+-|-+-|-+
--   ^            ^                  |   |
--   |            `------------------|---'
--   `-------------------------------'
quickFib :: [Integer]
quickFib = 0 : quickFib'
    where
        quickFib' = 1 : zipWith (+) quickFib quickFib'

-- a!!1 (Haskell) ≡ a[1] (c++)
fib :: Int -> Integer
fib n = quickFib!!n