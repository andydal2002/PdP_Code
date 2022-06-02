module Library where
import PdePreludat

-- Modelo inicial
data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Number,
  precisionJugador :: Number
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Number,
  precision :: Number,
  altura :: Number
} deriving (Eq, Show)

type Puntos = Number

-- Funciones útiles
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

-- 1

type Palo = Habilidad -> Tiro

putter :: Palo
putter habilidad = UnTiro 10 (precisionJugador habilidad * 2) 0

madera :: Palo
madera habilidad = UnTiro 100 (div (precisionJugador habilidad) 2) 5

hierros :: Number -> Palo
hierros n habilidad = UnTiro (fuerzaJugador habilidad * n) (div (precisionJugador habilidad) n) (max 0 (n-3))

-- 2

golpe :: Jugador -> Palo -> Tiro
golpe persona palo = palo (habilidad persona)

-- 3

type Obstaculo = Tiro -> Tiro

tunelConRampa :: Obstaculo
tunelConRampa (UnTiro velocidad presicion altura)
    | presicion > 90 && altura == 0 = UnTiro (velocidad * 2) 100 0
    | otherwise = UnTiro 0 0 0

laguna :: Number -> Obstaculo
laguna largoLaguna (UnTiro velocidad presicion altura)
    | velocidad > 80 && between 1 altura 5 = UnTiro velocidad presicion (div altura largoLaguna)
    | otherwise = UnTiro 0 0 0
{-
hoyo :: Obstaculo
hoyo (UnTiro velocidad presicion altura)
    | between 5 velocidad 20 && altura == 0 && presicion > 98 = UnTiro 0 0 0
    | otherwise = UnTiro 0 0 0
-}
hoyo :: Obstaculo
hoyo tiro = UnTiro 0 0 0

-- 4

palosUtiles :: Jugador -> Obstaculo -> [Palo] -> [Palo]
palosUtiles persona obstaculo palos = filter (paloUtil persona obstaculo) palos

paloUtil :: Jugador -> Obstaculo -> Palo -> Bool
paloUtil persona obstaculo palo = pasaObstaculo (palo (habilidad persona)) obstaculo

pasaObstaculo :: Tiro -> Obstaculo -> Bool
pasaObstaculo tiro obstaculo 
    | show obstaculo == "hoyo" = between 5 (velocidad tiro) 20 && altura tiro == 0 && precision tiro > 98 
    | otherwise = obstaculo tiro /= UnTiro 0 0 0 

cantObstaculosSuperados :: [Obstaculo] -> Tiro -> Number
cantObstaculosSuperados obstaculos tiro = length (takeWhile (pasaObstaculo tiro) obstaculos)

mejorTiro :: Jugador -> [Obstaculo] -> [Palo] -> Tiro
mejorTiro persona obstaculos palos = maximoSegun (cantObstaculosSuperados obstaculos) (map (golpe persona) palos)

buscarQuePaloHizoUnTiro :: Jugador -> [Palo] -> Tiro -> Palo
buscarQuePaloHizoUnTiro persona palos tiro = head ((filter ((==tiro) . golpe persona)) palos)

paloMasUtil :: Jugador -> [Obstaculo] -> [Palo] -> Palo
paloMasUtil persona obstaculos palos = buscarQuePaloHizoUnTiro persona palos (mejorTiro persona obstaculos palos)

-- 5

padresPerdedores :: [(Jugador, Puntos)] -> [String] 
padresPerdedores jugadores = map (\(jugador, puntos) -> padre jugador) (filter ((<maximoPuntaje) . snd) jugadores)
    where maximoPuntaje = maximum (map snd jugadores)

