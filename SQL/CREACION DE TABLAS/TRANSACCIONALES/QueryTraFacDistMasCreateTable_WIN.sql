
-- QUERY INSERT TRANSACCIONAL FACTURACION WIN
INSERT INTO [BD_RAMEDICAS_SAS].[dbo].[rmd_trafac_win]

-- ENERO
SELECT 
CAST(K.ka4 AS DATE) AS 'fecfac',
CONCAT(K.ka2,K.ka3) AS 'facnro',
K.ka2 AS 'tipfac',
K.ka24 AS 'ordped',
K.ka13 AS 'nitcli',
MC.cl3 AS 'nomcli',
C.ci2 AS 'ciupri',
ISNULL(CA.ca2, '') AS 'canal',
ISNULL(MC.cl13, '') AS 'codven',
ISNULL(v.ve2, '') AS 'nomven',
K.ka1 AS 'codart',
MA.in2 AS 'nomart',
MA.in3 'presart',
MA.innc AS 'nomcomart',
MA.invi AS 'inviart',
MA.incum AS 'cumart',
MA.in19 AS 'codbarart',
MA.in12 AS 'embart',
(K.ka5s-K.ka5e) 'cajart',
'vlrtotbrt'= CASE 
    WHEN T.t8 IN ('04','19') THEN CASE  
        WHEN F.IsSubsidised=1 THEN 0 
        ELSE(K.ka12 - K.ka11) END ELSE CASE 
            WHEN F.IsSubsidised=1 THEN 0 
            ELSE (K.ka12 - K.ka11 )*-1 END END, 
K.kalote AS 'lotart',
F.FACAJ AS 'cajdes',
PC.nmPopCentre AS 'ciuent',
PC.cdCity AS 'codciuent'
from [ka010125] K WITH(NOLOCK) 
INNER JOIN [iA125] MA WITH(NOLOCK) ON K.ka1 = MA.in1 
INNER JOIN [tipo] T WITH(NOLOCK) ON K.ka2 = T.t1 
LEFT JOIN [clie] MC WITH(NOLOCK) ON K.ka13 = MC.cl1 
LEFT JOIN nits2 N2 WITH(NOLOCK) ON K.kaprov = ced 
LEFT JOIN [ciud] C WITH(NOLOCK) ON MC.cl36 = C.ci1  
LEFT JOIN [facc] F (nolock) ON K.ka2 = F.fa3 AND K.ka3 = F.fa2  
LEFT JOIN [vend] V ON MC.cl13 = V.ve4 
LEFT JOIN [nits] N ON K.ka13 = N.n1
LEFT JOIN [cana] CA ON cl18a = CA.ca1
LEFT JOIN [CustomerAddress] CAD ON F.idcustomeraddress = CAD.idcustomeraddress
LEFT JOIN [PopulationCentre] PC ON CAD.idPopCentre = PC.idPopCentre
WHERE T.t8 IN ('04','08','NR','19')

UNION ALL

-- FEBRERO
SELECT 
CAST(K.ka4 AS DATE) AS 'fecfac',
CONCAT(K.ka2,K.ka3) AS 'facnro',
K.ka2 AS 'tipfac',
K.ka24 AS 'ordped',
K.ka13 AS 'nitcli',
MC.cl3 AS 'nomcli',
C.ci2 AS 'ciupri',
ISNULL(CA.ca2, '') AS 'canal',
ISNULL(MC.cl13, '') AS 'codven',
ISNULL(v.ve2, '') AS 'nomven',
K.ka1 AS 'codart',
MA.in2 AS 'nomart',
MA.in3 'presart',
MA.innc AS 'nomcomart',
MA.invi AS 'inviart',
MA.incum AS 'cumart',
MA.in19 AS 'codbarart',
MA.in12 AS 'embart',
(K.ka5s-K.ka5e) 'cajart',
'vlrtotbrt'= CASE 
    WHEN T.t8 IN ('04','19') THEN CASE  
        WHEN F.IsSubsidised=1 THEN 0 
        ELSE(K.ka12 - K.ka11) END ELSE CASE 
            WHEN F.IsSubsidised=1 THEN 0 
            ELSE (K.ka12 - K.ka11 )*-1 END END, 
