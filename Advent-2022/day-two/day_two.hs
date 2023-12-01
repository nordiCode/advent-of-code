data Piece = Rock | Paper | Scissors
  deriving (Show, Eq, Enum)

outCome :: (Piece, Piece) -> Int
outCome (x, y)
  | y == Rock && x == Scissors || y == Paper && x == Rock || y == Scissors && x == Paper = 6
  | x == y = 3
  | otherwise = 0

changeSecond :: (Piece, Piece) -> (Piece, Piece)
changeSecond (m, n)
  | n == Scissors = swapWin (m, n)
  | n == Paper = swapDraw (m, n)
  | n == Rock = swapLose (m, n)

swapWin :: (Piece, Piece) -> (Piece, Piece)
swapWin (m, _)
  | m == Rock = (m, Paper)
  | m == Paper = (m, Scissors)
  | otherwise = (m, Rock)

swapDraw :: (Piece, Piece) -> (Piece, Piece)
swapDraw (m, _) = (m, m)

swapLose :: (Piece, Piece) -> (Piece, Piece)
swapLose (m, _)
  | m == Rock = (m, Scissors)
  | m == Paper = (m, Rock)
  | otherwise = (m, Paper)

sumResult :: (Piece, Piece) -> Int
sumResult (x, y) = fromEnum y + 1 + outCome (x, y)

-- need to not use Head/Tail
mapTuple :: [b] -> (b, b)
mapTuple x = (head x, last x)

tuplePiece :: (Char, Char) -> (Piece, Piece)
tuplePiece (m, n) = (mapPiece m, mapPiece n)

mapPiece :: Char -> Piece
mapPiece x
  | x == 'A' || x == 'X' = Rock
  | x == 'B' || x == 'Y' = Paper
  | x == 'C' || x == 'Z' = Scissors

main :: IO ()
main = do
  contents <- readFile "day_two.txt"
  -- print $ sum . map sumResult $ map changeSecond $ map mapTuple $ lines contents
  print $ sum . map (sumResult . tuplePiece . mapTuple) $ lines contents
