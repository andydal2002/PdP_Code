data grupoAsado = grupoAsado String Int [Int]

nombreEncargado(grupoAsado nombreEncargado edadEncargado edadesAcompaniantes) = nombreEncargado
edadEncargado (grupoAsado nombreEncargado edadEncargado edadesAcompaniantes) = edadEncargado
edadesAcompaniantes (grupoAsado nombreEncargado edadEncargado edadesAcompaniantes) = edadesAcompaniantes

cantidadIntegrantes :: grupoAsado -> Int
cantidadIntegrantes grupoAsado = (length edadesAcompaniantes) + 1

edadPromedio::grupoAsado -> Number
edadPromedio grupoAsado = ((sum (edadesAcompaniantes grupoAsado)) + (edadEncargado grupoAsado))/cantidadIntegrantes grupoAsado

edadPromedioMayor::grupoAsado -> grupoAsado -> Number
edadPromedioMayor parrilla1 parrilla2 = max((edadPromedio parrilla1) (edadPromedio parrilla2))

encargadoDelGrupoMasViejo:: grupoAsado -> grupoAsado -> String
encargadoDelGrupoMasViejo parrilla1 parrilla2 | edadPromedioMayor parrilla1 parrilla2 == edadPromedio parrilla1 = nombreEncargado parrilla1
    | otherwise = nombreEncargado parrilla2

parrilla1 = grupoAsado "Juan" 29 [19,24,45]
parrilla2 = grupoAsado "Jorge" 32 [60, 80, 76]
