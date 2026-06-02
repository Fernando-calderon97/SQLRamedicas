-- QUERY INSERT FACTURACION FE FICC
DELETE [RamedicasBI].[dbo].[rmd_trafacdist_ficc] WHERE facfec >= CAST(GETDATE()-10 AS DATE)
INSERT INTO [RamedicasBI].[dbo].[rmd_trafacdist_ficc]
SELECT
F.FacSec AS 'facsec',
K.KarSec AS 'karsec',
F.FacFec AS 'facfec',
F.FacNitSec AS 'facnitsec',
F.FacCliSec AS 'facclisec',
F.FacVenCod AS 'facvencod',
F.FacTipCod AS 'factipcod',
F.FacNro AS 'facnro',
K.KarNat AS 'nat',
F.FacEst AS 'facest',
K.KarEst AS 'karest',
F.FacConPla AS 'facconpla',
K.ArtSec AS 'artsec',
K.PreArtCod AS 'preartcod',
K.KarPrePub AS 'preundant',
K.KarPre AS 'preundact',
K.KarUni AS 'und',
K.KarPorIva AS 'poriva',
K.KarArtIva AS 'vlriva',
K.KarValTotMenDes AS 'vlrtot',
F.FacSecDev AS 'facsecdev',
F.FacUsuCod AS 'usucre',
F.FacUsuCodMod AS 'usumod',
F.FacFecMod AS 'fecmod',
F.FacAnuUsu AS 'fecanuusu',
F.FacAnuFec AS 'fecanufec',
F.FacEstRad AS 'facestrad',
F.FacCufe AS 'faccufe',
F.FacFecTra AS 'facfectra',
F.FacAnuObs AS 'facanuonbs',
F.FacObs AS 'facobs',
K.FacSecRem AS 'facsecrem',
F.FacDocCom AS 'facdoccom',
F.FacComSec AS 'faccomsec'
FROM [RamedicasFiccERP].[dbo].[factura] F
INNER JOIN [RamedicasFiccERP].[dbo].[facturaKardex] K ON F.FacSec = K.FacSec 
WHERE F.FacTipCod = 'FE' AND F.FacFec >= CAST(GETDATE()-10 AS DATE)

-- CREATE TABLE FACTURACION FICC FE
USE RamedicasBI
CREATE TABLE rmd_trafacdist_ficc (
    facsec VARCHAR(100) NOT NULL,
    karsec INT NOT NULL,
    facfec DATETIME NULL,
    facnitsec INT NULL,
    facclisec INT NULL,
    facvencod INT NULL,
    factipcod VARCHAR(5) NULL,
    facnro VARCHAR(100) NULL,
    nat INT NULL,
    facest VARCHAR(3) NULL,
    karest VARCHAR(3) NULL,
    facconpla INT NULL,
    artsec INT NULL,
    preartcod INT NULL,
    preundant NUMERIC(18,2) NULL,
    preundact NUMERIC(18,2) NULL,
    und INT NULL, 
    poriva NUMERIC(18,2) NULL,
    vlriva NUMERIC(18,2) NULL,
    vlrtot NUMERIC(18,2) NULL,
    facsecdev VARCHAR(100) NULL,
    usucre VARCHAR(30) NULL,
    usumod VARCHAR(30) NULL,
    fecmod DATETIME NULL,
    fecanuusu VARCHAR(30) NULL,
    fecanufec DATETIME NULL,
    facestrad VARCHAR(5) NULL,
    faccufe VARCHAR(250) NULL,
    facfectra DATETIME NULL,
    facanuonbs VARCHAR(1500) NULL,
    facobs VARCHAR(1500) NULL,
    facsecrem VARCHAR(100) NULL,
    facdoccom VARCHAR(100) NULL,
    FacComSec VARCHAR(100) NULL
 CONSTRAINT [pk_rmd_trafacdist_ficc] PRIMARY KEY CLUSTERED 
(
    [facsec] ASC,
    [karsec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

USE RamedicasBI
DROP TABLE rmd_trafacdist_ficc


