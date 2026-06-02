--Informe de dispensacion COMPENSAR

DECLARE @fecha_inicial_origen DATETIME = null;
DECLARE @fecha_final_origen  DATETIME = null;
DECLARE @fecha_inicial_ini_kardex DATETIME = '20260301'
DECLARE @fecha_inicial_fin_kardex   DATETIME = '20260331'
DECLARE @fecha_inicial_dispensacion DATETIME = null;
DECLARE @fecha_final_dispensacion DATETIME = null;

SELECT
ROW_NUMBER() OVER (ORDER BY "Fecha Generacion") AS "No",
*
FROM
(
SELECT
       'EPS008' AS "Codigo EPS",
       'No aplica' AS "Tipo Plan Convenio",
       'AMBULATORIO' AS "Tipo de Contratacion",
       CASE WHEN F.FacDisTip = 'P' THEN 'POS'
            WHEN F.FacDisTip = 'A' THEN 'CAPITADO'
            WHEN F.FacDisTip = 'C' THEN 'CTC'
            WHEN F.FacDisTip = 'T' THEN 'TUTELA'
            WHEN F.FacDisTip = 'Z' THEN 'NO APLICA'
            WHEN F.FacDisTip = 'M' THEN 'MIPRES'
            WHEN F.FacDisTip = 'L' THEN 'AMBULANCIA'
            WHEN F.FacDisTip = 'R' THEN 'ARL'
            WHEN F.FacDisTip = 'D' THEN 'MOVILIDADREDUCIDA'
       END "Nombre Subcuenta",
       T.TipNom AS "Nombre Caf",
       '901429936' AS "Nit Prestador",
       '1' AS "Digito de Verificacion",
       'A' AS "Ambito del servicio",
       FORMAT(F.FacFecPriCuo,'yyyy-MM') AS "Fecha Autorizacion",
       F.FacFecTra AS "Fecha Generacion",
       CASE WHEN (K.KarUniCP - K.KarUni) > 0 THEN 'S' ELSE 'N' END AS "Pendiente",
       K.KarFec AS "Fecha Dispensacion",
       F.FacNro AS "No Autorizacion/Formula",
       'Ambulatorio' AS "Tipo de Autorizacion",
       Doc.DocMed "Tipo Id Usuario",
       Pac.PacCedNum "Id Usuario",
       CAST(Pac.PacFec AS DATE) AS "Fecha Nacimiento",
       CASE WHEN T.TipNom = 'PAF CHIA COMPENSAR' THEN '25'
       WHEN  T.TipNom = 'PAF SUBA COMPENSAR' THEN '11' ELSE '' END AS "Codigo Departamento",
       CASE WHEN T.TipNom = 'PAF CHIA COMPENSAR' THEN '25175'
       WHEN  T.TipNom = 'PAF SUBA COMPENSAR' THEN '11001' ELSE '' END AS "Codigo Municipio",
       Pac.PacNomCom AS "Nombre completo Usuario",
       Pac.PacGenero AS "Sexo", 
       F.FacDisMed AS "Id Medico o Institucion Remitente",
       Med.DisMedNom AS "Nombre Completo Medico",
       F.FacCieCod AS "CIE10",
       Art.ArtCod "Codigo Comercial",
       COALESCE(NULLIF(Cdalt.contcodcumalt, ''), '0') AS "Codigo Generico",
       COALESCE(NULLIF(Art.ArtAtc, ''), '0') AS "Codigo ATC",
       COALESCE(CASE WHEN CHARINDEX('-', Art.ArtMedCum) > 0 
            THEN LEFT(Art.ArtMedCum, CHARINDEX('-', Art.ArtMedCum) - 1)
            ELSE Art.ArtMedCum
            END, '0') AS "Expediente",
       COALESCE(CASE WHEN Art.ArtMedConExp < 10
            THEN '0' + CAST(Art.ArtMedConExp AS VARCHAR(10))
            ELSE CAST(Art.ArtMedConExp AS VARCHAR(10))
       END, '0') AS "Consecutivo",
       Art.ArtMedCum AS "CUMS",
       Art.ArtMedInv AS "Registro Sanitario (Invima)",
       CAST(Art.ArtFecVenInv AS DATE) AS "Fecha Vigencia",
       'VIGENTE' AS "Estado Registro Sanitario",
       Art.ArtMedDesAtc AS "Descripcion Atc",
       Art.ArtMedPriAct AS "Principio Activo",
       Art.ArtMedNomCom AS "Nombre Comercial",
       CASE WHEN F.FacDisTip = 'POS' then 'POS' ELSE 'NOPOS' END AS "POS O NOPOS",
       Art.ArtMedRes AS "Regulado Si o No",
       Art.ArtMedForFar AS "Forma Farmaceutica (FF)",
       Art.ArtMedCon AS "Concentracion",
       Art.ArtMedUndMed AS "Unidad de concentracion",
       Art.ArtMedUndMed AS "Unidad de Medida",
       Pre.preartnom AS "Presentación comercial",
       Art.ArtFrac AS "Fraccionable",
       Art.ArtMedVia AS "Via Administracion",
       '' AS "Laboratorio",
       CAST(K.KarUniCP AS INT) AS "Cantidad Prescrita Y/O Autorizada",
       CAST(K.KarUni AS INT) AS "Cantidad dispensada",
       CAST(K.KarPrePub AS INT) AS "Valor unitario",
       CAST((K.KarValTotMenDes + K.KarArtIva) AS INT) AS "Valor Total",
       CAST(CASE WHEN F.FacPunCan = 0 THEN F.FacValDocCom ELSE 0 END AS INT) AS "Copago/Cuota Moderadora",
        'Presencial' AS "Tipo Dispensación",
       F.FacNroPreAuto AS "NAP",
       CAST(f2.FacFec AS DATE) AS "FechaFactura"
FROM Factura F WITH (NOLOCK)
INNER JOIN Tipos T WITH (NOLOCK) ON F.FacTipCod = T.TipCod AND T.FueCod = 45
INNER JOIN Pacientes Pac WITH (NOLOCK) ON F.FacPacCedSec = Pac.PacCedSec
INNER JOIN Nit N WITH (NOLOCK) ON F.FacNitSec = N.NitSec
LEFT JOIN Documentos Doc WITH (NOLOCK) ON Pac.PacDocCod = Doc.DocCod
INNER JOIN Kardex K WITH (NOLOCK) ON F.FacSec = K.FacSec AND K.KarSec < 500000
INNER JOIN Articulos Art WITH (NOLOCK) ON K.ArtSec = Art.ArtSec
LEFT JOIN PresentacionArticulos Pre WITH (NOLOCK) ON Pre.PreArtCod = K.PreArtCod
LEFT JOIN Medicos Med WITH (NOLOCK) ON F.FacDisMed = Med.DisMedCod
LEFT JOIN Factura F2 ON F.facdoccom IS NOT NULL AND F.facdoccom <> '' AND F2.facdoccom = F.facdoccom AND F2.factiptra = 'FDV' AND F2.facsec <> F.facsec
LEFT JOIN ContratosDispensacionReferenci Cdalt ON Cdalt.ConDisRefCod = art.ArtCod and Cdalt.condisid= '29'
WHERE f.FacEst = 'A'and ((@fecha_inicial_origen is not null and @fecha_final_origen is not null and F.FacFecTra BETWEEN @fecha_inicial_origen AND @fecha_final_origen)
or (@fecha_inicial_origen is null and @fecha_final_origen is null))
and 
((@fecha_inicial_dispensacion is not null and @fecha_final_dispensacion is not null and F.FacFec BETWEEN @fecha_inicial_dispensacion AND @fecha_final_dispensacion)
or (@fecha_inicial_dispensacion is null and @fecha_final_dispensacion is null))
and ((@fecha_inicial_ini_kardex is not null and @fecha_inicial_fin_kardex is not null and k.KarFec BETWEEN @fecha_inicial_ini_kardex AND @fecha_inicial_fin_kardex)
or (@fecha_inicial_ini_kardex is null and @fecha_inicial_fin_kardex is null)) 
and N.NitIde = '860066942' AND K.karuni > 0
) as rmd;