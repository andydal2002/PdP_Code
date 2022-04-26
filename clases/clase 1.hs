{-

Haskell: (lenguaje funcional)
El "=" es una sustitución en una sola dirección. No guarda datos en memoria.
x = True
y = False
Es decir, creamos un ALIAS para un determinado VALOR, le damos un nombre.
Estos valores pueden ser números, booleanos (True y False), strings, etc.

Se llama lenguaje funcional porque se usan funciones, que toman un input y realizan un procedimiento para dar una salida.
F(x) = 2x (en matemática)

(En Haskell)
Funciones numéricas:
anterior nro = nro-1
siguiente nro = nro+1
doble nro = nro*2 
cuadrado nro = nro*nro

Funciones booleanas:
esPositivo nro = nro>0 (devuelve True o False)

Multiples parámetros:
areaRectangulo base altura = base*altura

Composición de funciones:
dobleDelCuadrado x = 2*(x*x)
dobleDelCuadrado x = doble (cuadrado x) //si no tuviera paréntesis tomaria a "doble" como un parametro de la funcion
dobleDelCuadrado x = doble.siguiente
La composicion es una funcion que toma por parametro dos funciones y devuelve una funcion

Operadores:
Los operadores como +, -, *, son funciones que se usan de forma INFIJA (entre sus argumentos) y no PREFIJA (antes de sus argumentos)
siguiente nro = (+) nro 1 --la suma se puede escribir de forma PREFIJA

Strings:
Funciones base: 
length: dice el largo
head: devuelve el primer caracter
++: concatena Strings
elem: dice si una letra o caracter pertenece a una palabra
Funcion creada: cuantoMidenJuntos a b = length(a ++b)

-}

