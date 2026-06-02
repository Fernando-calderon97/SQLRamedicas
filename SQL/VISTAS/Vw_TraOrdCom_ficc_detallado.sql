--USE RamedicasPBI;
ALTER VIEW vw_rmd_ordcom_ficc_detallada AS
SELECT
CAST(OC.ordfec AS DATE) AS 'Fecha',
CAST(OC.ordfecent AS DATE) AS 'FechaEntrega',
OC.ordnum AS 'Documento',
MP.nitcc AS 'Nit',
MP.nomprov AS 'Nombre',
CASE
    WHEN OC.estado = 'A' THEN 'ACTIVO' 
    WHEN OC.estado = 'I' THEN 'INACTIVO'
    WHEN OC.estado = 'P' THEN 'PROCESO'
    WHEN OC.estado = 'P' THEN 'BORRADO' 
    ELSE OC.estado END AS 'Estado',
MA.ArtCod AS 'artcod',
MA.ArtNom AS 'Articulo',
MA.Artpres AS 'Presentacion',
CAST(OC.und AS INT) AS 'Unidades',
CAST(OC.preund AS NUMERIC(18,2)) AS 'PrecioUnitario',
CAST(OC.ordartiva AS NUMERIC(18,2)) AS 'Iva',
CAST(OC.pretot AS NUMERIC(18,2)) AS 'Total',
(
    SELECT TOP 1
    AR.actrecnro
    FROM [RamedicasBI_FICC].[dbo].[rmd_traactrec_ficc] AR
    WHERE AR.actrecdetodcsec = OC.ordsec
) AS 'ActaRecepcion',
(
    SELECT TOP 1
    COALESCE(AR.und,0)
    FROM [RamedicasBI_FICC].[dbo].[rmd_traactrec_ficc] AR
    WHERE AR.actrecdetodcsec = OC.ordsec AND AR.artsec = OC.ArtSec
) AS 'ActaRecUnd',
MA.ArtlabCod AS 'labcod',
MA.artlabnom AS 'Laboratorio',
MA.ArtMedCum AS 'Cum',
MA.InvFamId AS 'invimacod',
MA.InvFamNom AS 'Invima',
MA.ArtAtc AS 'Atc',
OC.ordbodsuccsec AS 'bodcod',
MB.BodSucCCNom AS 'Bodega',
(
SELECT TOP 1
    CASE
        WHEN OCE.ordcomhisest = 'P' THEN 'PENDIENTE'
        WHEN OCE.ordcomhisest = 'I' THEN 'INACTIVO'
        ELSE OCE.ordcomhisest END AS 'EstadoCierre'
    FROM [RamedicasBI_FICC].[dbo].[rmd_objestordcom_ficc] OCE
    WHERE OC.ordsec = OCE.ordsec
    ORDER BY ordcomhisestsec DESC
) AS 'EstadoCierre',

OC.ordusucre AS 'UsuarioCreacion',
CAST(OC.ordfeccre AS DATETIME) AS 'FechaCreacion',
OC.ordanuusu AS 'UsuarioAnulacion',
CASE
    WHEN YEAR(OC.ordanufec) = 1753 THEN NULL
    ELSE CAST(OC.ordanufec AS DATETIME) END AS 'FechaAnulacion',
OC.ordanuobs AS 'ObservacionAnulacion',
OC.ordobs AS 'ObsercacionGeneral'
FROM [RamedicasBI_FICC].[dbo].[rmd_traordcom_ficc] OC 
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maeproveedor_ficc] MP ON OC.ordnitsec = MP.nitsec AND OC.ordprovsec = MP.provsec
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maearticulo_ficc] MA ON OC.artsec = MA.ArtSec
LEFT JOIN [RamedicasBI_FICC].[dbo].[rmd_maebodega_ficc] MB ON OC.ordbodsuccsec = MB.BodSucCCSec
WHERE OC.estado = 'A'