K.kalote AS 'lotart',
F.FACAJ AS 'cajdes',
PC.nmPopCentre AS 'ciuent',
PC.cdCity AS 'codciuent'
from [ka010225] K WITH(NOLOCK) 
INNER JOIN [iA125] MA WITH(NOLOCK) ON K.ka1 = MA.in1 
INNER JOIN [tipo] T WITH(NOLOCK) ON K.ka2 = T.t1 
LEFT JOIN [clie] MC WITH(NOLOCK) ON K.ka13 = MC.cl1 
LEFT JOIN nits2 N2 WITH(NOLOCK) ON K.kaprov = ced 
LEFT JOIN [ciud] C WITH(NOLOCK) ON MC.cl36 = C.ci1  
LEFT JOIN [facc] F (nolock) ON K.ka2 = F.fa3 AND K.ka3 = F.fa2  
LEFT JOIN [vend] V ON MC.cl13 = V.ve4 
LEFT JOIN [nits] N ON K.ka13 = N.n1
LEFT JOIN [cana] CA ON cl18a = CA.ca1
LEFT JOIN [CustomerAddress] CAD ON F.idcustomeraddress = CAD.idcustomeraddress
LEFT JOIN [PopulationCentre] PC ON CAD.idPopCentre = PC.idPopCentre
WHERE T.t8 IN ('04','08','NR','19')

UNION ALL

-- MARZO
SELECT 
CAST(K.ka4 AS DATE) AS 'fecfac',
CONCAT(K.ka2,K.ka3) AS 'facnro',
K.ka2 AS 'tipfac',
K.ka24 AS 'ordped',
K.ka13 AS 'nitcli',
MC.cl3 AS 'nomcli',
C.ci2 AS 'ciupri',
ISNULL(CA.ca2, '') AS 'canal',
ISNULL(MC.cl13, '') AS 'codven',
ISNULL(v.ve2, '') AS 'nomven',
K.ka1 AS 'codart',
MA.in2 AS 'nomart',
MA.in3 'presart',
MA.innc AS 'nomcomart',
MA.invi AS 'inviart',
MA.incum AS 'cumart',
MA.in19 AS 'codbarart',
MA.in12 AS 'embart',
(K.ka5s-K.ka5e) 'cajart',
'vlrtotbrt'= CASE 
    WHEN T.t8 IN ('04','19') THEN CASE  
        WHEN F.IsSubsidised=1 THEN 0 
        ELSE(K.ka12 - K.ka11) END ELSE CASE 
            WHEN F.IsSubsidised=1 THEN 0 
            ELSE (K.ka12 - K.ka11 )*-1 END END, 
K.kalote AS 'lotart',
F.FACAJ AS 'cajdes',
PC.nmPopCentre AS 'ciuent',
PC.cdCity AS 'codciuent'
from [ka010325] K WITH(NOLOCK) 
INNER JOIN [iA125] MA WITH(NOLOCK) ON K.ka1 = MA.in1 
INNER JOIN [tipo] T WITH(NOLOCK) ON K.ka2 = T.t1 
LEFT JOIN [clie] MC WITH(NOLOCK) ON K.ka13 = MC.cl1 
LEFT JOIN nits2 N2 WITH(NOLOCK) ON K.kaprov = ced 
LEFT JOIN [ciud] C WITH(NOLOCK) ON MC.cl36 = C.ci1  
LEFT JOIN [facc] F (nolock) ON K.ka2 = F.fa3 AND K.ka3 = F.fa2  
LEFT JOIN [vend] V ON MC.cl13 = V.ve4 
LEFT JOIN [nits] N ON K.ka13 = N.n1
LEFT JOIN [cana] CA ON cl18a = CA.ca1
LEFT JOIN [CustomerAddress] CAD ON F.idcustomeraddress = CAD.idcustomeraddress
LEFT JOIN [PopulationCentre] PC ON CAD.idPopCentre = PC.idPopCentre
WHERE T.t8 IN ('04','08','NR','19')

UNION ALL

