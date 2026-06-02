--- QUERY MAESTRO CLIENTES DE MANTIS WEB
SELECT
C.NitSec AS 'nitsec',
CAST(C.CliSec AS INT) AS 'clisec',
N.NitIde AS 'nitcc',
C.CliNom AS 'nomcli',
N.NitCom AS 'nomcliraz',
CASE 
    WHEN C.CliEst = 'A' THEN 'Activo' 
    ELSE 'Inactivo' END AS 'estado',
CV.VenCod AS 'vencod',
--CAST(N.NitCliCup AS NUMERIC(18,2)) AS 'cupo',  --- Todo desde Nit esta en 0
--CAST(N.NitCliPla AS INT) AS 'plazo',           --- Todo desde Nit esta en 0
C.CliDir AS 'dirpri',
C.CliCiuCod AS 'ciucod',
C.lisprecod AS 'lisprecod',
C.PerCliCod AS 'percod',
PC.PerCliNom AS 'pernom',
C.ZonCod AS 'zoncod',
Z.ZonNom AS 'zonnom',
C.CliTra AS 'clitracod',
CASE 
    WHEN C.CliTra = 'C' THEN 'COMERCIAL'
    WHEN C.CliTra = 'I' THEN 'INSTITUCIONAL'
    WHEN C.CliTra = 'O' THEN 'OTROS' 
    ELSE '' END AS 'citranom',
CASE 
    WHEN N.NitIde = '830003564' THEN 'FAMISANAR'
    WHEN N.NitIde = '805001157' THEN 'SOS'
    WHEN N.NitIde = '901429936' THEN 'RAMEDICAS'
    WHEN N.NitIde = '900033371' THEN 'SUMIMEDICAL'
    WHEN N.NitIde = '830053105' THEN 'FOMAG'
    WHEN N.NitIde = '800130907' THEN 'SALUD TOTAL'
    WHEN N.NitIde = '860066942' THEN 'COMPENSAR'
    ELSE '' END AS 'undneg',
C.TipCliCod AS 'tipclicod',
TC.TipCliNom AS 'tipclinom',
C.CanCod AS 'cancod',
CC.CanNom AS 'cannom',
C.CanSubCod AS 'subcancod',
SCC.CanSubNom AS 'subcannom',
C.CliMedIns AS 'medins',
C.ZonRutCod AS 'zonrutcod',
ZRC.ZonRutDes AS 'zonrutnom',
C.CliGcnTip AS 'gnctip',
C.CliGcnCod AS 'gnccod',
GC.GcnNom AS 'gncnom',
C.CliMail AS 'email',
C.CliUsuCod AS 'usucre',
CASE 
    WHEN YEAR(C.CliFecIng) = 1753 THEN NULL
    ELSE CAST(C.CliFecIng AS DATETIME) END AS 'feccre',
C.CliUsuCodMod AS 'usumod',
CASE 
    WHEN YEAR(C.CliFecMod) = 1753 THEN NULL
    ELSE CAST(C.CliFecMod AS DATETIME) END AS 'fecmod'
FROM [Ramedicas].[dbo].[Clientes] C
LEFT JOIN [Ramedicas].[dbo].[Nit] N ON C.NitSec = N.NitSec
LEFT JOIN [Ramedicas].[dbo].[ClientesVendedores] CV ON C.NitSec = CV.NitSec AND C.CliSec = CV.CliSec
LEFT JOIN [Ramedicas].[dbo].[Zona] Z ON C.ZonCod = Z.ZonCod
LEFT JOIN [Ramedicas].[dbo].[TipoClientes] TC ON C.TipCliCod = TC.TipCliCod
LEFT JOIN [Ramedicas].[dbo].[ListasPrecios] LP ON C.LisPreCod = LP.lisprecod
LEFT JOIN [Ramedicas].[dbo].[PerfilClientes] PC ON C.PerCliCod = PC.PerCliCod
LEFT JOIN [Ramedicas].[dbo].[Canales] CC ON C.CanCod = CC.CanCod
LEFT JOIN [Ramedicas].[dbo].[CanalesSubCanales] SCC ON C.CanSubCod = SCC.CanSubCod
LEFT JOIN [Ramedicas].[dbo].[ZonaZonRut] ZRC ON  C.ZonCod = ZRC.ZonCod AND C.ZonRutCod = ZRC.ZonRutCod
LEFT JOIN [Ramedicas].[dbo].[GruConNit] GC ON  C.CliGcnTip = GC.GcnTip AND C.CliGcnCod = GC.GcnCod

-- CREATE TABLE MAESTRO CLIENTES WEB

CREATE TABLE (
    [nitsec] VARCHAR(20) NOT NULL,
    [clisec] INT NOT NULL,
    [nitcc] VARCHAR(30) NOT NULL,
    [nomcli] VARCHAR(120) NOT NULL,
    [nomcliraz] VARCHAR(120) NOT NULL,
    [estado] VARCHAR(10) NULL
    [vencod] 
    [dirpri]
    [ciucod]
    [lisprecod]
    [percod]
    [pernom]
    [zoncod]
    [zonnom]
    [clitracod]
    [citranom]
    [undneg]
    [tipclicod]
    [tipclinom]
    [cancod]
    [cannom]
    [subcancod]
    [subcannom]
    [medins]
    [zonrutcod]
    [zonrutnom]
    [gnctip]
    [gnccod]
    [gncnom]
    [email]
    [usucre]
    [feccre]
    [usumod]
    [fecmod]
)
