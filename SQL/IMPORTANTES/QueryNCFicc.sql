SELECT SUM(Vlr)
FROM(
SELECT
N.NitNomCom as nomb,
N.NitIde as prov,
F.FacVenCod as cvend,
V.VenNom as nvend,
C.CiuNom as ciudad,
CAST(F.FacFec as DATE) as fech,
F.FacNro as docm,
CNC.ConNotNom as concepto,
F.FacObs as Observacion,
A.ArtNom as noma,
A.ArtCod as arti,
A.ArtNomPrePrin as pres,
A.ArtMedNomCom as nomc,
A.ArtPasCaj as emb,
A.InvCatCod as invi,
A.ArtMedCum as cum,
A.ArtCodBar1 as codbar,
CASE 
  WHEN K.KarNat = 1 THEN CAST(K.KarUni * -1 AS INT) 
  WHEN K.KarNat = 0 THEN CAST(K.KarUni AS INT) END caja,
0 as unid,
CASE
  WHEN K.KarNat = 1 THEN K.KarValTotMenDes * -1 
  WHEN K.KarNat = 0 THEN K.KarValTotMenDes END vlr,
K.KarLot as lote,
CAST(K.KarlotFec as DATE) as fecv,
(
  SELECT
  F1.FacNro
  FROM Factura F1
  WHERE F1.FacSec = F.FacSecDev
) AS Factura,
(
  SELECT
  CAST(F1.FacFec as DATE)
  FROM Factura F1
  WHERE F1.FacSec = F.FacSecDev
) AS fechfac
/*(
  SELECT
  SUM(K1.KarValTotMenDes)
  FROM Factura F1
  INNER JOIN FacturaKardex K1 WITH (NOLOCK) ON F1.FacSec = K1.FacSec
  WHERE F1.FacSec = F.FacSecDev
) AS VlrFactura*/
--F.FacSecDev,
--F.FacSec
FROM factura F
INNER JOIN FacturaKardex K WITH (NOLOCK) ON F.FacSec = K.FacSec
INNER JOIN Articulos A WITH (NOLOCK) ON K.ArtSec = A.ArtSec 
INNER JOIN Nit N WITH (NOLOCK) ON F.FacNitSec = N.NitSec
INNER JOIN Vendedores V WITH (NOLOCK) ON F.FacVenCod = V.VenCod
INNER JOIN Ciudades C WITH (NOLOCK) ON N.nitCiuCod = C.CiuCod
LEFT JOIN ConceptoNC CNC WITH (NOLOCK) ON F.ConNotCod = CNC.ConNotId
WHERE FacTipCod = 'NC' AND F.FacFec BETWEEN '20260101' AND DATEADD(DAY, -1, GETDATE()) AND FacEst = 'A' AND K.KarUni <> 0
ORDER BY F.FacSec ASC
)AS MC   