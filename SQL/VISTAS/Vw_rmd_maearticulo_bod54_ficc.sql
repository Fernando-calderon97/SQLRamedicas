CREATE VIEW [dbo].[vw_rmd_maearticulo_bod54_ficc] 
AS
SELECT 
MA.ArtCod AS 'CodigoArticulo',
MA.artlabnom AS 'Laboratorio', 
MA.ArtCodBar AS 'CodigoBarra',
MA.ArtAgrIntCod AS 'Cur',
MA.ArtNom AS 'Nombre',
MA.artpres AS 'Presentacion',
MA.ArtEmb AS 'Embalaje',
MA.ArtMedNomCom AS 'NombreComercial',
MA.ArtMedInv AS 'Invima',
CASE 
WHEN YEAR(MA.ArtFecVenInv) IN (1999, 1753) THEN NULL
ELSE CAST(MA.ArtFecVenInv AS DATE) END AS 'FechaVenInv',
MA.ArtMedCum AS 'Cum',
MA.ArtMedForFar,
MA.ArtAtc AS 'Atc',
MA.artcontrolado AS 'Controlado',
MA.artmedaltcos AS  'Artmedaltcos',
MA.artcondalmac AS 'Condicion',
MA.ArtRanPreMol AS 'OpcionArt', 
MA.ArtFecCre AS 'FechaCreacion',
MA.ParConCod AS 'Parconcod',
MA.ParConNom AS 'Iva',
MA.ArtMedCon AS 'Cocentracion',
AB.artubi AS 'Ubicacion',
MA.estado_carago AS 'EstCarAgo',
CASE 
    WHEN YEAR(MA.artagoini) = 1753 THEN NULL
    ELSE CAST(MA.artagoini AS DATE) END AS 'FechaIniAgo',
CASE
    WHEN YEAR(MA.artagofin) = 1753 THEN NULL 
    ELSE CAST(MA.ArtAgoFin AS DATE) END AS 'FechaFinAgo',
LP2.PrePreFijVal AS 'PrecioLista2',
(LP2.PrePreFijVal / MA.ArtEmb) AS 'PrecioUndL2',
MBO.BodSucCCNom as 'Nombre Bodega'
FROM [ramedicasbi_ficc].[dbo].[rmd_maearticulo_ficc] MA
LEFT JOIN [RamedicasBI_ficc].[dbo].[rmd_objlistapreciodetalle_ficc] LP2 ON MA.ArtSec = LP2.ArtSec AND MA.ArtPreCodPrin = LP2.PreArtCod and lisprecod = 2
LEFT JOIN [RamedicasBI_ficc].dbo.rmd_objartbod_ficc AB ON AB.ArtSec = MA.ArtSec
LEFT JOIN RamedicasBI_FICC.dbo.rmd_maebodega_ficc MBO ON AB.ArtBodSucCCSec = MBO.BodSucCCSec
WHERE MA.ArtCod NOT IN ('FVIN', 'NDEEX', 'NDEGR', 'NMEEX', 'NMEGR', 'FVFEX', 'FVFGR') and AB.ArtBodSucCCSec = 4
GO
