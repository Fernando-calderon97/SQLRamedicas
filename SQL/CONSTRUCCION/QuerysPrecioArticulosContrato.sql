SELECT
Documento,
Contratoid,
Contrato,
STRING_AGG(CodigoArticulo, '- ') AS 'CodigoArticulo',
STRING_AGG(Preciound, '- ') AS 'Preciound',
STRING_AGG(PrecioundArt, '- ') AS 'PrecioundArt'
FROM(
SELECT 
F.FacNro AS 'Documento',
F.FacConDisId AS 'Contratoid',
CD.ConDisNro AS 'Contrato',
A.ArtCod AS 'CodigoArticulo',
CDR.ConDisRefCod AS 'CodigoArticuloContrato',
COALESCE(CDR.ConDisRefVal, 0) AS 'PrecioundCtr',
COALESCE(K.KarPre, 0) AS 'PrecioundArt'
FROM Factura F
INNER JOIN Kardex K ON F.FacSec = K.FacSec AND K.KarSec < 500000
LEFT JOIN Articulos A ON A.ArtSec = K.ArtSec
LEFT JOIN ContratosDispensacionReferenci CDR ON F.FacConDisId = CDR.ConDisId  AND A.ArtCod = CDR.ConDisRefCod
LEFT JOIN ContratosDispensacion CD ON F.FacConDisId = CD.ConDisId
INNER JOIN Tipos T WITH (NOLOCK) ON F.FacTipCod = T.TipCod 
WHERE F.FacEst = 'A' AND  T.FueCod = 45 AND F.FacConDisId <> 0 AND F.FacConDisId = 24
) AS CT 
WHERE Preciound = 0
GROUP BY
Documento,
Contratoid,
Contrato
