
--QUERY INSERT ORDENES DE PEDIDO
INSERT INTO [RamedicasBI].[dbo].[rmd_traordped_ficc]
SELECT 
F.FacSec AS 'ordsec',
K.KarSec AS 'karsec',
F.FacNitSec AS 'ordnitsec',
F.FacCliSec AS 'ordclisec',
F.FacVenCod AS 'ordvencod',
F.FacFec AS 'ordfec',
F.FacGuiCiuOri AS 'ordguiciuori',
F.FacGuiCiuDes AS 'ordguiciudes',
F.FacCOnPla AS 'ordpla',
F.FacFecVen AS 'ordfecven',
F.FacTipCod AS 'ordtipcod',
F.FacNro AS 'ordnum',
K.FacSecRem AS 'facsecrem',
F.FacEst AS 'estado',
K.ArtSec AS 'artsec',
K.KarPorIva AS 'ordporartiva',
K.KarPreFacCon AS 'emb',
CAST(K.KarPrePub AS NUMERIC(18,2)) AS 'preund',
CAST(K.KarUniCp AS INT) AS 'undsol',
CAST(K.KarUniCp * K.KarPrePub * K.KarPorIva AS NUMERIC(18,2)) AS 'ordartivasol',
CAST((K.KarUniCp * K.KarPrePub) AS NUMERIC(18,2)) AS 'pretotbrtsol',
CAST((K.KarUniCp * K.KarPrePub * K.KarPorIva) + (K.KarUniCp * K.KarPrePub) AS NUMERIC(18,2)) AS 'pretotntosol',
CAST(K.KarUni AS INT) AS 'unddes',
CAST(K.KarArtIva AS NUMERIC(18,2)) AS 'ordartivades',
CAST(K.KarValTotMenDes AS NUMERIC(18,2)) AS 'pretotbrtdes',
CAST(K.KarValTotMenDes AS NUMERIC(18,2)) + CAST(K.KarArtIva AS NUMERIC(18,2)) AS 'pretotntodes',
F.FacUsuCod AS 'ordusucre',
F.FacUsuCodMod 'ordusumod',
F.FacFecMod AS 'ordfecmod',
F.FacAnuUsu AS 'ordaunuusu',
F.FacAnuFec AS 'ordanufec',
F.FacAnuObs AS 'ordanuobs',
F.FacObs AS 'ordobs'
FROM [RamedicasFiccERP].[dbo].[Factura] F
INNER JOIN [RamedicasFiccERP].[dbo].[FacturaKardex] K ON F.FacSec = K.FacSec
WHERE F.FacTipCod = 'OP'

-- CREATE TABLE TRANSACCIONAL ORDENES DE PEDIDO

USE RamedicasBI;
CREATE TABLE rmd_traordped_ficc (
    ordsec VARCHAR(100) NOT NULL,
    karsec INT NOT NULL,
    ordnitsec INT NULL,
    ordclisec INT NULL,
    ordvencod INT NULL,
    ordfec DATETIME NULL,
    ordguiciuori VARCHAR(5) NULL,
    ordguiciudes VARCHAR(5) NULL,
    ordpla INT NULL,
    ordfecven DATETIME NULL,
    ordtipcod VARCHAR(5) NULL,
    ordnum VARCHAR(100) NULL,
    facsecrem VARCHAR(100) NULL,
    estado VARCHAR(3) NULL,
    artsec INT NULL,
    ordporartiva DECIMAL NULL,
    emb INT NULL,
    preund NUMERIC(18,2) NULL,
    undsol INT NULL,
    ordartivasol NUMERIC(18,2) NULL,
    pretotbrtsol NUMERIC(18,2) NULL,
    pretotntosol NUMERIC(18,2) NULL,    
    unddes INT NULL,
    ordartivades NUMERIC(18,2) NULL,
    pretotbrtdes NUMERIC(18,2) NULL,
    pretotntodes NUMERIC(18,2) NULL,
    ordusucre VARCHAR(30) NULL,
    ordusumod VARCHAR(30) NULL,
    ordfecmod DATETIME NULL,
    ordaunuusu VARCHAR(30) NULL,
    ordanufec DATETIME NULL,
    ordanuobs VARCHAR(1500) NULL,
    ordobs VARCHAR(1500) NULL
 CONSTRAINT [pk_rmd_traordped_ficc] PRIMARY KEY CLUSTERED 
(
    [ordsec] ASC,
    [karsec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

-- CUIDADO CON ESTO SE ELIMINA LA TABLA

USE RamedicasBI;
DROP TABLE rmd_traordped_ficc


