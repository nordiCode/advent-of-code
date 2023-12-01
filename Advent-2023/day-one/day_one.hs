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
  | x == "one" = "one1one"
  | x == "two" = "two2two"
  | x == "three" = "three3three"
  | x == "four" = "four4four"
  | x == "five" = "five5five"
  | x == "six" = "six6six"
  | x == "seven" = "seven7seven"
  | x == "eight" = "eight8eight"
  | x == "nine" = "nine9nine"
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