
CREATE VIEW vw_rmdtraclinue AS 

WITH primera_factura AS (
    SELECT 
        MC.nitcc,
        MC.nomcli,
        CAST(MC.feccre AS DATE) AS 'fecha_creacion',
        CAST(MIN(F.facfec) AS DATE) AS 'primera_fecha'
    FROM [RamedicasBI_FICC].[dbo].[rmd_trafacdist_ficc] F
    INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_maecliente_ficc] MC ON F.facnitsec = MC.nitsec AND  F.facclisec = MC.clisec
   GROUP BY MC.nitcc, MC.nomcli, MC.feccre
)

SELECT * FROM primera_factura WHERE fecha_creacion >= primera_fecha