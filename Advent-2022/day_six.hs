import Data.List
import Data.List.Split

windows :: Int -> [String] -> [[String]]
windows n xs = transpose (take n (tails xs))

unique :: Eq a => [a] -> Bool
unique li = nub li == li

-- Change 14 to 4 for part 1
main :: IO ()
main = do
    contents <- readFile "day_six.txt" 
    let xs = windows 14 $ map (:[]) contents
    print $ length  xs
    print  $ fmap (+14) <$> elemIndex True $ map unique xs