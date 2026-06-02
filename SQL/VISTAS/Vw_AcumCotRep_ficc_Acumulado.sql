SELECT
--CAST(C.cotfec AS DATE) AS 'fecha',
--MC.nitcc AS 'nit',
--UPPER(MC.nomcli) AS 'nombre_cliente',
--C.tipcod AS 'tipo_documento',
C.cotvencod AS 'codigo_vendedor',
MR.VenNom AS 'nombre_vendedor',
COUNT(C.cotnum) AS 'documento',
/*CASE 
    WHEN C.estado = 'A' THEN 'ACTIVO'
    WHEN C.estado = 'I' THEN 'INACTIVO'
    WHEN C.estado = 'P' THEN 'PROCESO'
    WHEN C.estado = 'B' THEN 'BORRADOR'
    ELSE C.estado END AS 'estado',*/
--C.cotpla AS 'plazo',

--MA.ArtCod AS 'codigo_articulo',
--MA.ArtNom AS 'nombre_articulo',
--CAST(C.cotporiva AS DECIMAL) AS 'iva',
--C.cotprepub AS 'precio_unitario',
SUM(C.cotuni) AS 'unidades',
SUM(C.cortartiva) AS 'precio_iva',
SUM(C.pretotbrt) AS 'precio_bruto',
SUM(C.pretotnto) AS 'precio_neto'
--C.cotlisprecod AS 'codigo_lista_precio',
--C.cotbodcod AS 'codigo_bodega',
--MB.BodSucCCNom AS 'nombre_bodega',
--C.cotusucre AS 'usuario_creacion',
/*CASE
    WHEN YEAR(CAST(C.cotfeccre AS DATE)) = 1753 THEN NULL
    ELSE CAST(C.cotfeccre AS DATE)  END AS 'fecha_creacion',
C.cotusuanu AS 'usuario_anulacion',*/
/*CASE
    WHEN YEAR(CAST(C.cotfecanu AS DATE)) = 1753 THEN NULL
    ELSE CAST(C.cotfecanu AS DATE)  END AS 'fecha_anulacion',*/
--C.cotobs AS 'obsevacion_general'
FROM rmd_tracot_ficc C 
--INNER JOIN rmd_maecliente_ficc MC ON C.cotnitsec = MC.nitsec AND C.cotclisec = MC.clisec
INNER JOIN rmd_maerepresentante_ficc MR ON C.cotvencod = MR.VenCod
--INNER JOIN rmd_maearticulo_ficc MA ON C.artsec = MA.ArtSec
--INNER JOIN rmd_maebodega_ficc MB ON C.cotbodcod = MB.BodSucCCSec
GROUP BY C.cotvencod, MR.VenNom

