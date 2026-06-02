INSERT INTO [RamedicasBI].[dbo].[rmd_maecliente_ficc]
SELECT 
C.NitSec AS 'nitsec',
CAST(C.CliSec AS INT) AS 'clisec',
N.NitIde AS 'nitcc',
C.CliNom AS 'nomcli',
N.NitCom AS 'nomcliraz',
CASE 
    WHEN C.CliEst = 'A' THEN 'Activo' 
    ELSE 'Inactivo' END AS 'estado',
CV.VenCod AS 'vencod',
CAST(N.NitCliCup AS NUMERIC(18,2)) AS 'cupo',
CAST(N.NitCliPla AS INT) AS 'plazo',
C.CliDir AS 'dirpri',
C.CliCiuCod AS 'ciucod',
C.lisprecod AS 'lisprecod',
C.PerCliCod AS 'percod',
PC.PerCliNom AS 'pernom',
N.NitTipRegIva AS 'resiva',
C.CliTra AS 'clitracod',
CASE 
    WHEN C.CliTra = 'C' THEN 'COMERCIAL'
    WHEN C.CliTra = 'I' THEN 'INSTITUCIONAL'
    ELSE 'OTROS' END AS 'citranom',
CASE 
    WHEN CV.VenCod = 54 THEN 'VIP'
    ELSE 'COMERCIAL' END AS 'undneg',
C.TipCliCod AS 'tipclicod',
TC.TipCliNom AS 'tipclinom',
C.CatCliCod AS 'catclicod',
CC.CatCliNom AS 'catclinom',
C.CanSubCod AS 'subcancod',
SC.CanSubNom AS 'subcannom',
C.CliMedIns AS 'medins',
C.RutCod AS 'rutcod',
RC.RutDes AS 'rutnom',
C.CliCorEle AS 'email',
C.CliFecNac AS 'feccum',
N.NitUsuCre AS 'usucre',
CAST(N.NitFecCre AS DATETIME) AS 'feccre',
N.NitUsuMod AS 'usumod',
CAST(N.NitFecMod AS DATETIME) AS 'fecmod'
FROM [RamedicasFiccERP].[dbo].[Clientes] C
LEFT JOIN [RamedicasFiccERP].[dbo].[Nit] N ON C.NitSec = N.NitSec
LEFT JOIN [RamedicasFiccERP].[dbo].[ClientesVendedores] CV ON C.NitSec = CV.NitSec AND C.CliSec = CV.CliSec
LEFT JOIN [RamedicasFiccERP].[dbo].[CategoriaCliente] CC ON C.CatCliCod = CC.CatCliCod
LEFT JOIN [RamedicasFiccERP].[dbo].[TipodeClientes] TC ON C.TipCliCod = TC.TipCliCod
LEFT JOIN [RamedicasFiccERP].[dbo].[ListaPrecios] LP ON C.LisPreCod = LP.lisprecod
LEFT JOIN [RamedicasFiccERP].[dbo].[PerfilDeClientes] PC ON C.PerCliCod = PC.PerCliCod
LEFT JOIN [RamedicasFiccERP].[dbo].[SubCanal] SC ON C.CanSubCod = SC.CanSubCod
LEFT JOIN [RamedicasFiccERP].[dbo].[Ruta] RC ON  C.RutCod = RC.RutCod
WHERE LTRIM(rtrim(C.NitSec))+LTRIM(rtrim(C.CliSec)) NOT IN
(SELECT LTRIM(rtrim(NitSec))+LTRIM(rtrim(CliSec)) FROM RamedicasBI.dbo.rmd_maecliente_ficc)

-- CREATE TABLE MAESTRO CLIENTES

