-- QUERY INSET 
INSERT INTO [RamedicasBI].[dbo].[rmd_trakar_ficc]
SELECT 
K.FacSec AS 'facsec',
K.KarSec AS 'karsec',
CAST(F.FacFec AS DATETIME) AS  'facfec',
F.FacTipCod AS 'factipcod',
F.FacNro AS 'facnro',
K.FacSecTip AS 'facsectip',
K.KarConAjuCod AS 'karconajucod',
K.KarNat AS 'nat',
K.KarEst AS 'estado',
K.Artsec AS 'artsec',
K.PreArtCod AS 'preartcod',
K.KarPreFacCon AS 'emb',
K.KarPrePub AS 'preund',
K.KarPorIva  AS 'poriva',
CASE 
    WHEN K.KarNat = 1 THEN  CAST(K.KarUniCp * 1 AS INT)
    WHEN K.KarNat = -1 THEN CAST(K.KarUniCP * -1 AS INT)
    ELSE CAST(K.KarUniCP AS INT) END AS 'undsol',
((K.KarUniCp)*(K.KarPorIva * K.KarPrePub)) AS 'artivasol',
CASE 
    WHEN K.KarNat = 1 THEN ((K.KarUniCp * K.KarPrePub)*1)
    WHEN K.KarNat = -1 THEN ((K.KarUniCp * K.KarPrePub)*-1)
    ELSE (K.KarUniCp * K.KarPrePub) END AS 'vlrtotbrtsol',
CASE 
    WHEN K.KarNat = 1 THEN (((K.KarUniCp * K.KarPrePub)*(K.KarPorIva * K.KarPrePub * K.KarUniCp))*1)
    WHEN K.KarNat = -1 THEN (((K.KarUniCp * K.KarPrePub)*(K.KarPorIva * K.KarPrePub * K.KarUniCp))*-1)
    ELSE ((K.KarUniCp * K.KarPrePub)*(K.KarPorIva * K.KarPrePub * K.KarUniCp)) END AS 'vlrtotntosol',
CASE
    WHEN K.KarNat = 1 THEN CAST(K.KarUni * 1 AS INT)
    WHEN K.KarNat = -1 THEN CAST(K.KarUni * -1 AS INT)
    ELSE CAST(K.KarUni AS INT) END AS 'unddes',
K.KarArtIva AS 'artivades',
CASE 
    WHEN K.KarNat = 1 THEN (K.KarValTotMenDes * 1) 
    WHEN K.KarNat = -1 THEN (K.KarValTotMenDes * -1)
    ELSE K.KarValTotMenDes END AS 'vlrtotbrtdes',
CASE 
    WHEN K.KarNat = 1 THEN ((K.KarValTotMenDes + K.KarArtIva)*1)
    WHEN K.KarNat = 1 THEN ((K.KarValTotMenDes + K.KarArtIva)*-1)
    ELSE K.KarValTotMenDes + K.KarArtIva END AS 'vlrtotntodes',
K.Karlot AS 'lote',
CAST(K.KarLotFec AS DATE) AS 'lotefec',
F.BodSucCCSecOri AS 'codbodori',
F.BscDesSec  AS 'codboddes',
K.FacSecRem AS 'facsecrem',
K.KarSecRem AS 'karsecrem'
FROM [RamedicasFiccERP].[dbo].[FacturaKardex] K
LEFT JOIN [RamedicasFiccERP].[dbo].[Factura] F ON K.FacSec = F.FacSec

-- CREATE TABLE TRANSACCIONAL KARDEX

USE RamedicasBI;
CREATE TABLE rmd_trakar_ficc (
    facsec VARCHAR(100) NOT NULL,
    karsec INT NOT NULL,
    facfec DATETIME NULL,
    factipcod VARCHAR(10) NULL,
    facnro VARCHAR(100) NULL,
    facsectip VARCHAR(5) NULL,
    karconajucod INT NULL,
    nat INT NULL,
    estado VARCHAR(3) NULL,
    artsec INT NULL,
    preartcod INT NULL,
    emb INT NULL,
    preund NUMERIC(18,2) NULL,
    poriva DECIMAL NULL,
    undsol INT NULL,
    artivasol NUMERIC(18,2) NULL,
    vlrtotbrtsol NUMERIC(18,2) NULL,
    vlrtotntosol NUMERIC(18,2) NULL,
    unddes INT NULL,
    artivades NUMERIC(18,2) NULL,
    vlrtotbrtdes NUMERIC(18,2) NULL,
    vlrtotntodes NUMERIC(18,2) NULL,
    lote VARCHAR(30) NULL,
    lotefec DATETIME NULL,
    codbodori INT NULL,
    codboddes INT NULL,
    facsecrem VARCHAR(100) NULL,
    karsecrem INT NULL
CONSTRAINT [pk_rmd_trakar_ficc] PRIMARY KEY CLUSTERED 
(
    [facsec] ASC,
    [karsec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]



--CUIDADO ELIMNA LA TABLA
USE RamedicasBI
DROP TABLE rmd_trakar_ficc
