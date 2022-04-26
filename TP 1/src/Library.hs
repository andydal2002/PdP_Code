module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

data GrupoAsado = GrupoAsado {
    nombreEncargado::String,
    edadEncargado::Number,
    edadesAcompaniantes::[Number]
} deriving (Show, Eq)

cantidadIntegrantes :: GrupoAsado -> Number
cantidadIntegrantes parrilla = (length (edadesAcompaniantes parrilla)) + 1

edadPromedio::GrupoAsado -> Number
edadPromedio parrilla = ((sum (edadesAcompaniantes parrilla)) + (edadEncargado parrilla))/cantidadIntegrantes parrilla

edadPromedioMayor::GrupoAsado -> GrupoAsado -> Number
edadPromedioMayor parrilla1 parrilla2 = max (edadPromedio parrilla1) (edadPromedio parrilla2)

encargadoDelGrupoMasViejo:: GrupoAsado -> GrupoAsado -> String
encargadoDelGrupoMasViejo parrilla1 parrilla2 | edadPromedioMayor parrilla1 parrilla2 == edadPromedio parrilla1 = nombreEncargado parrilla1
    | otherwise = nombreEncargado parrilla2

parrilla1 = GrupoAsado {
    nombreEncargado = "Juan",
    edadEncargado = 29,
    edadesAcompaniantes = [19,24,45]
}
parrilla2 = GrupoAsado {
    nombreEncargado = "Jorge",
    edadEncargado = 32,
    edadesAcompaniantes = [60, 80, 76]
}
parrilla3 = GrupoAsado {
    nombreEncargado = "Pedro",
    edadEncargado = 80,
    edadesAcompaniantes = [65, 82, 76]
}