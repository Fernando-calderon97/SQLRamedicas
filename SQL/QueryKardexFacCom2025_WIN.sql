DELETE TABLE [BD_RAMEDICAS_SAS].[dbo].[rmd_tracomwin]
INSERT INTO [BD_RAMEDICAS_SAS].[dbo].[rmd_tracomwin]
SELECT 
CAST(K.ka4 AS DATE) AS 'facfec',
F.fa1 AS 'nit',
CONCAT(K.Ka2,K.ka3) AS 'facnro',
K.ka1 'artcod',
CAST(K.kaemb AS INT) 'emb',
CASE 
    WHEN K.ka2 = 'DC' THEN CAST((K.ka5s *-1) AS INT) 
    ELSE CAST(K.ka5e AS INT) END AS 'und',
CAST(K.ka7 AS NUMERIC(18,2)) AS 'preund',
CAST(K.ka7c AS NUMERIC(18,2))AS 'prepres',
CASE
    WHEN K.ka2 = 'DC' THEN CAST((K.vreal * -1) AS NUMERIC(18,2))
    ELSE CAST(K.vreal AS NUMERIC(18,2)) END AS 'vlr',
CAST(K.ka14 AS VARCHAR(30)) AS 'bod',
K.kalote,
CAST(K.kafv AS DATE) AS 'feclotven'
FROM [BD_RAMEDICAS_SAS].[dbo].ka010125 K
LEFT JOIN [BD_RAMEDICAS_SAS].[dbo].FACP F ON F.Fa3b = K.ka2 AND F.Fa2b = K.ka3
WHERE K.ka2 IN ('FC', 'DC') 

UNION ALL

-- FEBRERO
SELECT 
CAST(K.ka4 AS DATE) AS 'facfec',
F.fa1 AS 'nit',
CONCAT(K.Ka2,K.ka3) AS 'facnro',
K.ka1 'artcod',
CAST(K.kaemb AS INT) 'emb',
CASE 
    WHEN K.ka2 = 'DC' THEN CAST((K.ka5s *-1) AS INT) 
    ELSE CAST(K.ka5e AS INT) END AS 'und',
CAST(K.ka7 AS NUMERIC(18,2)) AS 'preund',
CAST(K.ka7c AS NUMERIC(18,2))AS 'prepres',
CASE
    WHEN K.ka2 = 'DC' THEN CAST((K.vreal * -1) AS NUMERIC(18,2))
    ELSE CAST(K.vreal AS NUMERIC(18,2)) END AS 'vlr',
CAST(K.ka14 AS VARCHAR(30)) AS 'bod',
K.kalote,
CAST(K.kafv AS DATE) AS 'feclotven'
FROM [BD_RAMEDICAS_SAS].[dbo].ka010225 K
INNER JOIN [BD_RAMEDICAS_SAS].[dbo].FACP F ON F.Fa3b = K.ka2 AND F.Fa2b = K.ka3
WHERE K.ka2 IN ('FC', 'DC') 

UNION ALL

-- MARZO
SELECT 
CAST(K.ka4 AS DATE) AS 'facfec',
F.fa1 AS 'nit',
CONCAT(K.Ka2,K.ka3) AS 'facnro',
K.ka1 'artcod',
CAST(K.kaemb AS INT) 'emb',
CASE 
    WHEN K.ka2 = 'DC' THEN CAST((K.ka5s *-1) AS INT) 
    ELSE CAST(K.ka5e AS INT) END AS 'und',
CAST(K.ka7 AS NUMERIC(18,2)) AS 'preund',
CAST(K.ka7c AS NUMERIC(18,2))AS 'prepres',
CASE
    WHEN K.ka2 = 'DC' THEN CAST((K.vreal * -1) AS NUMERIC(18,2))
    ELSE CAST(K.vreal AS NUMERIC(18,2)) END AS 'vlr',
CAST(K.ka14 AS VARCHAR(30)) AS 'bod',
K.kalote,
CAST(K.kafv AS DATE) AS 'feclotven'
FROM [BD_RAMEDICAS_SAS].[dbo].ka010325 K
INNER JOIN [BD_RAMEDICAS_SAS].[dbo].FACP F ON F.Fa3b = K.ka2 AND F.Fa2b = K.ka3
WHERE K.ka2 IN ('FC', 'DC') 

