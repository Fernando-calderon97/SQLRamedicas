
--QUERY PARA EXTRAER DATOS DEL MAESTRO ARTICULOS DE WEB
SELECT
ArtCod AS 'Codigo_articulo',
ArtNom AS 'Nombre_articulo',
artpres AS 'presentacion',
ArtMedUndMed AS 'tipo_unidad',
ArtCodBar AS'codigo_barras',
ArtPasCaj AS 'Embalaje',
ArtMedCum AS 'codigo_cum',
artlab AS 'laboratorio',
ParConNom AS 'iva',
ClaArtNom as 'tipo'
FROM [RamedicasBI].[dbo].[rmd_maearticulo_web]