USE RamedicasBI;
CREATE TABLE rmd_maecliente_ficc (
    [nitsec] VARCHAR(20) NOT NULL,
    [clisec] INT NOT NULL,
    [nitcc] VARCHAR(50) NOT NULL,
    [nomcli] VARCHAR(150) NOT NULL,
    [nomcliraz] VARCHAR(150) NOT NULL,
    [estado] VARCHAR(20) NULL,
    [vencod] VARCHAR(5) NULL,
    [cupo] DECIMAL(18,2) NULL,
    [plazo] INT NULL,
    [dirpri] VARCHAR(150) NULL,
    [ciucod] VARCHAR(10) NULL,
    [lisprecod] DECIMAL(18,2) NULL,
    [percod] VARCHAR(5) NULL,
    [pernom] VARCHAR(20) NULL,
    [resiva] NVARCHAR(20) NULL,
    [clitracod] VARCHAR(5) NULL,
    [citranom] VARCHAR(50) NULL,
    [undneg] VARCHAR(50) NULL,
    [tipclicod] VARCHAR(5) NULL,
    [tipclinom] VARCHAR(50) NULL,
    [catclicod] VARCHAR(5) NULL,
    [catclinom] VARCHAR(50) NULL,
    [subcancod] VARCHAR(5) NULL,
    [subcannom] VARCHAR(50) NULL,
    [medins] VARCHAR(5) NULL,
    [rutcod] VARCHAR(5) NULL,
    [rutnom] VARCHAR(50) NULL,
    [email] VARCHAR(120) NULL,
    [feccum] DATETIME NULL,
    [usucre] VARCHAR(50) NULL,
    [feccre] DATETIME NULL,
    [usumod] VARCHAR(50) NULL,
    [fecmod] DATETIME NULL,
    PRIMARY KEY CLUSTERED
    (
        [nitsec] ASC,
        [clisec] ASC
    )
)

DECLARE @fecha_inicial_origen DATETIME = null
DECLARE @fecha_final_origen  DATETIME = null
DECLARE @fecha_inicial_ini_kardex DATETIME = '20241101'
DECLARE @fecha_inicial_fin_kardex   DATETIME = DATEADD(DAY, -1, GETDATE())
DECLARE @fecha_inicial_dispensacion DATETIME = null;
DECLARE @fecha_final_dispensacion DATETIME = null;

