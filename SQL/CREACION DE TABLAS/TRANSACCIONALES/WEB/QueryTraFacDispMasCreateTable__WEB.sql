-- INSERT TRANSACCIONAL CUOTAS MODERADORAS
INSERT INTO [RamedicasBI].[dbo].[rmd_trafacdip_web]
SELECT TOP 100
F.FacSec AS 'facsec',
K.KarSec AS 'karsec',
F.facfec AS 'facfec',
F.FacfecDes AS 'facfecdes',
F.FacNitSec AS 'facnitsec',
F.FacCliSec AS 'facclisec',
F.FacVenCod AS 'facvencod',
F.FacTipCod AS 'factipcod',
F.FacNro AS 'facnro',
F.FacEst AS 'facest',
F.FacAutEstado AS 'facautest',
K.KarEsT AS 'karest',
K.KarNat AS 'karnat',
K.ArtSec AS 'artsec',
K.PreArtCod AS 'preart',
K.KarArtEmb AS 'emb',
CAST(K.KarUni AS INT) AS 'und',
K.KarPre AS 'preund',
K.KarArtIva AS 'iva',
K.karvaltotMenDes AS 'vlrtotbrt',
((K.karvaltotMenDes + K.KarArtIva) * -1)  AS 'vlrtotnto',
F.BodSucCCSec AS 'bodsuccsec',
F.FacEscPac AS 'facescpac',
F.FacSecDev AS 'facsecdev',
F.FacDocCom AS 'facdoccom',
F.FacUsuCod AS 'facusucre',
F.FacUsuMod AS 'facusumod',
F.FacFecHorMod AS 'facfecmod',
F.FacUsuAnu AS 'facanuusu',
F.FacFecAnu AS 'facfecanu',
F.FacAnuObs AS 'facobsanu',
F.FacObs AS 'facobs'
FROM [Ramedicas].[dbo].[factura] F
INNER JOIN [Ramedicas].[dbo].[Kardex] K ON F.FacSec = K.FacSec
WHERE FacTipCod IN ('FEV', 'FVE', 'FMC', 'FVA', 'FVC', 'SOS')


-- CREATE TABLE TRANSACCIONAL CUOTAS MODERADORAS

USE RamedicasBI
CREATE TABLE rmd_trafacdip_web (
    facsec INT NOT NULL,
    karsec INT NOT NULL,
    facfec DATETIME NULL,
    facfecdes DATETIME NULL,
    facnitsec INT NULL,
    facclisec INT NULL,
    facvencod INT NULL,
    factipcod VARCHAR(5) NULL,
    facnro VARCHAR(30) NULL,
    facest VARCHAR(3) NULL,
    karest VARCHAR(3) NULL,
    facautest VARCHAR(3) NULL,
    karnat VARCHAR(3) NULL,
    artsec INT NULL,
    preart INT NULL,
    emb INT NULL,
    und INT NULL,
    preund NUMERIC(18,2) NULL,
    iva NUMERIC(18,2) NULL,
    vlrtotbrt NUMERIC(18,2) NULL,
    vlrtotnto NUMERIC(18,2) NULL,
    bodsuccsec INT NULL,
    facescpac VARCHAR(30) NULL,
    facsecdev INT NULL,
    facdoccom INT NULL,
    facusucre VARCHAR(30) NULL,
    facusumod VARCHAR(30) NULL,
    facfecmod DATETIME NULL,
    facanuusu VARCHAR(30) NULL,
    facfecanu DATETIME NULL,
    facobsanu VARCHAR(1500) NULL,
    facobs VARCHAR(1500) NULL
 CONSTRAINT [pk_rmd_trafacdip_web] PRIMARY KEY CLUSTERED 
(
    [facsec] ASC,
    [karsec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]



