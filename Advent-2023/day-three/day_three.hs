module DayThree where
import Data.Char (isDigit)
import Data.List(groupBy, nub, sort)
import Debug.Trace

digits :: String
digits = ".1234567890"

symbolLines ::  [[Char]] -> [(Int, Int)]
symbolLines lines = go 0 lines []
  where 
    go y [] acc = concat $ reverse acc 
    go y (x : xs) acc = go (y + 1) xs ((findSymbol y x) : acc )

findSymbol :: Num b => a -> [Char] -> [(a, b)]
findSymbol index str = go index 0 str [] 
  where 
    go _ y [] acc = reverse acc 
    go index y (x : xs) acc 
      | x == '*' = go index (y + 1) xs ((index,y): acc)
      | otherwise = go index (y + 1) xs acc

findDigit :: Num b => a -> [Char] -> [(a,b)]
findDigit index str = go index 0 str [] 
  where 
    go _ y [] acc = reverse acc 
    go index y (x : xs) acc 
      | isDigit x = go index (y + 1) xs ((index,y): acc)
      | otherwise = go index (y + 1) xs acc

digitLines :: (Num a, Num b) => [[Char]] -> [(a, b)]
digitLines lines = go 0 lines []
  where 
    go y [] acc = concat $ reverse acc 
    go y (x : xs) acc = go (y + 1) xs ((findDigit y x) : acc )


adjacentPts :: (Eq a1, Eq a2, Num a2) => (a1, a2) -> (a1, a2) -> Bool
adjacentPts (x,y) (a,b) = x == a && abs (y - b) == 1

adjacentPtsDir :: (Ord a1, Ord a2, Num a1, Num a2) => (a1, a2) -> (a1, a2) -> Bool
adjacentPtsDir (x, y) (a, b) = abs (x - a) <= 1 && abs (y - b) <= 1

removeAdjacentGroups :: (Foldable t1, Foldable t2, Ord a1, Ord a2, Num a1, Num a2) => t2 (a1, a2) -> [t1 (a1, a2)] -> [t1 (a1, a2)]
removeAdjacentGroups _ [] = []
removeAdjacentGroups points (group:groups)
  | any (\groupPoint -> any (\point -> adjacentPtsDir groupPoint point) points) group = removeAdjacentGroups points groups
  | otherwise = group : removeAdjacentGroups points groups

adjacentPtsList :: (Eq a1, Eq a2, Num a2) => [(a1, a2)] -> [[(a1, a2)]]
adjacentPtsList pts = reverse $ go pts []
  where
    go [] acc = acc
    go (pt:pts) [] = go pts [[pt]]
    go (pt:pts) (group:accGroups)
      | adjacentPts pt (head group) = go pts ((pt:group):accGroups)
      | otherwise = go pts ([pt]:group:accGroups)




-- extractNumbersForLists :: [[(Int, Int)]] -> [String] -> [String]
-- extractNumbersForLists lists grid = map (\coords -> extractNumbers (nub coords) grid) lists

subtractCoordLists :: Eq a => [[a]] -> [[a]] -> [[a]]
subtractCoordLists firstList secondList = filter (\coords -> notElem coords (map nub secondList)) firstList

adjacentToBothGroups :: (Foldable t1, Foldable t2, Ord a1, Ord a2, Num a1, Num a2) => (a1, a2) -> t2 (a1, a2) -> t1 (a1, a2) -> Bool
adjacentToBothGroups point g1 g2 =
    any (\p1 -> any (\p2 -> adjacentPtsDir p1 point && adjacentPtsDir p2 point) g1) g2

adjacentGroups :: (Foldable t, Ord a1, Ord a2, Ord (t (a1, a2)), Num a1, Num a2) => [t (a1, a2)] -> [(a1, a2)] -> [[t (a1, a2)]]
adjacentGroups groups pts =  [ [g1,g2] | g1 <- groups, g2 <- groups, g1 /= g2, g1 < g2, point <- pts, adjacentToBothGroups point g1 g2 ]

fillNumbers :: [[[(Int, Int)]]] -> [String] -> [[String]]
fillNumbers pairsLists grid = map (\pairsList -> map (\pairs -> concatMap (\(y, x) -> [grid !! y !! x]) pairs) pairsList) pairsLists

extractNumbers :: (Int, Int) -> [[a]] -> [a]
extractNumbers coords grid =  (\(y, x) -> [grid !! y !! x]) coords

main :: IO ()
main = do 
    contents <- readFile "day_three.txt"
    let grid =  lines contents
    let symbolPts = symbolLines grid -- where the * are
    -- print $  symbolPts 
    let digs =  digitLines grid -- all digit coors
    let adjPts =  map reverse $ adjacentPtsList (sort digs) -- all adjacent pts grouped
    -- print adjPts 
    let notTouchSymbolPts = removeAdjacentGroups symbolPts adjPts 
    -- print notTouchSymbolPts
    let touchSymbolPts =  subtractCoordLists adjPts notTouchSymbolPts -- groups touching a symbol
    -- print touchSymbolPts
    let allPairs =  adjacentGroups touchSymbolPts symbolPts
    -- print allPairs
    
    let filledNumbers = fillNumbers allPairs grid
    -- print filledNumbers

    let ints = map (map read) filledNumbers :: [[Int]]
    -- print ints
 
    let prods = map (\[x,y] -> x * y) ints 
    -- print prods

    print $ sum prods