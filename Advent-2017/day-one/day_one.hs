module DayOne where
import Data.Char (digitToInt)

circleAdd :: String -> Int
circleAdd n = go n 0 
  where 
    go [] acc = acc 
    go [x] acc
      | x == head n = digitToInt x + acc 
      | otherwise = acc 
    go (x:xs) acc 
      | x == head xs = go xs (digitToInt x + acc)
      | otherwise = go xs acc

main :: IO ()
main = do
  contents <- readFile "day_one.txt"
  print $ circleAdd contents