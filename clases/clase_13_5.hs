-- Recursividad

-- Por ejemplo:
factorial 0 = 1
factorial n = n * factorial (n-1)
--La funcion se llama a si misma indefinidamente hasta llegar al factorial de cero

sumatoria [] = 0
sumatoria (x:xs) = x + sumatoria xs
-- En este caso, en (x:xs), x es la cabeza de la lista y xs son todos los elementos que le siguen

funcionLoca x = x : funcionLoca x
-- Esta funcion concatena x con x infinitamente. 
-- Se puede trabajar con esta funcion aunque nunca termine de iterar.
-- En haskell, no hace falta esperar hasta que la funcion de adentro termine para aplicar la funcion de afuera.
-- Por ejemplo, head (funcionLoca 1) compila y da 1.

-- Esta "lazy evaluation" que evita hacer calculos de más, ahorrando el mayor esfuerzo posible, se llama EVALUACION DIFERIDA.
-- La funcion tiene potestad de evaluar los parametros como mejor le convenga para trabajar menos


-- FOLDL - REDUCCION

-- La Reduccion consiste en aplicar a un elemento una funcion, y al resultado aplicarle la misma funcion, una cantidad determinada de veces.
-- Esto es lo que hace FOLDL: dada una semilla y una funcion de reduccion, aplica la funcion sobre la semilla.
-- De alguna manera, acumula el resultado de aplicar la funcion sobre la semilla.

-- Por ejemplo:
f1 x = foldl (+) x [1,2,3] 
-- Hace ((x+1)+2)+3, osea x+1+2+3
-- Al resultado, le aplica el siguiente

maximum [1,2,13,5] = foldl max 0 [1,2,13,5]
-- Esto es porque maximum aplica max entre cada par de elementos de una lista

--         f reduccion    sem  lista  result
foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' f semilla (x:xs) = foldl' f (f semilla x) xs
foldl' _ semilla [] = semilla 

-- foldr: hace lo mismo pero opera la semilla al final
-- foldl asocia a IZQUIERDA
-- foldr asocia a DERECHA

foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' f semilla (x:xs) = f x (foldr' f semilla xs)
foldr' _ semilla [] = semilla 

-- foldl1: no requiere una semilla, la "semilla" es el primer elemento de la lista


-- Ejemplos de recursividad
take' 0 _ = []
take' _ [] = []
take' n (x:xs) = x:take' (n-1) xs 

encontrarUno :: (a -> Bool) -> [a] -> a
encontrarUno funcion [] = error "no esta el elemento"
encontrarUno funcion (cabeza:cola)
    | funcion cabeza = cabeza
    | otherwise = encontrarUno funcion cola

elem' a [] = False
elem' a (x:xs) = a == x || elem' a xs

enPosicion n [] = error "no hay tantos elementos como me pedis"
enPosicion 0 (x:_) = x 
enPosicion n (_:xs) = enPosicion (n-1) xs