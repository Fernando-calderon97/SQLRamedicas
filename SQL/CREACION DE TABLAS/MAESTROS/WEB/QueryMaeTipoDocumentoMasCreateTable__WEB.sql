
-- QUERY INSERT MAESTRO TIPOS DE DOCUMENTOS WEB
INSERT INTO  [RamedicasBI].[dbo].[rmd_maetipdoc_web]
SELECT 
TipCod AS 'tipcod',
TipNom AS 'tipnom',
TipComEst AS 'estado',
FueCod AS 'fuecod',
'' AS 'modori',
'' AS 'docori',
0 AS 'cueori',
'' AS 'tipnat',
TipCodCopago AS 'tipcodcopago',
TipComUsuCod AS 'tipusucre',
TipComUsuFec AS 'tipfeccre',
TipComUsuCodMod AS 'tipusumod',
TipComFacFecMod AS 'tipfecmod'
FROM [Ramedicas].[dbo].[Tipos]

-- CREATE TABLE MAESTRO TIPOS DE DOCUMENTO WEB
USE RamedicasBI;
CREATE TABLE rmd_maetipdoc_web (
    tipcod VARCHAR(5) NOT NULL,
    tipnom VARCHAR(100) NOT NULL,
    estado VARCHAR(3) NOT NULL,
    fuecod INT NULL,
    modori VARCHAR(5) NULL,
    docori VARCHAR(5) NULL,
    cueori INT NULL,
    tipnat INT NULL,
    tipcodcopago VARCHAR(5) NULL, 
    tipusucre VARCHAR(40) NULL,
    tipfeccre DATETIME NULL,
    tipusumod VARCHAR(40) NULL,
    tipfecmod DATETIME NULL
CONSTRAINT [pk_rmd_maetipodocumento_web] PRIMARY KEY CLUSTERED 
(
    [tipcod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

-- ELIMINCION

USE RamedicasBI
DROP TABLE rmd_maetipdoc_web