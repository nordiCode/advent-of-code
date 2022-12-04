module Main where

import Data.List.Split
import Data.List

readInt :: String -> Int
readInt =  read

mapInc :: (Int, Int) -> Int
mapInc (x,y)
  | x < y = 1
  | otherwise = 0

-- from Gabriella Gonzalez write up
windows n xs = transpose (take n (tails xs))
-- print $ sum . map mapInc $ zip <*> tail $ xs

main :: IO ()
main = do
    contents <- readFile "day_one_input.txt" 
    let xs = map readInt . lines $ contents
    print  $ sum . map mapInc $ zip <*> tail $ map sum $ windows 3 xs
    