UNION ALL

-- ABRIL
SELECT 
CAST(K.ka4 AS DATE) AS 'facfec',
F.fa1 AS 'nit',
CONCAT(K.Ka2,K.ka3) AS 'facnro',
K.ka1 'artcod',
CAST(K.kaemb AS INT) 'emb',
CASE 
    WHEN K.ka2 = 'DC' THEN CAST((K.ka5s *-1) AS INT) 
    ELSE CAST(K.ka5e AS INT) END AS 'und',
CAST(K.ka7 AS NUMERIC(18,2)) AS 'preund',
CAST(K.ka7c AS NUMERIC(18,2))AS 'prepres',
CASE
    WHEN K.ka2 = 'DC' THEN CAST((K.vreal * -1) AS NUMERIC(18,2))
    ELSE CAST(K.vreal AS NUMERIC(18,2)) END AS 'vlr',
CAST(K.ka14 AS VARCHAR(30)) AS 'bod',
K.kalote,
CAST(K.kafv AS DATE) AS 'feclotven'
FROM [BD_RAMEDICAS_SAS].[dbo].ka010425 K
INNER JOIN [BD_RAMEDICAS_SAS].[dbo].FACP F ON F.Fa3b = K.ka2 AND F.Fa2b = K.ka3
WHERE K.ka2 IN ('FC', 'DC') 

UNION ALL

-- MAYO
SELECT 
CAST(K.ka4 AS DATE) AS 'facfec',
F.fa1 AS 'nit',
CONCAT(K.Ka2,K.ka3) AS 'facnro',
K.ka1 'artcod',
CAST(K.kaemb AS INT) 'emb',
CASE 
    WHEN K.ka2 = 'DC' THEN CAST((K.ka5s *-1) AS INT) 
    ELSE CAST(K.ka5e AS INT) END AS 'und',
CAST(K.ka7 AS NUMERIC(18,2)) AS 'preund',
CAST(K.ka7c AS NUMERIC(18,2))AS 'prepres',
CASE
    WHEN K.ka2 = 'DC' THEN CAST((K.vreal * -1) AS NUMERIC(18,2))
    ELSE CAST(K.vreal AS NUMERIC(18,2)) END AS 'vlr',
CAST(K.ka14 AS VARCHAR(30)) AS 'bod',
K.kalote,
CAST(K.kafv AS DATE) AS 'feclotven'
FROM [BD_RAMEDICAS_SAS].[dbo].ka010525 K
INNER JOIN [BD_RAMEDICAS_SAS].[dbo].FACP F ON F.Fa3b = K.ka2 AND F.Fa2b = K.ka3
WHERE K.ka2 IN ('FC', 'DC') 

UNION ALL

-- JUNO
SELECT 
CAST(K.ka4 AS DATE) AS 'facfec',
F.fa1 AS 'nit',
CONCAT(K.Ka2,K.ka3) AS 'facnro',
K.ka1 'artcod',
CAST(K.kaemb AS INT) 'emb',
CASE 
    WHEN K.ka2 = 'DC' THEN CAST((K.ka5s *-1) AS INT) 
    ELSE CAST(K.ka5e AS INT) END AS 'und',
CAST(K.ka7 AS NUMERIC(18,2)) AS 'preund',
CAST(K.ka7c AS NUMERIC(18,2))AS 'prepres',
CASE
    WHEN K.ka2 = 'DC' THEN CAST((K.vreal * -1) AS NUMERIC(18,2))
    ELSE CAST(K.vreal AS NUMERIC(18,2)) END AS 'vlr',
CAST(K.ka14 AS VARCHAR(30)) AS 'bod',
K.kalote,
CAST(K.kafv AS DATE) AS 'feclotven'
FROM [BD_RAMEDICAS_SAS].[dbo].ka010625 K
INNER JOIN [BD_RAMEDICAS_SAS].[dbo].FACP F ON F.Fa3b = K.ka2 AND F.Fa2b = K.ka3
WHERE K.ka2 IN ('FC', 'DC') 