SELECT T.TipNom "Tipo Comprobante",
       S.SucNom "Sucursal",
       F.FacNro "Documento",
       F.FACFEC "Fecha Dispensacion",
       F.FacFecTra "Fecha Origen Dispensacion",
       F.FacUsuCod "Usuario Creacion",
       F.FacFecHorMod "Fecha Modificacion",
       Fac.[FacUsuCodMod] "Usuario Modificacion",
       K.KarFec "Fecha Movimiento Kardex",
       N.NitIde "Documento Cliente",
       N.NitCom "Sigla Comercial",
       Doc.DocMed "Documento Paciente",
       Pac.PacCedNum "Cedula Paciente",
       Pac.PacNomCom "Nombre Paciente",
       CASE WHEN Pac.PacRegSal = 'S' THEN 'SUBSIDIADO' 
            WHEN Pac.PacRegSal = 'C' THEN 'CONTRIBUTIVO' 
            WHEN Pac.PacRegSal = 'V' THEN 'VINCULADO' 
            WHEN Pac.PacRegSal = 'P' THEN 'PARTICULAR' 
            WHEN Pac.PacRegSal = 'O' THEN 'OTROS' 
            WHEN Pac.PacRegSal = 'E' THEN 'ESPECIAL' 
       END "Regimen Paciente",
       CASE WHEN F.FacDisTip = 'P' THEN 'POS'
            WHEN F.FacDisTip = 'A' THEN 'CAPITADO'
            WHEN F.FacDisTip = 'C' THEN 'CTC'
            WHEN F.FacDisTip = 'T' THEN 'TUTELA'
            WHEN F.FacDisTip = 'Z' THEN 'NO APLICA'
            WHEN F.FacDisTip = 'M' THEN 'MIPRES'
            WHEN F.FacDisTip = 'L' THEN 'AMBULANCIA'
            WHEN F.FacDisTip = 'R' THEN 'ARL'
            WHEN F.FacDisTip = 'D' THEN 'MOVILIDADREDUCIDA'
       END "Tipo Servicio",
       CAST(F.FacFecVen AS DATE) "Fecha Formula",
       CASE WHEN F.FacPunCan = 0 THEN F.FacValDocCom ELSE 0 END "Couta Recaudo",
       Ciu.CiuCod "Codigo Ciudad",
       Ciu.CiuNom "Nombre Ciudad",
       CASE WHEN Pac.PacGenero = 'M' THEN '(M) MASCULINO'
            WHEN Pac.PacGenero = 'F' THEN '(F) FEMENINO'
            WHEN Pac.PacGenero = 'E' THEN '(E) EMPRESA'
       END "Genero",
       F.FacDisMed "Medico Codigo",
       Med.DisMedNom "Medico Nombre",
       F.FacDisIps "IPS Codigo",
       IPS.IpsMedNom "IPS Nombre",
       F.FacCieCod "Codigo CIE 10",
       CIE.CieNom "Descripcion CIE 10",
       Coh.CohoNom "Cohorte",
       F.FacObs "Observacion",
       Art.ArtCod "ArticuloID",
       Art.ArtNom "Descripcion",
       Pre.PreArtNom "Presentacion",
       Art.ArtInvGru "Grupo",
       K.KarUni "Unidades",
       K.KarUni "Cantidad Autorizada",
       K.KarUniCP "Cantidad Preescrita",
       K.KarUniCP - K.KarUni  "Diferencia",
       K.KarPrePub "Precio al Publico",
       K.KarValTotMenDes + K.KarArtIva "Total venta",
       K.KarPre "Costo",
       K.KarPre * K.KarUni "Costo Total",
       Art.ArtMedRes "Articulo Controlado",
       Art.ArtMedCum "Codigo CUM Medicamento",
       Art.ArtAtc "Codigo ATC",
       Art.ArtMedInv "Invima",
       Art.ArtMedPyP "Medicamento PyP?",
       Art.ArtMedPos "POS",
       Cat.CatNom "Categoria Articulo",
       SubC.SubCatNom "Sub Categoria Articulo",
       K.KarLot "Lote",
       CAST(K.KarLotFec AS DATE) "Fecha Lote",
       K.KarMedMipCod "Codigo Autorizado",
       K.KarMedMipCodAlt "Codigo Tecnologia",
       Art.ArtPreMax "Precio Maximo",
       Art.ArtPreMaxCir "Circular Precio",
       CASE WHEN Art.ArtMedPos = 'S' THEN 'PBS'
            WHEN Art.ArtMedPos = 'N' THEN 'NO PBS'
       END "PBS/NO PBS",
       COALESCE(Pac.PacExcCuoMod,'N') "Exonera Cuota Recuperacion?",
       F.FacSec "FacSec",
       K.KarSec "KarSec",
       K.KarMedDos "Dosis",
       K.KarMedPer "Periodo Dispensas",
       Dep.DepNom "Departamento Tipo",
       Ciud.CiuNom "Municipio Tipo",
       CDR.ConDisRefCod "Codigo Cliente",
       CDR.ConDisRefDes "Descripcion Cliente",
       CDR.ConDisRefVal "Precio Cliente",
       OV.OriVendesc "Origen Venta",
       Med.DisMedEsp "Especialidad Medico",
       COALESCE(K.KarUniCie,0) "Unidades Cierre",
       F.FacConDisId "Id Contrato",
        CASE WHEN CD.ConDisTip = 'Eve' THEN 'EVENTO'
            WHEN CD.ConDisTip = 'Cap' THEN 'CAPITA' 
            WHEN CD.ConDisTip = 'Amb' THEN 'AMBULATORIO'
            End "Tipo Servicio",
       CASE WHEN F.FacPunCan = 0 THEN F.FacValDocCom ELSE 0 END "Cuota Moderadora",
       Fac.FacSec "FacSec Factura",
       Fac.FacNro "Numero Factura",
       Fac.FacFec "Fecha Factura",
       K.KarPre "Precio Unitario",
       K.KarPorIva "Porcentaje IVA",
       K.karvaltotMenDes "Total Venta sin IVA",
       K.KarArtIva "Total IVA",
      COALESCE( T29.[FacSumDetDoc], 0) "Cantidad soportes",
      f.FacFecHorCieMed "Fecha cierre"
