module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

-- 29/4

-- Creado Tests
triple :: Number -> Number
triple num = num*3

sumarDos a = a+2
operar operacion a = operacion a

-- Aplicacion parcial

mejorFuncion :: Ord b => (a -> b) -> (a -> b) -> a -> (a -> b)
mejorFuncion f g x 
    | f x > g x = f
    | otherwise = g

funcion g x = (g x) + 3
g x = (x*4)/3

-- Composicion

funcionLol = (*2).(+4).(/3)