-- ABRIL
SELECT 
CAST(K.ka4 AS DATE) AS 'fecfac',
CONCAT(K.ka2,K.ka3) AS 'facnro',
K.ka2 AS 'tipfac',
K.ka24 AS 'ordped',
K.ka13 AS 'nitcli',
MC.cl3 AS 'nomcli',
C.ci2 AS 'ciupri',
ISNULL(CA.ca2, '') AS 'canal',
ISNULL(MC.cl13, '') AS 'codven',
ISNULL(v.ve2, '') AS 'nomven',
K.ka1 AS 'codart',
MA.in2 AS 'nomart',
MA.in3 'presart',
MA.innc AS 'nomcomart',
MA.invi AS 'inviart',
MA.incum AS 'cumart',
MA.in19 AS 'codbarart',
MA.in12 AS 'embart',
(K.ka5s-K.ka5e) 'cajart',
'vlrtotbrt'= CASE 
    WHEN T.t8 IN ('04','19') THEN CASE  
        WHEN F.IsSubsidised=1 THEN 0 
        ELSE(K.ka12 - K.ka11) END ELSE CASE 
            WHEN F.IsSubsidised=1 THEN 0 
            ELSE (K.ka12 - K.ka11 )*-1 END END, 
K.kalote AS 'lotart',
F.FACAJ AS 'cajdes',
PC.nmPopCentre AS 'ciuent',
PC.cdCity AS 'codciuent'
from [ka010425] K WITH(NOLOCK) 
INNER JOIN [iA125] MA WITH(NOLOCK) ON K.ka1 = MA.in1 
INNER JOIN [tipo] T WITH(NOLOCK) ON K.ka2 = T.t1 
LEFT JOIN [clie] MC WITH(NOLOCK) ON K.ka13 = MC.cl1 
LEFT JOIN nits2 N2 WITH(NOLOCK) ON K.kaprov = ced 
LEFT JOIN [ciud] C WITH(NOLOCK) ON MC.cl36 = C.ci1  
LEFT JOIN [facc] F (nolock) ON K.ka2 = F.fa3 AND K.ka3 = F.fa2  
LEFT JOIN [vend] V ON MC.cl13 = V.ve4 
LEFT JOIN [nits] N ON K.ka13 = N.n1
LEFT JOIN [cana] CA ON cl18a = CA.ca1
LEFT JOIN [CustomerAddress] CAD ON F.idcustomeraddress = CAD.idcustomeraddress
LEFT JOIN [PopulationCentre] PC ON CAD.idPopCentre = PC.idPopCentre
WHERE T.t8 IN ('04','08','NR','19')

UNION ALL

-- MAYO
SELECT 
CAST(K.ka4 AS DATE) AS 'fecfac',
CONCAT(K.ka2,K.ka3) AS 'facnro',
K.ka2 AS 'tipfac',
K.ka24 AS 'ordped',
K.ka13 AS 'nitcli',
MC.cl3 AS 'nomcli',
C.ci2 AS 'ciupri',
ISNULL(CA.ca2, '') AS 'canal',
ISNULL(MC.cl13, '') AS 'codven',
ISNULL(v.ve2, '') AS 'nomven',
K.ka1 AS 'codart',
MA.in2 AS 'nomart',
MA.in3 'presart',
MA.innc AS 'nomcomart',
MA.invi AS 'inviart',
MA.incum AS 'cumart',
MA.in19 AS 'codbarart',
MA.in12 AS 'embart',
(K.ka5s-K.ka5e) 'cajart',
'vlrtotbrt'= CASE 
    WHEN T.t8 IN ('04','19') THEN CASE  
        WHEN F.IsSubsidised=1 THEN 0 
        ELSE(K.ka12 - K.ka11) END ELSE CASE 
            WHEN F.IsSubsidised=1 THEN 0 
            ELSE (K.ka12 - K.ka11 )*-1 END END, 
