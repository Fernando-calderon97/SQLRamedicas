
USE Ramedicas;
SELECT
COUNT(*) AS 'Documentos',
CAST(SUM(VlrNTC) AS NUMERIC(20,2)) AS 'Valor en NTC',
CAST(SUM(VlrCM) AS NUMERIC(20,2)) AS 'Valor en CM',
CAST(SUM(Saldo) AS NUMERIC(20,2)) AS 'Saldo'
FROM
(
SELECT 
T1.[FacNro] AS 'Documento',
CAST(T1.[FacFec] AS DATE) AS Fecha, 
/* SUB SELECT para traer la NTC */
(
    SELECT 
    STRING_AGG(T22.[FacNro], ', ')
    FROM [FACTURA] T22
    WHERE T22.[FacSecDev] = T1.[FacSec] AND T22.[FacEst] = 'A'
) AS 'NOTAS CREDITO',
CAST((
    SELECT 
    SUM(K21.karvaltotMenDes) + SUM([KarArtIva])
    FROM [FACTURA] T22
    INNER JOIN KARDEX K21 ON K21.FacSec = T22.FacSec
    WHERE T22.[FacSecDev] = T1.[FacSec] AND T22.[FacEst] = 'A'
)AS NUMERIC(18,2)) AS 'VlrNTC',
(
    SELECT 
    STRING_AGG(T22.[FacCufe], ', ')
    FROM [FACTURA] T22
    WHERE T22.[FacSecDev] = T1.[FacSec] AND T22.[FacEst] = 'A'
) AS 'Cufe NTC',
(
    SELECT 
    STRING_AGG(T22.[FacFecTra], ', ')
    FROM [FACTURA] T22
    WHERE T22.[FacSecDev] = T1.[FacSec] AND T22.[FacEst] = 'A'
) AS 'Fec Cufe NTC',

CAST(
    COALESCE(
    (
        SELECT
        SUM([karvaltotMenDes]) AS FacTotal 
        FROM [KARDEX] K1
        WHERE K1.FACSEC IN (SELECT facsec FROM factura st1 WHERE st1.facest = 'A' AND st1.facsecdev IN (SELECT TOP 1 ST2.[FacSec] FROM FACTURA ST2 WHERE ST2.FacEst = 'A' AND T1.[FacDocCom] = ST2.[FacDocCom]  AND ST2.[FacTipTra] = 'REV'))
    ),0
)AS NUMERIC(18,2)) +
CAST(
    COALESCE(
    (
        SELECT
        SUM([karvaltotMenDes]) AS FacTotal 
        FROM [KARDEX] K
        WHERE K.Facsec IN (SELECT F2.FacSec FROM FACTURA F2 WHERE F2.FacEst = 'A' AND F2.FacSecDev IN (SELECT F3.[FacSec] FROM FACTURA F3 WHERE F3.[FacEscPac] = T1.[FacNro] AND F3.FacEst ='A'))
    ),0
)AS NUMERIC(18,2)) -
--- Resta del valor de NTC de las Cuotas Moderadoras
CAST(
    COALESCE(
        (
            SELECT
            SUM([karvaltotMenDes]) AS FacTotal 
            FROM [KARDEX] K
            WHERE K.Facsec IN (SELECT F6.FacSec FROM FACTURA F6 WHERE F6.FacEst = 'A' AND F6.FacSecDev IN (SELECT F2.FacSec FROM FACTURA F2 WHERE F2.FacEst = 'A' AND F2.FacSecDev IN (SELECT F3.[FacSec] FROM FACTURA F3 WHERE F3.[FacEscPac] = T1.[FacNro])))
        ),0
)AS NUMERIC(18,2)) AS 'VlrCM',

CAST(COALESCE( T12.[FacTotal], 0) AS NUMERIC(18,2)) AS Total,
CAST(
        (
            CAST(COALESCE(T12.FacTotal, 0) AS NUMERIC(18,2)) - 
            (
                COALESCE(
                    (
                        SELECT
                        SUM([karvaltotMenDes]) AS FacTotal 
                        FROM [KARDEX] K1
                        WHERE K1.FACSEC IN (SELECT facsec FROM factura st1 WHERE st1.facsecdev IN (SELECT TOP 1 ST2.[FacSec] FROM FACTURA ST2 WHERE T1.[FacDocCom] = ST2.[FacDocCom]  AND ST2.[FacTipTra] = 'REV'))
                    ),0
                ) +
                COALESCE(
                    (
                        SELECT
                        SUM([karvaltotMenDes]) AS FacTotal 
                        FROM [KARDEX] K
                        WHERE K.Facsec IN (SELECT F2.FacSec FROM FACTURA F2 WHERE F2.FacSecDev IN (SELECT F3.[FacSec] FROM FACTURA F3 WHERE F3.[FacEscPac] = T1.[FacNro]))
                    ),0
                ) -
                COALESCE(
                    (
                        SELECT
                        SUM([karvaltotMenDes]) AS FacTotal 
                        FROM [KARDEX] K
                        WHERE K.Facsec IN (SELECT F6.FacSec FROM FACTURA F6 WHERE F6.FacSecDev IN (SELECT F2.FacSec FROM FACTURA F2 WHERE F2.FacSecDev IN (SELECT F3.[FacSec] FROM FACTURA F3 WHERE F3.[FacEscPac] = T1.[FacNro])))
                    ),0
                )
            ) -
            COALESCE(
                (
                    SELECT 
                    SUM(K21.karvaltotMenDes)
                    FROM [FACTURA] T22
                    INNER JOIN KARDEX K21 ON K21.FacSec = T22.FacSec
                    WHERE T22.[FacSecDev] = T1.[FacSec] AND T22.[FacEst] = 'A'
                ),0
            ) -
            CAST(COALESCE( T12.[FacValBasIva], 0) AS NUMERIC(18,2))-
            --- Resta del valor de NTC de las Cuotas Moderadoras
            CAST(
                COALESCE(
                    (
                        SELECT
                        SUM([karvaltotMenDes]) AS FacTotal 
                        FROM [KARDEX] K
                        WHERE K.Facsec IN (SELECT F6.FacSec FROM FACTURA F6 WHERE F6.FacEst = 'A' AND F6.FacSecDev IN (SELECT F2.FacSec FROM FACTURA F2 WHERE F2.FacEst = 'A' AND F2.FacSecDev IN (SELECT F3.[FacSec] FROM FACTURA F3 WHERE F3.[FacEscPac] = T1.[FacNro])))
                    ),0
            )AS NUMERIC(18,2))

        )AS NUMERIC(18,2)
) AS Saldo,
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
            SUM(COALESCE( [KarArtValImp], 0) * CAST(( ( ( ( [KarCaj] * CAST([KarArtEmb] AS DECIMAL( 19, 10))) + [KarUni]) * CAST([KarPreFacCon] AS 
            DECIMAL( 25, 10)))) AS DECIMAL( 28, 10))) AS FacArtValImp, 
            SUM([KarValAiu]) AS FacSumValAIU, 
            SUM([KarArtIva]) AS FacValBasIva, 
            SUM(ROUND(ROUND(( ( ( [KarCaj] * CAST([KarArtEmb] AS DECIMAL( 19, 10))) + [KarUni]) * CAST([KarPre] AS 
            DECIMAL( 28, 10))), 0) + ( ( ( [KarCaj] * CAST([KarArtEmb] AS DECIMAL( 19, 10))) + [KarUni]) * CAST([KarDesVal] AS 
            DECIMAL( 28, 10))) - ROUND(( ( ( ( [KarCaj] * CAST([KarArtEmb] AS DECIMAL( 19, 10))) + [KarUni]) * CAST([KarPre] AS 
            DECIMAL( 28, 10))) * CAST(( 1 - ( CAST([KarDesUno] AS DECIMAL( 16, 10)) / 100)) * CAST(( 1 - ( CAST([KarDesDos] AS 
            DECIMAL( 16, 10)) / 100)) AS DECIMAL( 11, 10)) * CAST(( 1 - ( CAST([KarDesTre] AS DECIMAL( 16, 10)) / 100)) AS 
            DECIMAL( 11, 10)) * CAST(( 1 - ( CAST([KarDesCua] AS DECIMAL( 22, 10)) / 100)) AS DECIMAL( 11, 10)) AS 
            DECIMAL( 19, 10))), 0), 0)) AS FacValDesSubTot, 
            SUM([karvaltotMenDes]) AS fackarvaltotMenDesfor, 
            SUM([KarArtValImp]) AS FacImp, 
            SUM(ROUND(( ( ( [KarCaj] * CAST([KarArtEmb] AS DECIMAL( 19, 10))) + [KarUni]) * CAST(COALESCE( [KarIvaMon], 0) AS 
            DECIMAL( 28, 10))), 0)) AS FAcSumIvaMon, 
            /*SUM([KarSubTotal])*/ SUM([KarArtIva]) + SUM([karvaltotMenDes]) AS FacTotal 
            FROM [KARDEX] WITH (NOLOCK) 
            GROUP BY [FacSec] ) T12 ON T12.[FacSec] = T1.[FacSec])
    LEFT JOIN (
        SELECT 
        T15.[FacSec], 
        SUM(CASE  WHEN ( T16.[FacTipTra] = 'NCR' OR T16.[FacTipTra] = 'REV' OR T16.[FacTipTra] = 'FDV') AND 
        COALESCE( T15.[KarDes], '') = 'F' THEN ROUND(( ( T15.[KarUni] + ( T15.[KarCaj] * CAST(T15.[KarArtEmb] AS DECIMAL( 19, 10)))) * CAST(T15.[KarPrePub] AS 
        DECIMAL( 28, 10))), 0) WHEN ( T16.[FacTipTra] = 'REC' OR T16.[FacTipTra] = 'NDB' OR T16.[FacTipTra] = 'COM' OR T16.[FacTipTra] = 'SAL' OR 
        T16.[FacTipTra] = 'ENT' OR T16.[FacTipTra] = 'DVP' OR T16.[FacTipTra] = 'TRA' OR T16.[FacTipTra] = 'AJT') AND COALESCE( T15.[KarDes], '') = 'F' THEN 
        ROUND(( ( T15.[KarUni] + ( T15.[KarCaj] * CAST(T15.[KarArtEmb] AS DECIMAL( 19, 10)))) * CAST(T15.[KarPre] AS DECIMAL( 28, 10))), 0) END) AS FacValBasIca 
        FROM ([KARDEX] T15 WITH (NOLOCK) 
        INNER JOIN [FACTURA] T16 WITH (NOLOCK) ON T16.[FacSec] = T15.[FacSec]) 
        GROUP BY T15.[FacSec] ) T13 ON T13.[FacSec] = T1.[FacSec]) 
LEFT JOIN (
    SELECT 
    SUM(( COALESCE( [ComDevFacCos], 0) * CAST(COALESCE( [ConDevKarUni], 0) AS DECIMAL( 28, 10))) + COALESCE( [ConDevValIva], 0)) AS ComDevSumCos, 
    [FacSec] 
    FROM [DEVOLUCIONCOMPRASDEVOLUCIONES] WITH (NOLOCK) 
    GROUP BY [FacSec] ) T14 ON T14.[FacSec] = T1.[FacSec]) 
WHERE T1.[FacEst] =  'A' AND T1.[FacTipTra] = 'FDV' /*AND T1.[FacFec] BETWEEN '20260201' AND '20260216'*/ /*AND T9.[NitIde] = '830003564''860066942''805001157'*/ AND T1.FacNro = 'CAP228'
) AS TotalSma


