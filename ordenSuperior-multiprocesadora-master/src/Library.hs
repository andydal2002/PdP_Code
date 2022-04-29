module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

triple :: Number -> Number
triple numero = numero + numero + numero

absoluto :: Number -> Number
absoluto n 
 | n >= 0 = n
 | n < 0 = (-n)



------------

data Tomate = UnTomate {
    caracteristicas:: [String],
    peso:: Number 
} deriving Show

tomate1 = UnTomate ["grande", "lindo","rojo"] 50
tomate2 = UnTomate ["rojo","maduro"] 60
tomate3 = UnTomate [] 121

algunosTomates = [tomate1,tomate2,tomate3]

cortar :: Tomate -> Number
cortar tomate = div (peso tomate) 10  

cortadora :: [ Tomate ] -> Number
cortadora tomates = multiprocesadora cortar tomates

-------------------

rayar :: Tomate -> Number
rayar tomate  = min (peso tomate) 100

rayadora :: [ Tomate ] -> Number
rayadora tomates = multiprocesadora rayar tomates

rayadoFino :: Tomate -> Number
rayadoFino tomate  = round (peso tomate * 1.5)

--rayadoraFina :: [ Tomate ] -> Number
--rayadoraFina tomates = sum (map rayadoFino tomates) - length tomates

multiprocesadora:: (Tomate -> Number) -> [ Tomate ] -> Number
multiprocesadora accesorio tomates = sum (map accesorio tomates) - length tomates

---------------------

trabajaConCuchillo:: Tomate -> Number
trabajaConCuchillo tomate 
 | maduro tomate = cortar tomate 
 | otherwise = 1

trabajaConRayador:: Tomate -> Number
trabajaConRayador tomate 
 | maduro tomate = rayar tomate 
 | otherwise = 1

maduro tomate = elem "maduro" (caracteristicas tomate)

-----------------------------------------

trabajaCon :: (Tomate -> Number) -> Tomate ->  Number
trabajaCon accesorio tomate 
 | maduro tomate = accesorio tomate 
 | otherwise = 1


---------------------------

--Los cocineros
data Cocinero = UnCocinero {
  nombre :: String,
  accesorioPreferido:: Tomate -> Number
}

german = UnCocinero "German" cortar
donato = UnCocinero "Donato" rayar

cocinaMucho:: Cocinero -> [Tomate] -> Bool
cocinaMucho cocinero tomates = 
  (multiprocesadora (accesorioPreferido cocinero) tomates) > 50


-----------------------

olla :: String -> Tomate -> Tomate
olla liquido tomate = 
  UnTomate ("cocido":caracteristicas tomate) 
  (peso tomate * incremento liquido)

incremento "aceite" = 1.1
incremento "agua" = 1.2
incremento x = 1


cocina:: (Tomate -> Tomate)  -> [Tomate] -> Number
cocina utensillo tomates =  sum (map peso (map utensillo tomates))


plancha:: Tomate -> Tomate
plancha tomate = tomate{peso=peso tomate - 1}


freir tomate = olla "aceite" tomate
hervir tomate = olla "agua" tomate

-----------------

licuar :: Number -> Tomate -> Number
licuar intensidad tomate = intensidad * peso tomate


pepe = UnCocinero "pepe licuador" (licuar 2)
pepa = UnCocinero "pepa super licuadora" (licuar 10)


mejorFuncion::( Ord b) => (a-> b) -> (a-> b) -> a -> a-> b
mejorFuncion h p v t
 | h v > p v = h t
 | otherwise = p t