K.kalote AS 'lotart',
F.FACAJ AS 'cajdes',
PC.nmPopCentre AS 'ciuent',
PC.cdCity AS 'codciuent'
from [ka010525] K WITH(NOLOCK) 
INNER JOIN [iA125] MA WITH(NOLOCK) ON K.ka1 = MA.in1 
INNER JOIN [tipo] T WITH(NOLOCK) ON K.ka2 = T.t1 
LEFT JOIN [clie] MC WITH(NOLOCK) ON K.ka13 = MC.cl1 
LEFT JOIN nits2 N2 WITH(NOLOCK) ON K.kaprov = ced 
LEFT JOIN [ciud] C WITH(NOLOCK) ON MC.cl36 = C.ci1  
LEFT JOIN [facc] F (nolock) ON K.ka2 = F.fa3 AND K.ka3 = F.fa2  
LEFT JOIN [vend] V ON MC.cl13 = V.ve4 
LEFT JOIN [nits] N ON K.ka13 = N.n1
LEFT JOIN [cana] CA ON cl18a = CA.ca1
LEFT JOIN [CustomerAddress] CAD ON F.idcustomeraddress = CAD.idcustomeraddress
LEFT JOIN [PopulationCentre] PC ON CAD.idPopCentre = PC.idPopCentre
WHERE T.t8 IN ('04','08','NR','19')

UNION ALL

-- JUNIO
SELECT 
CAST(K.ka4 AS DATE) AS 'fecfac',
CONCAT(K.ka2,K.ka3) AS 'facnro',
K.ka2 AS 'tipfac',
K.ka24 AS 'ordped',
K.ka13 AS 'nitcli',
MC.cl3 AS 'nomcli',
C.ci2 AS 'ciupri',
ISNULL(CA.ca2, '') AS 'canal',
ISNULL(MC.cl13, '') AS 'codven',
ISNULL(v.ve2, '') AS 'nomven',
K.ka1 AS 'codart',
MA.in2 AS 'nomart',
MA.in3 'presart',
MA.innc AS 'nomcomart',
MA.invi AS 'inviart',
MA.incum AS 'cumart',
MA.in19 AS 'codbarart',
MA.in12 AS 'embart',
(K.ka5s-K.ka5e) 'cajart',
'vlrtotbrt'= CASE 
    WHEN T.t8 IN ('04','19') THEN CASE  
        WHEN F.IsSubsidised=1 THEN 0 
        ELSE(K.ka12 - K.ka11) END ELSE CASE 
            WHEN F.IsSubsidised=1 THEN 0 
            ELSE (K.ka12 - K.ka11 )*-1 END END, 
K.kalote AS 'lotart',
F.FACAJ AS 'cajdes',
PC.nmPopCentre AS 'ciuent',
PC.cdCity AS 'codciuent'
from [ka010625] K WITH(NOLOCK) 
INNER JOIN [iA125] MA WITH(NOLOCK) ON K.ka1 = MA.in1 
INNER JOIN [tipo] T WITH(NOLOCK) ON K.ka2 = T.t1 
LEFT JOIN [clie] MC WITH(NOLOCK) ON K.ka13 = MC.cl1 
LEFT JOIN nits2 N2 WITH(NOLOCK) ON K.kaprov = ced 
LEFT JOIN [ciud] C WITH(NOLOCK) ON MC.cl36 = C.ci1  
LEFT JOIN [facc] F (nolock) ON K.ka2 = F.fa3 AND K.ka3 = F.fa2  
LEFT JOIN [vend] V ON MC.cl13 = V.ve4 
LEFT JOIN [nits] N ON K.ka13 = N.n1
LEFT JOIN [cana] CA ON cl18a = CA.ca1
LEFT JOIN [CustomerAddress] CAD ON F.idcustomeraddress = CAD.idcustomeraddress
LEFT JOIN [PopulationCentre] PC ON CAD.idPopCentre = PC.idPopCentre
WHERE T.t8 IN ('04','08','NR','19')

UNION ALL

-- JULIO

