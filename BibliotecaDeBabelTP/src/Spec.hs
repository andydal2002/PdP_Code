module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  describe "Test de ejemplo" $ do
    it "El pdepreludat se instaló correctamente" $ do
      doble 1 `shouldBe` 2
  
  describe "Busqueda" $ do
    it "buscarTextoEnTexto" $ do
      buscarTextoEnTexto "hola" "abcd ho hola chau" `shouldBe` True
      buscarTextoEnTexto "hola" "chau adios" `shouldBe` False
      buscarTextoEnTexto "hola" [] `shouldBe` False
    
    it "buscarTextoEnBiblioteca" $ do
      buscarTextoEnBiblioteca "mama" biblioteca4 `shouldBe` [l1,l3]
      buscarTextoEnBiblioteca "casa" biblioteca4 `shouldBe` []
    
    it "primerLibroEncontrado" $ do
      primerLibroEncontrado "mama" biblioteca4 `shouldBe` l1

    it "cantLibrosEncontrados" $ do
      cantLibrosEncontrados "mama" biblioteca4 `shouldBe` 2