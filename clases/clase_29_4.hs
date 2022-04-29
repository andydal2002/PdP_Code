-- Clase Foldable: son tipos de datos que pueden recorrerse 
--sucesivamente, en general son listas

-- Funciones de orden superior:

-- las funciones de primer orden trabajan sobre datos (abstraccion de la realidad)
-- Las funciones de orden superior trabajan sobre otras funciones (estan vivas, transforman cosas)
-- Las funciones tambien son DATOS. Por lo tanto, se pueden pasar como parametro.

-- Podemos crear nuestras propias funciones de orden superior, mirar
-- para evitar repetir logica en el codigo.
-- Por ejemplo: 
sumarDos a = a+2
triple a = 3*a
operar operacion a = operacion a

-- Aplicacion parcial

-- Aca hicimos una funcion que devuelve una funcion
mejorFuncion :: Ord b => (a -> b) -> (a -> b) -> a -> (a -> b)
mejorFuncion f g x 
    | f x > g x = f
    | otherwise = g

-- Cuando aplico una funcion con menos parametros de los que necesita, me devuelve otra funcion
-- Esta funcion espera el resto de parametros que le faltan.

cuadruple = (*4)

funcion g x = (g x) + 3
g x = (x*4)/3
-- si escribo en la terminal: funcion g, eso me va a devolver una funcion que solo espera a "x"


-- Composicion

--Es una funcion de orden superior
-- Se escribe (.)
-- Toma dos funciones y un valor, aplica la primera funcion al resultado de aplicar la segunda al valor
composicion f g x = f(g x)

funcionLol = (*2).(+4).(/3)
-- Tambien se puede escribir como:  
-- funcionLol x  = ((*2).(+4).(/3)) x

-- La aplicacion de la funcion precede a la composicion
