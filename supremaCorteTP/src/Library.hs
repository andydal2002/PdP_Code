module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

data Ley = Ley {
    tema :: String,
    presupuesto :: Number,
    partidos :: [Partido]
} deriving (Show, Eq)

type Partido = String -- por ahora 

-- Ejemplos
cannabis = Ley "uso medicinal del cannabis" 5 ["cambio de todos", "sector financiero"]
educacion = Ley "educacion superior" 30 ["docentes universitarios", "partido de centro federal"]
pingPong = Ley "profesionalizacion del tenis de mesa" 1 ["partido de centro federal", "liga de deportistas autonomos", "club paleta veloz"]
tenis = Ley "tenis" 2 ["liga de deportistas autonomos"]

-- 1
compatibles :: Ley -> Ley -> Bool
compatibles ley1 ley2 = any (\partido -> elem partido (partidos ley1)) (partidos ley2)

-- Constitucionalidad de las leyes

type Juez = Ley -> Bool -- Me dicen si vota que si o no

juez1 :: [Ley] -> Juez
juez1 agenda ley = elem ley agenda 

juez2 :: Juez
juez2 ley = elem "sector financiero" (partidos ley)

juez3 :: Juez
juez3 ley = presupuesto ley <= 10

juez4 :: Juez
juez4 ley = presupuesto ley <= 20

juez5 :: Juez
juez5 ley = elem "partido conservador" (partidos ley)

-- 1

type CorteSuprema = [Juez]

corte1 = [juezFacil, juezTacanio]
corte2 = [juezFacil]

constitucional :: CorteSuprema -> Ley -> Bool
constitucional corte ley = all (\juez -> juez ley) corte

-- 2

juezFacil :: Juez
juezFacil ley = True

juezPopulum :: Juez
juezPopulum ley = (length . partidos) ley > 2

juezTacanio :: Juez
juezTacanio ley = presupuesto ley <= 4

-- 3

leyesNoAprobadas :: [Ley] -> CorteSuprema -> [Ley]
leyesNoAprobadas leyes corte = filter (not . (constitucional corte)) leyes

leyesFuturas :: [Ley] -> CorteSuprema -> [Juez] -> [Ley]
leyesFuturas leyes corte nuevosJueces = filter (constitucional (corte ++ nuevosJueces)) (leyesNoAprobadas leyes corte)


-- Cuestion de principios

-- 1

borocotizar :: CorteSuprema -> CorteSuprema 
borocotizar corte = map (\juez -> not . juez) corte

-- 2

partidario :: Juez -> [Ley] -> Bool
partidario juez leyes
    | (filter juez leyes) /= [] = foldl1 interseccion (map partidos (filter juez leyes)) /= []
    | otherwise = False -- Si el juez no aprueba ninguna ley, entonces no es partidario (lo puse porque el "foldl1" tira error si tiene una lista vacia de input)

interseccion :: Eq a => [a] -> [a] -> [a]
interseccion [] _ = []
interseccion (x:xs) ys
    | elem x ys = x : interseccion xs ys
    | otherwise = interseccion xs ys

-- Ejemplos
leyes1 = [cannabis, educacion, pingPong, tenis]

-- Para pensar
{-
Si hubiera una ley apoyada por infinitos sectores ¿puede ser declarada constitucional?
¿cuáles jueces podrián votarla y cuáles no? Justificar

Depende, si algun juez requiere informacion sobre los sectores para tomar su decision de voto y hace uso de una funcion que debe recorrer la lista de leyes completa,
entonces no puede declararse constitucional. 
Por ejemplo: 
El juez1 puede votarla en caso de que la ley este en la agenda, porque elem es una funcion en la que se puede aplicar evaluacion diferida (cuando encuentra el elemento, deja de buscar).
Si no esta en la agenda, no la puede votar porque nunca terminará de recorrer la lista de leyes.
El juez2 puede votarla porque no requiere informacion sobre los sectores que apoyan a la ley.
Juez3, Juez4, Juez5, juezFacil, juezTacanio IDEM juez2.
El juezPopulum no puede votarla, porque necesita saber la cantidad de partidos de la ley, y sum debe recorrer toda la lista infinita.
-}