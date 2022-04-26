module Library where
import PdePreludat

data grupoAsado = grupoAsado {
    nombreEncargado::String,
    edadEncargado::Number,
    edadesAcompaniantes::[Number]
} deriving (Show, Eq)

cantidadIntegrantes :: grupoAsado -> Number
cantidadIntegrantes grupoAsado = (length edadesAcompaniantes) + 1

edadPromedio::grupoAsado -> Number
edadPromedio grupoAsado = ((sum (edadesAcompaniantes grupoAsado)) + (edadEncargado grupoAsado))/cantidadIntegrantes grupoAsado

edadPromedioMayor::grupoAsado -> grupoAsado -> Number
edadPromedioMayor parrilla1 parrilla2 = max((edadPromedio parrilla1) (edadPromedio parrilla2))

encargadoDelGrupoMasViejo:: grupoAsado -> grupoAsado -> String
encargadoDelGrupoMasViejo parrilla1 parrilla2 | edadPromedioMayor parrilla1 parrilla2 == edadPromedio parrilla1 = nombreEncargado parrilla1
    | otherwise = nombreEncargado parrilla2

{-}
parrilla1 = grupoAsado {
    nombreEncargado = "Juan",
    edadEncargado = 29,
    edadesAcompaniantes = [19,24,45]
}
parrilla2 = grupoAsado {
    nombreEncargado = "Jorge",
    edadEncargado = 32,
    edadesAcompaniantes = [60, 80, 76]
}