-- INSERT FACTURACION NOTAS CREDITO FICC V2 CON CONCEPTO DE DEVOLUCION

DELETE [RamedicasBI].[dbo].[rmd_trafacncnd_ficc] WHERE facfec >= CAST(GETDATE()-10 AS DATE)
INSERT [RamedicasBI].[dbo].[rmd_trafacncnd_ficc]
SELECT TOP 100
F.FacSec AS 'facsec',
K.KarSec AS 'karsec',
F.FacFec AS 'facfec',
F.FacNitSec AS 'facnitsec',
F.FacCliSec AS 'facclisec',
F.FacVenCod AS 'facvencod',
F.FacTipCod AS 'factipcod',
F.FacNro AS 'facnro',
F.FacDocCom AS 'facdoccom',
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
F.FacAnuUsu AS 'usuanu',
F.FacAnuFec AS 'fecanu',
F.FacEstRad AS 'facestrad',
F.FacCufe AS 'faccufe',
F.FacFecTra AS 'facfectra',
F.FacAnuObs AS 'facanuonbs',
F.FacObs AS 'facobs',
CNC.ConNotNom AS 'facaspdev', -- Cambio de nombre
CNC2.ConNotNom AS 'faccondev' -- Actualizado
FROM [RamedicasFiccERP].[dbo].[factura] F
INNER JOIN [RamedicasFiccERP].[dbo].[facturaKardex] K ON F.FacSec = K.FacSec 
LEFT JOIN [RamedicasFiccERP].[dbo].[ConceptoNC] CNC WITH (NOLOCK) ON F.ConNotCod = CNC.ConNotId
LEFT JOIN [RamedicasFiccERP].[dbo].[ConceptoNC] CNC2 WITH (NOLOCK) ON F.ConNotCod = CNC2.ConNotCod
WHERE F.FacTipCod IN ('NC', 'ND', 'NM') AND F.FacFec >= CAST(GETDATE()-10 AS DATE)

-- CREATE TABLE TRANSACCIONAL FACTURACION NOTAS CREDITOS FICC

USE RamedicasBI
CREATE TABLE rmd_trafacncnd_ficc (
    facsec VARCHAR(100) NOT NULL,
    karsec INT NOT NULL,
    facfec DATETIME NULL,
    facnitsec INT NULL,
    facclisec INT NULL,
    facvencod INT NULL,
    factipcod VARCHAR(3) NULL,
    facnro VARCHAR(100) NULL,
    facdoccom VARCHAR(100) NULL,
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
    usucre VARCHAR(50) NULL,
    usumod VARCHAR(50) NULL,
    fecmod DATETIME NULL,
    usuanu VARCHAR(50) NULL,
    fecanu DATETIME NULL,
    facestrad VARCHAR(5) NULL,
    faccufe VARCHAR(250) NULL,
    facfectra DATETIME NULL, 
    facanuonbs VARCHAR(1500) NULL,
    facobs VARCHAR(1500) NULL,
    facaspdev VARCHAR(1500) NULL, -- Cambio de nombre
    faccondev VARCHAR(1500) NULL, -- Nuevo
 CONSTRAINT [pk_rmd_trafacncnd_ficc] PRIMARY KEY CLUSTERED 
(
    [facsec] ASC,
    [karsec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

USE RamedicasBI
DROP TABLE rmd_trafacncnd_ficc