SELECT 
CAST(K.ka4 AS DATE) AS 'fecfac',
CONCAT(K.ka2,K.ka3) AS 'facnro',
K.ka2 AS 'tipfac',
K.ka24 AS 'ordped',
K.ka13 AS 'nitcli',
MC.cl3 AS 'nomcli',
C.ci2 AS 'ciupri',
ISNULL(CA.ca2, '') AS 'canal',
ISNULL(MC.cl13, '') AS 'codven',
ISNULL(v.ve2, '') AS 'nomven',
K.ka1 AS 'codart',
MA.in2 AS 'nomart',
MA.in3 'presart',
MA.innc AS 'nomcomart',
MA.invi AS 'inviart',
MA.incum AS 'cumart',
MA.in19 AS 'codbarart',
MA.in12 AS 'embart',
(K.ka5s-K.ka5e) 'cajart',
'vlrtotbrt'= CASE 
    WHEN T.t8 IN ('04','19') THEN CASE  
        WHEN F.IsSubsidised=1 THEN 0 
        ELSE(K.ka12 - K.ka11) END ELSE CASE 
            WHEN F.IsSubsidised=1 THEN 0 
            ELSE (K.ka12 - K.ka11 )*-1 END END, 
K.kalote AS 'lotart',
F.FACAJ AS 'cajdes',
PC.nmPopCentre AS 'ciuent',
PC.cdCity AS 'codciuent'
from [ka010725] K WITH(NOLOCK) 
INNER JOIN [iA125] MA WITH(NOLOCK) ON K.ka1 = MA.in1 
INNER JOIN [tipo] T WITH(NOLOCK) ON K.ka2 = T.t1 
LEFT JOIN [clie] MC WITH(NOLOCK) ON K.ka13 = MC.cl1 
LEFT JOIN nits2 N2 WITH(NOLOCK) ON K.kaprov = ced 
LEFT JOIN [ciud] C WITH(NOLOCK) ON MC.cl36 = C.ci1  
LEFT JOIN [facc] F (nolock) ON K.ka2 = F.fa3 AND K.ka3 = F.fa2  
LEFT JOIN [vend] V ON MC.cl13 = V.ve4 
LEFT JOIN [nits] N ON K.ka13 = N.n1
LEFT JOIN [cana] CA ON cl18a = CA.ca1
LEFT JOIN [CustomerAddress] CAD ON F.idcustomeraddress = CAD.idcustomeraddress
LEFT JOIN [PopulationCentre] PC ON CAD.idPopCentre = PC.idPopCentre
WHERE T.t8 IN ('04','08','NR','19')

UNION ALL

-- AGOSTO
SELECT 
CAST(K.ka4 AS DATE) AS 'fecfac',
CONCAT(K.ka2,K.ka3) AS 'facnro',
K.ka2 AS 'tipfac',
K.ka24 AS 'ordped',
K.ka13 AS 'nitcli',
MC.cl3 AS 'nomcli',
C.ci2 AS 'ciupri',
ISNULL(CA.ca2, '') AS 'canal',
ISNULL(MC.cl13, '') AS 'codven',
ISNULL(v.ve2, '') AS 'nomven',
K.ka1 AS 'codart',
MA.in2 AS 'nomart',
MA.in3 'presart',
MA.innc AS 'nomcomart',
MA.invi AS 'inviart',
MA.incum AS 'cumart',
MA.in19 AS 'codbarart',
MA.in12 AS 'embart',
(K.ka5s-K.ka5e) 'cajart',
'vlrtotbrt'= CASE 
    WHEN T.t8 IN ('04','19') THEN CASE  
        WHEN F.IsSubsidised=1 THEN 0 
        ELSE(K.ka12 - K.ka11) END ELSE CASE 
            WHEN F.IsSubsidised=1 THEN 0 
            ELSE (K.ka12 - K.ka11 )*-1 END END, 
