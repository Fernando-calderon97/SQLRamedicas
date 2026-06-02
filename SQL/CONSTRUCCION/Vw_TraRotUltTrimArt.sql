USE RamedicasPBI;
ALTER VIEW vw_rmd_clasifrotarti_detallada AS
SELECT
DENSE_RANK() OVER (ORDER BY SUM(CajaTot) DESC) AS 'RankCaja',
DENSE_RANK() OVER (ORDER BY SUM(Valor) DESC) AS 'RankValor',
CodigoArticulo,
SUM(Mestresanterior) AS 'Mestresanterior',
SUM(Mesdosanterior) AS 'Mesdosanterior',
SUM(Mesunoanterior) AS 'Mesunoanterior',
SUM(CajaTot) / 3 AS 'PromTrimCajasTotales',
CAST(SUM(Valor) / 3 AS NUMERIC(18,2))  AS 'PromTrimValorTotal',
CAST(SUM(CajaTot) * 1.0 / NULLIF(SUM(SUM(CajaTot)) OVER(), 0) AS NUMERIC(18,8)) AS 'PorctPartCajas',
CAST(SUM(Valor)  / SUM(SUM(Valor)) OVER() AS NUMERIC(18,8)) AS 'PorctPartValor'
FROM 
(
SELECT 
F.codart AS 'CodigoArticulo',
SUM(CASE WHEN MONTH(F.fecfac) = 12  THEN F.cajart ELSE 0 END) AS 'Mestresanterior',
SUM(CASE WHEN MONTH(F.fecfac) = 0 THEN F.cajart ELSE 0 END) AS 'Mesdosanterior',
SUM(CASE WHEN MONTH(F.fecfac) = 0 THEN F.cajart ELSE 0 END) AS 'Mesunoanterior',
SUM(CASE WHEN MONTH(F.fecfac) IN (12) THEN CAST(F.cajart AS INT) ELSE 0 END) AS 'CajaTot',
SUM(CASE WHEN MONTH(F.fecfac) = 12 THEN CAST(F.vlrtotbrt AS NUMERIC(18,2)) ELSE 0 END) AS 'Valor'
FROM [RamedicasBI_WIN].[dbo].[rmd_trafacwin] F
--WHERE MONTH(F.fecfac) IN (12)
GROUP BY F.codart

UNION ALL

SELECT 
MA.ArtCod AS 'CodigoArticulo',
SUM(CASE WHEN MONTH(F.facfec) = 0  THEN F.und ELSE 0 END) AS 'Mestresanterior',
SUM(CASE WHEN MONTH(F.facfec) = 1 THEN F.und ELSE 0 END) AS 'Mesdosanterior',
SUM(CASE WHEN MONTH(F.facfec) = 2 THEN F.und ELSE 0 END) AS 'Mesunoanterior',
SUM(CASE WHEN MONTH(F.facfec) IN (1, 2) THEN CAST(F.und AS INT) ELSE 0 END) AS 'CajaTot',
SUM(CASE WHEN MONTH(F.facfec) IN (1, 2) THEN CAST(F.vlrtot AS NUMERIC(18,2)) ELSE 0 END) AS 'Valor'
FROM [RamedicasBI_FICC].[dbo].[rmd_maearticulo_ficc] MA  
LEFT JOIN [RamedicasBI_FICC].[dbo].[rmd_trafacdist_ficc] F ON MA.ArtSec = F.artsec
WHERE MA.ArtCod NOT IN ('FVFEX', 'FVFGR', 'FVIN')
--WHERE MONTH(F.facfec) IN (1, 2)
GROUP BY MA.ArtCod

UNION ALL

SELECT
codart AS 'CodigoArticulo',
SUM(CASE WHEN MONTH(fech) = 12 AND YEAR(fech) = 2025  THEN (und / emb) ELSE 0 END) AS 'Mestresanterior',
SUM(CASE WHEN MONTH(fech) = 1 AND YEAR(fech) = 2026  THEN (und / emb) ELSE 0 END) AS 'Mesdosanterior',
SUM(CASE WHEN MONTH(fech) = 0 AND YEAR(fech) = 2025 THEN (und / emb) ELSE 0 END) AS 'Mesunoanterior',
SUM(CASE WHEN MONTH(fech) = 12 AND YEAR(fech) = 2025  THEN (und / emb) ELSE 0 END) + SUM(CASE WHEN MONTH(fech) = 1 AND YEAR(fech) = 2026  THEN (und / emb) ELSE 0 END) AS 'CajaTot',
SUM(CASE WHEN MONTH(fech) = 12 AND YEAR(fech) = 2025 THEN vlr ELSE 0 END) + SUM(CASE WHEN MONTH(fech) = 1 AND YEAR(fech) = 2026 THEN vlr ELSE 0 END) AS 'Valor'
FROM [RamedicasBI_WIN].[dbo].[rmd_traoxwin]
WHERE /*MONTH(fech) IN (12) AND*/ nit NOT LIKE '901429936%' /*AND YEAR(fech) = 2025*/
GROUP BY codart
) AS RMD

GROUP BY CodigoArticulo
HAVING SUM(CajaTot) / 3 >= 0
