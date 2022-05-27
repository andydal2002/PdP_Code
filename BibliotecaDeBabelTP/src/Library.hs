module Library where
import PdePreludat

import Data.Char

doble :: Number -> Number
doble numero = numero + numero

data Libro = Libro {
    titulo :: String,
    cantPags :: Number,
    texto :: String,
    generos :: [String]
} deriving (Show, Eq)

data Biblioteca = Biblioteca {
    libros :: [Libro],
    criterio :: Criterio
}

-- 1) Estadísticas

promedioPaginas :: Biblioteca -> Number
promedioPaginas = sum . (map cantPags) . libros

librosEnComun :: Biblioteca -> Biblioteca -> [Libro]
librosEnComun biblioteca1 biblioteca2 = interseccion (libros biblioteca1) (libros biblioteca2)

interseccion :: Eq a => [a] -> [a] -> [a]
interseccion [] ys = []
interseccion (x:xs) ys
    | elem x ys = x : interseccion xs ys
    | otherwise = interseccion xs ys

-- 2) Integridad de la biblioteca 

esLibroValido :: Criterio
esLibroValido libro = (cantPags libro == 410) && (all esSimboloValido (texto libro))

{-
esSimboloValido :: Char -> Bool
esSimboloValido simbolo = simbolo == 'a' || simbolo == 'b' || simbolo == 'c' || simbolo == 'd' || simbolo == 'e' || simbolo == 'f' 
     || simbolo == 'g' || simbolo == 'h' || simbolo == 'i' || simbolo == 'j' || simbolo == 'k' || simbolo == 'l' || simbolo == 'm' 
     || simbolo == 'n' || simbolo == 'o' || simbolo == 'p' || simbolo == 'q' || simbolo == 'r' || simbolo == 's' || simbolo == 't' 
     || simbolo == 'u' || simbolo == 'v' || simbolo == 'w' || simbolo == 'x' || simbolo == 'y' ||simbolo == 'z' 
     || simbolo == '.' || simbolo == ',' || simbolo == ' '
-}

simbolosValidos = ['a'..'z'] ++ ['.', ',', ' ']

esSimboloValido :: Char -> Bool
esSimboloValido simbolo = elem simbolo simbolosValidos

depurarBiblioteca :: Biblioteca -> Biblioteca
depurarBiblioteca biblioteca = biblioteca {libros = filter esLibroValido (libros biblioteca)}

-- 3) Generos

cantLibrosDelGenero :: String -> Biblioteca -> Number
cantLibrosDelGenero genero = length . filter (any (==genero) . (generos)) . libros

conjuntoGeneros :: Biblioteca -> [String]
conjuntoGeneros =  eliminarDuplicados . concat . map generos . libros

eliminarDuplicados :: Eq a => [a] -> [a]
eliminarDuplicados [] = []
eliminarDuplicados (x:xs)
    | elem x xs   = eliminarDuplicados xs
    | otherwise   = x : eliminarDuplicados xs

generoPopular:: Biblioteca -> String
generoPopular biblioteca = fst (masRepetido1 ((concat . (map generos)) (libros biblioteca)))

-- Dada una lista, genera una lista de tuplas con el elemento seguido de la cantidad de veces que aparece en la lista. Luego toma el que aparece mas veces.
masRepetido1 :: Ord a => [a] -> (a,Number) 
masRepetido1 [x] = (x,1)
masRepetido1 (x:y:zs) | m > n      = (x,m)
                      | m == n     = (max x u,m)
                      | otherwise  = (u,n)
  where (u,n)  = masRepetido1 (y:zs)
        m      = length (takeWhile (==x) (x:y:zs))

-- Ejemplos y Consultas
l1 = Libro "A" 10 "hola mama" ["policial", "terror"] 
l2 = Libro "B" 9 "chau papa" ["policial"] 
l3 = Libro "C" 5 "mimamamemima" ["romantico"] 
l4 = Libro "Andy" 5 "xd" ["fantasia"] 



-- Problemas de registracion 
--NO ANDA EL TOLOWER, NO LO INCLUYE AL COMPILAR

--normalizarGenerosBiblioteca :: Biblioteca -> Biblioteca
--normalizarGenerosBiblioteca = map normalizarGeneros

--normalizarGeneros :: Libro -> Libro
--normalizarGeneros libro = map allToLower (generos libro)

--allToLower = map toLower


-- Bibliotecas selectivas

type Criterio = Libro -> Bool

berlin :: Criterio
berlin libro = any (=="policial") (generos libro) 

alejandria :: Criterio
alejandria libro = length (texto libro) == cantPags libro

paris :: Criterio
paris libro = any (=="romantico") (generos libro) 

turdera :: Criterio
turdera libro = head (titulo libro) == 'A'

bibliotecasQueAceptanLibro :: Libro -> [Biblioteca] -> [Biblioteca]
bibliotecasQueAceptanLibro libro listaBibliotecas = filter (aceptaLibro libro) listaBibliotecas

aceptaLibro :: Libro -> Biblioteca -> Bool
aceptaLibro libro biblioteca = (criterio biblioteca) libro

-- Ejemplos
biblioteca1 = Biblioteca [l1,l2] berlin
biblioteca2 = Biblioteca [l1] turdera
biblioteca3 = Biblioteca [l3] paris


-- Biblioteca infinita?

-- Tengo que crear una funcion que calcule todas las variaciones con repeticion de "n" (cant letras del alfabeto) en "p" (tamanio de cadenas)

variacionesConRep :: [a] -> Number -> [[a]]
variacionesConRep [] _ = [[]]
variacionesConRep _ 0 = [[]] 
variacionesConRep lista n = [z:ys | z <- lista, ys <- variacionesConRep lista (n-1) ]

-- Literal

cantSimbolosTotalesPorLibro = 410 * 40 * 80 -- Paginas * renglonesPorPagina * simbolosPorRenglon = 1312000
bibliotecaDeBabel = Biblioteca librosDeBabel esLibroValido

-- La cantidad de libros de babel son: 29 simbolos ^ 1312000 simbolos por libro, osea = 29^1312000 libros totales
librosDeBabel = map generarLibrosDeBabel [0..(29^1312000 - 1)]
-- De todos los textos posibles, elijo el de la posicion "n"
-- La cantidad de textos posibles es: 29^1312000
generarLibrosDeBabel n = Libro "Babel" 410 ((variacionesConRep simbolosValidos cantSimbolosTotalesPorLibro ) !! n ) ["desconocido"] 


-- Simplificada
-- Tiene un solo simbolo por pagina, 410 pags. Es decir, 410 simbolos por libro.

bibliotecaSimplificada = Biblioteca librosSimplificados esLibroValido

librosSimplificados = map generarLibrosSimplificados [0..(29^410 - 1)]
-- Cantidad de libros = 29^410
generarLibrosSimplificados n = Libro "Simp" 410 ((variacionesConRep simbolosValidos (29^410) ) !! n ) ["desconocido"] 


-- Personalizada

sinCriterio :: Criterio
sinCriterio _ = True

simbolosPers1 = "ab"
bibliotecaPers1 = Biblioteca (librosPers simbolosPers1) sinCriterio
-- Cantidad de libros de Pers1 = 2^1312000 
librosPers simbolosPers = map (generarLibrosPers simbolosPers) [0..((length simbolosPers)^1312000 - 1)]
generarLibrosPers simbolosPers n = Libro "Pers" 410 ((variacionesConRep simbolosPers ((length simbolosPers)^1312000) ) !! n ) ["desconocido"] 