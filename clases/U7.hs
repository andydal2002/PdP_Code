
-- Guardas: se simbolizan con "|", separan las condiciones dadas sus valores correspondientes.
-- Un ejemplo conocido es:
valorAbsoluto x = | x>=0 = x
                  | x<0 = -x
-- Las condiciones se leen de arriba para abajo.
-- El otherwise se usa para definir el caso en el que no se cumplan ningunas de las condiciones anteriores.

-- Pattern Matching: consiste en especificar patrones que deben cumplir con un cierto dato, y si lo hace, deconstruirlo de acuerdo a esos patrones.
--Por ejemplo:
esVocalCerrada 'a' = False
esVocalCerrada 'e' = False
esVocalCerrada 'i' = True
esVocalCerrada 'o' = False
esVocalCerrada 'u' = True
esVocalCerrada otro = False

-- En este ejemplo, como el valor de "otro" no importa porque no se usa, se puede reemplazar con "_", que es una variable anonima.

-- Tanto en Guardas como en Pattern Matching, se debe mantener una coherencia con los tipos.
--Por ejemplo, 
funcionMala1 1 = 2
funcionMala1 2 = "hola"
-- no tipa: una ecuación devuelve un número, pero la otra, un String

funcionMala2 x | x > 0 = 2
               | otherwise = "hola"
-- no tipa, porque las guardas retornan tipos diferentes

funcionMala3 3     = 1
funcionMala3 True  = 2
-- no tipa, porque la primera ecuación espera un número, 
-- pero la segunda un booleano

-- Tuplas: es un valor compuesto, osea, formado por otros valores
-- Se escriben entre () y los valores estan separados por comas
-- Ejemplo:
tupla1 = (2, 4)
tupla2 = ("Andy", 19)

-- Dos funciones basicas para operar con tuplas son fst y snd
-- que devuelven el 1er y 2do elemento respectivamente.
-- Pero solo sirven para tuplas de dos valores.

-- Pattern Matching con Tuplas:
sumaCoords (x,y) = x + y

pod
