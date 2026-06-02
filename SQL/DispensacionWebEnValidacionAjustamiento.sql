
-- DISPENSACION WEB 1 SEMESTRE 2026 FECHA MOVIMIENTO KARDEX

DECLARE @fecha_inicial_origen DATETIME = null
DECLARE @fecha_final_origen  DATETIME = null
DECLARE @fecha_inicial_ini_kardex DATETIME = '20260301'
DECLARE @fecha_inicial_fin_kardex   DATETIME = DATEADD(DAY, -1, GETDATE());
DECLARE @fecha_inicial_dispensacion DATETIME = null
DECLARE @fecha_final_dispensacion DATETIME =  null

SELECT 
        T.TipNom "Tipo Comprobante", -- 1
        S.SucNom "Sucursal", -- 2
        F.FacNro "Documento", -- 3
        K.KarFec "Fecha Dispensacion", -- 4
        --F.FACFEC "Fecha Dispensacion innecesaria", --
        F.FacFecTra "Fecha Origen", -- 5
        F.FacAutSolFecSol "Fecha solicitud", -- 6
        F.FacFecHorMod "Fecha Modificacion",  -- 7
        N.NitIde "Documento Cliente", -- 8
        N.NitCom "Sigla Comercial", -- 9
        Doc.DocMed "Documento Paciente", -- 10
        Pac.PacCedNum "Cedula Paciente", -- 11
            Pac.PacNomCom "Nombre Paciente", -- 12
        CASE WHEN Pac.PacRegSal = 'S' THEN 'SUBSIDIADO' 
                WHEN Pac.PacRegSal = 'C' THEN 'CONTRIBUTIVO' 
                WHEN Pac.PacRegSal = 'V' THEN 'VINCULADO' 
                WHEN Pac.PacRegSal = 'P' THEN 'PARTICULAR' 
                WHEN Pac.PacRegSal = 'O' THEN 'OTROS' 
                WHEN Pac.PacRegSal = 'E' THEN 'ESPECIAL' 
        END "Regimen Paciente", -- 13
        CASE WHEN F.FacDisTip = 'P' THEN 'POS'
                WHEN F.FacDisTip = 'A' THEN 'CAPITADO'
                WHEN F.FacDisTip = 'C' THEN 'CTC'
                WHEN F.FacDisTip = 'T' THEN 'TUTELA'
                WHEN F.FacDisTip = 'Z' THEN 'NO APLICA'
                WHEN F.FacDisTip = 'M' THEN 'MIPRES'
                WHEN F.FacDisTip = 'L' THEN 'AMBULANCIA'
                WHEN F.FacDisTip = 'R' THEN 'ARL'
                WHEN F.FacDisTip = 'D' THEN 'MOVILIDADREDUCIDA'
        END "Tipo Servicio", -- 14
        CAST(F.FacFecVen AS DATE) "Fecha Formula", -- 15
        CASE WHEN F.FacPunCan = 0 THEN F.FacValDocCom ELSE 0 END "Couta Recaudo", -- 16 /*Validar en FICC*/
        Ciu.CiuCod "Codigo Ciudad", -- 17
        Ciu.CiuNom "Nombre Ciudad", -- 18
        Dep.DepNom "Nombre Departamento", --19
        CASE WHEN Pac.PacGenero = 'M' THEN '(M) MASCULINO'
                WHEN Pac.PacGenero = 'F' THEN '(F) FEMENINO'
                WHEN Pac.PacGenero = 'E' THEN '(E) EMPRESA'
        END "Genero", -- 20
        F.FacDisMed "Codigo Medico", -- 21
        Med.DisMedNom "Nombre Medico", -- 22
        F.FacDisIps "Codigo IPS", -- 23
        IPS.IpsMedNom "Nombre IPS", -- 24
        F.FacCieCod "Codigo CIE 10", -- 25
        CIE.CieNom "Descripcion CIE 10", -- 26
        Coh.CohoNom "Cohorte", -- 27
        F.FacObs "Observacion", -- 28
        Art.ArtCod "Codigo Articulo", -- 29
        Art.ArtNom "Descripcion", -- 30
        Pre.PreArtNom "Presentacion", -- 31
        Art.ArtInvGru "Grupo", -- 32
        K.KarUni "Unidades", -- 33 
        K.KarUni "Cantidad Autorizada", -- 34
        K.KarUniCP "Cantidad Preescrita", -- 35
        K.KarUniCP - K.KarUni  "Cantidad Pendiente", -- 36
        K.KarPrePub "Precio al Publico", -- 37
        K.karvaltotMenDes "TotalVentaBruta", -- 38
        K.KarPorIva "PorcentajeIVA", -- 39
        K.KarArtIva AS 'TotalIVA', -- 40
        K.KarValTotMenDes + K.KarArtIva "TotalVentaNeta", -- 41
        K.KarPre "Costo", -- 42
        K.KarPre * K.KarUni "Costo Total", -- 43
        Art.ArtMedRes "Articulo Controlado", -- 44
        Art.ArtMedCum "Cum", -- 45
        Art.ArtAtc "Atc", -- 46
        Art.ArtMedInv "Invima", -- 47
        Art.ArtMedPyP "Medicamento PyP?", -- 48 /*Validar en FICC*/
        Cat.CatNom "Categoria Articulo", -- 49
        SubC.SubCatNom "Sub Categoria Articulo", -- 50
        K.KarLot "Lote", -- 51
        CAST(K.KarLotFec AS DATE) "Fecha de Vencimiento", -- 52
        K.KarMedMipCod "Codigo Autorizado", -- 53 /*Validar en FICC*/
        K.KarMedMipCodAlt "Codigo Tecnologia", -- 54 /*Validar en FICC*/
        Art.ArtPreMax "Precio Maximo", -- 55
        Art.ArtPreMaxCir "Circular Precio", -- 56
        CASE WHEN Art.ArtMedPos = 'S' THEN 'PBS' 
                WHEN Art.ArtMedPos = 'N' THEN 'NO PBS'
                ELSE 'SIN CLASIFICAR'
        END "PBS/NOPBS", -- 57
        --COALESCE(Pac.PacExcCuoMod,'N') "Exonera Cuota Recuperacion?",
        K.KarMedDos "Dosis", -- 58
        K.KarMedPer "Periodo Dispensas",  -- 59
        Ciud.CiuNom "Municipio Tipo", -- 60
        CDR.ConDisRefCod "Codigo Contrato", -- 61
        CDR.ConDisRefDes "Descripcion Cliente", -- 62 /*Validar en FICC*/
        CDR.ConDisRefVal "Precio Cliente", -- 63
        OV.OriVendesc "Origen Venta", -- 64
        Med.DisMedEsp "Especialidad Medico", -- 65
        F.FacConDisId "Id Contrato", -- 66
            CASE WHEN CD.ConDisTip = 'Eve' THEN 'EVENTO'
                WHEN CD.ConDisTip = 'Cap' THEN 'CAPITA' 
                WHEN CD.ConDisTip = 'Amb' THEN 'AMBULATORIO'
                End "Contrato", -- 67
        '' AS 'FacturaCM', -- 68/*Falta Traer Fatura cuota moderadora*/
        CASE WHEN F.FacPunCan = 0 THEN F.FacValDocCom ELSE 0 END "Cuota Moderadora", -- 69
        --Fac.FacSec "FacSec Factura",
        Fac.FacFec "Fecha Factura", -- 70
        Fac.FacNro "Factura", -- 71
        --K.KarPre "Precio Unitario",
        COALESCE( T29.[FacSumDetDoc], 0) "Cantidad soportes", -- 72
        COALESCE(K.KarUniCie,0) "Unidades Cierre", -- 73
        f.FacFecHorCieMed "Fecha cierre" --74
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
WHERE Art.ArtCod = 'WT0049' and f.FacEst = 'A' and ((@fecha_inicial_origen is not null and @fecha_final_origen is not null and F.FacFecTra BETWEEN @fecha_inicial_origen AND @fecha_final_origen)
or (@fecha_inicial_origen is null and @fecha_final_origen is null))
and 
((@fecha_inicial_dispensacion is not null and @fecha_final_dispensacion is not null and F.FacFec BETWEEN @fecha_inicial_dispensacion AND @fecha_final_dispensacion)
or (@fecha_inicial_dispensacion is null and @fecha_final_dispensacion is null))
and ((@fecha_inicial_fin_kardex is not null and @fecha_inicial_fin_kardex is not null and k.KarFec BETWEEN @fecha_inicial_ini_kardex AND @fecha_inicial_fin_kardex)
or (@fecha_inicial_ini_kardex is null and @fecha_inicial_fin_kardex is null))
ORDER BY F.FacFec DESC

     /*CASE
                WHEN CAST(F.FacFecTra AS DATE) = K.KarFec THEN 'No fue pendiente'
                ELSE 'Pendiente entregado' END
        AS 'Fue pendiente',
       CASE 
                WHEN (K.KarUniCP - K.KarUni) <> 0 
                        AND F.FacFecTra IS NOT NULL 
                        AND K.karSec IS NOT NULL 
                THEN
                        CASE 
                        WHEN F.FacFecTra <> K.karSec 
                                THEN DATEDIFF(DAY, F.FacFecTra, GETDATE())
                        ELSE 
                                DATEDIFF(DAY, F.FacFecTra, K.KarFec)
                        END
                ELSE NULL
        END AS 'Oportunidad de entrega'*/