UNION ALL

-- JULIO
SELECT 
CAST(K.ka4 AS DATE) AS 'facfec',
F.fa1 AS 'nit',
CONCAT(K.Ka2,K.ka3) AS 'facnro',
K.ka1 'artcod',
CAST(K.kaemb AS INT) 'emb',
CASE 
    WHEN K.ka2 = 'DC' THEN CAST((K.ka5s *-1) AS INT) 
    ELSE CAST(K.ka5e AS INT) END AS 'und',
CAST(K.ka7 AS NUMERIC(18,2)) AS 'preund',
CAST(K.ka7c AS NUMERIC(18,2))AS 'prepres',
CASE
    WHEN K.ka2 = 'DC' THEN CAST((K.vreal * -1) AS NUMERIC(18,2))
    ELSE CAST(K.vreal AS NUMERIC(18,2)) END AS 'vlr',
CAST(K.ka14 AS VARCHAR(30)) AS 'bod',
K.kalote,
CAST(K.kafv AS DATE) AS 'feclotven'
FROM [BD_RAMEDICAS_SAS].[dbo].ka010725 K
INNER JOIN [BD_RAMEDICAS_SAS].[dbo].FACP F ON F.Fa3b = K.ka2 AND F.Fa2b = K.ka3
WHERE K.ka2 IN ('FC', 'DC') 

UNION ALL

-- AGOSTO
SELECT 
CAST(K.ka4 AS DATE) AS 'facfec',
F.fa1 AS 'nit',
CONCAT(K.Ka2,K.ka3) AS 'facnro',
K.ka1 'artcod',
CAST(K.kaemb AS INT) 'emb',
CASE 
    WHEN K.ka2 = 'DC' THEN CAST((K.ka5s *-1) AS INT) 
    ELSE CAST(K.ka5e AS INT) END AS 'und',
CAST(K.ka7 AS NUMERIC(18,2)) AS 'preund',
CAST(K.ka7c AS NUMERIC(18,2))AS 'prepres',
CASE
    WHEN K.ka2 = 'DC' THEN CAST((K.vreal * -1) AS NUMERIC(18,2))
    ELSE CAST(K.vreal AS NUMERIC(18,2)) END AS 'vlr',
CAST(K.ka14 AS VARCHAR(30)) AS 'bod',
K.kalote,
CAST(K.kafv AS DATE) AS 'feclotven'
FROM [BD_RAMEDICAS_SAS].[dbo].ka010825 K
INNER JOIN [BD_RAMEDICAS_SAS].[dbo].FACP F ON F.Fa3b = K.ka2 AND F.Fa2b = K.ka3
WHERE K.ka2 IN ('FC', 'DC') 

UNION ALL

-- SEPTIEMBRE
SELECT 
CAST(K.ka4 AS DATE) AS 'facfec',
F.fa1 AS 'nit',
CONCAT(K.Ka2,K.ka3) AS 'facnro',
K.ka1 'artcod',
CAST(K.kaemb AS INT) 'emb',
CASE 
    WHEN K.ka2 = 'DC' THEN CAST((K.ka5s *-1) AS INT) 
    ELSE CAST(K.ka5e AS INT) END AS 'und',
CAST(K.ka7 AS NUMERIC(18,2)) AS 'preund',
CAST(K.ka7c AS NUMERIC(18,2))AS 'prepres',
CASE
    WHEN K.ka2 = 'DC' THEN CAST((K.vreal * -1) AS NUMERIC(18,2))
    ELSE CAST(K.vreal AS NUMERIC(18,2)) END AS 'vlr',
CAST(K.ka14 AS VARCHAR(30)) AS 'bod',
K.kalote,
CAST(K.kafv AS DATE) AS 'feclotven'
FROM [BD_RAMEDICAS_SAS].[dbo].ka010925 K
INNER JOIN [BD_RAMEDICAS_SAS].[dbo].FACP F ON F.Fa3b = K.ka2 AND F.Fa2b = K.ka3
WHERE K.ka2 IN ('FC', 'DC') 

