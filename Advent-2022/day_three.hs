import Data.List (elemIndex, genericSplitAt)
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

main :: IO ()
main = do
  contents <- readFile "day_three.txt"
  let x = lines contents
  let z = map (stringHalves . stringMid) x
  print $ sum . map (+ 1) $ fmap sum $ map (alphaNum . hasSame) z
