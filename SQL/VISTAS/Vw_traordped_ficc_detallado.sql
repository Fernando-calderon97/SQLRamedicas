SELECT
CAST(OP.ordfec AS DATE) AS 'fecha',
MC.nitcc AS 'nit',
UPPER(MC.nomcli)AS 'nombre_cliente',
OP.ordtipcod AS 'tipo_documento',
OP.ordnum AS 'documento',
CASE 
    WHEN OP.estado = 'A' THEN 'ACTIVO'
    WHEN OP.estado = 'I' THEN 'INACTIVO'
    WHEN OP.estado = 'P' THEN 'PROCESO'
    WHEN OP.estado = 'B' THEN 'BORRADOR'
    ELSE OP.estado END AS 'estado',
OP.ordpla AS 'plazo',
CAST(OP.ordfecven AS DATE) AS 'fecha_vencimiento',
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
--OP.unddes AS 'cajas_despachadas',
--CAST(OP.unddes * OP.emb AS INT) AS 'unidades_despachadas',
--CAST(OP.ordartivasol AS NUMERIC(18,2)) AS 'precio_iva_despa',
--CAST(OP.pretotbrtdes AS NUMERIC(18,2)) AS 'precio_bruto_despa',
--CAST(OP.pretotntodes AS NUMERIC(18,2)) AS 'precio_neto_despa',
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
INNER JOIN rmd_maecliente_ficc MC ON OP.ordnitsec = MC.nitsec AND OP.ordclisec = MC.clisec
INNER JOIN rmd_maearticulo_ficc MA ON OP.artsec = MA.artsec 
LEFT JOIN rmd_maerepresentante_ficc MR ON OP.ordvencod = MR.vencod