UNION ALL

-- OCTUBRE
SELECT 
CAST(K.ka4 AS DATE) AS 'facfec',
F.fa1 AS 'nit',
CONCAT(K.Ka2,K.ka3) AS 'facnro',
K.ka1 'artcod',
CAST(K.kaemb AS INT) 'emb',
CASE 
    WHEN K.ka2 = 'DC' THEN CAST((K.ka5s *-1) AS INT) 
    ELSE CAST(K.ka5e AS INT) END AS 'und',
CAST(K.ka7 AS NUMERIC(18,2)) AS 'preund',
CAST(K.ka7c AS NUMERIC(18,2))AS 'prepres',
CASE
    WHEN K.ka2 = 'DC' THEN CAST((K.vreal * -1) AS NUMERIC(18,2))
    ELSE CAST(K.vreal AS NUMERIC(18,2)) END AS 'vlr',
CAST(K.ka14 AS VARCHAR(30)) AS 'bod',
K.kalote,
CAST(K.kafv AS DATE) AS 'feclotven'
FROM [BD_RAMEDICAS_SAS].[dbo].ka011025 K
INNER JOIN [BD_RAMEDICAS_SAS].[dbo].FACP F ON F.Fa3b = K.ka2 AND F.Fa2b = K.ka3
WHERE K.ka2 IN ('FC', 'DC') 

UNION ALL

-- NOVIEMBRE
SELECT 
CAST(K.ka4 AS DATE) AS 'facfec',
F.fa1 AS 'nit',
CONCAT(K.Ka2,K.ka3) AS 'facnro',
K.ka1 'artcod',
CAST(K.kaemb AS INT) 'emb',
CASE 
    WHEN K.ka2 = 'DC' THEN CAST((K.ka5s *-1) AS INT) 
    ELSE CAST(K.ka5e AS INT) END AS 'und',
CAST(K.ka7 AS NUMERIC(18,2)) AS 'preund',
CAST(K.ka7c AS NUMERIC(18,2))AS 'prepres',
CASE
    WHEN K.ka2 = 'DC' THEN CAST((K.vreal * -1) AS NUMERIC(18,2))
    ELSE CAST(K.vreal AS NUMERIC(18,2)) END AS 'vlr',
CAST(K.ka14 AS VARCHAR(30)) AS 'bod',
K.kalote,
CAST(K.kafv AS DATE) AS 'feclotven'
FROM [BD_RAMEDICAS_SAS].[dbo].ka011125 K
INNER JOIN [BD_RAMEDICAS_SAS].[dbo].FACP F ON F.Fa3b = K.ka2 AND F.Fa2b = K.ka3
WHERE K.ka2 IN ('FC', 'DC') 

UNION ALL

-- DICIEMBRE
SELECT 
CAST(K.ka4 AS DATE) AS 'facfec',
F.fa1 AS 'nit',
CONCAT(K.Ka2,K.ka3) AS 'facnro',
K.ka1 'artcod',
CAST(K.kaemb AS INT) 'emb',
CASE 
    WHEN K.ka2 = 'DC' THEN CAST((K.ka5s *-1) AS INT) 
    ELSE CAST(K.ka5e AS INT) END AS 'und',
CAST(K.ka7 AS NUMERIC(18,2)) AS 'preund',
CAST(K.ka7c AS NUMERIC(18,2))AS 'prepres',
CASE
    WHEN K.ka2 = 'DC' THEN CAST((K.vreal * -1) AS NUMERIC(18,2))
    ELSE CAST(K.vreal AS NUMERIC(18,2)) END AS 'vlr',
CAST(K.ka14 AS VARCHAR(30)) AS 'bod',
K.kalote,
CAST(K.kafv AS DATE) AS 'feclotven'
FROM [BD_RAMEDICAS_SAS].[dbo].ka011225 K
INNER JOIN [BD_RAMEDICAS_SAS].[dbo].FACP F ON F.Fa3b = K.ka2 AND F.Fa2b = K.ka3
WHERE K.ka2 IN ('FC', 'DC') 
