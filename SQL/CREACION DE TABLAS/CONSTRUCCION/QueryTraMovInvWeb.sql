SELECT TOP 100
F.FacSec AS 'facsec',
K.KarSec AS 'karsec',
C.ComSec AS 'comsec',
F.FacFec AS 'facfec',
C.ComFecEnc AS 'comfecenc',
F.FacNitSec AS 'facnitsec',
--C.ComNitSec AS 'comnitsec',
F.FacNro AS 'facnro',
--C.ComNum AS 'comnum',
F.FacTipCod AS 'factipcod',
--C.ComTipCod AS 'comtipcod',
F.FacEst AS 'facest',
--C.ComEst AS 'comest',
K.KarEst AS 'karest',
K.ArtSec AS 'artsec',
K.PreArtCod AS 'preartcod',
K.KarPreFacCon AS 'artemb',
CASE 
    WHEN K.karNat = '-' THEN CAST((K.KarUni * -1 ) AS INT)
    WHEN K.karNat = '+' THEN CAST((K.KarUni * 1 ) AS INT)
    WHEN K.karNat = '-O' THEN CAST((K.KarUni * 0 ) AS INT)
    WHEN K.karNat = '+O' THEN CAST((K.KarUni * 0 ) AS INT)
    ELSE 0 END AS 'karcaj',
CASE
    WHEN K.karNat = '-' THEN CAST((K.KarUni * k.KarPreFacCon * -1)AS INT)
    WHEN K.karNat = '+' THEN CAST((K.KarUni * k.KarPreFacCon * 1)AS INT)
    WHEN K.karNat = '-O' THEN CAST((K.KarUni * k.KarPreFacCon * 0)AS INT)
    WHEN K.karNat = '+O' THEN CAST((K.KarUni * k.KarPreFacCon * 0)AS INT)
    ELSE 0 END AS 'karuni',
K.KarPorIva AS 'karporiva',
K.KarArtIva AS 'karartiva',
CASE 
    WHEN K.karNat = '-' THEN CAST(K.KarPrePub * -1 AS NUMERIC(18,2)) 
    WHEN K.karNat = '+' THEN CAST(K.KarPrePub * 1 AS NUMERIC(18,2)) 
    WHEN K.karNat = '-O' THEN CAST(K.KarPrePub * 0 AS NUMERIC(18,2))
    WHEN K.karNat = '-O' THEN CAST(K.KarPrePub * 0 AS NUMERIC(18,2))  
    ELSE 0 END AS 'karprecaj',
CASE 
    WHEN K.karNat = '-' THEN CAST(K.karvaltotMenDes * -1 AS NUMERIC(18,2)) 
    WHEN K.karNat = '+' THEN CAST(K.karvaltotMenDes * 1 AS NUMERIC(18,2)) 
    WHEN K.karNat = '-O' THEN CAST(K.karvaltotMenDes * 0 AS NUMERIC(18,2)) 
    WHEN K.karNat = '+O' THEN CAST(K.karvaltotMenDes * 0 AS NUMERIC(18,2)) 
    ELSE 0 END AS 'kartot',
K.karNat AS 'karnat',
K.KarLot AS 'karlot',
K.KarLotFec AS 'karlotfec',
--K.KarEst AS 'karest',
K.SubBodSucCCSec AS 'subbodsuccsec',
F.FacUsuCod AS 'facusucre',
F.FacUsuCodMod AS 'facusumod',
F.FacFecHorMod AS 'facfecmod',
F.FacUsuAnu AS 'facusuanu',
F.FacFecAnu AS 'facfecanu',
F.FacObs AS 'facobs',
C.ComObs AS 'comobs'
FROM [Ramedicas].[dbo].[Factura] F
LEFT JOIN [Ramedicas].[dbo].[Kardex] K ON F.FacSec = K.FacSec
LEFT JOIN [Ramedicas].[dbo].[comprobante] C ON F.FacComSec = C.ComSec
