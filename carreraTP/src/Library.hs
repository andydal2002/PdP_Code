module Library where
import PdePreludat

-- 1

data Auto = Auto {
    color :: String, -- para identificar el auto
    velocidad :: Number,
    distancia :: Number
}

instance Show Auto where
    show (Auto color velocidad distancia) = color ++ " - " ++ show velocidad ++ " - " ++ show distancia

instance Eq Auto where 
    auto1 == auto2 = color auto1 == color auto2

type Carrera = [Auto] -- por ahora

auto1 = Auto "azul" 30 10
auto2 = Auto "rojo" 80 7
auto3 = Auto "verde" 100 25
carrera1 = [auto1, auto2, auto3]

estaCerca :: Auto -> Auto -> Bool
estaCerca auto1 auto2 = auto1 /= auto2 && abs (distancia auto1 - distancia auto2) < 10

vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo auto carrera = all (not . estaCerca auto) carrera && maximum (map distancia carrera) == distancia auto

cantAutosAdelante :: Auto -> Carrera -> Number
cantAutosAdelante auto = length . filter ((>distancia auto) . distancia)

puesto :: Auto -> Carrera -> Number
puesto auto carrera = cantAutosAdelante auto carrera + 1


-- 2) Funciones de manipulacion de estados del auto

type Mod = Auto -> Auto

correr :: Number -> Mod
correr tiempo auto = auto {distancia = distancia auto + tiempo * velocidad auto}

--sumarVelocidad :: Number -> Number -> Number -- esta funcion esta media al pedo, pero la pongo por la consigna
--sumarVelocidad vel1 vel2 = vel1 + vel2 

--alterarVelocidad :: Mod
--alterarVelocidad auto vel = auto {velocidad = max 0 (sumarVelocidad (velocidad auto) vel)}

alterarVelocidad :: Number -> Mod 
alterarVelocidad vel auto = auto {velocidad = max 0 (velocidad auto + vel)}


-- 3) Power Ups

type PowerUp = Auto -> Carrera -> Carrera

afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista = (map efecto . filter criterio) lista ++ filter (not.criterio) lista

terremoto :: PowerUp
terremoto auto carrera = afectarALosQueCumplen (estaCerca auto) (alterarVelocidad (-50)) carrera

miguelitos :: Number -> PowerUp
miguelitos velNeg auto carrera = afectarALosQueCumplen detrasDe (alterarVelocidad (-velNeg)) carrera
    where detrasDe = (<distancia auto) . distancia

jetPack :: Number -> PowerUp
jetPack tiempoDuracion auto carrera = afectarALosQueCumplen (==auto) ((correr tiempoDuracion) . duplicaVel) carrera
    where duplicaVel auto = auto {velocidad = velocidad auto * 2}

-- 4) Simulacion de carrera

type Evento = Carrera -> Carrera

simularCarrera :: Carrera -> [Evento] -> [(Number, String)]
simularCarrera carrera listaEventos = map (\auto -> (puesto auto aplicarEventos , color auto)) aplicarEventos 
    where aplicarEventos = foldl (\x f -> f x) carrera listaEventos

correnTodos :: Number -> Evento
correnTodos tiempo carrera = map (correr tiempo) carrera


usaPowerUp :: String -> PowerUp -> Evento
usaPowerUp colorAuto powerUp carrera
    | elem colorAuto (map color carrera) = buscarAplicar powerUp colorAuto carrera
    | otherwise = carrera -- si no lo encuentra, deja la carrera igual
    where buscarAplicar powerUp colorAuto (x:xs)
            | colorAuto == color x = powerUp x carrera
            | otherwise = buscarAplicar powerUp colorAuto xs


-- Ejemplo de simulacion
auto4 = Auto "rojo" 120 0 
auto5 = Auto "blanco" 120 0 
auto6 = Auto "azul" 120 0 
auto7 = Auto "negro" 120 0 
carrera2 = [auto4, auto5, auto6, auto7]
eventos = [(correnTodos 30), (usaPowerUp "azul" (jetPack 3)), (correnTodos 40), (usaPowerUp "blanco" (miguelitos 20)), (usaPowerUp "negro" (jetPack 6)), (correnTodos 10)]

-- 5

--a. Si, la solucion actual lo permite, usando "afectarALosQueCumplen":
misil :: String -> PowerUp
misil colorAuto auto carrera = afectarALosQueCumplen ((==colorAuto) . color) (alterarVelocidad (-50)) carrera

--b. "vaTranquilo" no puede usarse para una carrera infinita, ya que tanto "all" como "maximum" requieren recorrer toda la lista.
-- "puesto" tampoco puede usarse, ya que necesita saber cuantos autos hay delante de un cierto auto, lo que implica un "sum", que requiere recorrer toda la lista.

