CREATE VIEW vw_rmd_trafaccom_ficc_detallada AS
SELECT 
CAST(OC.facfec AS DATE) AS 'Fecha',
OC.facnro AS 'Documento',
MP.nitcc AS 'Nit',
MP.nomprov AS 'Nombre',
CASE
    WHEN OC.facest = 'A' THEN 'ACTIVO'
    WHEN OC.facest = 'I' THEN 'INACTIVO'
    WHEN OC.facest = 'P' THEN 'PROCESO'
    ELSE OC.facest END AS 'Estado',
MA.ArtCod,
MA.ArtNom,
MA.artpres,
OC.preundact,
OC.und,
OC.vlrtot,
OC.usucre,
OC.usumod,
OC.fecmod
FROM [RamedicasBI_FICC].[dbo].[rmd_trafaccom_ficc] OC
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maeproveedor_ficc] MP ON OC.facnitsec = MP.nitsec
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maearticulo_ficc] MA ON OC.artsec = MA.ArtSec
WHERE OC.facest = 'A'

