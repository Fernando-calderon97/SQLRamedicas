
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
T1.[FacSec],
T1.[FacDocCom],
T1.[FacNro] AS 'Documento',
T1.[FacTipCod] AS FacTipCod,----------------------------------------------------------Prefijo De Factura
CAST(T1.[FacFec] AS DATE) AS Fecha, 
T9.[NitIde] AS 'Nit/C.C',
T1.[FacUsuAnu],
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

CAST(COALESCE( T12.[FacValBasIva], 0) as numeric(18,2)) AS 'BASE RTE.IVA',
--CAST(COALESCE( T13.[FacValBasIca], 0) as numeric(18,2)) AS 'BASE RTE.ICA',

--0 AS Retefuente,
--0 AS Reteica,
--0 AS Reteiva,

/* SUB SELECT para traer la NTC */
(
    SELECT 
    STRING_AGG(T22.[FacNro], ', ')
    FROM [FACTURA] T22
    WHERE T22.[FacSecDev] = T1.[FacSec] and T22.[FacEst] = 'A'
) AS 'NOTAS CREDITO',
CAST((
    SELECT 
    SUM(K21.karvaltotMenDes) + SUM([KarArtIva])
    FROM [FACTURA] T22
    INNER JOIN KARDEX K21 ON K21.FacSec = T22.FacSec
    WHERE T22.[FacSecDev] = T1.[FacSec] and T22.[FacEst] = 'A'
)AS NUMERIC(18,2)) AS 'VlrNTC',
(
    SELECT 
    STRING_AGG(T22.[FacCufe], ', ')
    FROM [FACTURA] T22
    WHERE T22.[FacSecDev] = T1.[FacSec] and T22.[FacEst] = 'A'
) AS 'Cufe NTC',

CAST(
    COALESCE(
    (
        SELECT
        SUM([karvaltotMenDes]) AS FacTotal 
        FROM [KARDEX] K1
        WHERE K1.FACSEC in (select facsec from factura st1 where st1.facsecdev in (SELECT TOP 1 ST2.[FacSec] FROM FACTURA ST2 WHERE T1.[FacDocCom] = ST2.[FacDocCom]  AND ST2.[FacTipTra] = 'REV'))
    ),0
)AS NUMERIC(18,2)) +
CAST(
    COALESCE(
    (
        SELECT
        SUM([karvaltotMenDes]) AS FacTotal 
        FROM [KARDEX] K
        WHERE K.Facsec in (select F2.FacSec from FACTURA F2 where F2.FacSecDev in (SELECT F3.[FacSec] FROM FACTURA F3 WHERE F3.[FacEscPac] = T1.[FacNro]))
    ),0
)AS NUMERIC(18,2)) -
--- Resta del valor de NTC de las Cuotas Moderadoras
CAST(
    COALESCE(
        (
            SELECT
            SUM([karvaltotMenDes]) AS FacTotal 
            FROM [KARDEX] K
            WHERE K.Facsec in (select F6.FacSec from FACTURA F6 where F6.FacSecDev in (select F2.FacSec from FACTURA F2 where F2.FacSecDev in (SELECT F3.[FacSec] FROM FACTURA F3 WHERE F3.[FacEscPac] = T1.[FacNro])))
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
        WHERE T22.[FacSecDev] = T1.[FacSec] and T22.[FacEst] = 'A'
    ),0
)
- CAST(COALESCE( T12.[FacValBasIva], 0) as numeric(18,2))
)AS NUMERIC(18,2)) AS Saldo,
T1.[FacEst] AS Estado, 
/* Campos de Anulaci�n */
T1.[FacUsuAnu] AS 'Usuario Anulacion',
CAST(T1.[FacFecAnu] AS DATE) AS 'Fecha Anulaci�n',
--T1.[FacAnuObs] AS 'Observaciones Anulacion',  
--T4.[SucNom] AS Sucursal, 
--0 AS 'Id Bodega',
--'' AS 'Nombre Bodega',
--'' AS 'Id Bodega Origen',
T1.[BodSucCCSec] AS 'Id Bodega Origen', 
T5.[BodSucCCNom] AS 'Nombre Bodega Origen',
--'' AS 'Unidad de Negocio',
--'' AS 'Transporte',
--0 AS 'Nevera', ---------------------------------------------------------------T1.[FacTraNev],
--'' AS 'Nro Guia', ------------------------------------------------------------T1.[FacGuiTra],
--0 AS 'Cajas', ----------------------------------------------------------------T1.[FacTraCaj], 
--0 AS 'Valor Flete', 
T1.[FacFecTra] AS 'Fecha de Creacion',
--0 AS 'Lios', -----------------------------------------------------------------T1.[FacTraLio], 
--0 AS 'Valor Reexpedicion',
--'' AS 'Contenido',
--'' AS 'Nit Origen',
--'' AS 'Razon Social Origen',
--'' AS 'CANAL DEL CLIENTE',
--'' AS 'Nro Cargue',
--'' AS 'Fecha Cargue',
--'' AS 'Vehiculo',