-- Anexo 2. Informes Anexo Suficiencia Capita Famisanar WEB



-- Anexo 2. Informes Anexo Suficiencia Capita Famisanar WEB

DECLARE @fecha_inicial_origen DATETIME = '20260401' --Fecha inicial del periodo a presentar
DECLARE @fecha_final_origen  DATETIME = '20260430' -- Fecha final del periodo a presentar
DECLARE @fecha_inicial_ini_kardex DATETIME = '20260401' -- Fecha inicial del periodo a presentar
DECLARE @fecha_inicial_fin_kardex   DATETIME = '20260430' -- Fecha final del periodo a presentar
DECLARE @fecha_inicial_dispensacion DATETIME = null;
DECLARE @fecha_final_dispensacion DATETIME = null;

select
'RAMEDICAS' AS [Dispensador],
'901429936-1' AS [Nit Dispensador],
CASE WHEN T.TipNom IN ('PAF AMARU','PAF CALLE 26', 'PAF CHAPINERO', 'PAF CIUDAD JARDIN',
						'PAF CIUDADELA COLSUBSIDIO', 'PAF EL LAGO', 'PAF FONTIBÓN', 'PAF PUENTE ARANDA',
						'PAF RESTREPO', 'PAF ROMA', 'PAF SANTA BÁRBARA', 'PAF SUBA', 'PAF TOBERÍN', 'PAF TECHO') 
					    THEN 'BOGOTA' 
						WHEN T.TipNom IN ('RAMEDICAS ESPINAL','RAMEDICAS GUADUAS', 'RAMEDICAS MESITAS DEL COLEGIO', 
					    'RAMEDICAS MOSQUERA', 'RAMEDICAS SUESCA', 'RAMEDICAS VILLETA') 
					    THEN 'CUNDINAMARCA'
					    ELSE 'REVISAR'
