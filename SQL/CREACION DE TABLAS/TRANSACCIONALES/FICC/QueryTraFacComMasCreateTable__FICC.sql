-- INSERT QUERY FACTURA COMPRAS FICC

DELETE [RamedicasBI].[dbo].[rmd_trafaccom_ficc] WHERE facfec >= CAST(GETDATE()-10 AS DATE)
INSERT INTO [RamedicasBI].[dbo].[rmd_trafaccom_ficc]
SELECT TOP 100
F.FacSec AS 'facsec',
K.KarSec AS 'karsec',
F.FacFec AS 'facfec',
F.FacNitSec AS 'facnitsec',
F.FacProvSec AS 'facprovsec',
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
F.FacUsuCod AS 'usucre',
F.FacUsuCodMod AS 'usumod',
F.FacFecMod AS 'fecmod',
F.FacAnuUsu AS 'fecanuusu',
F.FacAnuFec AS 'fecanufec',
F.FacFecTra AS 'facfectra',
F.FacAnuObs AS 'facanuonbs',
F.FacObs AS 'facobs',
K.FacSecRem AS 'facsecrem',
F.FacDocCom AS 'facdoccom',
F.FacComSec AS 'faccomsec'
FROM [RamedicasFiccERP].[dbo].[factura] F
INNER JOIN [RamedicasFiccERP].[dbo].[facturaKardex] K ON F.FacSec = K.FacSec 
WHERE F.FacTipCod = 'COM'

-- CREATE TABLE FACTURA COMPRAS
USE RamedicasBI

CREATE TABLE rmd_trafaccom_ficc (
    facsec VARCHAR(100) NOT NULL,
    karsec INT NOT NULL,
    facfec DATETIME NULL,
    facnitsec INT NULL,
    facprovsec INT NULL,
    factipcod VARCHAR(3) NULL,
    facnro VARCHAR(100) NULL,
    nat INT NULL,
    facest VARCHAR(3) NULL,
    karest VARCHAR(3) NULL,
    facconpla INT NULL,
    artsec INT NULL,
    preartcod INT NULL,
    preundant NUMERIC(18, 2) NULL,
    preundact NUMERIC(18, 2) NULL,
    und INT NULL,
    poriva NUMERIC(18, 2) NULL,
    vlriva NUMERIC(18, 2) NULL,
    vlrtot NUMERIC(18, 2) NULL,
    usucre VARCHAR(30) NULL,
    usumod VARCHAR(30) NULL,
    fecmod DATETIME NULL,
    fecanuusu VARCHAR(30) NULL,
    fecanufec  DATETIME NULL,
    facfectra DATETIME NULL,
    facanuonbs VARCHAR(1500) NULL,
    facobs VARCHAR(1500) NULL,
    facsecrem VARCHAR(100) NULL,
    facdoccom VARCHAR(100) NULL,
    faccomsec VARCHAR(100) NULL
 CONSTRAINT [pk_rmd_trafaccom_ficc] PRIMARY KEY CLUSTERED 
(
    [facsec] ASC,
    [karsec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


-- CUIDADO ELIMINA LA TABLA

USE RamedicasBI
DROP TABLE rmd_trafaccom_ficc