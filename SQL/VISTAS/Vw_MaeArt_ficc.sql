ALTER VIEW [dbo].[vw_rmd_maearticulo_ficc] AS
SELECT 
MA.ArtCod AS 'CodigoArticulo',
MA.artlabnom AS 'Laboratorio', 
MA.ArtCodBar AS 'CodigoBarra',
MA.ArtAgrIntCod AS 'Cur',
MA.ArtNom AS 'Nombre',
MA.artpres AS 'Presentacion',
MAP.preartfacconval AS 'Embalaje',
MA.ArtMedNomCom AS 'NombreComercial',
MA.ArtMedInv AS 'Invima',
CASE 
WHEN YEAR(MA.ArtFecVenInv) = 1999 THEN NULL
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
MA.estado_carago AS 'EstCarAgo',
CASE 
    WHEN YEAR(MA.artagoini) = 1753 THEN NULL
    ELSE CAST(MA.artagoini AS DATE) END AS 'FechaIniAgo',
CASE
    WHEN YEAR(MA.artagofin) = 1753 THEN NULL 
    ELSE CAST(MA.ArtAgoFin AS DATE) END AS 'FechaFinAgo',
MA2.PrePreFijVal AS 'PrecioLista2',
(MA2.PrePreFijVal / MAP.preartfacconval) AS 'PrecioUndL2',
MA3.PrePreFijVal AS 'PrecioLista3',
(MA3.PrePreFijVal / MAP.preartfacconval) AS 'PrecioUndL3',
MA6.PrePreFijVal AS 'PrecioLista6',
(MA6.PrePreFijVal / MAP.preartfacconval) AS 'PrecioUndL6',
MA7.PrePreFijVal AS 'PrecioLista7',
(MA7.PrePreFijVal / MAP.preartfacconval) AS 'PrecioUndL7',
MA24.PrePreFijVal AS 'PrecioLista24',
(MA24.PrePreFijVal / MAP.preartfacconval) AS 'PrecioUndL24'
FROM [ramedicasbi_ficc].[dbo].[rmd_maearticulo_ficc] MA
INNER JOIN  [ramedicasbi_ficc].[dbo].[rmd_maearticulopres_ficc] MAP ON MA.ArtSec = MAP.Artsec
LEFT JOIN 
(
    SELECT
    MA2.ArtSec,
    LP2.PrePreFijVal
    FROM [RamedicasBI_ficc].[dbo].[rmd_maearticulo_ficc] MA2
    INNER JOIN [ramedicasbi_ficc].[dbo].[rmd_maearticulopres_ficc] MAP2 ON MA2.ArtSec = MAP2.Artsec
    INNER JOIN  [RamedicasBI_ficc].[dbo].[rmd_objlistapreciodetalle_ficc] LP2 ON MA2.ArtSec = LP2.ArtSec AND MAP2.PreArtCod = LP2.PreArtCod
    WHERE LP2.LisPreCod = 2  AND preartest ='A'
)  MA2 ON MA.ArtSec = MA2.ArtSec
LEFT JOIN 
(
    SELECT
    MA3.ArtSec,
    LP3.PrePreFijVal
    FROM [RamedicasBI_ficc].[dbo].[rmd_maearticulo_ficc] MA3
    INNER JOIN [ramedicasbi_ficc].[dbo].[rmd_maearticulopres_ficc] MAP3 ON MA3.ArtSec = MAP3.Artsec
    INNER JOIN  [RamedicasBI_ficc].[dbo].[rmd_objlistapreciodetalle_ficc] LP3 ON MA3.ArtSec = LP3.ArtSec AND MAP3.PreArtCod = LP3.PreArtCod
    WHERE LP3.LisPreCod = 3 AND preartest ='A'
)  MA3 ON MA.ArtSec = MA3.ArtSec
LEFT JOIN 
(
    SELECT
    MA6.ArtSec,
    LP6.PrePreFijVal
    FROM [RamedicasBI_ficc].[dbo].[rmd_maearticulo_ficc] MA6
    INNER JOIN [ramedicasbi_ficc].[dbo].[rmd_maearticulopres_ficc] MAP6 ON MA6.ArtSec = MAP6.Artsec
    INNER JOIN  [RamedicasBI_ficc].[dbo].[rmd_objlistapreciodetalle_ficc] LP6 ON MA6.ArtSec = LP6.ArtSec AND MAP6.PreArtCod = LP6.PreArtCod
    WHERE LP6.LisPreCod = 5 AND preartest ='A'
)  MA6 ON MA.ArtSec = MA6.ArtSec
LEFT JOIN 
(
    SELECT
    MA7.ArtSec,
    LP7.PrePreFijVal
    FROM [RamedicasBI_ficc].[dbo].[rmd_maearticulo_ficc] MA7
    INNER JOIN [ramedicasbi_ficc].[dbo].[rmd_maearticulopres_ficc] MAP7 ON MA7.ArtSec = MAP7.Artsec
    INNER JOIN  [RamedicasBI_ficc].[dbo].[rmd_objlistapreciodetalle_ficc] LP7 ON MA7.ArtSec = LP7.ArtSec AND MAP7.PreArtCod = LP7.PreArtCod
    WHERE LP7.LisPreCod = 6 AND preartest ='A'
)  MA7 ON MA.ArtSec = MA7.ArtSec
LEFT JOIN 
(
    SELECT
    MA24.ArtSec,
    LP24.PrePreFijVal
    FROM [RamedicasBI_ficc].[dbo].[rmd_maearticulo_ficc] MA24
    INNER JOIN [ramedicasbi_ficc].[dbo].[rmd_maearticulopres_ficc] MAP24 ON MA24.ArtSec = MAP24.Artsec
    INNER JOIN  [RamedicasBI_ficc].[dbo].[rmd_objlistapreciodetalle_ficc] LP24 ON MA24.ArtSec = LP24.ArtSec AND MAP24.PreArtCod = LP24.PreArtCod
    WHERE LP24.LisPreCod = 16 AND preartest ='A'
)  MA24 ON MA.ArtSec = MA24.ArtSec
WHERE MAP.preartest = 'A'

