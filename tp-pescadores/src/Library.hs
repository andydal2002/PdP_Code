module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

{-
data Pescado = Pescado {
    especie :: String,
    peso :: Number
} deriving (Show)
-}

type Pescado = (String, Number)

data Pescador = Pescador {
    apodo :: String,
    pescados :: [Pescado],
    peso :: Number
} deriving (Show)

-- Pescadores de ejemplo
pez1 = ("trucha", 200)
pez2 = ("ajolote", 100)
pez3 = ("pez globo", 800)
pez4 = ("trucha", 100)
pescador1 = Pescador "Juan" [pez1, pez4] 80
pescador2 = Pescador "Pedro" [pez1, pez2, pez3] 70

-- 1
cantPescados :: Pescador -> Number
cantPescados = length.pescados

-- 2
ultimaPescaEsMasPesada :: Pescador -> Bool
ultimaPescaEsMasPesada pescador = (snd.last.pescados) pescador > (snd.head.pescados) pescador

-- 3
nuevaPesca :: Pescador -> Pescado -> Pescador
nuevaPesca pescador pez = pescador {pescados = pescados pescador ++ [pez]}

-- 4
merienda :: Pescador -> Number -> Pescador
merienda pescador comida = pescador {peso = peso pescador + comida*2/100}

-- 5
descartarPescadosLivianos :: Pescador -> Pescador
descartarPescadosLivianos pescador = pescador {pescados = filter ((>=500).snd) (pescados pescador)}

-- 6
coincidenEspecie :: Pescador -> Pescador -> String -> Bool
coincidenEspecie pescador1 pescador2 especie = map (coincidencia (filter ((==especie).fst) (pescados pescador1))) (filter ((==especie).fst) (pescados pescador2))

coincidencia pescados1 pescado2 = any (((==).snd) pescado2) pescados1