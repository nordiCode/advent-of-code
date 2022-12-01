module Main where


-- cleanContents :: String -> [String]
-- cleanContents =  map read . unlines .words


readInt :: String -> Int
readInt =  read

main :: IO ()
main = do
    contents <- readFile "day_one_input.txt" 
    let intArray = map readInt . lines $ contents
    print $ intArray