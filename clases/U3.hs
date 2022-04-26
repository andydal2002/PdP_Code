{-
Tipos de datos: En Haskell, los valores tienen asociadas operaciones.
Por ejemplo, los valores numericos tienen asociados las operaciones (+), (-), (*).
Al conjunto de valores y operaciones se denomina tipo de dato.
Ejemplos de tipos de datos son: Numero entero, numero con coma, booleano, etc.

Inferencia: Haskell sabe que tipos de datos acepta o no una funcion sin que tengamos que decirselo. Puede INFERIRLO.
Por ejemplo, la funcion doble x = x*2 solo acepta y devuelve Numeros.

Cuando trabajamos con composicion, se respeta la misma regla. 
Por ejemplo, funcionNueva x = f1 (f2 numero) o lo que es lo mismo:
funcionNueva = f1.f2, acepta lo que acepta f2 y devuelve lo que devuelve f1.

Tipando:
Para definir el tipo de un ALIAS, se escribe.
miEdad :: Int
miEdad = 19

Para tipar funciones, se debe determinar el tipo de las entradas (en orden) y el tipo de la salida:
siguiente :: Int -> Int
siguiente x = x+1

Clases de tipos:
Las clases de tipos son agrupaciones generales de tipos que se parecen entre sí.
Por ejemplo: Num agrupa a los Int y Float.

A la hora de tipar funciones, se pueden usar VARIABLES DE TIPO.
Por ejemplo, doble :: Num a => a -> a
funcionRandom :: (Ord a, Eq b) => a -> b

Estas son algunas clases de tipos más:
    Eq: pueden comparase por /= e ==.
    Ord: pueden compararse y además pueden ser ordenadas de menor a mayor (<,>,<=,>=)
    Show: pueden convertirse en un string y se mostrados en una consola (mediante la funcion show).
    Num: pueden ser sumados, restados y multiplicados, pero no divididos.

Hay funciones, como la funcion identidad (id), que pueden tomar cualquier valor. 
En estos casos, se usa la variable de tipo de forma generica: id :: a -> a 

-}