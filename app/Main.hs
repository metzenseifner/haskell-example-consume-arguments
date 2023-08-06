{-# OPTIONS_GHC -Wno-name-shadowing #-}
module Main where
import Options.Applicative

-- Options Data Record to contain validated input data
data Options = Options {
    firstNumber :: Integer,
    verboseFlag :: Bool
} deriving (Show)

-- Define parsers for each piece of data inputted
firstNumberParser :: Parser Integer
firstNumberParser = option auto (long "first" <>
  short '1' <> help "A first number." <> value 0 <> showDefault <> metavar "NUMBER")

verboseParser :: Parser Bool
verboseParser = switch (long "verbose" <> short 'v' <> help "verbose output")


-- Construct a Parser for the Options data record type using applicative syntax for 
-- the constructor arguments: 
-- <$> :: fmap (functor map)
-- <*> :: apply operator
--
-- use ghci interpreter :info <$> or <*> for details
optionsParser :: Parser Options
optionsParser = Options <$> firstNumberParser <*> verboseParser

-- Usage Example
-- 
-- $ cabal run pkg:read-args-exp -- --help
--   Haskell CLI
--   
--   Usage: cli-exp [-1|--first FIRSTNUMBER] [-v|--verbose]
--   
--     This program demonstrates a simple CLI utility written in Haskell.
--   
--   Available options:
--     -1,--first FIRSTNUMBER   A first number. (default: 0)
--     -v,--verbose             verbose output
--     -h,--help                Show this help text
main :: IO ()
main = do
    inputValues <- execParser inputValues
    -- Here is where you'd put the fully-composed function to handle validated input values
    -- In this example, we just print the populated Options data record.
    -- If validation fails, program will exit before this point and print the reason for failure.
    print inputValues
  where
    inputValues = info (optionsParser <**> helper)
      ( fullDesc
     <> progDesc "This program demonstrates a simple CLI utility written in Haskell."
     <> header "Haskell CLI" )
