module Main where

readInt :: String -> Int
readInt =  read

mapInc :: (Int, Int) -> Int
mapInc (x,y)
  | x < y = 1
  | otherwise = 0

main :: IO ()
main = do
    contents <- readFile "day_one_input.txt" 
    let xs = map readInt . lines $ contents
    print $ sum . map mapInc $ zip <*> tail $ xs