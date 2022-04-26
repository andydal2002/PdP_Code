dobleDe :: Num a => a -> a
dobleDe x = 2*x

main :: IO()
main = do
    print(dobleDe 1)
    print(dobleDe 2)
    
