-- QUERY INSERT TRANSACCIONAL COTIZACIONES
INSERT INTO [RamedicasBI].[dbo].[rmd_tracot_ficc]
SELECT 
C.CotSec AS 'cotsec',
CD.CotDetSec AS 'cotdetsec',
C.CotNitSec AS 'cotnitsec',
C.CotCliSec AS 'cotclisec',
C.CotVenCod AS 'cotvencod',
C.CotFec AS 'cotfec',
C.CotPla AS 'cotpla',
C.TipCod AS 'tipcod',
C.CotNum AS 'cotnum',
C.CotEst AS 'estado',
CD.ArtSec AS 'artsec',
CD.PreArtCod AS 'preartcod',
CAST(CD.CotUni AS INT) AS 'cotuni', 
CAST(CD.CotPrePub AS NUMERIC(18,2)) AS 'cotprepub',
CD.CotPorIva AS 'cotporiva',
CAST(CD.CotArtIva AS NUMERIC(18,2)) AS 'cortartiva',
CAST(CD.CotKarValTotMenDes AS NUMERIC(18,2)) AS 'pretotbrt',
CAST(CD.CotKarValTotMenDes + CD.CotArtIva AS NUMERIC(18,2)) AS 'pretotnto',
CD.CotLisPreCod AS 'cotlisprecod',
C.BodSucCCSec AS 'cotbodcod',
C.CotUsuCre AS 'cotusucre',
C.CotFecCre AS 'cotfeccre',
C.CotUsuAnu AS 'cotusuanu',
C.CotFecAnu AS 'cotfecanu',
C.cotObs AS 'cotobs'
FROM [RamedicasFiccERP].[dbo].[Cotizaciones] C
INNER JOIN [RamedicasFiccERP].[dbo].[CotizacionesDetalle] CD ON C.CotSec = CD.CotSec

-- CREATE TABLE TRANSACCIONAL COTIZACIONES
USE RamedicasBI;
CREATE TABLE rmd_tracot_ficc (
    cotsec VARCHAR(100) NOT NULL,
    cotdetsec INT NOT NULL,
    cotnitsec INT NULL,
    cotclisec INT NULL,
    cotvencod INT NULL,
    cotfec DATETIME NULL,
    cotpla INT NULL,
    tipcod VARCHAR(5) NULL,
    cotnum VARCHAR(100) NULL,
    estado VARCHAR(3) NULL,
    artsec INT NULL,
    preartcod INT NULL,
    cotuni INT NULL,
    cotprepub NUMERIC(18,2) NULL,
    cotporiva DECIMAL NULL,
    cortartiva NUMERIC(18,2) NULL,
    pretotbrt NUMERIC(18,2) NULL,
    pretotnto NUMERIC(18,2) NULL,
    cotlisprecod INT NULL,
    cotbodcod INT NULL,
    cotusucre VARCHAR(30) NULL,
    cotfeccre DATETIME NULL,
    cotusuanu VARCHAR(30) NULL,
    cotfecanu DATETIME NULL,
    cotobs VARCHAR(1500) NULL
 CONSTRAINT [pk_rmd_tracot_ficc] PRIMARY KEY CLUSTERED 
(
    [cotsec] ASC,
    [cotdetsec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

-- CUIDADO ESTO ELIMINA LA TABLA

USE RamedicasBI;
CREATE TABLE rmd_tracot_ficc