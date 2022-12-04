import Data.List.Split

readInt :: [String, String] -> [String,Int]
readInt = map read

intList [x,y] = [x,read y]


main :: IO ()
main = do
  contents <- readFile "day_two.txt"
  print $ map (intList . splitOn " ") $ lines contents