/* Modalidad Contrato */
MCM.[ModConMedNom] AS 'Modalidad Factura',
T1.[FacCufe]
/*(
    SELECT
    STRING_AGG(FACFAC.FacNro, ', ')
    FROM FACTURA FACFAC
    WHERE FACFAC.FacDocCom = T1.FacDocCom AND FACFAC.FacTipTra <> 'FDV'
) AS 'Documento Origen',*/
--0 AS 'Mipres Id Programado',
--0 AS 'Mipres Id Entregado',
--0 AS 'Mipres Id Reporte Entrega',
--'' AS 'Mipres Id Facturaci�n',
--'' AS 'Nombre Paquete',
--'' AS 'N�mero de Cargue',
--T1.[FacUsuCod] as Usuario,
--'' AS 'Pedido',
--'' AS 'Origen',
--'' AS 'Prescripcion'
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
WHERE T1.[FacEst] =  'A' and T1.[FacTipTra] = 'FDV' and T1.[FacFec] between'20260101' and '20260123' and T9.[NitIde] = '830003564'/*'860066942'*//*'805001157'*/ and T1.[FacNro] = 'CAP269' /*and T1.[Factipcod] = 'FVE'*/ /*and MCM.[ModConMedNom] = 'CAPITA'*/
--ORDER BY /*T1.[FacFec] DESC,*/ T1.[FacNro] ASC 
) as TotalSma



--select * from nit Where NitCom LIKE '%SAN RAFAEL%'
/*SELECT 
FacTipCod,
FacEst,
FacSec,
FacDocCom,
FacSecDev,
FacNro,
FacEst,
FacUsuCod,
FacUsuAnu,
*
FROM FACTURA
WHERE FacTipCod = 'FVD' and FacEst = 'A'

SELECT * FROM Tipos*/



-------- V2 


use Ramedicas;
--SELECT
---COUNT(*) as 'Documentos',
---CAST(SUM(VlrNTC) as numeric(20,2)) as 'Valor en NTC',
--CAST(SUM(VlrCM) as numeric(20,2)) as 'Valor en CM',
--CAST(SUM(Saldo) as numeric(20,2)) as 'Saldo'
--DISTINCT(Cliente)
---FROM
--(
SELECT 
T1.[FacSec],
T1.[FacDocCom],
T1.[FacNro] AS 'Documento',
T1.[FacTipCod] AS FacTipCod,----------------------------------------------------------Prefijo De Factura
CAST(T1.[FacFec] AS DATE) AS Fecha, 
T9.[NitIde] AS 'Nit/C.C',
T1.[FacUsuAnu],
CAST(COALESCE( T12.[FacValBasIva], 0) as numeric(18,2)) AS 'BASE RTE.IVA',
(
    SELECT 
    STRING_AGG(T22.[FacNro], ', ')
    FROM [FACTURA] T22
    WHERE T22.[FacSecDev] = T1.[FacSec] and T22.[FacEst] = 'A'
) AS 'NOTAS CREDITO',
CAST((
    SELECT 
    SUM(K21.karvaltotMenDes) + SUM([KarArtIva])
    FROM [FACTURA] T22
    INNER JOIN KARDEX K21 ON K21.FacSec = T22.FacSec
    WHERE T22.[FacSecDev] = T1.[FacSec] and T22.[FacEst] = 'A'
)AS NUMERIC(18,2)) AS 'VlrNTC',
(
    SELECT 
    STRING_AGG(T22.[FacCufe], ', ')
    FROM [FACTURA] T22
    WHERE T22.[FacSecDev] = T1.[FacSec] and T22.[FacEst] = 'A'
) AS 'Cufe NTC',
----------------------------------------------------------------------------
CAST(
    COALESCE(
    (
        SELECT
        SUM([karvaltotMenDes]) AS FacTotal 
        FROM [KARDEX] K1
        WHERE K1.FACSEC in (select facsec from factura st1 where st1.facsecdev in (SELECT TOP 1 ST2.[FacSec] FROM FACTURA ST2 WHERE T1.[FacDocCom] = ST2.[FacDocCom]  AND ST2.[FacTipTra] = 'REV'))
    ),0
)AS NUMERIC(18,2)) +
CAST(
    COALESCE(
    (
        SELECT
        SUM([karvaltotMenDes]) AS FacTotal 
        FROM [KARDEX] K
        WHERE K.Facsec in (select F2.FacSec from FACTURA F2 where F2.FacSecDev in (SELECT F3.[FacSec] FROM FACTURA F3 WHERE F3.[FacEscPac] = T1.[FacNro]))
    ),0
)AS NUMERIC(18,2)) -
--- Resta del valor de NTC de las Cuotas Moderadoras
CAST(
    COALESCE(
        (
            SELECT
            SUM([karvaltotMenDes]) AS FacTotal 
            FROM [KARDEX] K
            WHERE K.Facsec in (select F6.FacSec from FACTURA F6 where F6.FacSecDev in (select F2.FacSec from FACTURA F2 where F2.FacSecDev in (SELECT F3.[FacSec] FROM FACTURA F3 WHERE F3.[FacEscPac] = T1.[FacNro])))
        ),0
)AS NUMERIC(18,2)) as 'VlrCM',
--------------------------------------------------------------------------------

CAST(COALESCE( T12.[FacTotal], 0) AS NUMERIC(18,2)) AS Total,
    CASE
        WHEN X.saldo <0 THEN 0
        ELSE X.saldo
    END AS Saldo,
T1.[FacEst] AS Estado, 
T1.[FacUsuAnu] AS 'Usuario Anulacion',
CAST(T1.[FacFecAnu] AS DATE) AS 'Fecha Anulaci�n',
T1.[BodSucCCSec] AS 'Id Bodega Origen', 
T5.[BodSucCCNom] AS 'Nombre Bodega Origen',
T1.[FacFecTra] AS 'Fecha de Creacion',
MCM.[ModConMedNom] AS 'Modalidad Factura',
T1.[FacCufe]
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
CROSS APPLY (
    SELECT CAST((
    CAST(COALESCE(T12.FacTotal, 0) AS NUMERIC(18,2)) - 
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
            WHERE T22.[FacSecDev] = T1.[FacSec] and T22.[FacEst] = 'A'
        ),0
    )
    - CAST(COALESCE( T12.[FacValBasIva], 0) as numeric(18,2))
    )AS NUMERIC(18,2)) AS Saldo
) AS X
WHERE T1.[FacEst] =  'A' and T1.[FacTipTra] = 'FDV' and T1.[FacFec] between'20260301' and '20260331' and T9.[NitIde] = /*'830003564'*/'860066942'/*'805001157'*/ and T1.[FacNro] = 'FEV310096'/*and T1.[Factipcod] = 'FVE'*/ /*and MCM.[ModConMedNom] = 'CAPITA'*/
--ORDER BY /*T1.[FacFec] DESC,*/ T1.[FacNro] ASC 
--) as TotalSma

