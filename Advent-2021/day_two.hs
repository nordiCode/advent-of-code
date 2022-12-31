import Data.List.Split


data Position = Up | Down | Forward
 deriving (Show,Eq)


intTuple :: [String] -> (String, Int)
intTuple xs =  (xs !! 0, read (xs !! 1)::Int)


incPosition :: [[String]] -> Int -> Int -> Int
incPosition [] n h = n * (abs h)
incPosition (x:xs) n h
  | head x == "forward" = incPosition xs (n+(read (last x)::Int)) h
  | head x == "down" = incPosition xs n (h - (read (last x)::Int)) 
  | head x == "up" = incPosition xs n (h + (read (last x)::Int)) 
  | otherwise = incPosition xs n h

mapPosition :: String -> Position 
mapPosition x 
  | x == "forward" = Forward
  | x == "up" = Up
  | x == "down" = Down


main :: IO ()
main = do
  contents <- readFile "day_two.txt"
  let array = map (splitOn " ") . lines $ contents
  print $ incPosition array 0 0
