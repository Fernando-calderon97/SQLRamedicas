SELECT 
MONTH(facfec),
--DAY(facfec),
--factipcod,
SUM(pretot)
FROM
(
SELECT 
--F.FacSec AS 'facsec',
--K.KarSec AS 'karsec',
F.FacFec AS 'facfec',
F.FacNitSec AS 'facnitsec',
F.FacCliSec AS 'facclisec',
F.FacVenCod AS 'facvencod',
F.FacTipCod AS 'factipcod',
F.FacEstRad AS 'facestrad',
F.FacNro AS 'facnro',
K.KarNat AS 'nat',
F.FacEst AS 'facest',
F.FacConPla AS 'facconpla',
K.ArtSec AS 'artsec',
K.PreArtCod AS 'preartcod',
K.KarEst AS 'karest',
K.KarPrePub AS 'preund',
K.KarUni AS 'und',
K.KarArtIva AS 'iva',
K.KarValTotMenDes AS 'pretot',
--F.FacSecDev AS 'facsecdev',
--F.FacDocCom AS 'facdoccom',
F.FacUsuCod AS 'usucre',
F.FacUsuCodMod AS 'usumod',
F.FacFecMod AS 'fecmod',
F.FacAnuUsu AS 'fecanuusu',
F.FacAnuFec AS 'fecanufec',
F.FacCufe AS 'faccufe',
F.FacFecTra AS 'facfectra',
F.FacAnuObs AS 'facanuonbs',
F.FacObs AS 'facobs'
FROM factura F
INNER JOIN facturaKardex K ON F.FacSec = K.FacSec 
INNER JOIN Articulos A ON K.ArtSec = A.ArtSec
WHERE F.FacTipCod = 'FE' AND facfec BETWEEN '20260101' AND '20260213' AND FacEst = 'A' /*AND A.ArtCod NOT IN ('FVFEX','FVFGR')*/

UNION

SELECT 
--F.FacSec AS 'facsec',
--K.KarSec AS 'karsec',
F.FacFec AS 'facfec',
F.FacNitSec AS 'facnitsec',
F.FacCliSec AS 'facclisec',
F.FacVenCod AS 'facvencod',
F.FacTipCod AS 'factipcod',
F.FacEstRad AS 'facestrad',
F.FacNro AS 'facnro',
K.KarNat AS 'nat',
F.FacEst AS 'facest',
F.FacConPla AS 'facconpla',
K.ArtSec AS 'artsec',
K.PreArtCod AS 'preartcod',
K.KarEst AS 'karest',
K.KarPrePub AS 'preund',
K.KarUni AS 'und',
K.KarArtIva AS 'iva',
(K.KarValTotMenDes *-1) AS 'pretot',
--F.FacSecDev AS 'facsecdev',
--F.FacDocCom AS 'facdoccom',
F.FacUsuCod AS 'usucre',
F.FacUsuCodMod AS 'usumod',
F.FacFecMod AS 'fecmod',
F.FacAnuUsu AS 'fecanuusu',
F.FacAnuFec AS 'fecanufec',
F.FacCufe AS 'faccufe',
F.FacFecTra AS 'facfectra',
F.FacAnuObs AS 'facanuonbs',
F.FacObs AS 'facobs'
FROM factura F
INNER JOIN facturaKardex K ON F.FacSec = K.FacSec 
WHERE F.FacTipCod IN ('NC'/*, 'NM'*/) AND facfec BETWEEN '20260201' AND '20260213'  AND FacEst = 'A'
) AS rmd 
GROUP BY MONTH(facfec)/*, DAY(facfec), factipcod
ORDER BY MONTH(facfec) DESC,*/
ORDER BY
MONTH(facfec) ASC