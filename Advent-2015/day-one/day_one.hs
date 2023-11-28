module DayOne where

testStr :: String
testStr = "()())"

whichFloor :: (Num t) => String -> t
whichFloor xs = go xs 0
  where
    go [] n = n
    go (y : ys) acc
      | y == '(' = go ys (acc + 1)
      | y == ')' = go ys (acc - 1)

whenBasement :: (Num t) => String -> t
whenBasement xs = go xs 0 0
  where
    go [] _ i = i
    go _ (-1) i = i
    go (y : ys) acc i
      | y == '(' = go ys (acc + 1) (i + 1)
      | y == ')' = go ys (acc - 1) (i + 1)

main :: IO ()
main = do
  contents <- readFile "day_one.txt"
  print $ whichFloor contents
  print $ whenBasement contents
