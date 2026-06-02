
-- QUERY INSERT TRANSACCIONAL ORDENES DE COMPRA

INSERT INTO [RamedicasBI].[dbo].[rmd_traordcom_ficc]
SELECT
OC.OrdSec AS 'ordsec',
OCD.OrdComDet AS 'ordcomdet',
CAST(OC.OrdFecha AS DATE) AS 'ordfec',
CAST(OC.OrdFecEnt AS DATE) AS 'ordfecent',
OC.OrdNitSec AS 'ordnitsec',
OC.OrdNum AS 'ordnum',
OC.OrdEst AS 'estado',
OCD.ArtSec AS 'artsec',
OCD.PreArtCod 'preartcod',
CAST(OCD.OrdUni AS INT) AS 'und',
CAST(OCD.OrdPrePub AS NUMERIC(18,2)) AS 'preund',
CAST(OCD.OrdArtIva AS NUMERIC(18,2)) AS 'ordartiva',
CAST(OCD.OrdKarValTotMenDes AS NUMERIC(18,2)) AS 'pretot',
OC.OrdPla AS 'ordpla',
OC.OrdProvSec AS 'ordprovsec',
OCD.OrdBodSucCCSec AS 'ordbodsuccsec',
OCD.OrdDetArtRecibido AS 'orddetartrecibido',
OC.OrdTipOri AS 'ordtipori',
OC.OrdUsuCre AS 'ordusucre',
OC.OrdFecCre AS 'ordfeccre',
OC.OrdComAnuFueSec AS 'ordanufuesec',
OC.OrdAnuUsu AS 'ordanuusu',
CAST(OC.OrdAnuFec AS DATETIME) AS 'ordanufec',
OC.OrdAnuObs AS 'ordanuobs',
OC.OrdObs AS 'ordobs'
FROM [RamedicasFiccERP].[dbo].[OrdenCompra] OC
INNER JOIN [RamedicasFiccERP].[dbo].[OrdenCompraDetalle] OCD ON OC.OrdSec = OCD.OrdSec

-- CREATE TABLE TRANSACCIONAL ORDENES DE COMPRA

USE RamedicasBI;
CREATE TABLE rmd_traordcom_ficc (
    ordsec VARCHAR(100) NOT NULL,
    ordcomdet INT NOT NULL,
    ordfec DATETIME NULL,
    ordfecent DATETIME NULL,
    ordnitsec INT NULL,
    ordnum VARCHAR(80),
    estado VARCHAR(2) NULL,
    artsec INT NULL,
    preartcod INT NULL,
    und INT NULL,
    preund NUMERIC(18,2) NULL,
    ordartiva NUMERIC(18,2) NULL,
    pretot NUMERIC(18,2) NULL,
    ordpla INT NULL,
    ordprovsec INT NULL,
    ordbodsuccsec INT NULL,
    orddetartrecibido VARCHAR(2) NULL,
    ordtipori VARCHAR(3) NULL,
    ordusucre VARCHAR(30) NULL,
    ordfeccre DATETIME NULL,
    ordanufuesec INT NULL,
    ordanuusu VARCHAR(30) NULL,
    ordanufec DATETIME NULL,
    ordanuobs VARCHAR(1500) NULL,
    ordobs VARCHAR(1500) NULL,
 CONSTRAINT [pk_rmd_traordcom_ficc] PRIMARY KEY CLUSTERED 
(
    [ordsec] ASC,
    [ordcomdet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


USE RamedicasBI;
DROP TABLE rmd_traordcom_ficc
----------------------------------------------------------------------------------

-- QUERY INSERT OBJETO HISTORICO ESTADO ORDENES DE COMPRA

INSERT INTO [RamedicasBI].[dbo].[rmd_objestordcom_ficc]
SELECT 
OrdSec AS 'ordsec',
OrdcomHisEstSec AS 'ordcomhisestsec',
OrdComHisEst AS 'ordcomhisest',
OrdComHisUsuMod AS 'ordcomhisusumod',
OrdComHisFecMod AS 'ordcomhisfecmod'
FROM [RamedicasFiccERP].[dbo].[OrdenCompraHisoricoEstados]

-- CREATE TABLE OBJETO HISTORICO ESTADO ORDENES DE COMPRA

USE RamedicasBI;
CREATE TABLE rmd_objestordcom_ficc (
ordsec VARCHAR(100) NOT NULL,
ordcomhisestsec INT NOT NULL,
ordcomhisest VARCHAR(3) NULL,
ordcomhisusumod VARCHAR(30) NULL,
ordcomhisfecmod DATETIME NULL
 CONSTRAINT [pk_rmd_objestordcom_ficc] PRIMARY KEY CLUSTERED 
(
    [ordsec] ASC,
    [ordcomhisestsec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

