module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  describe "Test de ejemplo" $ do
    it "El pdepreludat se instaló correctamente" $ do
      doble 1 `shouldBe` 2
  describe "Test de triple" $ do
    it "triple de 1" $ do
      triple 1 `shouldBe` 3
    it "triple de 2" $ do
      triple 2 `shouldBe` 6