K.kalote AS 'lotart',
F.FACAJ AS 'cajdes',
PC.nmPopCentre AS 'ciuent',
PC.cdCity AS 'codciuent'
from [ka010825] K WITH(NOLOCK) 
INNER JOIN [iA125] MA WITH(NOLOCK) ON K.ka1 = MA.in1 
INNER JOIN [tipo] T WITH(NOLOCK) ON K.ka2 = T.t1 
LEFT JOIN [clie] MC WITH(NOLOCK) ON K.ka13 = MC.cl1 
LEFT JOIN nits2 N2 WITH(NOLOCK) ON K.kaprov = ced 
LEFT JOIN [ciud] C WITH(NOLOCK) ON MC.cl36 = C.ci1  
LEFT JOIN [facc] F (nolock) ON K.ka2 = F.fa3 AND K.ka3 = F.fa2  
LEFT JOIN [vend] V ON MC.cl13 = V.ve4 
LEFT JOIN [nits] N ON K.ka13 = N.n1
LEFT JOIN [cana] CA ON cl18a = CA.ca1
LEFT JOIN [CustomerAddress] CAD ON F.idcustomeraddress = CAD.idcustomeraddress
LEFT JOIN [PopulationCentre] PC ON CAD.idPopCentre = PC.idPopCentre
WHERE T.t8 IN ('04','08','NR','19')

UNION ALL

-- SEPTIEMBRE
SELECT 
CAST(K.ka4 AS DATE) AS 'fecfac',
CONCAT(K.ka2,K.ka3) AS 'facnro',
K.ka2 AS 'tipfac',
K.ka24 AS 'ordped',
K.ka13 AS 'nitcli',
MC.cl3 AS 'nomcli',
C.ci2 AS 'ciupri',
ISNULL(CA.ca2, '') AS 'canal',
ISNULL(MC.cl13, '') AS 'codven',
ISNULL(v.ve2, '') AS 'nomven',
K.ka1 AS 'codart',
MA.in2 AS 'nomart',
MA.in3 'presart',
MA.innc AS 'nomcomart',
MA.invi AS 'inviart',
MA.incum AS 'cumart',
MA.in19 AS 'codbarart',
MA.in12 AS 'embart',
(K.ka5s-K.ka5e) 'cajart',
'vlrtotbrt'= CASE 
    WHEN T.t8 IN ('04','19') THEN CASE  
        WHEN F.IsSubsidised=1 THEN 0 
        ELSE(K.ka12 - K.ka11) END ELSE CASE 
            WHEN F.IsSubsidised=1 THEN 0 
            ELSE (K.ka12 - K.ka11 )*-1 END END, 
K.kalote AS 'lotart',
F.FACAJ AS 'cajdes',
PC.nmPopCentre AS 'ciuent',
PC.cdCity AS 'codciuent'
from [ka010925] K WITH(NOLOCK) 
INNER JOIN [iA125] MA WITH(NOLOCK) ON K.ka1 = MA.in1 
INNER JOIN [tipo] T WITH(NOLOCK) ON K.ka2 = T.t1 
LEFT JOIN [clie] MC WITH(NOLOCK) ON K.ka13 = MC.cl1 
LEFT JOIN nits2 N2 WITH(NOLOCK) ON K.kaprov = ced 
LEFT JOIN [ciud] C WITH(NOLOCK) ON MC.cl36 = C.ci1  
LEFT JOIN [facc] F (nolock) ON K.ka2 = F.fa3 AND K.ka3 = F.fa2  
LEFT JOIN [vend] V ON MC.cl13 = V.ve4 
LEFT JOIN [nits] N ON K.ka13 = N.n1
LEFT JOIN [cana] CA ON cl18a = CA.ca1
LEFT JOIN [CustomerAddress] CAD ON F.idcustomeraddress = CAD.idcustomeraddress
LEFT JOIN [PopulationCentre] PC ON CAD.idPopCentre = PC.idPopCentre
WHERE T.t8 IN ('04','08','NR','19')

UNION ALL

-- OCTUBRE
SELECT 
CAST(K.ka4 AS DATE) AS 'fecfac',
CONCAT(K.ka2,K.ka3) AS 'facnro',
K.ka2 AS 'tipfac',
K.ka24 AS 'ordped',
K.ka13 AS 'nitcli',
MC.cl3 AS 'nomcli',
C.ci2 AS 'ciupri',
ISNULL(CA.ca2, '') AS 'canal',
ISNULL(MC.cl13, '') AS 'codven',
ISNULL(v.ve2, '') AS 'nomven',
K.ka1 AS 'codart',
MA.in2 AS 'nomart',
MA.in3 'presart',
MA.innc AS 'nomcomart',
MA.invi AS 'inviart',
MA.incum AS 'cumart',
MA.in19 AS 'codbarart',
MA.in12 AS 'embart',
(K.ka5s-K.ka5e) 'cajart',
'vlrtotbrt'= CASE 
    WHEN T.t8 IN ('04','19') THEN CASE  
        WHEN F.IsSubsidised=1 THEN 0 
        ELSE(K.ka12 - K.ka11) END ELSE CASE 
            WHEN F.IsSubsidised=1 THEN 0 
            ELSE (K.ka12 - K.ka11 )*-1 END END, 
