module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  describe "Compatibles" $ do
    it "Ley de PingPong y Tenis" $ do
      compatibles pingPong tenis `shouldBe` True

  describe "Borocotizar" $ do
    it "Corte2" $ do
      constitucional corte2 tenis `shouldBe` True
      constitucional (borocotizar corte2) tenis `shouldBe` False

  describe "Partidario" $ do
    it "Juez2" $ do
      partidario juez2 leyes1 `shouldBe` True
    
    it "JuezFacil" $ do
      partidario juezFacil leyes1 `shouldBe` False
