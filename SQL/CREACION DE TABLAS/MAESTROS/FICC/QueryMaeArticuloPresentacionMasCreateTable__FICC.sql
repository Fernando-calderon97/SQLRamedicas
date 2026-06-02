--QUERY MAESTRO ARTICULOS PRESENTACION  FICC

INSERT INTO [RamedicasLAB].[dbo].[rmd_maearticulopres_ficc]
SELECT 
ArtSec AS 'artsec',
PreArtCod AS 'preartcod',
PreArtFacConVal AS 'preartfacconval',
PreArtEmb AS 'preartemb',
PreArtEst AS 'preartest',
PreArtUsuCre AS 'preartusucre',
PreArtFecCre AS 'preartfeccre',
PreArtUsuMod AS 'preartsumod',
PreArtFecMod AS 'preartfecmod',
PreArtOcuDis AS 'preartocudis',
PreArtOcuPos AS 'preartocupos',
PreArtMedAlt AS 'preartmedalt',
PreArtMedAnc AS 'preartmedanc',
PreArtMedLar AS 'preartmedlar'
FROM [RamedicasFiccERP].[dbo].[ArticulosPresentacion]

-- CREATE TABLE MAESTRO ARTICULOS PRESENTACION FICC

USE RamedicasLAB

CREATE TABLE rmd_maearticulopres_ficc (
    artsec INT NOT NULL,
    preartcod INT NOT NULL,
    preartfacconval INT NULL,
    preartemb INT NULL,
    preartest VARCHAR(3) NULL,
    preartusucre VARCHAR(50) NULL,
    preartfeccre DATETIME NULL,
    preartsumod VARCHAR(50) NULL,
    preartfecmod DATETIME NULL,
    preartocudis VARCHAR(3) NULL,
    preartocupos VARCHAR(3) NULL,
    preartmedalt NUMERIC(18,2) NULL,
    preartmedanc NUMERIC(18,2) NULL,
    preartmedlar NUMERIC(18,2) NULL,
CONSTRAINT [pk_rmd_maearticulopres_ficc] PRIMARY KEY CLUSTERED 
(
    [artsec] ASC,
    [preartcod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


-- CUIDADO ESTO ELIMINA LA TABLA

DROP TABLE rmd_maearticulopres_ficc

