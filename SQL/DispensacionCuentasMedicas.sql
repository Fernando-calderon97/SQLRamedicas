USE Ramedicas;

DECLARE @fecha_inicial_origen         DATETIME = NULL;
DECLARE @fecha_final_origen           DATETIME = NULL;

DECLARE @fecha_inicial_ini_kardex     DATETIME = '20241201';
DECLARE @fecha_inicial_fin_kardex     DATETIME = DATEADD(DAY, -1, GETDATE());

DECLARE @fecha_inicial_dispensacion   DATETIME = NULL;
DECLARE @fecha_final_dispensacion     DATETIME = NULL;

WITH T29 AS (
    SELECT
        FacSec,
        SUM(CASE WHEN COALESCE(FacDetDocArcExt, '') <> '' THEN 1 ELSE 0 END) AS FacSumDetDoc
    FROM REMISIONESDOCUMENTOSDISMED WITH (NOLOCK)
    GROUP BY FacSec
),
MedAplicacion AS (
    SELECT DISTINCT k2.FacSec
    FROM Kardex k2 WITH (NOLOCK)
    INNER JOIN Articulos a WITH (NOLOCK) ON a.ArtSec = k2.ArtSec
    WHERE a.ArtCod IN (
        'AB0019','AB0026','AB0027','ABV001','ABV008','ALL021',
        'ALL031','AMG001','AMG009','AMG014','AMG016','BP0015',
        'BP0019','BP0080','BR0039','BY0023','BY0128','FE0007',
        'FK0118','GH0021','GH0034','GL0154','GR0073','HU0064',
        'JN0032','JN0046','JN0058','LL0051','LL0054','NO0138',
        'NO0143','NO0144','NO0186','PF0200','PX0126','PX0263',
        'RC0044','RC0046','RC0072','RC0074','SE0001','SH0014',
        'SIC018','TK0021'
    )
),
KarParametrizacion AS (
    SELECT DISTINCT FacSec
    FROM Kardex WITH (NOLOCK)
    WHERE KarPrePub = 0
)
SELECT
    T.TipNom                                                        AS "Tipo Comprobante",
    F.FacNro                                                        AS "Documento",
    CAST(F.FacFec AS DATE)                                          AS "Fecha Dispensacion",
    CAST(F.FacFecTra AS DATE)                                       AS "Fecha Origen Dispensacion",
    F.FacUsuCod                                                     AS "Usuario Creacion",
    F.FacUsuCodMod                                                  AS "Usuario Modificacion",
    N.NitIde                                                        AS "Documento Cliente",
    N.NitCom                                                        AS "Sigla Comercial",
    Doc.DocMed                                                      AS "Documento Paciente",
    Pac.PacCedNum                                                   AS "Cedula Paciente",
    Pac.PacNomCom                                                   AS "Nombre Paciente",
    CASE Pac.PacRegSal
        WHEN 'S' THEN 'SUBSIDIADO'
        WHEN 'C' THEN 'CONTRIBUTIVO'
        WHEN 'V' THEN 'VINCULADO'
        WHEN 'P' THEN 'PARTICULAR'
        WHEN 'O' THEN 'OTROS'
        WHEN 'E' THEN 'ESPECIAL'
    END                                                             AS "Regimen Paciente",
    CASE F.FacDisTip
        WHEN 'P' THEN 'POS'
        WHEN 'A' THEN 'CAPITADO'
        WHEN 'C' THEN 'CTC'
        WHEN 'T' THEN 'TUTELA'
        WHEN 'Z' THEN 'NO APLICA'
        WHEN 'M' THEN 'MIPRES'
        WHEN 'L' THEN 'AMBULANCIA'
        WHEN 'R' THEN 'ARL'
        WHEN 'D' THEN 'MOVILIDADREDUCIDA'
    END                                                             AS "TipoPac",
    CAST(F.FacFecVen AS DATE)                                       AS "Fecha Formula",
    MAX(CASE WHEN F.FacPunCan = 0 THEN F.FacValDocCom ELSE 0 END)  AS "Cuota Moderadora",
    Ciu.CiuCod                                                      AS "Codigo Ciudad",
    Ciu.CiuNom                                                      AS "Nombre Ciudad",
    CASE Pac.PacGenero
        WHEN 'M' THEN '(M) MASCULINO'
        WHEN 'F' THEN '(F) FEMENINO'
        WHEN 'E' THEN '(E) EMPRESA'
    END                                                             AS "Genero",
    F.FacDisMed                                                     AS "Medico Codigo",
    Med.DisMedNom                                                   AS "Medico Nombre",
    Med.DisMedEsp                                                   AS "Especialidad Medico",
    F.FacDisIps                                                     AS "IPS Codigo",
    IPS.IpsMedNom                                                   AS "IPS Nombre",
    F.FacCieCod                                                     AS "Codigo CIE 10",
    CIE.CieNom                                                      AS "Descripcion CIE 10",
    Coh.CohoNom                                                     AS "Cohorte",
    SUM(K.KarUni)                                                   AS "Unidades",
    SUM(K.KarUniCP)                                                 AS "Cantidad Preescrita",
    SUM(K.KarUni - K.KarUniCP)                                     AS "Diferencia",
    SUM(K.KarValTotMenDes + K.KarArtIva)                           AS "TotalVenta",
    SUM(K.KarPre * K.KarUni)                                       AS "Costo Total",
    COUNT(DISTINCT Art.ArtCod)                                      AS "Articulos",
    MAX(COALESCE(K.KarUniCie, 0))                                   AS "Unidades Cierre",
    F.FacConDisId                                                   AS "Id Contrato",
    CASE CD.ConDisTip
        WHEN 'Eve' THEN 'EVENTO'
        WHEN 'Cap' THEN 'CAPITA'
        WHEN 'Amb' THEN 'AMBULATORIO'
    END                                                             AS "Tipo Servicio",
    CAST(F.FacFec AS DATE)                                          AS "Fecha Factura",
    MAX(K.KarFec)                                                   AS "Fecha Movimiento Kardex",
    MAX(ISNULL(T29.FacSumDetDoc, 0))                               AS "Cantidad soportes",
    MAX(BSC.BodSucCCNom)                                            AS "Bodega origen",
    F.FacDocCom                                                     AS "#Autorizacion",
    F.FacEscPac                                                     AS "Factura Capita",
    Dep.DepNom                                                      AS "Departamento Tipo",
    Ciud.CiuNom                                                     AS "Municipio Tipo",
    F.FacNroPreAuto                                                 AS "Preautorizacion",
    CASE WHEN MAX(MedApl.FacSec) IS NOT NULL
         THEN 'Medicamento de aplicacion'
         ELSE 'No aplica'
    END                                                             AS Medicamento_aplicacion,
    CASE WHEN MAX(KarParam.FacSec) IS NOT NULL
         THEN 'PARAMETRIZACION PRECIO'
         ELSE 'NO'
    END                                                             AS Parametrizacion,
    'WEB'                                                           AS ERP

