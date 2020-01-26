module Minimizer where

minimizeFile :: FilePath -> IO String
minimizeFile f = minimize <$> readFile f

minimize :: String -> String
minimize [] = []
minimize (x:[])  = [x]
minimize (x:y:xs)
  | isBlockCommentStart x y = minimize $ skipBlockComment xs
  | isLineComment x y = minimize $ skipLineComment xs
  | isWhitespace x = x:(minimize $ skipDuplicateWhitespaces (y:xs))
  | isNewline x = minimize (y:xs)
  | otherwise = x : minimize (y:xs)

-- |Skips the content of a block comment, returning the rest of the string after the comment end
skipBlockComment :: String -> String
skipBlockComment [] = []
skipBlockComment (x:y:xs)
  | isBlockCommentEnd x y = xs
  | otherwise             = skipBlockComment (y:xs)

-- |Skips the content of a line comment, returning the rest of the string after the comment end
skipLineComment :: String -> String
skipLineComment [] = []
skipLineComment (x:xs)
  | x == '\n' = xs
  | otherwise = skipLineComment xs

skipDuplicateWhitespaces :: String -> String
skipDuplicateWhitespaces [] = []
skipDuplicateWhitespaces (x:xs) 
  | isWhitespace x = skipDuplicateWhitespaces xs
  | otherwise = (x:xs)

isBlockCommentStart :: Char -> Char -> Bool
isBlockCommentStart x y = x == '/' && y == '*'

isBlockCommentEnd :: Char -> Char -> Bool
isBlockCommentEnd x y = x == '*' && y == '/'

isLineComment :: Char -> Char -> Bool
isLineComment x y = x == '/' && y == '/'

isSemiColon :: Char -> Bool
isSemiColon = (==) ';'

isWhitespace :: Char -> Bool
isWhitespace = (==) ' '

isNewline :: Char -> Bool
isNewline = (==) '\n'