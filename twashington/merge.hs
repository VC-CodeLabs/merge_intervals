-------------------------
-- note: nonfunctional
-- DO NOT USE
-- runs with "haskell(stack)" debug profile --
-------------------------

import System.IO
import Text.Read (readMaybe)
import Data.Maybe (fromMaybe)

type Interval = [Int]

intervalsCoincide :: Interval -> Interval -> Bool
intervalsCoincide a b = not ((a !! 0 > b !! 1) || (b !! 0 > a !! 1))

parseIntervals :: String -> Maybe [Interval]
parseIntervals s = readMaybe s :: Maybe [Interval]

readIntervals :: FilePath -> IO [Interval]
readIntervals filePath = do
    contents <- readFile filePath
    let intervals = fromMaybe [] (parseIntervals contents)
    return intervals

main :: IO ()
main = do
    let filePath = "twashington/intervals.txt"
    intervals <- readIntervals(filePath)
    print intervals

    print $ parseIntervals "[[1,2]]"

    print $ missingNumber nums1
    print $ missingNumber nums2
    print $ missingNumber nums3
    print $ missingNumber nums4
  
nums1 = [3, 7, 1, 2, 8, 4, 5]
nums2 = [11, 2, 10, 4, 5, 6, 7, 8, 1, 9]
nums3 = [4, 3, 1, 5]
nums4 = [23, 24, 22, 26, 28, 21, 20, 27, 19, 32, 31, 30, 29]

--missingNumber :: [Int] -> Int
missingNumber numList = missingNumber' (numList !! 0) 0 0 numList where
    missingNumber' minAcc lenAcc sumAcc [] = (floor ((2 * minAcc + lenAcc) * (lenAcc + 1) / 2 - sumAcc))
    missingNumber' minAcc lenAcc sumAcc (x : xs) = missingNumber' (if x < minAcc then x else minAcc) (lenAcc + 1) (x + sumAcc) xs

minMaxSum lst = minMaxSum' (lst !! 0) (lst !! 0) 0 lst where
    minMaxSum' a b c [] = [a, b, c]
    minMaxSum' a b c (x : xs) = minMaxSum' (if x < a then x else a) (if x > b then x else b) (x + c) xs

--missingNumber'' :: [Int] -> Int
missingNumber'' lst = do
    let r = minMaxSum lst
    let a = r !! 0
    let b = r !! 1
    let c = r !! 2
    (floor ((2 * a + (b - a)) * (b - a + 1) / 2 - c))