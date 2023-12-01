module DayOne where
import Data.Char (isDigit)
import Data.List (find, isInfixOf)
import Debug.Trace
import Data.Maybe

numbers :: [String]
numbers = ["one","two","three","four","five","six","seven","eight","nine"]

numbersToInt :: String -> String
numbersToInt x 
  | x == "zero" = "0"
  | x == "one" = "1"
  | x == "two" = "2"
  | x == "three" = "3"
  | x == "four" = "4"
  | x == "five" = "5"
  | x == "six" = "6"
  | x == "seven" = "7"
  | x == "eight" = "8"
  | x == "nine" = "9"
  | otherwise = x

firstLast :: [a] -> [a]
firstLast xs = head xs : [last xs] 

lineToInt :: String -> String
lineToInt xs = go xs [] [] 
  where 
    go [] _ acc = concat $ firstLast . map numbersToInt $ reverse acc 
    go (x:xs) curr acc 
      | isDigit x && (x /= '0') = go xs [] ([x] : acc)
      | any (\n -> n `isInfixOf` reverse (x : curr)) numbers = go xs [x] (findNumber (reverse (x : curr)) numbers : acc)
      | otherwise = go xs (x : curr) acc

findNumber :: String -> [String] -> String
findNumber word numbers = fromJust $ find ( `isInfixOf` word) numbers


main :: IO ()
main = do 
  contents <- readFile "day_one.txt"
  let ints = map lineToInt $ words contents 
  let arr =  map (read . firstLast . filter isDigit) $ ints
  print $ sum arr