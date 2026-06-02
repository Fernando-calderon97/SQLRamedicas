SELECT 
F.facfec AS 'Fecha',
F.facnro AS 'Documento',
F.factipcod AS 'TipoDoc',
MC.nitcc AS 'Nit',
UPPER(MC.nomcli) AS 'NombreCli',
CIU.ciunom AS 'CiudadPri',
F.facvencod AS 'CodigoVen',
MP.vennom AS 'NombreVen',
MA.ArtCod AS 'CodigoArt',
F.preundant AS 'PrecioUnidad',
MA.ArtEmb AS 'Embalaje',
F.und AS 'Unidades',
F.vlrtot AS 'ValorTot',
(
    SELECT TOP 1
    COALESCE(C1.ciunom, CIU.ciunom)
    FROM [RamedicasBI_FICC].[dbo].[rmd_traordped_ficc] OP
    INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_objciudad_ficc] C1 ON OP.ordguiciudes = C1.ciucod 
    WHERE F.facsecrem = OP.ordsec
)AS 'CiudadEntr',
CASE 
    WHEN F.facvencod = 54 THEN 'VIP'
    ELSE 'COMERCIAL' END AS 'UndNegocio'
FROM [RamedicasBI_FICC].[dbo].[rmd_trafacdist_ficc] F
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maecliente_ficc] MC ON F.facnitsec = MC.nitsec AND F.facclisec = MC.clisec
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maerepresentante_ficc] MP ON F.facvencod = MP.vencod
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maearticulo_ficc] MA ON F.artsec = MA.artsec
LEFT JOIN [RamedicasBI_FICC].[dbo].[rmd_objciudad_ficc] CIU ON MC.ciucod = CIU.ciucod
WHERE F.facest = 'A' AND F.factipcod = 'FE' AND F.facfec BETWEEN '20260101' AND  CAST(GETDATE()-1 AS DATE)

UNION ALL

SELECT 
F.facfec AS 'Fecha',
F.facnro AS 'Documento',
F.factipcod AS 'TipoDoc',
MC.nitcc AS 'Nit',
UPPER(MC.nomcli) AS 'NombreCli',
C.ciunom AS 'CiudadPri',
F.facvencod AS 'CodigoVen',
MP.vennom AS 'NombreVen',
MA.ArtCod AS 'CodigoArt',
F.preundant AS 'PrecioUnidad',
MA.ArtEmb AS 'Embalaje',
F.und AS 'Unidades',
CASE
    WHEN F.factipcod = 'NC' OR F.factipcod = 'NM' THEN (F.vlrtot *-1) 
    ELSE F.vlrtot END AS 'ValorTot',
'' AS 'CiudadEntr',
CASE 
    WHEN F.facvencod = 54 THEN 'VIP'
    ELSE 'COMERCIAL' END AS 'UndNegocio'
FROM [RamedicasBI_FICC].[dbo].[rmd_trafacncnd_ficc] F
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maecliente_ficc] MC ON F.facnitsec = MC.nitsec AND F.facclisec = MC.clisec
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maerepresentante_ficc] MP ON F.facvencod = MP.vencod
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maearticulo_ficc] MA ON F.artsec = MA.artsec
LEFT JOIN [RamedicasBI_FICC].[dbo].[rmd_objciudad_ficc] C ON MC.ciucod = C.ciucod
WHERE F.facest = 'A' AND F.factipcod IN ('NC','NM', 'ND')  AND F.facfec BETWEEN '20260101' AND  CAST(GETDATE()-1 AS DATE)
