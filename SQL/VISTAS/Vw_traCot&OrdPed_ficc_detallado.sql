SELECT TOP 100
CAST(OP.ordfec AS DATE) AS 'fecha',
MC.nitcc AS 'nit',
UPPER(MC.nomcli)AS 'nombre_cliente',
(
    SELECT 
    TOP 1 (C.cotfec)
    FROM rmd_tracot_ficc C
    WHERE C.cotSec = OP.facsecrem
) AS 'fecha_cotizacion',
(
    SELECT 
    TOP 1 (C.cotpla)
    FROM rmd_tracot_ficc C
    WHERE C.cotSec = OP.facsecrem
) AS 'plazo_cotizacion',
(
    SELECT 
    TOP 1 (C.cotnum)
    FROM rmd_tracot_ficc C
    WHERE C.cotSec = OP.facsecrem
) AS 'cotizacion_doc',
(
    SELECT 
    TOP 1 (C.estado)
    FROM rmd_tracot_ficc C
    WHERE C.cotSec = OP.facsecrem
) AS 'estado_cotizacio',
(
    SELECT 
    TOP 1 (C.cotprepub)
    FROM rmd_tracot_ficc C
    WHERE C.cotSec = OP.facsecrem AND C.artsec = OP.artsec
) AS 'precio_und_cotizacion',
(
    SELECT 
    TOP 1 (C.cotuni)
    FROM rmd_tracot_ficc C
    WHERE C.cotSec = OP.facsecrem AND C.artsec = OP.artsec
) AS 'cajas_cotizadas',
(
    SELECT 
    TOP 1 (C.cortartiva)
    FROM rmd_tracot_ficc C
    WHERE C.cotSec = OP.facsecrem AND C.artsec = OP.artsec
) AS 'precio_iva_coti',
(
    SELECT 
    TOP 1 (C.pretotbrt)
    FROM rmd_tracot_ficc C
    WHERE C.cotSec = OP.facsecrem AND C.artsec = OP.artsec
) AS 'precio_bruto_coti',
(
    SELECT 
    TOP 1 (C.pretotnto)
    FROM rmd_tracot_ficc C
    WHERE C.cotSec = OP.facsecrem AND C.artsec = OP.artsec
) AS 'precio_neto_coti',
OP.ordtipcod AS 'orden_pedido_tip',
OP.ordnum AS 'orden_pedido_doc',
CASE 
    WHEN OP.estado = 'A' THEN 'ACTIVO'
    WHEN OP.estado = 'I' THEN 'INACTIVO'
    WHEN OP.estado = 'P' THEN 'PROCESO'
    WHEN OP.estado = 'B' THEN 'BORRADOR'
    ELSE OP.estado END AS 'estado_op',
OP.ordpla AS 'plazo_op',
CASE 
    WHEN YEAR(CAST(OP.ordfecven AS DATE)) = 1753 THEN NULL
    ELSE CAST(OP.ordfecven AS DATE) END AS 'fecha_vencimiento_op',
OP.ordvencod AS 'codigo_vendedor',
MR.VenNom AS 'nombre_vendedor',
MA.ArtCod AS 'codigo_articulo',
MA.ArtNom AS 'nombre_articulo',
CAST(OP.ordporartiva AS NUMERIC(18,2)) AS 'iva',
OP.emb AS 'embalaje',
OP.preund AS 'precio_unitario',
OP.undsol AS 'cajas_solicitadas',
OP.emb * OP.undsol AS 'unidades_solicitadas',
OP.ordartivasol AS 'precio_iva_soli',
OP.pretotbrtsol AS 'precio_bruto_soli',
OP.pretotntosol AS 'precio_neto_soli',
OP.unddes AS 'cajas_despachadas',
CAST(OP.unddes * OP.emb AS INT) AS 'unidades_despachadas',
CAST(OP.ordartivasol AS NUMERIC(18,2)) AS 'precio_iva_despa',
CAST(OP.pretotbrtdes AS NUMERIC(18,2)) AS 'precio_bruto_despa',
CAST(OP.pretotntodes AS NUMERIC(18,2)) AS 'precio_neto_despa',
OP.ordusucre AS 'usuario_creacion',
OP.ordusumod AS 'usuario_modificacion',
CASE
    WHEN YEAR(CAST(OP.ordfecmod AS DATE)) = 1753 THEN NULL
    ELSE CAST(OP.ordfecmod AS DATE)  END AS 'fecha_modificacion',
OP.ordaunuusu AS 'usuario_anulacion',
CASE
    WHEN YEAR(CAST(OP.ordanufec AS DATE)) = 1753 THEN NULL
    ELSE CAST(OP.ordanufec AS DATE)  END AS 'fecha_anulacion'
FROM rmd_traordped_ficc OP
LEFT JOIN rmd_maecliente_ficc MC ON OP.ordnitsec = MC.nitsec AND OP.ordclisec = MC.clisec
LEFT JOIN rmd_maearticulo_ficc MA ON OP.artsec = MA.artsec 
LEFT JOIN rmd_maerepresentante_ficc MR ON OP.ordvencod = MR.vencod
WHERE OP.estado = 'A'

