module MinifyParser where

import Data.Either
import Data.List
import Text.ParserCombinators.Parsec

data Statement = Statement String
               | LCurl Statement
               | RCurl Statement
               | MultiStatement Statement

statements :: Parser [String]
statements = sepBy statement (oneOf ";\n")

statement :: Parser String
statement = (spaces >> many (noneOf ";\n"))

minimize :: String -> String
minimize s
  | isRight res = intercalate ";" $ fromRight res
  | otherwise   = error "Parse error"
  where res = parseSource s

minimizeFile :: FilePath -> IO ()
minimizeFile f = do 
  out <- minimize <$> readFile f
  writeFile "min.js" out

parseSource :: String -> Either ParseError [String]
parseSource = parse statements "(unknown)"

parseSourceFile :: FilePath -> IO (Either ParseError [String])
parseSourceFile f = parseSource <$> readFile f

fromLeft :: Either a b -> a
fromLeft (Left x) = x

fromRight :: Either a b -> b
fromRight (Right x) = x