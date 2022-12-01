import Data.List (groupBy, sort)
import Data.Tree (flatten)
import System.IO

partOne :: [[String]] -> Int
partOne = maximum . map sum . intArrays

partTwo :: [[String]] -> Int
partTwo = sum . take 3 . reverse . sort . map sum . intArrays

cleanContents :: String -> [[[Char]]]
cleanContents = filter (not . null) . map (filter (/= "")) . groupBy (\x y -> x /= "" && y /= "") . lines

intArrays :: [[String]] -> [[Int]]
intArrays = map readInt

readInt :: [String] -> [Int]
readInt = map read

main :: IO ()
main = do
  contents <- readFile "day_one_input.txt"
  let groups = cleanContents $ contents
  let maxCal = partOne groups
  let maxCalTopThree = partTwo groups
  print $ "Solution Part One " <> show maxCal
  print $ "Solution Part Two " <> show maxCalTopThree


