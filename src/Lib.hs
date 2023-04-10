module Lib where

import System.Random
import Control.Exception (evaluate, try, SomeException)

data Hands
  = Rock
  | Paper
  | Scissors
  deriving (Enum, Eq, Show, Read)

data Won
  = Lost
  | Tie
  | Win


-- h1 wins h2
win :: Hands -> Hands -> Won
win h1 h2
  | h1 == h2 = Tie
win Paper Rock = Win
win Scissors Paper = Win
win Rock Scissors = Win
win _ _ = Lost

randomHand :: IO Hands
randomHand = do
  r <- randomRIO (0,2)
  return $ enumFrom Rock !! r

loopRockPaper :: IO ()
loopRockPaper = do
  putStr "\ESC[2J\ESC[HQuit/Rock/Paper/Sciccors: "
  hand <- getLine
  if hand == "Quit"
    then return ()
    else do
      res <- try (evaluate (read hand :: Hands)) :: IO (Either SomeException Hands)
      case res of
        Left _ -> do
              putStrLn "Not a valid string"
              getChar
              loopRockPaper
        Right hand -> do
              h2 <- randomHand
              case win hand h2 of
                Win -> putStrLn "You've won!"
                Lost -> putStrLn "You've lost"
                Tie -> putStrLn "It's a Tie!"
              getChar
              loopRockPaper