END [Departamento],
CASE WHEN T.TipNom IN ('PAF AMARU','PAF CALLE 26', 'PAF CHAPINERO', 'PAF CIUDAD JARDIN',
						'PAF CIUDADELA COLSUBSIDIO', 'PAF EL LAGO', 'PAF FONTIBÓN', 'PAF PUENTE ARANDA',
						'PAF RESTREPO', 'PAF ROMA', 'PAF SANTA BÁRBARA', 'PAF SUBA', 'PAF TOBERÍN', 'PAF TECHO') 
					    THEN 'BOGOTA' 
						WHEN T.TipNom = 'RAMEDICAS ESPINAL' THEN 'ESPINAL'
						WHEN T.TipNom = 'RAMEDICAS GUADUAS' THEN 'GUADUAS'
						WHEN T.TipNom = 'RAMEDICAS MESITAS DEL COLEGIO' THEN 'MESITAS DEL COLEGIO'
						WHEN T.TipNom = 'RAMEDICAS MOSQUERA' THEN 'MOSQUERA'
						WHEN T.TipNom = 'RAMEDICAS SUESCA' THEN 'SUESCA'
						WHEN T.TipNom = 'RAMEDICAS VILLETA' THEN 'VILLETA'
					    ELSE 'REVISAR'
END [Municipio],
'NA' AS [Ips Primaria paciente],
T.TipNom AS [Punto de despacho],
'NA' AS [Agrupador IPS Formuladora],
IPS.IpsMedNom AS [IPS de formulación],
Med.DisMedEsp AS [Especialidad],
'CC' AS [Tipo Documento prescriptor],
F.FacDisMed AS [Numero Documento prescriptor],
F.FacNro AS [Numero de Formula],
F2.FacFec AS [Fecha de factura],
K.KarFec AS [Fecha de dispensacion],
F2.FacNro AS [Numero de Factura],
'NA' AS [Numero de Radicado],
'NA' AS [ID Mipres],
'Ambulatorio' AS [Ambito],
CASE WHEN F.FacDisTip = 'P' THEN 'PBS'
     WHEN F.FacDisTip = 'A' THEN 'PBS'
     WHEN F.FacDisTip = 'C' THEN 'CTC'
     WHEN F.FacDisTip = 'T' THEN 'PBS'
     WHEN F.FacDisTip = 'Z' THEN 'NO APLICA'
     WHEN F.FacDisTip = 'M' THEN 'NO PBS'
     WHEN F.FacDisTip = 'L' THEN 'AMBULANCIA'
     WHEN F.FacDisTip = 'R' THEN 'PBS'
     WHEN F.FacDisTip = 'D' THEN 'MOVILIDADREDUCIDA' END "Tipo Cobertura (PBS / NO PBS)",
