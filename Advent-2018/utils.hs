module Utils(
    readInt,
    dropSign
) where

dropSign :: String -> Int
dropSign x 
  | head x == '+' = read (tail x)
  | otherwise = read x

readInt :: String -> Int
readInt =  read