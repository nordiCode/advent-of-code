import Data.List ( elemIndex, genericSplitAt, nub ) 
import Data.List.Split as Sp
import Data.Maybe
import Data.Typeable

 
midPoint :: String -> Int
midPoint l = length l `div` 2

splitHalf :: [String] -> [Int] -> [([Char], [Char])]
splitHalf m n = [genericSplitAt y x | x <- m, y <- n]

stringMid :: String -> (String, Int)
stringMid s = (s, midPoint s)

stringHalves :: ([a], Int) -> ([a], [a])
stringHalves (x, y) = splitAt y x

alphaNum :: [Char] -> Maybe Int
alphaNum (x : xs) = elemIndex x alpha

alpha :: [Char]
alpha = ['a' .. 'z'] ++ ['A' .. 'Z']

hasSame :: (Foldable t, Eq a) => (t a, [a]) -> [a]
hasSame (s1, s2) = filter (\x -> (x `elem` s1)) s2

inAllThree [s1,s2,s3] = filter (\x -> (x `elem` s1) && (x `elem` s2)) s3

-- Part 1
--   print $ sum . map (+ 1) $ fmap sum $ map (alphaNum . hasSame) z

main :: IO ()
main = do
  contents <- readFile "./res/day_three.txt"
  let x = lines contents
  print $ sum . map (+1) $ fmap sum $ map (alphaNum .nub . inAllThree) $ Sp.chunksOf 3 x
