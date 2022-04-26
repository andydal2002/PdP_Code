{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_JujutsuTP (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "D:\\Users\\Andy\\Documents\\Estudios\\UTN\\2 A\241o\\Paradigmas\\Programaci\243n\\JujutsuTP\\.stack-work\\install\\3ff42cf6\\bin"
libdir     = "D:\\Users\\Andy\\Documents\\Estudios\\UTN\\2 A\241o\\Paradigmas\\Programaci\243n\\JujutsuTP\\.stack-work\\install\\3ff42cf6\\lib\\x86_64-windows-ghc-8.10.7\\JujutsuTP-0.1.0.0-7n2dFtV8aiRB2Dh4UB3vtV"
dynlibdir  = "D:\\Users\\Andy\\Documents\\Estudios\\UTN\\2 A\241o\\Paradigmas\\Programaci\243n\\JujutsuTP\\.stack-work\\install\\3ff42cf6\\lib\\x86_64-windows-ghc-8.10.7"
datadir    = "D:\\Users\\Andy\\Documents\\Estudios\\UTN\\2 A\241o\\Paradigmas\\Programaci\243n\\JujutsuTP\\.stack-work\\install\\3ff42cf6\\share\\x86_64-windows-ghc-8.10.7\\JujutsuTP-0.1.0.0"
libexecdir = "D:\\Users\\Andy\\Documents\\Estudios\\UTN\\2 A\241o\\Paradigmas\\Programaci\243n\\JujutsuTP\\.stack-work\\install\\3ff42cf6\\libexec\\x86_64-windows-ghc-8.10.7\\JujutsuTP-0.1.0.0"
sysconfdir = "D:\\Users\\Andy\\Documents\\Estudios\\UTN\\2 A\241o\\Paradigmas\\Programaci\243n\\JujutsuTP\\.stack-work\\install\\3ff42cf6\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "JujutsuTP_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "JujutsuTP_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "JujutsuTP_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "JujutsuTP_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "JujutsuTP_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "JujutsuTP_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
