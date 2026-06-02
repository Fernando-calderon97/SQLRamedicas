SELECT 
F.facfec AS 'Fecha',
F.facnro AS 'Documento',
F.factipcod AS 'TipoDoc',
MC.nitcc AS 'Nit',
UPPER(MC.nomcli) AS 'NombreCliente',
MC.lisprecod AS 'CodList',
MLP.LisPreNom AS 'ListaPrecio',
C.ciunom AS 'CiudadPri',
F.facvencod AS 'CodigoVen',
MP.vennom AS 'NombreVen',
MA.ArtCod AS 'CodigoArt',
F.preundant AS 'PrecioUnidad',
MA.ArtEmb AS 'Embalaje',
F.und AS 'Unidades',
F.vlrtot AS 'ValorTot',
(
    SELECT 
    CASE
        WHEN LP.PrePreFijVal = 0 THEN ((LP.PrePorVal/100) * (MA.ArtEmb * MA.ArtCos2)) + (MA.ArtEmb * MA.ArtCos2)
        ELSE LP.PrePreFijVal END AS 'Precio'
    FROM [RamedicasBI_FICC].[dbo].[rmd_objlistapreciodetalle_ficc] LP
    WHERE F.artsec = LP.Artsec AND F.preartcod = LP.PreArtCod AND MC.lisprecod = LP.lisprecod  
) AS 'PrecioLista',
'' AS 'CiudadEntr',
CASE 
    WHEN F.facvencod = 54 THEN 'VIP'
    ELSE 'COMERCIAL' END AS 'UndNegocio'
FROM [RamedicasBI_FICC].[dbo].[rmd_trafacdist_ficc] F
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maecliente_ficc] MC ON F.facnitsec = MC.nitsec AND F.facclisec = MC.clisec
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maerepresentante_ficc] MP ON F.facvencod = MP.vencod
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maearticulo_ficc] MA ON F.artsec = MA.artsec
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maelistaprecio_ficc] MLP ON MC.lisprecod = MLP.LisPreCod
LEFT JOIN [RamedicasBI_FICC].[dbo].[rmd_objciudad_ficc] C ON MC.ciucod = C.ciucod
WHERE F.facest = 'A' AND F.factipcod = 'FE' AND  MA.ArtCod NOT IN ('FVFEX', 'FVFGR', 'FVIN') AND F.facfec BETWEEN '20260101' AND  CAST(GETDATE()-1 AS DATE)



.