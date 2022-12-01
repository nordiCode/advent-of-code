import Data.List (groupBy, sort)
import Data.Tree (flatten)
import System.IO

-- solves part 1 and part 2
-- for part 1 remove a bunch in maxGroups and replace with maximum prev to
-- map sum
main :: IO ()
main = do
  contents <- readFile "day_one_input.txt"
  let groups = cleanContents $ contents
  let maxGroups = sum . take 3 . reverse . sort . map sum $ intArrays groups
  print maxGroups

cleanContents :: String -> [[[Char]]]
cleanContents = filter (not . null) . map (filter (/= "")) . groupBy (\x y -> x /= "" && y /= "") . lines

intArrays :: [[String]] -> [[Int]]
intArrays = map readInt

readInt :: [String] -> [Int]
readInt = map read
