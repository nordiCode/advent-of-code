-- Extremely naive lunchhour solution !

choiceScore :: (a, Char) -> Int
choiceScore (_,x) 
  | x == 'X' = 1
  | x == 'Y' = 2
  | x == 'Z' = 3
  | otherwise = 0

outCome :: (Char,Char) -> Int
outCome (x,y) 
 | y == 'X' && x == 'C' || y == 'Y' && x == 'A' || y == 'Z' && x == 'B' = 6
 | y == 'X' && x == 'A' || y == 'Z' && x == 'C' || y == 'Y' && x == 'B' = 3
 | otherwise = 0

changeSecond :: (Char,Char) -> (Char, Char)
changeSecond (m,n)
  | n == 'Z' = swapWin (m,n)
  | n == 'Y' = swapDraw (m,n)
  | n == 'X' = swapLose (m,n)

swapWin :: (Char,Char) -> (Char,Char)
swapWin (m,_)
  | m == 'A' = (m,'Y')
  | m == 'B' = (m,'Z')
  | otherwise = (m,'X')

swapDraw :: (Char,Char) -> (Char,Char)
swapDraw (m,_)
  | m == 'A' = (m,'X')
  | m == 'B' = (m,'Y')
  | otherwise = (m,'Z')


swapLose :: (Char,Char) -> (Char,Char)
swapLose (m,_)
  | m == 'A' = (m,'Z')
  | m == 'B' = (m,'X')
  | otherwise = (m,'Y')

sumResult :: (Char, Char) -> Int
sumResult x = choiceScore x + outCome x

-- need to not use Head/Tail
mapTuple :: [b] -> (b, b)
mapTuple x = (head x, last x)

main :: IO ()
main = do
  contents <- readFile "day_two.txt"
  print $ sum . map sumResult $ map changeSecond $ map mapTuple $ lines contents 