module DayNine where
import Data.List.Split



--histNum :: [Int] -> [[Int]]-> Int
--histNum xs diffs = (last xs) - (sum $ (map (\x -> last x)) diffs)

diffLines :: [Int] -> [[Int]]
diffLines xs = go xs []
  where
    go [] acc = reverse acc
    go xs acc
      | all (==0)(diffLine xs) = reverse ([0] : acc)
      | otherwise = go (diffLine xs) (diffLine xs : acc)


diffLine :: [Int] -> [Int]
diffLine xs = go xs
  where
    go []  = []
    go [_]  = []
    go (x:y:ys)  =  (y-x) : go (y:ys)


cleanLines :: [String] -> [[Int]]
cleanLines xs = go xs []
  where
    go [] acc = reverse  acc
    go (x:xs) acc = go xs (cleanLine x : acc)

    cleanLine l = map (\x -> read x :: Int) $ splitOn " " l


histNum :: Num a => [[a]] -> [a]
histNum xs = go xs []
  where
    go [] acc = acc
    go [_] acc = acc
    go (x :y : ys) acc = go (((head y - head x):y):ys) ((head y - head x) : acc )


histNums :: [[Int]] -> Int
histNums xs = go xs
  where
    go [] = 0
    go (y:ys) = head (histNum (diffs y)) + go ys

    diffs x = reverse $ x : diffLines x



main :: IO ()
main = do
  contents <- readFile "day_nine.txt"
  let exLine =  (lines contents) !! 1
  let ls =  cleanLines (lines contents)
  print $ histNums ls
