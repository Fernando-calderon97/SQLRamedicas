----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- QUERY MAESTRO PROVEEDORES
INSERT INTO  [RamedicasBI].[dbo].[rmd_maeproveedores_ficc]
SELECT
P.NitSec AS 'nitsec',
P.ProvSec AS 'provsec',
N.NitIde AS 'nitcc',
P.ProvNom AS 'nomprov',
CASE 
    WHEN P.ProvEst = 'A' THEN 'Activo'
    ELSE 'Inactivo' END AS 'estado',
CAST(P.ProvCup AS NUMERIC(18,2)) AS 'cupo',
CAST(P.ProvPla AS INT) AS 'plazo',
P.ProvCiuCod AS 'ciucod',
P.TriProCod AS 'tipcod',
TP.TriProNom AS 'tipnom',
P.ClaProvCod AS 'clacod',
CP.ClaProvNom AS 'clanom',
P.PerProCod AS 'percod',
PP.PerProNom AS 'pernom',
N.NitTipRegIva AS 'resiva',
P.GruProvCod AS 'grucod',
GP.GruProvNom AS 'grupnom',
N.NitCor AS 'email',
P.ProvUsuCre AS 'usucre',
CASE 
    WHEN YEAR(P.ProvFecCre) = 1753 THEN NULL
    ELSE P.ProvFecCre END AS 'feccre',
P.ProvUsuMod AS 'usumod',
CASE
    WHEN YEAR(P.ProvFecMod) = 1753 THEN NULL
    ELSE P.ProvFecMod END AS 'fecmod'
FROM [RamedicasFiccERP].[dbo].[Proveedores] P
LEFT JOIN [RamedicasFiccERP].[dbo].[Nit] N ON P.NitSec = N.NitSec
LEFT JOIN [RamedicasFiccERP].[dbo].[TipoProveedor] TP ON P.TriProCod = TP.TriProCod
LEFT JOIN [RamedicasFiccERP].[dbo].[ClaseProveedor] CP ON P.ClaProvCod = CP.ClaProvCod
LEFT JOIN [RamedicasFiccERP].[dbo].[PerfilProveedor] PP ON P.PerProCod = PP.PerProCod
LEFT JOIN [RamedicasFiccERP].[dbo].[GrupoProveedor] GP ON P.GruProvCod = GP.GruProvCod


-- CREATE TABLE MAESTRO PROVEEDORES
USE RamedicasBI;
CREATE TABLE rmd_maeproveedores_ficc (
    [nitsec] VARCHAR(20) NOT NULL,
    [provsec] INT NOT NULL,
    [nitcc] VARCHAR(50) NOT NULL,
    [nomprov] VARCHAR(120) NOT NULL,
    [estado] VARCHAR (20) NULL,
    [cupo] NUMERIC(18,2) NULL,
    [plazo] INT NULL,
    [ciucod] VARCHAR(10) NULL,
    [tipcod] VARCHAR(5) NULL,--
    [tipnom] VARCHAR(20) NULL,
    [clacod] VARCHAR(5) NULL,
    [clanom] VARCHAR(120) NULL,
    [percod] VARCHAR(5) NULL,
    [pernom] VARCHAR(20) NULL,
    [resiva] VARCHAR(20) NULL,
    [grucod] VARCHAR(5) NULL,
    [grunom] VARCHAR(120) NULL,
    [email] VARCHAR(120) NULL,
    [usucre] VARCHAR(50) NULL,
    [feccre] DATETIME NULL,
    [usumod] VARCHAR(50) NULL,
    [fecmod] DATETIME NULL,
    PRIMARY KEY CLUSTERED
    (
        [nitsec] ASC,
        [provsec] ASC
    )
)

--
USE RamedicasBI;
DROP TABLE rmd_maeproveedores_ficc