Doc.DocMed AS [Tipo Documento],
Pac.PacCedNum AS [Numero Documento],
Pac.PacGenero AS [Genero],
F.FacCieCod AS [Diagnóstico CIE-10],
CIE.CieNom AS [descripción Diagnostico],
Art.ArtMedCum AS [Codigo CUM],
Art.ArtCod AS [Codigo del Medicamento],
Art.ArtNom AS [Descripcion Molecula],
Art.ArtAtc AS [ATC],
Pre.PreArtNom AS [Presentación / Forma Farmacéutica],
Art.ArtMedCon AS [Concentracion],
Art.ArtMedUndMed AS [Unidad de Medida],
K.KarMedPer AS [Días de tratamiento],
CAST(F.FacFecTra AS DATE) AS [Fecha de Solicitud],
K.KarUniCP AS [Cantidad solicitada],
K.KarFec AS [Fecha de Dispensacion1],
Art.ArtMedMin AS [Unidad minima dispensada],
K.KarUni AS [Cantidad dispensada],
K.KarPrePub AS [Vlr. Unitario],
K.KarValTotMenDes + K.KarArtIva AS [Vlr.total],
'NA' AS [Tipo de pago Moderadora],
CASE WHEN F.FacPunCan = 0 THEN F.FacValDocCom ELSE 0 END [Cuota Moderadora],
'NA' AS [numFEVPagoModerador],
'NA' AS [DescripciOn Sub-Plan],
'' AS [Codigo DCI],
'' AS [Descripcion DCI],
'' AS [Tipo medicamento],
K.KarMedMipCod AS [Codigo Contratado]
FROM Factura F WITH (NOLOCK)
INNER JOIN Tipos T WITH (NOLOCK) ON F.FacTipCod = T.TipCod AND T.FueCod = 45
INNER JOIN Pacientes Pac WITH (NOLOCK) ON F.FacPacCedSec = Pac.PacCedSec
INNER JOIN Nit N WITH (NOLOCK) ON F.FacNitSec = N.NitSec and N.NitIde = '830003564'
LEFT JOIN Documentos Doc WITH (NOLOCK) ON Pac.PacDocCod = Doc.DocCod
LEFT JOIN Medicos Med WITH (NOLOCK) ON F.FacDisMed = Med.DisMedCod
LEFT JOIN IpsMedico IPS WITH (NOLOCK) ON F.FacDisIps = IPS.IpsMedCod
LEFT JOIN CIE CIE WITH (NOLOCK) ON F.FacCieCod = CIE.CieCod
INNER JOIN Kardex K WITH (NOLOCK) ON F.FacSec = K.FacSec AND K.KarSec < 500000 and K.KarUni > 0
INNER JOIN Articulos Art WITH (NOLOCK) ON K.ArtSec = Art.ArtSec
INNER JOIN PresentacionArticulos Pre WITH (NOLOCK) ON K.PreArtCod = Pre.PreArtCod
LEFT JOIN ContratosDispensacionReferenci CDR WITH (NOLOCK) ON F.FacConDisId = CDR.ConDisId AND K.KarMedMipCod = CDR.ConDisRefCod
LEFT JOIN Contratosdispensacion CD WITH (NOLOCK) ON F.FacConDisId  = CD.ConDisId 
LEFT JOIN Factura F2 ON F.facdoccom IS NOT NULL AND F.facdoccom <> '' AND F2.facdoccom = F.facdoccom AND F2.factiptra = 'FDV' AND F2.facsec <> F.facsec
WHERE f.FacEst = 'A'and ((@fecha_inicial_origen is not null and @fecha_final_origen is not null and F.FacFecTra BETWEEN @fecha_inicial_origen AND @fecha_final_origen)
or (@fecha_inicial_origen is null and @fecha_final_origen is null))
and 
((@fecha_inicial_dispensacion is not null and @fecha_final_dispensacion is not null and F.FacFec BETWEEN @fecha_inicial_dispensacion AND @fecha_final_dispensacion)
or (@fecha_inicial_dispensacion is null and @fecha_final_dispensacion is null))
and
--fecha kardex
((@fecha_inicial_fin_kardex is not null and @fecha_inicial_fin_kardex is not null and k.KarFec BETWEEN @fecha_inicial_ini_kardex AND @fecha_inicial_fin_kardex)
or (@fecha_inicial_ini_kardex is null and @fecha_inicial_fin_kardex is null))
and CD.ConDisTip = 'Cap'





