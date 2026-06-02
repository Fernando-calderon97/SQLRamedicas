-- INSERT TRANSACCIONAL AJUSTES FICC
DELETE [RamedicasBI].[dbo].[rmd_traajuinv_ficc] WHERE facfec >= CAST(GETDATE()-10 AS DATE)
INSERT INTO [RamedicasBI].[dbo].[rmd_traajuinv_ficc]
SELECT
F.FacSec AS 'facsec',
K.KarSec AS 'karsec',
F.FacFec AS 'facfec',
F.FacTipCod AS 'factipcod',
F.FacNro AS 'facnro',
K.KarNat AS 'nat',
F.FacEst AS 'facest',
K.KarEst AS 'karest',
K.ArtSec AS 'artsec',
K.PreArtCod AS 'preartcod',
K.KarPreFacCon AS 'emb',
K.KarPrePub AS 'preund',
K.KarUni * K.KarNat AS 'und',
K.KarValTotMenDes * K.KarNat AS 'vlrtot',
K.KarLot AS 'lote',
K.KarLotFec AS 'fecven',
F.BodSucCCSecOri AS 'codbodori',
K.SubBodSucCCSec AS 'subbodsuccsec',
F.FacUsuCod AS 'usucre',
F.FacUsuCodMod AS 'usumod',
F.FacFecMod AS 'fecmod',
F.FacAnuUsu AS 'usuanu',
F.FacAnuFec AS 'fecanu',
F.FacAnuObs AS 'facanuonbs',
F.FacObs AS 'facobs'
FROM [RamedicasFiccERP].[dbo].[factura] F
INNER JOIN [RamedicasFiccERP].[dbo].[facturaKardex] K ON F.FacSec = K.FacSec 
WHERE F.FacTipCod = 'AJUS' AND F.FacFec >= CAST(GETDATE()-10 AS DATE)

-- CREATE TABLE TRANSACCIONAL AJUSTES

CREATE TABLE rmd_traajuinv_ficc (
    facsec VARCHAR(100) NOT NULL,
    karsec INT NOT NULL,
    facfec DATETIME NULL,
    factipcod VARCHAR(5) NULL,
    facnro VARCHAR(100) NULL,
    nat INT NULL,
    facest VARCHAR(3) NULL,
    karest VARCHAR(3) NULL ,
    artsec INT NULL ,
    preartcod INT NULL,
    emb INT NULL,
    preund NUMERIC(18,2) NULL,
    und INT NULL,
    vlrtot NUMERIC(18,2) NULL,
    lote VARCHAR(30) NULL,
    fecven DATETIME NULL,
    codbodori INT NULL,
    subbodsuccsec INT NULL,
    usucre VARCHAR(30) NULL,
    usumod VARCHAR(30) NULL,
    fecmod DATETIME NULL,
    usuanu VARCHAR(30) NULL,
    fecanu DATETIME NULL ,
    facanuonbs VARCHAR(1500) NULL,
    facobs VARCHAR(1500) NULL
CONSTRAINT [pk_rmd_traajuinv_ficc] PRIMARY KEY CLUSTERED 
(
    [facsec] ASC,
    [karsec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SELECT * FROM TIPOS