import Data.List.Split (splitOn)

mapTuple :: [[Char]] -> ([Int], [Int])
mapTuple x = (map readInt $ head $ map (splitOn "-") x, map readInt . last $ map (splitOn "-") x)

scorePairs :: (Eq a, Enum a, Num p) => ([a], [a]) -> p
scorePairs ([a, b], [x, y])
  | a `elem` [x .. y] && b `elem` [x .. y] = 1
  | x `elem` [a .. b] && y `elem` [a .. b] = 1
  | otherwise = 0

readInt :: String -> Int
readInt = read

main :: IO ()
main = do
  contents <- readFile "day_four.txt"
  print $ sum . map scorePairs $ map mapTuple . map (splitOn ",") $ lines contents
