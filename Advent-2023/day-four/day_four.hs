module DayFour where

import Data.List.Split 

checkNums :: (Foldable t, Eq a) => t a -> [a] -> Int
checkNums n1 n2 = length $  (filter (`elem` n1)) n2

score :: (Integral b, Num a) => b -> a
score n 
  | n > 0 = 2^(n-1)
  | otherwise = 0 

scoreCards :: Num t => [[Char]] -> t
scoreCards cards = go cards 0 
  where 
    go [] acc = acc 
    go (x : xs) acc = go xs (acc + scoreCard x)

scoreCard :: Num a => [Char] -> a
scoreCard c =  score $ checkNums winningNums myNums
  where 
    card =  splitOn "|" c
    lotto = splitOn ":" (card !! 0 )
    winningNums = words (lotto !! 1)
    myNums = words (card !! 1 )


main :: IO ()
main = do 
    contents <- readFile "day_four.txt"
    let cards =  lines contents
    print $ scoreCards cards

    