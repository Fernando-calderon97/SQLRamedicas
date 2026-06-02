CREATE VIEW vw_rmd_tracomwin AS
SELECT
CAST(KC.facfec AS DATE) AS 'Fecha',
KC.facnro AS 'Documento',
KC.nit AS 'Nit',
P.p2 AS 'Nombre_prov',
KC.artcod AS 'Codigo_articulo',
A.in2 AS 'Nombre_art',
CAST(KC.emb AS INT) AS 'Embalaje',
CAST(KC.und  AS INT) AS 'Unidades',
CAST(KC.preund AS NUMERIC(18,2)) AS 'Precio_und',
CAST(KC.prepres AS NUMERIC(18,2)) AS 'Precio_pres',
CAST(KC.vlr AS NUMERIC(18,2)) AS 'Total',
KC.lote AS 'Lote',
CAST(KC.fechv AS DATE) AS 'Fecha_ven_lote'
FROM rmd_tracomwin KC
INNER JOIN prov P ON KC.nit = p.P1
INNER JOIN  IA125 A ON KC.artcod = A.in1
