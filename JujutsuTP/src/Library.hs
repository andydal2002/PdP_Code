module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

data Hechicero = Hechicero {
    grado::Number,
    antiguedad::Number,
    clan::String} deriving (Show, Eq)

nobara = Hechicero 3 1 "Kugisaki"
satoru = Hechicero 0 15 "Gojo"
maki = Hechicero 4 3 "Zenin"
yuji = Hechicero 1 0 "Itadori"

tieneExperiencia :: Hechicero -> Bool
tieneExperiencia hechicero = antiguedad hechicero > 1

estaPreparado :: [Hechicero] -> Bool
estaPreparado equipo = length equipo > 3

subirGrado :: Hechicero -> Hechicero
subirGrado (Hechicero grado antiguedad clan)
    |grado == 0 = (Hechicero grado antiguedad clan)
    | otherwise = (Hechicero (grado - 1) antiguedad clan)

esPrestigioso :: Hechicero -> Bool
esPrestigioso hechicero = 
    clan hechicero == "Zenin" 
    ||clan hechicero == "Gojo"
    || clan hechicero == "Kamo"

esInvencible :: [Hechicero] -> Bool
esInvencible equipo = any esEspecial equipo 

esEspecial :: Hechicero -> Bool
esEspecial hechicero = grado hechicero == 0

esFavorito :: [Hechicero] -> Bool
esFavorito equipo = all esEspecial equipo

sonExpertos :: [Hechicero] -> [Hechicero]
sonExpertos equipo = filter tieneExperiencia equipo

hacerFrenteACualquierMaldicion :: [Hechicero] -> Bool
hacerFrenteACualquierMaldicion equipo = esInvencible equipo || estaPreparado equipo

powerUp :: [Hechicero] -> [Hechicero]
powerUp equipo = map subirGrado equipo

cantidadEspeciales :: [Hechicero] -> Number
cantidadEspeciales equipo = length (filter esEspecial equipo)

promedioGrados :: [Hechicero] -> Number
promedioGrados equipo = sum(map grado equipo) / length equipo

grupo1 = [nobara, maki, yuji]
grupo2 = [nobara, yuji]
grupo3 = [satoru]
grupo4 = [satoru, maki, yuji, nobara]
