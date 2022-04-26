{-}
22/4/22

Pattern Matching: cuando usamos DATAs, se pueden escribir como un patron
Ejemplo: edades (UnGrupo edad nombre listaIntegrantes) = edad : listaIntegrantes
Tambien se puede usar el "_" si no es necesario nombrar una variable del DATA: 
edades (UnGrupo edad _ listaIntegrantes) = edad : listaIntegrantes

Polimorfismos: La salida de una funcion depende del TIPO de la entrada.
Por ejemplo, comparar a b = a < b devuelve algo diferente si a y b son Int, String, etc.
Esto permite la existencia de funciones genericas, basadas en funciones polimorfica.
Por ejemplo, identidad :: a -> a
             identidad x = x
La funcion identidad acepta cualquier tipo de variable, incluyendo otras FUNCIONES. 
identidad even = even
-}

-- MAP: aplica una funcion a cada elemento de una lista, devolviendo una lista con la salida de cada elemento.

data Persona = {
    nombre::String,
    edad::Number} deriving Show

listaPersonas = [pedro, carlos, juan]
pedro = Persona "pedro" 30
carlos = Persona "charly" 20
juan = Persona "john" 40

promedioEdades :: [Persona] -> Number
promedioEdades personas = promedio (map edad personas)
promedio lista = sum lista / length lista

map :: (a -> b) -> [a] -> [b]

-- Filter: dada una lista, devuelve otra lista solamente con los elementos que aprueban una condicion.
filter :: (a -> Bool) -> [a] -> [a]

esMayor :: [Persona] -> Bool
esMayor persona =  (edad persona) < 18
personasMayores personas = map nombre (filter esMayor personas)

{-}
Orden Superior: es cuando una funcion toma como parametro a otras funciones.
Por ejemplo: 
all devuelve true si todos los elementos de una lista cumplen con una condicion
all even [1..10] = false

any devuelve true si algun elemento de una lista cumple con una condicion
any even [1..10] = true

zipWith aplica una funcion de dos entradas, cuya primera entrada son cada elemento de la primer lista 
y cuya segunda entrada son cada elemento de la segunda lista,
aplicando el primero con el primero, segundo con el segundo y asi sucesivamente.

zipWith (+) [1,2,3] [100, 200, 300] = [101, 202, 303]
zipWith (:) ['A', 'B', 'C'] ["hola", "chau", "buenas"]

($): aplica una funcion a un valor
even $ 4 = even 4 = True
($) [odd, even, even] [2, 5, 6]

flip: aplica una funcion cambiando los argumentos de lugar
flip (/) 10 2 = (/) 2 10 

(.): composicion, f.g = f(g(x))
even . length "hola" = True


