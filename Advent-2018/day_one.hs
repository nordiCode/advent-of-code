module Main where
import Utils
import Data.List 

sumList :: [Int] -> [Int]
sumList xs = scanl (+) 0 xs 

findDuplicates :: Eq a => [a] -> [a]
findDuplicates xs = xs \\ nub xs


main :: IO ()
main = do
  contents <- readFile "day_one_input.txt"
  let cleanList = map dropSign . lines $ contents
  print $ findDuplicates $ sumList cleanList