--QUERY INSERT TRASLADO Y DEVOLUCIONES ENTRE PUNTOS

INSERT INTO [RamedicasBI].[dbo].[rmd_tratpdp_ficc]
SELECT 
F.FacSec AS 'facsec',
K.KarSec AS 'karsec',
F.FacFec AS 'facfec',
F.FacTipCod AS 'factipcod',
F.FacNro AS 'facnro',
K.KarNat AS 'nat',
F.FacEst AS 'estado',
K.ArtSec AS 'artsec',
K.KarPreFacCon AS 'emb',
CAST(K.KarPrePub AS NUMERIC(18,2)) AS 'preund',
CAST(K.KarUni AS INT) AS 'und',
CAST(K.KarValTotMenDes AS NUMERIC(18,2)) AS 'vlrtot',
F.BodSucCCSecOri AS 'codbodori',
K.SubBodSucCCSec AS 'subbodsuccsec',
F.BscDesSec AS 'codboddes',
F.FacUsuCod AS 'facusucre',
F.FacUsuCodMod 'facusumod',
F.FacFecMod AS 'facfecmod',
F.FacAnuUsu AS 'facaunuusu',
F.FacAnuFec AS 'facanufec',
F.FacAnuObs AS 'facanuobs',
F.FacObs AS 'facobs'
FROM [RamedicasFiccERP].[dbo].[Factura] F
INNER JOIN [RamedicasFiccERP].[dbo].[FacturaKardex] K ON F.FacSec = K.FacSec
WHERE F.FacTipCod IN ('TP','DP')


-- CREATE TABLA TRASLADOS Y DEVOLUCIONES ENTRE PUNTOS

CREATE TABLE rmd_tratpdp_ficc (
facsec VARCHAR(100) NOT NULL,
karsec INT NOT NULL,
facfec DATETIME NULL,
factipcod VARCHAR(5) NULL,
facnro VARCHAR(100) NULL,
nat INT NULL,
estado VARCHAR(3) NULL,
artsec INT NULL,
emb INT NULL,
preund NUMERIC(18,2) NULL,
und INT NULL,
vlrtot NUMERIC(18,2) NULL,
codbodori INT NULL,
subbodsuccsec INT NULL,
facusucre VARCHAR(30) NULL,
facusumod VARCHAR(30) NULL,
facfecmod DATETIME NULL,
facaunuusu VARCHAR(30) NULL,
facanufec DATETIME NULL,
facanuobs VARCHAR(1500) NULL,
facobs VARCHAR(1500) NULL
CONSTRAINT [pk_rmd_tratpdp_ficc] PRIMARY KEY CLUSTERED 
(
    [facsec] ASC,
    [karsec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]