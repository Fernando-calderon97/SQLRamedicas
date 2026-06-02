SELECT
--TP.facsec,
TP.facnro AS 'Documento',
MA.ArtCod AS 'CodigoArticulo',
TP.emb AS 'Embalaje',
TP.und AS 'Unidades',
TP.vlrtot AS 'ValorTotal'
FROM [RamedicasBI_FICC].[dbo].[rmd_tratpdp_ficc] TP
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maearticulo_ficc]  MA ON  TP.artsec = MA.ArtSec
WHERE TP.facest = 'A'

SELECT
--TP.facsec,
TB.facnro AS 'Documento',
MA.ArtCod AS 'CodigoArticulo',
TB.emb AS 'Embalaje',
TB.und AS 'Unidades',
TB.vlrtot AS 'ValorTotal'
FROM [RamedicasBI_FICC].[dbo].[rmd_tratb_ficc] TB
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maearticulo_ficc]  MA ON  TB.artsec = MA.ArtSec
WHERE TB.facest = 'A'

SELECT
OP.ordsec AS 'OrdenSecuencia',
CAST(OP.ordfec AS DATE) AS 'Fecha',
MC.nitcc AS 'Nit',
UPPER(MC.nomcli)AS 'NombreCliente',
OP.ordtipcod AS 'TipoDocumento',
OP.ordnum AS 'Documento',
CASE 
    WHEN OP.estado = 'A' THEN 'ACTIVO'
    WHEN OP.estado = 'I' THEN 'INACTIVO'
    WHEN OP.estado = 'P' THEN 'PROCESO'
    WHEN OP.estado = 'B' THEN 'BORRADOR'
    ELSE OP.estado END AS 'Estado',
OP.ordpla AS 'Plazo',
CAST(OP.ordfecven AS DATE) AS 'FechaVencimiento',
OP.ordvencod AS 'CodigoVendedor',
MR.VenNom AS 'NombreVendedor',
MA.ArtCod AS 'CodigoArticulo',
CAST(OP.ordporartiva AS NUMERIC(18,2)) AS 'Iva',
OP.emb AS 'Embalaje',
OP.undsol AS 'CajasSolicitadas',
OP.emb * OP.undsol AS 'UnidadesSolicitadas',
OP.ordartivasol AS 'PrecioIvaSoli',
OP.pretotbrtsol AS 'PrecioBrutoSoli',
OP.pretotntosol AS 'PrecioNetoSoli'
FROM rmd_traordped_ficc OP
INNER JOIN rmd_maecliente_ficc MC ON OP.ordnitsec = MC.nitsec AND OP.ordclisec = MC.clisec
INNER JOIN rmd_maearticulo_ficc MA ON OP.artsec = MA.artsec 
LEFT JOIN rmd_maerepresentante_ficc MR ON OP.ordvencod = MR.vencod