select
FacFec
FacSecUnique,
FacSec,
FacSecCop,
FacSecDev,
Facpaccedsec,
facdoccom,
faccomsec,
facnro,
FacEscPac,
*
from factura
where facnro = 'FEV310096'/*'FEV304959'*/ OR facnro = 'P16004241'/*'P152602003155'*/ OR facnro ='CMY1327'

select
facdoccom,
facnro,
facest,
*
from factura
where Facpaccedsec = '2695852'/*'2700616'*/ '2700019'



select 
st1.facsec, 
st1.facnro,
k.karvaltotMenDes,
*
from factura st1 
inner join kardex K on st1.facsec = K.facsec
where st1.facest ='A' and st1.facsecdev in (SELECT TOP 1 ST2.[FacSec] FROM FACTURA ST2 WHERE ST2.facest ='A' and '260288657118716' = ST2.[FacDocCom]  AND ST2.[FacTipTra] = 'REV')

SELECT
F.facnro,
F.facdoccom,
K.karvaltotMenDes,
F.facEst,
K.KarEst,
*
from factura F
inner join kardex K on F.facsec = K.facsec
where FacSecDev = '224'





SELECT
CAST(F1.FacFec AS DATE) AS 'Fecha NTC',
F1.FacNro AS 'Documento NTC',
CASE
    WHEN F1.FacEst = 'A' THEN 'ACTIVA'
    WHEN F1.FacEst = 'I' THEN 'INACTIVA'
    ELSE F1.FacEst
END AS 'Estado NTC',
CAST(SUM(K.Karvaltotmendes) AS NUMERIC(18,2)) AS 'Total',
(
    SELECT
    F2.FacNro
    FROM Factura F2
    WHERE F1.FacSecDev = F2.FacSec  
) AS 'Factura Afectada',
(
    SELECT
    CAST(F2.FacFec AS DATE)
    FROM Factura F2
    WHERE F1.FacSecDev = F2.FacSec  
) AS 'Fecha Factura',
(
    SELECT
    F2.FacEst
    FROM Factura F2
    WHERE F1.FacSecDev = F2.FacSec  
) AS 'Factura Estado'
FROM factura F1
INNER JOIN kardex K ON F1.FacSec = K.FacSec
INNER JOIN Nit N ON F1.FacNitSec = N.NitSec
WHERE F1.FacTipCod ='NTC' AND F1.FacFec BETWEEN '20260301' AND '20260331' AND N.NitIde = '860066942' AND
(
    SELECT
    F2.FacFec
    FROM Factura F2
    WHERE F1.FacSecDev = F2.FacSec  
) < '20260301'
GROUP BY 
F1.FacFec,
F1.FacNro,
F1.FacEst,
F1.FacSecDev


