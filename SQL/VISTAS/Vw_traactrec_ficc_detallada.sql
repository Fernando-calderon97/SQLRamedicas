-- CREACION DE VIEW ACTAS DE RECEPCION 
ALTER VIEW vw_rmd_traactrec_ficc_detallada AS
SELECT
CAST(AR.actfec AS DATE) AS 'Fecha',
AR.actrecnro AS 'Documento',
MP.nitcc AS 'Nit',
MP.nomprov AS 'Nombre',
CASE
    WHEN AR.actrecest = 'A' THEN 'ACTIVO' 
    WHEN AR.actrecest = 'I' THEN 'INACTIVO'
    WHEN AR.actrecest = 'P' THEN 'PROCESO'
    WHEN AR.actrecest = 'P' THEN 'BORRADO' 
    ELSE AR.actrecest END AS 'Estado',
MA.ArtCod AS 'artcod',
MA.ArtNom AS 'Articulo',
MA.artpres AS 'Presentacion',
CAST(AR.und AS INT) AS 'Unidades',
CAST(AR.preund AS NUMERIC(18,2)) AS 'PrecioUnitario',
CAST(AR.vlriva AS NUMERIC(18,2)) AS 'Iva',
CAST(AR.vlrtotbrt AS NUMERIC(18,2)) AS 'Total_brt',
CAST(AR.vlrtotnto AS NUMERIC(18,2)) AS 'Total_nto',
AR.actreclot AS 'Lote',
CAST(AR.actreclotfec AS DATE) AS 'Fecha_ven_lote',
MA.artlabcod AS 'Labcod',
MA.artlabnom AS 'Laboratorio',
MA.ArtMedCum AS 'Cum',
MA.InvFamCod AS 'Invimacod',
MA.InvFamNom AS 'Invima',
MA.ArtAtc AS 'Atc',
AR.actrecsuccod 'Succod',
CASE
    WHEN AR.actrecsuccod = 1 THEN 'PRINCIPAL'
    ELSE 'NO ASIGNADO' END AS 'Sucursal',
AR.actrecbodsuccsec AS 'bodcod',
MB.BodSucCCNom AS 'Bodega',
(
    SELECT 
    TOP 1 (OC.ordnum)
    FROM rmd_traordcom_ficc OC
    WHERE OC.ordsec = AR.actrecdetodcsec
) AS 'OrdenCompra',
(
    SELECT 
    TOP 1 (OC.und)
    FROM rmd_traordcom_ficc OC
    WHERE OC.ordsec = AR.actrecdetodcsec AND OC.artsec = AR.artsec
) AS 'UnidadesOrdenCompra',
AR.actrecusucodcre AS 'UsuarioCreacion',
AR.actferhormod AS 'UsuarioModificacion',
CASE
    WHEN YEAR(AR.actferhormod) = 1753 THEN NULL 
    ELSE CAST(AR.actferhormod AS DATE) END AS  'FechaModificacion',
AR.actrecobspre AS 'ObservacionArticulo',
AR.actrecobs AS 'ObservacionGeneral'
FROM rmd_traactrec_ficc AR
LEFT JOIN rmd_maeproveedor_ficc MP ON AR.actrecnitsec = MP.nitsec
INNER JOIN rmd_maearticulo_ficc MA ON AR.artsec = MA.artsec
INNER JOIN rmd_maebodega_ficc MB ON AR.actrecbodsuccsec = MB.BodSucCCSec
WHERE MP.nitcc <> '901429936'
GO