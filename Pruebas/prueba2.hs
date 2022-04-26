--Guardas
esAlto altura | altura < 1.60 = "jaj re bajito"
    | altura < 2 = "estas joya"
    | otherwise = "ehh paraaa, que sos? jugador de la NBA?"

main :: IO ()
main = do
    print(esAlto 2)
