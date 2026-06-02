/*SELECT 
K.facFec AS 'fecha',
K.facnro AS 'documento',
MA.ArtCod AS 'artcod',
CAST(SUM(K.unddes) AS INT) AS 'unidades',
CAST(SUM(K.vlrtotbrtdes) AS NUMERIC(18,2)) AS 'valor',
K.codbodori AS 'codbodori',
MB1.BodSucCCNom AS 'nombodori',
K.codboddes AS 'codboddes',
MB2.BodSucCCNom AS 'nombododes'
FROM rmd_trakar_ficc K
INNER JOIN rmd_maebodega_ficc MB1 ON K.codbodori = MB1.BodSucCCSec
INNER JOIN rmd_maebodega_ficc MB2 ON K.codboddes = MB2.BodSucCCSec
INNER JOIN rmd_maearticulo_ficc MA ON K.artsec = MA.ArtSec
WHERE factipcod IN ('TP' ,'TB') AND estado ='A' 
GROUP BY K.facfec, K.facnro, MA.ArtCod, K.codbodori, MB1.BodSucCCNom, K.codboddes, MB2.BodSucCCNom
*/

SELECT 
K.facFec AS 'fecha',
K.facnro AS 'documento',
MA.ArtCod AS 'artcod',
CAST(K.unddes AS INT) AS 'unidasal',
CAST(K.vlrtotbrtdes AS NUMERIC(18,2)) AS 'valorsal',
K.codbodori AS 'codbodori',
MB1.BodSucCCNom AS 'nombodori',
K3.unddes AS 'undent',
K3.vlrtotbrtdes AS 'valorent',
K.codboddes AS 'codbodent',
MB2.BodSucCCNom AS 'nombodoent',
CAST(K.unddes AS INT) + CAST(K3.unddes AS INT) AS 'undpend',
CAST(K.vlrtotbrtdes AS NUMERIC(18,2)) + CAST(K3.vlrtotbrtdes AS NUMERIC(18,2)) AS 'valorpend'
FROM rmd_trakar_ficc K
INNER JOIN rmd_maebodega_ficc MB1 ON K.codbodori = MB1.BodSucCCSec
INNER JOIN rmd_maebodega_ficc MB2 ON K.codboddes = MB2.BodSucCCSec
INNER JOIN rmd_maearticulo_ficc MA ON K.artsec = MA.ArtSec
LEFT JOIN 
(
    SELECT
    K2.FacSec,
    K2.karsec,
    K2.unddes,
    K2.vlrtotbrtdes,
    K2.codboddes,
    K2.artsec,
    K2.estado
    FROM rmd_trakar_ficc K2
    WHERE K2.nat = 1 AND K2.factipcod IN ('TP','TB')
) K3 ON K.facsec = K3.facsec AND ABS(K.karsec) = ABS(K3.karsec)
WHERE K.factipcod IN ('TP','TB') /*AND K.estado ='A'*/ AND K.nat = -1



SELECT 
K.facFec AS 'fecha',
K.facnro AS 'documento',
MA.ArtCod AS 'artcod',
CAST(K.unddes AS INT) AS 'unidasal',
CAST(K.vlrtotbrtdes AS NUMERIC(18,2)) AS 'valorsal',
K.codbodori AS 'codbodori',
MB1.BodSucCCNom AS 'nombodori',
K3.unddes AS 'undent',
K3.vlrtotbrtdes AS 'valorent',
K.codboddes AS 'codbodent',
MB2.BodSucCCNom AS 'nombodoent',
CAST(K.unddes AS INT) + CAST(K3.unddes AS INT) AS 'undpend',
CAST(K.vlrtotbrtdes AS NUMERIC(18,2)) + CAST(K3.vlrtotbrtdes AS NUMERIC(18,2)) AS 'valorpend'
FROM rmd_trakar_ficc K
INNER JOIN rmd_maebodega_ficc MB1 ON K.codbodori = MB1.BodSucCCSec
INNER JOIN rmd_maebodega_ficc MB2 ON K.codboddes = MB2.BodSucCCSec
INNER JOIN rmd_maearticulo_ficc MA ON K.artsec = MA.ArtSec
LEFT JOIN 
(
    SELECT
    K2.FacSec,
    K2.karsec,
    K2.unddes,
    K2.vlrtotbrtdes,
    K2.codboddes,
    K2.artsec,
    K2.estado
    FROM rmd_trakar_ficc K2
    WHERE K2.nat = 1 AND K2.factipcod IN ('TP')
) K3 ON K.facsec = K3.facsec AND ABS(K.karsec) = ABS(K3.karsec)
WHERE K.factipcod IN ('TP') AND K.nat = -1