FROM Factura F WITH (NOLOCK)
INNER JOIN Tipos T                       WITH (NOLOCK) ON F.FacTipCod = T.TipCod AND T.FueCod = 45
INNER JOIN Sucursales S                  WITH (NOLOCK) ON T.TipSucCod = S.SucCod
INNER JOIN Nit N                         WITH (NOLOCK) ON F.FacNitSec = N.NitSec
INNER JOIN Pacientes Pac                 WITH (NOLOCK) ON F.FacPacCedSec = Pac.PacCedSec
INNER JOIN Kardex K                      WITH (NOLOCK) ON F.FacSec = K.FacSec AND K.KarSec < 500000
INNER JOIN Articulos Art                 WITH (NOLOCK) ON K.ArtSec = Art.ArtSec
INNER JOIN PresentacionArticulos Pre     WITH (NOLOCK) ON K.PreArtCod = Pre.PreArtCod
INNER JOIN BodegaSucursalCC BSC          WITH (NOLOCK) ON K.SubBodSucCCSec = BSC.BodSucCCSec
LEFT JOIN Documentos Doc                 WITH (NOLOCK) ON Pac.PacDocCod = Doc.DocCod
LEFT JOIN Ciudad Ciu                     WITH (NOLOCK) ON Pac.PacCiuCod = Ciu.CiuCod
LEFT JOIN Medicos Med                    WITH (NOLOCK) ON F.FacDisMed = Med.DisMedCod
LEFT JOIN IpsMedico IPS                  WITH (NOLOCK) ON F.FacDisIps = IPS.IpsMedCod
LEFT JOIN CIE                            WITH (NOLOCK) ON F.FacCieCod = CIE.CieCod
LEFT JOIN Cohorte Coh                    WITH (NOLOCK) ON CIE.CohoId = Coh.CohoId
LEFT JOIN Ciudad Ciud                    WITH (NOLOCK) ON T.TipSubCiuCod = Ciud.CiuCod
LEFT JOIN Departamentos Dep              WITH (NOLOCK) ON Ciu.DepCod = Dep.DepCod
LEFT JOIN Contratosdispensacion CD       WITH (NOLOCK) ON F.FacConDisId = CD.ConDisId
LEFT JOIN T29                                          ON T29.FacSec = F.FacSec
LEFT JOIN MedAplicacion MedApl                         ON MedApl.FacSec = F.FacSec
LEFT JOIN KarParametrizacion KarParam                  ON KarParam.FacSec = F.FacSec

WHERE F.FacEst = 'A'
  AND (@fecha_inicial_origen     IS NULL OR F.FacFecTra BETWEEN @fecha_inicial_origen     AND @fecha_final_origen)
  AND (@fecha_inicial_dispensacion IS NULL OR F.FacFec   BETWEEN @fecha_inicial_dispensacion AND @fecha_final_dispensacion)
  AND (@fecha_inicial_ini_kardex IS NULL OR K.KarFec    BETWEEN @fecha_inicial_ini_kardex  AND @fecha_inicial_fin_kardex)

GROUP BY
    T.TipNom,
    F.FacNro,
    F.FacFec,
    F.FacSec,
    F.FacFecTra,
    F.FacUsuCod,
    F.FacUsuCodMod,
    N.NitIde,
    N.NitCom,
    Doc.DocMed,
    Pac.PacCedNum,
    Pac.PacNomCom,
    Pac.PacRegSal,
    F.FacDisTip,
    F.FacFecVen,
    Ciu.CiuCod,
    Ciu.CiuNom,
    Pac.PacGenero,
    F.FacDisMed,
    Med.DisMedNom,
    Med.DisMedEsp,
    F.FacDisIps,
    IPS.IpsMedNom,
    F.FacCieCod,
    CIE.CieNom,
    Coh.CohoNom,
    Pac.PacExcCuoMod,
    F.FacConDisId,
    CD.ConDisTip,
    F.FacDocCom,
    F.FacEscPac,
    Dep.DepNom,
    Ciud.CiuNom,
    F.FacNroPreAuto

ORDER BY CAST(F.FacFec AS DATE) DESC
OPTION (RECOMPILE);
