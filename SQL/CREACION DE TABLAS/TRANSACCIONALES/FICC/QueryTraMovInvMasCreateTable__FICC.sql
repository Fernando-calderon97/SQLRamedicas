-- QUERY INSERT TRANSACCIONAL MOVIMIENTO INVENTARIO

INSERT INTO [RamedicasBI].[dbo].[rmd_tramovinv_ficc]
SELECT
F.FacSec AS 'facsec',
K.KarSec AS 'karsec',
C.ComSec AS 'comsec',
F.FacFec AS 'facfec',
C.ComFecEnc AS 'comfecenc',
F.FacNitSec AS 'facnitsec',
F.FacNro AS 'facnro',
F.FacTipCod AS 'factipcod',
F.FacEst AS 'facest',
C.ComEst AS 'comest',
K.KarEst AS 'karest',
K.ArtSec AS 'artsec',
K.PreArtCod AS 'preartcod',
CAST(K.KarPreFacCon AS INT) AS 'artemb',
CAST((K.KarNat * K.karUni) AS NUMERIC(18,2)) AS 'karcaj',
CAST(((K.karUni * K.KarPreFacCon) * K.KarNat) AS NUMERIC(18,2)) AS 'karuni',
K.KarPorIva AS 'karporiva',
K.KarArtIva AS 'karartiva',
CASE 
    WHEN K.karNat = -1 THEN CAST(K.KarPrePub *-1 AS NUMERIC(18,2)) 
    ELSE CAST(K.KarPrePub AS NUMERIC(18,2)) END AS 'karprecaj',
CASE 
    WHEN K.karNat = -1 THEN CAST(K.karvaltotMenDes *-1 AS NUMERIC(18,2)) 
    ELSE CAST(K.karvaltotMenDes AS NUMERIC(18,2)) END AS 'kartot',
K.karNat AS 'karnat',
K.KarLot AS 'karlot',
K.KarLotFec AS 'karlotfec',
F.BodSucCCSecOri AS 'codbodori',
K.SubBodSucCCSec AS 'codsubbodori',
F.FacUsuCod AS 'facusucre',
F.FacUsuCodMod AS 'facusumod',
F.FacFecMod AS 'facfecmod',
F.FacAnuUsu AS 'facusuanu',
F.FacAnuFec AS 'facfecanu',
F.FacObs AS 'facobs',
C.ComObs AS 'comobs'
FROM [RamedicasFiccERP].[dbo].[Factura] F
INNER JOIN [RamedicasFiccERP].[dbo].[FacturaKardex] K ON F.FacSec = K.FacSec
LEFT JOIN [RamedicasFiccERP].[dbo].[Comprobante] C ON F.FacComSec = C.ComSec

-- CREATE TABLE TRANSACCIONAL MOVIMIENTO INVENTARIO 

USE RamedicasBI;
CREATE TABLE rmd_tramovinv_ficc (
    facsec VARCHAR(100) NOT NULL,
    karsec INT NOT NULL,
    comsec VARCHAR(100) NULL,
    facfec DATETIME NULL,
    comfecenc DATETIME NULL,
    facnitsec INT NULL,
    facnro VARCHAR(100) NULL,
    factipcod VARCHAR(20) NULL,
    facest VARCHAR(3) NULL,
    comest VARCHAR(3) NULL,
    karest VARCHAR(3) NULL,
    artsec INT NULL,
    preartcod INT NULL,
    artemb INT NULL,
    karcaj NUMERIC(18,2) NULL,
    karuni NUMERIC(18,2) NULL,
    karporiva NUMERIC(18,2) NULL,
    karartiva NUMERIC(18,2) NULL,
    karprecaj NUMERIC(18,2) NULL,
    kartot NUMERIC(18,2) NULL,
    karnat INT NULL,
    karlot VARCHAR(50) NULL,
    karlotfec DATETIME NULL,
    codbodori INT NULL,
    codsubbodori INT NULL,
    facusucre VARCHAR(30) NULL,
    facusumod VARCHAR(30) NULL,
    facmodfec DATETIME NULL,
    facusuanu VARCHAR(30) NULL,
    facfecanu DATETIME NULL,
    facobs VARCHAR(1500) NULL,
    comobs VARCHAR(1500) NULL
 CONSTRAINT [pk_rmd_tramovinv_ficc] PRIMARY KEY CLUSTERED 
(
    [facsec] ASC,
    [karsec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


USE RamedicasBI;
DROP TABLE rmd_tramovinv_ficc





