module Main where

import Asterius.Types
import Control.Monad.Except
import qualified Data.Text as T
import qualified Jikka.CPlusPlus.Convert.BundleRuntime as BundleRuntime
import Jikka.Common.Format.Error
import qualified Jikka.Main.Subcommand.Convert as Convert
import Jikka.Main.Target

convert' :: String -> String
convert' prog = case Convert.run PythonTarget CPlusPlusTarget "<input>" (T.pack prog) of
  Left err -> unlines $ prettyError' err
  Right prog -> T.unpack prog

convert :: JSString -> JSString
convert = toJSString . convert' . fromJSString

foreign export javascript "convert" convert :: JSString -> JSString

bundleRuntime' :: String -> String
bundleRuntime' prog = case BundleRuntime.run (T.pack prog) of
  Left err -> unlines $ prettyError' err
  Right prog -> T.unpack prog

bundleRuntime :: JSString -> JSString
bundleRuntime = toJSString . bundleRuntime' . fromJSString

foreign export javascript "bundleRuntime" bundleRuntime :: JSString -> JSString

main :: IO ()
main = return ()
