SELECT
SUM(vlr)
FROM
(
SELECT 
MC.nomcli AS 'nomb',
MC.nitcc AS 'prov',
N.facvencod AS 'cvend',
MR.VenNom AS 'nvend',
C.ciunom AS 'ciudad',
CAST(N.facfec AS DATE) AS 'fech',
N.facnro AS 'docm',
MA.ArtNom AS 'noma',
MA.ArtCod AS 'arti',
MA.artpres AS 'pres',
MA.ArtMedNomCom AS 'nomc',
MA.ArtEmb AS 'emb',
MA.InvFamNom AS 'invi',
MA.ArtMedCum AS 'cum',
MA.ArtCodBar AS 'codbar',
CASE
    WHEN N.factipcod = 'ND' THEN N.und 
    ELSE N.und * -1 END AS 'caj',
0 AS 'unid',
CASE
    WHEN N.factipcod = 'ND' THEN N.vlrtot
    ELSE N.vlrtot * -1 END AS 'vlr',
'' AS 'lote',
'' as 'fecv'
FROM rmd_trafacncnd_ficc N
INNER JOIN rmd_maecliente_ficc MC ON N.facnitsec = MC.nitsec AND N.facclisec = MC.clisec
INNER JOIN rmd_maerepresentante_ficc MR ON N.facvencod = MR.vencod 
INNER JOIN rmd_objciudad_ficc C ON MC.ciucod = C.ciucod
INNER JOIN rmd_maearticulo_ficc MA ON N.artsec = MA.ArtSec 
WHERE N.facest = 'A' AND N.vlrtot <> 0 AND N.facfec BETWEEN '20260201' AND '20260228' 
) AS RMD