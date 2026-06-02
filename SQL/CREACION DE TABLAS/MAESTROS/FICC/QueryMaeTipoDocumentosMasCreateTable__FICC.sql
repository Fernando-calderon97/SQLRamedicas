-- QUERY MAESTRO TIPO DE DOCUMENTOS FICC

INSERT INTO  [RamedicasBI].[dbo].[rmd_maetipdoc_ficc]
SELECT 
TipCod AS 'tipcod',
TipNom AS 'tipnom',
TipComEst AS 'estado',
FueCod AS 'fuecod',
'' AS 'modori',
'' AS 'docori',
0 AS 'cueori',
'' AS 'tipnat',
TipCiclo AS 'tipciclocod',
CASE
    WHEN TipCiclo = 'U' THEN 'UNICO'
    WHEN TipCiclo = 'A' THEN 'ANUAL'
    WHEN TipCiclo = 'M' THEN 'MENSUAL'
    ELSE '' END AS 'tipciclonom',
TipUsuCre AS 'tipusucre',
CASE 
    WHEN YEAR(TipFecCre) = 1753 THEN NULL
    ELSE CAST(TipFecCre AS DATETIME) END AS 'tipfeccre',
TipUsuMod AS 'tipusumod',
CASE 
    WHEN YEAR(TipFecMod) = 1753 THEN NULL
    ELSE CAST(TipFecMod AS DATETIME) END AS 'tipfecmod'
FROM [RamedicasFiccERP].[dbo].[Tipos]

-- CREATE TABLE MAESTRO TIPO DE DOCUMENTOS FICC

USE RamedicasBI;
CREATE TABLE rmd_maetipdoc_ficc (
    tipcod VARCHAR(5) NOT NULL,
    tipnom VARCHAR(100) NOT NULL,
    estado VARCHAR(10) NULL,
    fuecod VARCHAR(10)  NOT NULL,
    modori VARCHAR(7) NULL,
    docori VARCHAR(7) NULL,
    cueori INT NULL,
    tipnat VARCHAR(10) NULL,
    tipciclocod VARCHAR(1) NULL,
    tipcilonom VARCHAR(20) NULL,
    tipusucre VARCHAR(40) NULL,
    tipfeccre DATETIME NULL,
    tipusumod VARCHAR(40) NULL,
    tipfecmod DATETIME NULL
CONSTRAINT [pk_rmd_maetipodocumento_ficc] PRIMARY KEY CLUSTERED 
(
    [tipcod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

-- ELIMINCION DE LA TABLA CUIDADO
USE RamedicasBI
DROP TABLE rmd_maetipdoc_ficc