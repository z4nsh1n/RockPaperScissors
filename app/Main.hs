module Main (main) where

import Lib
import System.IO (hSetBuffering, stdin, stdout, BufferMode (NoBuffering))

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  hSetBuffering stdin NoBuffering

  loopRockPaper
  
