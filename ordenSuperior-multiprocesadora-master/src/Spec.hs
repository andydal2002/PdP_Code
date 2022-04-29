module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  describe "Test de ejemplo" $ do
    it "El pdepreludat se instaló correctamente" $ do
      doble 1 `shouldBe` 2
  describe "Test de multiplicaciones" $ do
    it "el triple de un numero" $ do
      triple 2 `shouldBe` 6
  describe "Test de absoluto" $ do
    it "el absoltuo de un numero positivo" $ do
      absoluto 2 `shouldBe` 2
    it "el absoluto de 0" $ do
      absoluto 0 `shouldBe` 0
    it "el absoluto de un numero negativo" $ do
      absoluto (-10) `shouldBe` 10
  describe "Test de cocina" $ do
   it "Al cortar un tomate obtengo la cantidad de partes, la décima parte de los gramos" $ do
      cortar tomate1 `shouldBe` 5
      cortar tomate3 `shouldBe` 12
   it "La cortadora suma toda las partes y le resta la cantidad" $ do
      cortadora algunosTomates `shouldBe` 20
   it "La rayadora de tomates raya en pedacitos por gramo" $ do
      rayar tomate1 `shouldBe` 50
  it "Debería tener máximo 100" $ do
      rayar tomate3 `shouldBe` 100
  it "La rayadora suma toda las partes y le resta la cantidad" $ do
      rayadora algunosTomates `shouldBe` (50 +60 +100 - 3)
  it "cocina de tomates con olla con agua" $ do
      cocina (olla "agua") algunosTomates `shouldBe`(60 + 72+ 145.2)