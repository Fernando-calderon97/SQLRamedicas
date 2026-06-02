SELECT
B.fec_acumsal AS 'Fecha',
MA.ArtCod AS 'Codigo Articulo',
B.uniart AS 'unidades',
B.codbod AS 'Codigo Bodega',
MB.BodSucCCNom AS 'Nombre Bodega'
FROM [RamedicasBI].[dbo].[rmd_acumsalinvbod_web] B
INNER JOIN [RamedicasBI].[dbo].[rmd_maebodega_web] MB ON B.codbod = MB.BodSucCCSec
INNER JOIN [RamedicasBI].[dbo].[rmd_maearticulo_web] MA ON B.artsec = MA.artsec
WHERE fec_acumsal = '20260131'