FROM Factura F WITH (NOLOCK)
INNER JOIN Tipos T WITH (NOLOCK) ON F.FacTipCod = T.TipCod AND T.FueCod = 45
INNER JOIN Sucursales S WITH (NOLOCK) ON T.TipSucCod = S.SucCod
INNER JOIN Nit N WITH (NOLOCK) ON F.FacNitSec = N.NitSec
LEFT JOIN Clientes Cli WITH (NOLOCK) ON N.NitSec = Cli.NitSec AND N.NitCliSec = Cli.CliSec
INNER JOIN Pacientes Pac WITH (NOLOCK) ON F.FacPacCedSec = Pac.PacCedSec
LEFT JOIN Documentos Doc WITH (NOLOCK) ON Pac.PacDocCod = Doc.DocCod
LEFT JOIN Ciudad Ciu WITH (NOLOCK) ON Pac.PacCiuCod = Ciu.CiuCod
LEFT JOIN Medicos Med WITH (NOLOCK) ON F.FacDisMed = Med.DisMedCod
LEFT JOIN IpsMedico IPS WITH (NOLOCK) ON F.FacDisIps = IPS.IpsMedCod
LEFT JOIN CIE CIE WITH (NOLOCK) ON F.FacCieCod = CIE.CieCod
LEFT JOIN Cohorte Coh WITH (NOLOCK) ON CIE.CohoId = Coh.CohoId
INNER JOIN Kardex K WITH (NOLOCK) ON F.FacSec = K.FacSec AND K.KarSec < 500000
INNER JOIN Articulos Art WITH (NOLOCK) ON K.ArtSec = Art.ArtSec
INNER JOIN PresentacionArticulos Pre WITH (NOLOCK) ON K.PreArtCod = Pre.PreArtCod
INNER JOIN BodegaSucursalCC BSC WITH (NOLOCK) ON K.SubBodSucCCSec = BSC.BodSucCCSec
LEFT JOIN Categoria Cat WITH (NOLOCK) ON Art.CatCod = Cat.CatCod
LEFT JOIN SubCategoria SubC WITH (NOLOCK) ON Art.SubCatCod = SubC.SubCatCod
LEFT JOIN Ciudad Ciud WITH (NOLOCK) ON T.TipSubCiuCod = Ciud.CiuCod
LEFT JOIN Departamentos Dep WITH (NOLOCK) ON Ciu.DepCod = Dep.DepCod
LEFT JOIN ContratosDispensacionReferenci CDR WITH (NOLOCK) ON F.FacConDisId = CDR.ConDisId AND K.KarMedMipCod = CDR.ConDisRefCod
LEFT JOIN Contratosdispensacion CD WITH (NOLOCK) ON F.FacConDisId  = CD.ConDisId
LEFT JOIN OrigenVenta OV WITH (NOLOCK) ON F.FacOriVenCod = OV.OriVencod
LEFT JOIN Factura Fac WITH (NOLOCK) ON K.FacSec = Fac.FacSec
LEFT JOIN (SELECT SUM(CASE  WHEN Not (COALESCE( [FacDetDocArcExt], '') = '') THEN 1 END) AS FacSumDetDoc, [FacSec] FROM [REMISIONESDOCUMENTOSDISMED] WITH (NOLOCK) GROUP BY [FacSec] ) T29 ON T29.[FacSec] = K.[FacSec] 
WHERE f.FacEst = 'A'and ((@fecha_inicial_origen is not null and @fecha_final_origen is not null and F.FacFecTra BETWEEN @fecha_inicial_origen AND @fecha_final_origen)
or (@fecha_inicial_origen is null and @fecha_final_origen is null))
and 
((@fecha_inicial_dispensacion is not null and @fecha_final_dispensacion is not null and F.FacFec BETWEEN @fecha_inicial_dispensacion AND @fecha_final_dispensacion)
or (@fecha_inicial_dispensacion is null and @fecha_final_dispensacion is null))
and ((@fecha_inicial_fin_kardex is not null and @fecha_inicial_fin_kardex is not null and k.KarFec BETWEEN @fecha_inicial_ini_kardex AND @fecha_inicial_fin_kardex)
or (@fecha_inicial_ini_kardex is null and @fecha_inicial_fin_kardex is null))
ORDER BY F.FacFec DESC
