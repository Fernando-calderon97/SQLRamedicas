-- QUERY OBJETO CIUDADES
INSERT INTO [RamedicasBI].[dbo].[rmd_objciudad_ficc]
SELECT 
C.CiuCod AS 'ciucod',
C.CiuNom AS 'ciunom',
C.DepCod AS 'depcod',
D.DepNom AS 'depnom',
D.PaiSec AS 'paicod',
P.PaiNom AS 'painom'
FROM [RamedicasFiccERP].[dbo].[Ciudades] C
LEFT JOIN [RamedicasFiccERP].[dbo].[Departamentos] D ON C.DepCod =  D.DepCod
LEFT JOIN [RamedicasFiccERP].[dbo].[Pais] P ON D.PaiSec =  P.PaiSec

-- CREATE TABLE OBJETO CIUDADES

USE RamedicasBI
CREATE TABLE rmd_objciudad_ficc (
    [ciucod] VARCHAR(5) NOT NULL,
    [ciunom] VARCHAR(80) NOT NULL,
    [depcod] VARCHAR(5) NOT NULL,
    [depnom] VARCHAR(80) NOT NULL,
    [paicod] VARCHAR(5) NOT NULL,
    [painom] VARCHAR(80) NOT NULL,
    PRIMARY KEY CLUSTERED
    (
        [ciucod] ASC,
        [depcod] ASC,
        [paicod] ASC
    )
)
