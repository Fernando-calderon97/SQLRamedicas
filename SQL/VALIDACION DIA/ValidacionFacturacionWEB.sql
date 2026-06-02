
--- FACTURACION WEB 

use Ramedicas;
SELECT
COUNT(*) as 'Documentos',
CAST(SUM(VlrNTC) as numeric(20,2)) as 'Valor en NTC',
CAST(SUM(VlrCM) as numeric(20,2)) as 'Valor en CM',
CAST(SUM(Saldo) as numeric(20,2)) as 'Saldo'
--DISTINCT(Cliente)
FROM
(
SELECT 
--T1.[FacSec],
--T1.[FacDocCom],
T1.[FacNro] AS 'Documento',
--T1.[FacTipCod] AS FacTipCod,----------------------------------------------------------Prefijo De Factura
CAST(T1.[FacFec] AS DATE) AS Fecha, 
--T9.[NitIde] AS 'Nit/C.C',
--T1.[FacUsuAnu],
--T10.[CliNom] AS Cliente, 
--T9.[NitCom] AS 'Raz�n Social', 

/* Ciudad Codigo y Nombre____ */
--T10.[CliCiuCod] AS CodCiudad, 
--T11.[CiuNom] AS Ciudad, 

/* Nombre vendedor Ramedicas */
--T7.[VenNom] AS Vendedor,                                                   

--0 AS 'Valor Base (Rte Fuente - Rteica)',
--0 AS 'Iva 5%',
--0 AS 'Iva 16%',
--0 AS 'Iva 19%',

--CAST(COALESCE( T12.[FacValBasIva], 0) as numeric(18,2)) AS 'BASE RTE.IVA',
--CAST(COALESCE( T13.[FacValBasIca], 0) as numeric(18,2)) AS 'BASE RTE.ICA',

--0 AS Retefuente,
--0 AS Reteica,
--0 AS Reteiva,

/* SUB SELECT para traer la NTC */
(
    SELECT 
    STRING_AGG(T22.[FacNro], ', ')
    FROM [FACTURA] T22
    WHERE T22.[FacSecDev] = T1.[FacSec] and T22.[FacEst] = 'A' /*AND T22.FacFec <= '20251231'*/
) AS 'NOTAS CREDITO',
CAST((
    SELECT 
    SUM(K21.karvaltotMenDes) + SUM([KarArtIva])
    FROM [FACTURA] T22
    INNER JOIN KARDEX K21 ON K21.FacSec = T22.FacSec
    WHERE T22.[FacSecDev] = T1.[FacSec] and T22.[FacEst] = 'A' /*AND T22.FacFec <= '20251231'*/
)AS NUMERIC(18,2)) AS 'VlrNTC',
(
    SELECT 
    STRING_AGG(T22.[FacCufe], ', ')
    FROM [FACTURA] T22
    WHERE T22.[FacSecDev] = T1.[FacSec] and T22.[FacEst] = 'A'/* AND T22.FacFec <= '20251231'*/
) AS 'Cufe NTC',
(
    SELECT 
    STRING_AGG(T22.[FacFecTra], ', ')
    FROM [FACTURA] T22
    WHERE T22.[FacSecDev] = T1.[FacSec] and T22.[FacEst] = 'A' /*AND T22.FacFec <= '20251231'*/
) AS 'Fec Cufe NTC',

CAST(
    COALESCE(
    (
        SELECT
        SUM([karvaltotMenDes]) AS FacTotal 
        FROM [KARDEX] K1
        WHERE K1.FACSEC in (select facsec from factura st1 where st1.facest = 'A' AND st1.facsecdev in (SELECT TOP 1 ST2.[FacSec] FROM FACTURA ST2 WHERE ST2.FacEst = 'A' AND T1.[FacDocCom] = ST2.[FacDocCom]  AND ST2.[FacTipTra] = 'REV'))
    ),0
)AS NUMERIC(18,2)) +
CAST(
    COALESCE(
    (
        SELECT
        SUM([karvaltotMenDes]) AS FacTotal 
        FROM [KARDEX] K
        WHERE K.Facsec in (select F2.FacSec from FACTURA F2 where F2.FacEst = 'A' AND F2.FacSecDev in (SELECT F3.[FacSec] FROM FACTURA F3 WHERE F3.[FacEscPac] = T1.[FacNro] AND F3.FacEst ='A'))
    ),0
)AS NUMERIC(18,2)) -
--- Resta del valor de NTC de las Cuotas Moderadoras
CAST(
    COALESCE(
        (
            SELECT
            SUM([karvaltotMenDes]) AS FacTotal 
            FROM [KARDEX] K
            WHERE K.Facsec in (select F6.FacSec from FACTURA F6 where F6.FacEst = 'A' AND F6.FacSecDev in (select F2.FacSec from FACTURA F2 where F2.FacEst = 'A' AND F2.FacSecDev in (SELECT F3.[FacSec] FROM FACTURA F3 WHERE F3.[FacEscPac] = T1.[FacNro])))
        ),0
)AS NUMERIC(18,2)) as 'VlrCM',




CAST(COALESCE( T12.[FacTotal], 0) AS NUMERIC(18,2)) AS Total,
CAST((CAST(COALESCE(T12.FacTotal, 0) AS NUMERIC(18,2)) - 
(
    COALESCE(
        (
            SELECT
            SUM([karvaltotMenDes]) AS FacTotal 
            FROM [KARDEX] K1
            WHERE K1.FACSEC in (select facsec from factura st1 where st1.facsecdev in (SELECT TOP 1 ST2.[FacSec] FROM FACTURA ST2 WHERE T1.[FacDocCom] = ST2.[FacDocCom]  AND ST2.[FacTipTra] = 'REV'))
        ),0
    ) +
    COALESCE(
        (
            SELECT
            SUM([karvaltotMenDes]) AS FacTotal 
            FROM [KARDEX] K
            WHERE K.Facsec in (select F2.FacSec from FACTURA F2 where F2.FacSecDev in (SELECT F3.[FacSec] FROM FACTURA F3 WHERE F3.[FacEscPac] = T1.[FacNro]))
        ),0
    ) -
    COALESCE(
        (
            SELECT
            SUM([karvaltotMenDes]) AS FacTotal 
            FROM [KARDEX] K
            WHERE K.Facsec in (select F6.FacSec from FACTURA F6 where F6.FacSecDev in (select F2.FacSec from FACTURA F2 where F2.FacSecDev in (SELECT F3.[FacSec] FROM FACTURA F3 WHERE F3.[FacEscPac] = T1.[FacNro])))
        ),0
    )
)   -
COALESCE(
    (
        SELECT 
        SUM(K21.karvaltotMenDes)
        FROM [FACTURA] T22
        INNER JOIN KARDEX K21 ON K21.FacSec = T22.FacSec
        WHERE T22.[FacSecDev] = T1.[FacSec] and T22.[FacEst] = 'A' /*AND T22.FacFec <= '20251231'*/
    ),0
)
- CAST(COALESCE( T12.[FacValBasIva], 0) as numeric(18,2))
)AS NUMERIC(18,2)) AS Saldo,
T1.[FacEst] AS Estado, 
T1.[FacUsuAnu] AS 'Usuario Anulacion',
CAST(T1.[FacFecAnu] AS DATE) AS 'Fecha Anulacion',
T1.[BodSucCCSec] AS 'Id Bodega Origen', 
T5.[BodSucCCNom] AS 'Nombre Bodega Origen',
T1.[FacFecTra] AS 'Fecha de Creacion',
MCM.[ModConMedNom] AS 'Modalidad Factura',
T1.[FacCufe],
T1.FacFecTra
FROM 
(
    (
        (   
            (
                (
                    (
                        (
                            (
                                (
                                    (
                                        (
                                            (             
                                                (
                                                    (
                                                        [FACTURA] T1 WITH (NOLOCK) 
                                                    LEFT JOIN [CIUDAD] T2 WITH (NOLOCK) ON T2.[CiuCod] = T1.[FacProCiuCod])
                                                LEFT JOIN [MODALIDADCONTRATOMED] MCM WITH (NOLOCK) ON MCM.[ModConMedSec] = T1.[FacModConMed])
                                            LEFT JOIN [TIPOS] T3 WITH (NOLOCK) ON T3.[TipCod] = T1.[FacTipCod]) 
                                        LEFT JOIN [SUCURSALES] T4 WITH (NOLOCK) ON T4.[SucCod] = T3.[TipSucCod]) 
                                    LEFT JOIN [BODEGASUCURSALCC] T5 WITH (NOLOCK) ON T5.[BodSucCCSec] = T1.[BodSucCCSec]) 
                                LEFT JOIN [CONENTSAL] T6 WITH (NOLOCK) ON T6.[ConEsCod] = T1.[ConEsCod]) 
                            LEFT JOIN [VENDEDORES] T7 WITH (NOLOCK) ON T7.[VenCod] = T1.[FacVenCod]) 
                        LEFT JOIN [TRANSPORTADORES] T8 WITH (NOLOCK) ON T8.[TranCod] = T1.[FacTranCod]) 
                    LEFT JOIN [NIT] T9 WITH (NOLOCK) ON T9.[NitSec] = T1.[FacNitSec]) 
                LEFT JOIN [CLIENTES] T10 WITH (NOLOCK) ON T10.[NitSec] = T1.[FacNitSec] AND T10.[CliSec] = T1.[FacCliSec]) 
            LEFT JOIN [CIUDAD] T11 WITH (NOLOCK) ON T11.[CiuCod] = T10.[CliCiuCod]) 
        LEFT JOIN (
            SELECT 
            [FacSec], 
            SUM(COALESCE( [KarArtValImp], 0) * CAST(( ( ( ( [KarCaj] * CAST([KarArtEmb] AS decimal( 19, 10))) + [KarUni]) * CAST([KarPreFacCon] AS 
            decimal( 25, 10)))) AS decimal( 28, 10))) AS FacArtValImp, 
            SUM([KarValAiu]) AS FacSumValAIU, 
            SUM([KarArtIva]) AS FacValBasIva, 
            SUM(ROUND(ROUND(( ( ( [KarCaj] * CAST([KarArtEmb] AS decimal( 19, 10))) + [KarUni]) * CAST([KarPre] AS 
            decimal( 28, 10))), 0) + ( ( ( [KarCaj] * CAST([KarArtEmb] AS decimal( 19, 10))) + [KarUni]) * CAST([KarDesVal] AS 
            decimal( 28, 10))) - ROUND(( ( ( ( [KarCaj] * CAST([KarArtEmb] AS decimal( 19, 10))) + [KarUni]) * CAST([KarPre] AS 
            decimal( 28, 10))) * CAST(( 1 - ( CAST([KarDesUno] AS decimal( 16, 10)) / 100)) * CAST(( 1 - ( CAST([KarDesDos] AS 
            decimal( 16, 10)) / 100)) AS decimal( 11, 10)) * CAST(( 1 - ( CAST([KarDesTre] AS decimal( 16, 10)) / 100)) AS 
            decimal( 11, 10)) * CAST(( 1 - ( CAST([KarDesCua] AS decimal( 22, 10)) / 100)) AS decimal( 11, 10)) AS 
            decimal( 19, 10))), 0), 0)) AS FacValDesSubTot, 
            SUM([karvaltotMenDes]) AS fackarvaltotMenDesfor, 
            SUM([KarArtValImp]) AS FacImp, 
            SUM(ROUND(( ( ( [KarCaj] * CAST([KarArtEmb] AS decimal( 19, 10))) + [KarUni]) * CAST(COALESCE( [KarIvaMon], 0) AS 
            decimal( 28, 10))), 0)) AS FAcSumIvaMon, 
            /*SUM([KarSubTotal])*/ SUM([KarArtIva]) + SUM([karvaltotMenDes]) AS FacTotal 
            FROM [KARDEX] WITH (NOLOCK) 
            GROUP BY [FacSec] ) T12 ON T12.[FacSec] = T1.[FacSec])
    LEFT JOIN (
        SELECT 
        T15.[FacSec], 
        SUM(CASE  WHEN ( T16.[FacTipTra] = 'NCR' or T16.[FacTipTra] = 'REV' or T16.[FacTipTra] = 'FDV') and 
        COALESCE( T15.[KarDes], '') = 'F' THEN ROUND(( ( T15.[KarUni] + ( T15.[KarCaj] * CAST(T15.[KarArtEmb] AS decimal( 19, 10)))) * CAST(T15.[KarPrePub] AS 
        decimal( 28, 10))), 0) WHEN ( T16.[FacTipTra] = 'REC' or T16.[FacTipTra] = 'NDB' or T16.[FacTipTra] = 'COM' or T16.[FacTipTra] = 'SAL' or 
        T16.[FacTipTra] = 'ENT' or T16.[FacTipTra] = 'DVP' or T16.[FacTipTra] = 'TRA' or T16.[FacTipTra] = 'AJT') and COALESCE( T15.[KarDes], '') = 'F' THEN 
        ROUND(( ( T15.[KarUni] + ( T15.[KarCaj] * CAST(T15.[KarArtEmb] AS decimal( 19, 10)))) * CAST(T15.[KarPre] AS decimal( 28, 10))), 0) END) AS FacValBasIca 
        FROM ([KARDEX] T15 WITH (NOLOCK) 
        INNER JOIN [FACTURA] T16 WITH (NOLOCK) ON T16.[FacSec] = T15.[FacSec]) 
        GROUP BY T15.[FacSec] ) T13 ON T13.[FacSec] = T1.[FacSec]) 
LEFT JOIN (
    SELECT 
    SUM(( COALESCE( [ComDevFacCos], 0) * CAST(COALESCE( [ConDevKarUni], 0) AS decimal( 28, 10))) + COALESCE( [ConDevValIva], 0)) AS ComDevSumCos, 
    [FacSec] 
    FROM [DEVOLUCIONCOMPRASDEVOLUCIONES] WITH (NOLOCK) 

    GROUP BY [FacSec] ) T14 ON T14.[FacSec] = T1.[FacSec]) 
WHERE T1.[FacEst] =  'A' and T1.[FacTipTra] = 'FDV' and T1.[FacFec] BETWEEN '20260201' and '20260211' and T9.[NitIde] = /*'830003564'*/'860066942'/*'805001157'*/ /*and T1.[FacNro] = 'FFE224'*/ /*and T1.[Factipcod] = 'FVA'*/ /*and MCM.[ModConMedNom] = 'CAPITA'*/
/*AND (
    SELECT 
    STRING_AGG(T22.[FacFecTra], ', ')
    FROM [FACTURA] T22
    WHERE T22.[FacSecDev] = T1.[FacSec] and T22.[FacEst] = 'A'
)  <> ''
AND (
    SELECT 
    TOP 1 T22.[FacFecTra]
    FROM [FACTURA] T22
    WHERE T22.[FacSecDev] = T1.[FacSec] and T22.[FacEst] = 'A'
) BETWEEN '20250101' and '20260131'*/
) as TotalSma


/*
SELECT 
CAST(facfec AS DATE) AS facfec,
facnro,
facest,
FacCufe
FROM factura
WHERE facnro IN ('NTC2504000010')

SELECT 
CAST(facfec AS DATE) AS facfec,
facnro,
facest,
FacCufe
FROM factura
WHERE facnro IN ('NTC2512001155','NTC2512001168', 'CAP195','CAP205')*/

-- SELECT * FROM FACTURA WHERE Factipcod = 'NTD' and FacFec BETWEEN '20260101' AND '20260201' 
-- SELECT * FROM TIPOS