K.kalote AS 'lotart',
F.FACAJ AS 'cajdes',
PC.nmPopCentre AS 'ciuent',
PC.cdCity AS 'codciuent'
from [ka011025] K WITH(NOLOCK) 
INNER JOIN [iA125] MA WITH(NOLOCK) ON K.ka1 = MA.in1 
INNER JOIN [tipo] T WITH(NOLOCK) ON K.ka2 = T.t1 
LEFT JOIN [clie] MC WITH(NOLOCK) ON K.ka13 = MC.cl1 
LEFT JOIN nits2 N2 WITH(NOLOCK) ON K.kaprov = ced 
LEFT JOIN [ciud] C WITH(NOLOCK) ON MC.cl36 = C.ci1  
LEFT JOIN [facc] F (nolock) ON K.ka2 = F.fa3 AND K.ka3 = F.fa2  
LEFT JOIN [vend] V ON MC.cl13 = V.ve4 
LEFT JOIN [nits] N ON K.ka13 = N.n1
LEFT JOIN [cana] CA ON cl18a = CA.ca1
LEFT JOIN [CustomerAddress] CAD ON F.idcustomeraddress = CAD.idcustomeraddress
LEFT JOIN [PopulationCentre] PC ON CAD.idPopCentre = PC.idPopCentre
WHERE T.t8 IN ('04','08','NR','19')

UNION ALL

-- NOVIEMBRE
SELECT 
CAST(K.ka4 AS DATE) AS 'fecfac',
CONCAT(K.ka2,K.ka3) AS 'facnro',
K.ka2 AS 'tipfac',
K.ka24 AS 'ordped',
K.ka13 AS 'nitcli',
MC.cl3 AS 'nomcli',
C.ci2 AS 'ciupri',
ISNULL(CA.ca2, '') AS 'canal',
ISNULL(MC.cl13, '') AS 'codven',
ISNULL(v.ve2, '') AS 'nomven',
K.ka1 AS 'codart',
MA.in2 AS 'nomart',
MA.in3 'presart',
MA.innc AS 'nomcomart',
MA.invi AS 'inviart',
MA.incum AS 'cumart',
MA.in19 AS 'codbarart',
MA.in12 AS 'embart',
(K.ka5s-K.ka5e) 'cajart',
'vlrtotbrt'= CASE 
    WHEN T.t8 IN ('04','19') THEN CASE  
        WHEN F.IsSubsidised=1 THEN 0 
        ELSE(K.ka12 - K.ka11) END ELSE CASE 
            WHEN F.IsSubsidised=1 THEN 0 
            ELSE (K.ka12 - K.ka11 )*-1 END END, 
K.kalote AS 'lotart',
F.FACAJ AS 'cajdes',
PC.nmPopCentre AS 'ciuent',
PC.cdCity AS 'codciuent'
from [ka011125] K WITH(NOLOCK) 
INNER JOIN [iA125] MA WITH(NOLOCK) ON K.ka1 = MA.in1 
INNER JOIN [tipo] T WITH(NOLOCK) ON K.ka2 = T.t1 
LEFT JOIN [clie] MC WITH(NOLOCK) ON K.ka13 = MC.cl1 
LEFT JOIN nits2 N2 WITH(NOLOCK) ON K.kaprov = ced 
LEFT JOIN [ciud] C WITH(NOLOCK) ON MC.cl36 = C.ci1  
LEFT JOIN [facc] F (nolock) ON K.ka2 = F.fa3 AND K.ka3 = F.fa2  
LEFT JOIN [vend] V ON MC.cl13 = V.ve4 
LEFT JOIN [nits] N ON K.ka13 = N.n1
LEFT JOIN [cana] CA ON cl18a = CA.ca1
LEFT JOIN [CustomerAddress] CAD ON F.idcustomeraddress = CAD.idcustomeraddress
LEFT JOIN [PopulationCentre] PC ON CAD.idPopCentre = PC.idPopCentre
WHERE T.t8 IN ('04','08','NR','19')

