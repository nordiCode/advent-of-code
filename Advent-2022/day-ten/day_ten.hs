import Data.List.Split

mapDup :: (Num a, Read a) => [[Char]] -> [a]
mapDup x 
  | (x !! 0) == "addx" = [0,read (x!!1)]
  | otherwise = [0]

main :: IO ()
main = do 
  contents <- readFile  "./res/day_ten.txt"  
  let li =  map  ( mapDup . words) . lines $ contents
  let startLi = 1 : concat li 
  let twentyCycleSum = 20 * (sum $ take 20  startLi)
  let sixtyCycleSum = 60 * (sum $ take 60 startLi)
  let hunCycleSum = 100 * (sum $ take 100 startLi)
  let hunFortyCycleSum = 140 *  (sum $ take 140 startLi)
  let hunEightCycleSum = 180 * (sum $ take 180 startLi)
  let twoHunTwentyCycleSum =220 * (sum $ take 220 startLi)
  print $ twentyCycleSum + sixtyCycleSum + hunCycleSum + hunFortyCycleSum + hunEightCycleSum+ twoHunTwentyCycleSum