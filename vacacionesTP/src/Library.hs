module Library where
import PdePreludat

data Turista = Turista {
    stress :: Number,
    cansancio :: Number,
    viajaSolo :: Bool,
    idiomas :: [String]
} deriving (Show, Eq)

type Excursion = Turista -> Turista

irPlaya :: Excursion
irPlaya turista
    | viajaSolo turista = turista {cansancio = cansancio turista + 5}
    | otherwise = turista {stress = stress turista - 1}

apreciarPaisaje :: String -> Excursion
apreciarPaisaje elemento turista = turista {stress = stress turista - length elemento}

salirAhablarIdioma :: String -> Excursion
salirAhablarIdioma idioma turista = turista {idiomas = idioma : idiomas turista}

caminar :: Number -> Excursion
caminar minutos turista = turista {cansancio = cansancio turista + intensidad, stress = stress turista - intensidad}
    where intensidad = div minutos 4

paseoEnBarco :: String -> Excursion
paseoEnBarco estadoMarea turista
    | estadoMarea == "fuerte" = turista {stress = stress turista + 6, cansancio = cansancio turista + 10}
    | estadoMarea == "moderada" = turista
    | estadoMarea == "tranquila" = foldl (\turista excursion -> excursion turista) turista [(caminar 10), (apreciarPaisaje "mar"), (salirAhablarIdioma "aleman")]

-- 1

ana = Turista 21 0 False ["espaniol"]
beto = Turista 15 15 True ["aleman"]
cathi = Turista 15 15 True ["aleman", "catalan"]

hacerExcursion :: Turista -> Excursion -> Turista
hacerExcursion turista excursion = (\turista -> turista{stress = stress turista - porcentaje (stress turista) 10}) (excursion turista)
    where porcentaje num p = num * p / 100

-- 2

deltaSegun :: (a -> Number) -> a -> a -> Number
deltaSegun f algo1 algo2 = f algo1 - f algo2

deltaExcursionSegun :: (Turista -> Number) -> Turista -> Excursion -> Number
deltaExcursionSegun indice turista excursion = deltaSegun indice (hacerExcursion turista excursion) turista

esEducativa :: Turista -> Excursion -> Bool
esEducativa turista excursion = deltaExcursionSegun (length . idiomas) turista excursion > 0

excursionesDesestresantes :: Turista -> [Excursion] -> [Excursion]
excursionesDesestresantes turista excursiones = filter (excursionDesestresante turista) excursiones

excursionDesestresante :: Turista -> Excursion -> Bool
excursionDesestresante turista excursion = negate (deltaExcursionSegun stress turista excursion) >= 3

-- 3

type Tour = [Excursion]

completo :: Tour
completo = [caminar 20, apreciarPaisaje "cascada", caminar 40, irPlaya, salirAhablarIdioma "melmacquiano"]

ladoB :: Excursion -> Tour
ladoB excursionElegida = [paseoEnBarco "tranquila", excursionElegida, caminar 120]

islaVecina :: String -> Tour
islaVecina estadoMarea = (paseoEnBarco estadoMarea, excursion, paseoEnBarco estadoMarea]
    where excursion | estadoMarea == "fuerte" = apreciarPaisaje "lago"
                    | otherwise = irPlaya

hacerTour :: Turista -> Tour -> Turista
hacerTour turista tour = foldl hacerExcursion turista tour

algunTourConvincente :: Turista -> [Tour] -> Bool
algunTourConvincente turista tours = any (tourConvincente turista) tours

tourConvincente :: Turista -> Tour -> Bool
tourConvincente turista tour = any (excursionDesestresante turista) tour

efectividadTour :: Tour -> [Turista] -> Number
efectividadTour tour = sum . map (espiritualidad tour)
    where espiritualidad tour turista = (negate . sum) (map (deltaExcursionSegun stress turista) tour ++ map (deltaExcursionSegun cansancio turista) tour)

-- 4

tourPlayasInfinitas = repeat irPlaya

{-
b)
Si, este tour es convincente tanto para Ana como para Beto.
Esto es posible gracias a la evaluacion diferida:
el "any" se detiene y da true cuando encuentra una excursion que cumple
excursionDesestresante verifica si la diferencia de stress es >=3, y como
"irPlaya" no modifica el stress si el turista viaja solo, y reduce el stress si viaja acompañado,
la diferencia de stress siempre se puede calcular de forma finita.
(si viaja solo, se fija en el stress del turista, de lo contrario, siempre va a ser verdadero, porque es una resta infinita)

c) No existe ningun caso donde se pueda conocer la efectividad de este tour,
ya que "sum" debe recorrer toda la lista de diferencias de stress en "espiritualidad",
y luego hay otro "sum" que debe hacerlo mismo para la espiritualidad de todos los turistas.

-}