UNION ALL

--DICIEMBRE
SELECT 
CAST(K.ka4 AS DATE) AS 'fecfac',
CONCAT(K.ka2,K.ka3) AS 'facnro',
K.ka2 AS 'tipfac',
K.ka24 AS 'ordped',
K.ka13 AS 'nitcli',
MC.cl3 AS 'nomcli',
C.ci2 AS 'ciupri',
ISNULL(CA.ca2, '') AS 'canal',
ISNULL(MC.cl13, '') AS 'codven',
ISNULL(v.ve2, '') AS 'nomven',
K.ka1 AS 'codart',
MA.in2 AS 'nomart',
MA.in3 'presart',
MA.innc AS 'nomcomart',
MA.invi AS 'inviart',
MA.incum AS 'cumart',
MA.in19 AS 'codbarart',
MA.in12 AS 'embart',
(K.ka5s-K.ka5e) 'cajart',
'vlrtotbrt'= CASE 
    WHEN T.t8 IN ('04','19') THEN CASE  
        WHEN F.IsSubsidised=1 THEN 0 
        ELSE(K.ka12 - K.ka11) END ELSE CASE 
            WHEN F.IsSubsidised=1 THEN 0 
            ELSE (K.ka12 - K.ka11 )*-1 END END, 
K.kalote AS 'lotart',
F.FACAJ AS 'cajdes',
PC.nmPopCentre AS 'ciuent',
PC.cdCity AS 'codciuent'
from [ka011225] K WITH(NOLOCK) 
INNER JOIN [iA125] MA WITH(NOLOCK) ON K.ka1 = MA.in1 
INNER JOIN [tipo] T WITH(NOLOCK) ON K.ka2 = T.t1 
LEFT JOIN [clie] MC WITH(NOLOCK) ON K.ka13 = MC.cl1 
LEFT JOIN nits2 N2 WITH(NOLOCK) ON K.kaprov = ced 
LEFT JOIN [ciud] C WITH(NOLOCK) ON MC.cl36 = C.ci1  
LEFT JOIN [facc] F (nolock) ON K.ka2 = F.fa3 AND K.ka3 = F.fa2  
LEFT JOIN [vend] V ON MC.cl13 = V.ve4 
LEFT JOIN [nits] N ON K.ka13 = N.n1
LEFT JOIN [cana] CA ON cl18a = CA.ca1
LEFT JOIN [CustomerAddress] CAD ON F.idcustomeraddress = CAD.idcustomeraddress
LEFT JOIN [PopulationCentre] PC ON CAD.idPopCentre = PC.idPopCentre
WHERE T.t8 IN ('04','08','NR','19')

-- CREATE TABLE FACTURACION WIN

USE BD_RAMEDICAS_SAS;

CREATE TABLE rmd_trafac_win (
    fecfac DATETIME NULL,
    facnro VARCHAR(30) NOT NULL,
    tipfac VARCHAR(3) NULL,
    ordped VARCHAR(30) NULL,
    nitcli VARCHAR(40) NULL,
    nomcli VARCHAR(180) NULL,
    ciupri VARCHAR(40) NULL,
    canal VARCHAR(30) NULL,
    codven VARCHAR(3) NULL,
    nomven VARCHAR(80) NULL,
    codart VARCHAR(7) NULL,
    nomart VARCHAR(180) NULL,
    presart VARCHAR(80) NULL,
    nomcomart VARCHAR(80) NULL,
    inviart VARCHAR(60) NULL,
    cumart VARCHAR(40) NULL,
    codbarart VARCHAR(40) NULL,
    embart INT NULL,
    cajart INT NULL,
    vlrtotbrt NUMERIC(18,2) NULL,
    lotart VARCHAR(20) NULL,
    cajdes INT NULL,
    ciuent VARCHAR(40) NULL
)