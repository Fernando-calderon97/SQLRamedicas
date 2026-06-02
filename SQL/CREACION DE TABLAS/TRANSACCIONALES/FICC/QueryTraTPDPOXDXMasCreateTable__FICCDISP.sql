--QUERY INSERT CONSUMO TRASLADO Y DEVOLUCIONES ENTRE PUNTOS

INSERT INTO [RamedicasBI].[dbo].[rmd_tratpdpodx_ficcdisp]
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
k.KarArtEmb AS 'emb',
K.KarPrePub AS 'preund',
K.KarUni AS 'und',
k.KarValTotMenDes AS 'vlrtot',
K.KarLot AS 'lote',
K.KarLotFec AS 'lotefec',
F.BodSucCCSecOri AS 'codbodori',
K.SubBodSucCCSec AS 'subbodsuccsec',
F.BscDesSec AS 'codboddes',
F.FacTranCod AS 'factrancod',
F.FacGuiTra AS 'facguitra',
F.FacUsuCod AS 'facusucre',
F.FacUsuCodMod AS 'facusumod',
F.FacFecMod AS 'facfecmod',
F.FacAnuUsu AS 'facanuusu',
F.FacAnuFec AS 'facanufec',
F.FacAnuObs AS 'facanuobs',
F.FacObs AS 'facobs',
F.FacSecRel AS 'facsecrel',
'' AS 'facsecrem'
FROM [RamedicasFiccDispensacion].[dbo].[Factura] F
INNER JOIN [RamedicasFiccDispensacion].[dbo].[FacturaKardex] K ON F.FacSec = K.FacSec
WHERE FacNro LIKE 'TP%' OR FacNro LIKE 'OX%' OR FacNro LIKE 'DP%' OR FacNro LIKE 'DX%'

-- CREATE TABLE TRANSACCIONAL OX Y TP CONSUMO EN DISPENSACION FICC
USE RamedicasBI;

CREATE TABLE rmd_tratpox_ficcdisp (
facsec VARCHAR(100) NOT NULL,
karsec INT NOT NULL,
facfec DATETIME NULL,
factipcod VARCHAR(5) NULL,
facnro VARCHAR(100) NULL,
nat INT NULL,
facest VARCHAR(3) NULL,
karest VARCHAR(3) NULL,
artsec INT NULL,
preartcod INT NULL,
emb INT NULL,
preund NUMERIC(18,2) NULL,
und INT NULL,
vlrtot NUMERIC(18,2) NULL,
lote VARCHAR(30) NULL,
lotefec DATETIME NULL,
codbodori INT NULL,
subbodsuccsec INT NULL,
codboddes INT NULL,
factrancod INT NULL,
facguitra VARCHAR(50) NULL,
facusucre VARCHAR(30) NULL,
facusumod VARCHAR(30) NULL,
facfecmod DATETIME NULL,
facaunuusu VARCHAR(30) NULL,
facanufec DATETIME NULL,
facanuobs VARCHAR(1500) NULL,
facobs VARCHAR(1500) NULL,
facsecrel VARCHAR(100) NULL,
facsecrem VARCHAR(100) NULL
CONSTRAINT [pk_rmd_tratpdpodx_ficcdisp] PRIMARY KEY CLUSTERED 
(
    [facsec] ASC,
    [karsec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


-- CUIDADO ELIMINA LA TABLA

DROP TABLE rmd_tratpdpodx_ficcdisp