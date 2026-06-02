SELECT
CodigoArticulo,
CAST(SUM(Cajas) /3 AS INT) AS 'Cajas',
CAST(SUM(Valor) /3 AS INT) AS 'Valor'
FROM 
(
SELECT 
MONTH(fecfac) AS 'Mes',
codart 'CodigoArticulo',
SUM(cajart) AS 'Cajas',
SUM(vlrtotbrt) AS 'Valor'
FROM rmd_trafacwin
WHERE MONTH(fecfac) IN (9, 10, 11)
GROUP BY MONTH(fecfac), codart

UNION ALL

SELECT
MONTH(fech) AS 'Mes',
codart AS 'CodigoArticulo',
SUM(und / emb) AS 'Cajas',
SUM(vlr) AS 'Valor'
FROM rmd_traoxwin
WHERE MONTH(fech) IN (9, 10, 11) AND YEAR(fech) = 2025 AND nit NOT LIKE '901429936%'
GROUP BY MONTH(fech), codart
) AS RMD
WHERE CodigoArticulo IN ('GF0413', 'WT0005', 'BI0065')
GROUP BY CodigoArticulo

