-- QUERY FUENTES FICC
INSERT INTO [RamedicasBI].[dbo].[rmd_objfuente_ficc]
SELECT
F.FueCod AS 'fuecod',
UPPER(F.FueNom) AS 'fuenom',
F.FueUsuCre AS 'fueusucre',
F.FueFecCre AS 'fuefeccre',
F.FueUsuMod AS 'fueusumod',
F.FUeFecMod AS 'fuefecmod',
'' AS 'moddoc'
FROM [RamedicasFiccERP].[dbo].[fuentes] F

-- CREATE TABLE FUENTES FICC

USE RamedicasBI;
CREATE TABLE rmd_objfuente_ficc (
    fuecod VARCHAR(20) NOT NULL,
    fuenom VARCHAR(80) NOT NULL,
    fueusucre VARCHAR(50) NULL,
    fuefeccre DATETIME NULL,
    fueusumod VARCHAR(50) NULL,
    fuefecmod DATETIME NULL,
    moddoc VARCHAR(30) NULL
CONSTRAINT [pk_rmd_objfuentes_ficc] PRIMARY KEY CLUSTERED 
(
    [fuecod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


---
USE RamedicasBI;
DROP TABLE rmd_objfuentes_ficc

