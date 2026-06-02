

-- QUERY INSERT TRANSACCIONAL ACTAS DE RECEPCION FICC

INSERT INTO [RamedicasBI].[dbo].[rmd_traactrec_ficc]
SELECT 
A.ActRecSec AS 'actrecsec',
AD.ActRecDetSec AS 'actrecdetsec',
CAST(A.ActRecFec AS DATE) AS 'actfec',
A.ActRecNitSec AS 'actrecnitsec',
A.ActRecTipCod AS 'actrectipcod',
A.ActRecNro AS 'actrecnro',
A.ActRecEst AS 'actrecest',
AD.Artsec AS 'artsec',
AD.PreArtCod AS 'preartcod',
CAST(AD.ActRecUni AS INT) AS 'und',
AD.ActRecPrePub AS 'preund',
AD.ActRecPorIva AS 'poriva',
AD.ActRecArtIva AS 'vlriva',
AD.ActRecValTotMenDes AS 'vlrtotbrt',
CAST((AD.ActRecArtIva + AD.ActRecValTotMenDes) AS NUMERIC(18,2)) AS 'vlrtotnto',
AD.ActReclot AS 'actreclot',
AD.ActRecLotFec AS 'actreclotfec',
A.ActRecSucCod AS 'actrecsuccod',
A.ActRecBodSucCcSec AS 'actrecbodsuccsec',
A.ActRecEstUbi AS 'actrecestubi',
A.LibEntSec AS 'libentsec',
A.ActRecUsuCod AS 'actrecusucodcre',
A.ActRecFecHor AS 'actrecfechorcre',
A.ActRecUsuCodMod AS 'actrecusucodmod',
A.ActRecFecHorMod AS 'actfechormod',
A.ActRecFacSec AS 'actrecfacsec',
AD.ActRecDetOdcSec AS 'actrecdetodcsec',
AD.ActRecObsPre AS 'actrecobspre',
A.ActRecObs AS 'actrecobs'
FROM [RamedicasFiccERP].[dbo].[ActaRecepcion] A
INNER JOIN [RamedicasFiccERP].[dbo].[ActaRecepcionDetalle] AD ON A.ActRecSec = AD.ActRecSec


-- CREATE TABLE TRANSACCIONAL ACTAS DE RECEPCIO FICC

USE RamedicasBI
CREATE TABLE rmd_traactrec_ficc (
    actrecsec VARCHAR(100) NOT NULL,
    actrecdetsec INT NOT NULL,
    actfec DATETIME NULL,
    actrecnitsec VARCHAR(20) NULL,
    actrectipcod VARCHAR(5) NULL,
    actrecnro VARCHAR(20) NULL,
    actrecest VARCHAR(3) NULL,
    artsec INT NULL,
    preartcod INT NULL,
    und INT NULL,
    preund NUMERIC(18,2) NULL,
    poriva DECIMAL NULL,
    vlriva NUMERIC(18,2) NULL,
    vlrtotbrt NUMERIC(18,2) NULL,
    vlrtotnto NUMERIC(18,2) NULL,
    actreclot VARCHAR(25) NULL,
    actreclotfec DATETIME NULL,
    actrecsuccod VARCHAR(100) NULL,
    actrecbodsuccsec INT NULL,
    actrecestubi VARCHAR(3) NULL,
    libentsec INT NULL,
    actrecusucodcre VARCHAR(100) NULL,
    actrecfechor DATETIME NULL,
    actrecusucod VARCHAR(100) NULL,
    actferhormod DATETIME NULL,
    actrecfacsec VARCHAR(100) NULL,
    actrecdetodcsec VARCHAR(100) NULL,
    actrecobspre VARCHAR(1500) NULL,
    actrecobs VARCHAR(1500) NULL
 CONSTRAINT [pk_rmd_traactrec_ficc] PRIMARY KEY CLUSTERED 
(
    [actrecsec] ASC,
    [actrecdetsec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


USE RamedicasBI;
DROP TABLE rmd_traactrec_ficc