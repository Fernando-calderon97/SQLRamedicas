SELECT 
        ISNULL(t.tipnom,'') as 'Tipo Comprobante', -- 1
        ISNULL(d2.DisDetNro,'') as 'Documento', -- 3
        f.FacFec AS 'Fecha Dispensacion', -- 4
        d1.DisFecSol as 'Fecha Origen', -- 5
        d1.DisFecSol AS 'Fecha de Solicitud', -- 6
        d1.DisFecMod AS 'Fecha Modificacion', -- 7
        ISNULL(n.NitIde,'') AS 'Documento Cliente', -- 8
        ISNULL(dn.DocHomMed,'') AS 'Documento Paciente', -- 10
        ISNULL(p.PacCedNum,'') AS 'Cedula Paciente', -- 11
        ISNULL(p.PacNomCom,'') AS 'Nombre Paciente', -- 12
        CASE ISNULL(p.PacRegSal,'') 
            WHEN 'S' THEN 'SUBSIDIADO' 
            WHEN 'C' THEN 'CONTRIBUTIVO' 
            WHEN 'V' THEN 'VINCULADO' 
            WHEN 'P' THEN 'PARTICULAR' 
            WHEN 'O' THEN 'OTROS' 
            WHEN 'E' THEN 'ESPECIAL' 
            ELSE '' END AS 'Regimen Paciente', -- 13
        CASE d2.DisTip 
            WHEN 'P' THEN 'POS' 
            WHEN 'A' THEN 'CAPITADO' 
            WHEN 'M' THEN 'MIPRES' 
            WHEN 'L' THEN 'AMBULANCIAS' 
            WHEN 'R' THEN 'ARL' END AS 'Tipo Servicio', -- 14
        d1.DisFecFor AS 'Fecha Formula', -- 15
        0 AS 'Cuota recaudo', -- 16 /*Pendiete por validar*/
        ISNULL(p.PacCiuCod,'') AS 'Codigo Ciudad', -- 17
        ISNULL(ciu.CiuNom,'') AS 'Nombre Ciudad', -- 18
        ISNULL(dep.DepNom,'') AS 'Nombre Departamento', -- 19
        ISNULL(p.PacGenero,'') AS 'Genero', -- 20
        ISNULL(m.DisMedCod,'') as 'Codigo Medico', -- 21
        ISNULL(m.DisMedNom,'') as 'Nombre Medico', -- 22
        ISNULL(ipsm.IpsMedCod, '') AS 'Codigo IPS', -- 23
        ISNULL(ipsm.IpsMedNom,'') as 'Nombre IPS', -- 24
        ISNULL(d1.DisCieCodPri,'') as 'Codigo CIE 10', -- 25
        ISNULL(cie.CieNom,'') as 'Descripcion CIE 10', -- 26
        ISNULL(co.CohoNom,'') as 'Cohorte', -- 27
        --f.FacObs AS 'Observacion', -- 28
        ISNULL(a.ArtCod,'') as 'Codigo Articulo', -- 29
        --ISNULL(a.ArtNom,'') as 'Descripcion', -- 30
        ISNULL(pa.PreArtNom,'') as 'Presentacion', -- 31
        ISNULL(ig.InvGruNom,'') as 'Grupo', -- 32
        ISNULL(fk.KarUni,0) AS 'Unidades', -- 33
        ISNULL(fk.KarUniCP,0) AS 'Cantidad Autorizadas', -- 34
        ISNULL(fk.KarUniCP,0) AS 'Cantidad Prescrita', -- 35
        ABS(ISNULL(fk.KarUniCp,0) - ISNULL(fk.KarUni,0)) as 'Cantidad Pendiente', -- 36
        ROUND(ISNULL(fk.KarPrePub, 0), 0) as 'Precio al Publico', -- 37
        ABS(ISNULL(fk.KarUniCp,0) - ISNULL(fk.KarUni,0)) * ROUND(ISNULL(fk.KarPrePub, 0), 0) AS "TotalVlrPendiente",
        fk.karvaltotMenDes AS 'TotalVentaBruta', -- 38
        fk.KarPorIva AS 'PorcentajeIVA', -- 39
        fk.KarArtIva AS 'TotalIVA', -- 40
        ISNULL(fk.KarValTotMenDes + fk.KarArtIva,0) as 'TotalVentaNeta', -- 41
        ISNULL(fk.KarPre,0) as 'Costo', -- 42
        ISNULL(fk.KarPre,0) * ISNULL(fk.KarUni,0) AS 'Costo Total', -- 43
        a.ArtMedRes AS 'Articulo Controlado', -- 44
        ISNULL(a.ArtMedCum,'') as 'Cum', -- 45
        a.ArtAtc AS 'Atc', -- 46
        ISNULL(a.ArtMedInv,'') as 'Invima', -- 47
        '' AS 'Medicamento PyP?', -- 48 /*Pendiente por validar*/
        '' AS 'Categoria Articulo', -- 49 /*Pendiente por validar*/
        '' AS 'Sub Categoria Articulo', -- 50 /*Pendiente por validar*/
        fk.KarLot as 'Lote', -- 51
        fk.KarLotFec as 'Fecha de Vencimiento', -- 52
        '' AS 'Codigo autorizado', -- 53 /*Pendiente por validar*/
        '' AS 'Codigo tecnologia', -- 54 /*Pendiente por validar*/
        a.artpremax AS 'Precio maximo', -- 55
        a.ArtPreMaxCir AS 'Circular Precio', -- 56
        CASE WHEN d2.DisTip = 'M' THEN 'NOPBS' ELSE 'PBS' END AS 'PBS/NOPBS', -- 57
        fk.KarMedDos AS 'Dosis', -- 58
        fk.KarMedPer AS 'Periodo Dispensas', -- 59
        ISNULL(ciud.CiuNom,'') as 'Municipio Tipo', -- 60
        ISNULL(fk.KarMedCodCon,'') as 'Codigo Contrato', -- 61
        --'' AS 'Descripcion Cliente', -- 62 /*Pendiente por validar*/
        cd.ConDisRefVal AS 'Precio Cliente', -- 63
        ISNULL(ori.OriVenDesc,'') AS 'Origen Venta', -- 64
        ISNULL(esp.EspMedNom,'') as 'Especialidad Medico', -- 65
        ISNULL(cd.ContDisCod,0) as 'Id Contrato', -- 66
        CASE  
            WHEN cdi.ContDisTipCont = 'CD' THEN 'Capita Codigo Directo' 
            WHEN cdi.ContDisTipCont = 'CP' THEN 'Capita Codigo Padre' 
            WHEN cdi.ContDisTipCont = 'EV' THEN 'Evento' 
            WHEN cdi.ContDisTipCont = 'MP' THEN 'Mipres' 
            WHEN cdi.ContDisTipCont = 'EM' THEN 'Evento Mipres' END AS 'Contrato', -- 67
        ISNULL(f4.FacNro,'') as 'FacturaCM', -- 68
        ISNULL(fk2.karvaltotMenDes,0) AS 'Cuota Moderadora',  -- 69
        F2.FacFec AS 'Fecha Factura', -- 70
        F2.FacNro AS 'Factura', -- 71
        0 AS 'Cantidad soportes', -- 72
        0 AS 'Unidades Cierre', -- 73
        NULL AS 'Fecha cierre', -- 74
        'FICC2026S1' AS 'ERP'
FROM Dispensacion d1 WITH (NOLOCK)
INNER JOIN DispensacionDetalleServicio d2 WITH (NOLOCK) on d2.DisId = d1.DisId
INNER JOIN factura f WITH (NOLOCK) on f.DisId = d2.DisId and f.DisDetId = d2.DisDetId
INNER JOIN FacturaKardex fk WITH (NOLOCK) on fk.FacSec = f.FacSec
LEFT JOIN DispensacionFacturaFacturaDeta d3 WITH (NOLOCK) on d3.DisId = d2.DisId and d3.DisDetId = d2.DisDetId
LEFT JOIN Factura f2 WITH (NOLOCK) on f2.FacSec = d3.DisFacFacFacSec and f2.FacEst = 'A'
LEFT JOIN Tipos t WITH (NOLOCK) on t.TipCod = f.FacTipCod
LEFT JOIN Tipos t2 WITH (NOLOCK) on t2.TipCod = f2.FacTipCod and t2.FueCod = 'FACT'
LEFT JOIN Sucursales s WITH (NOLOCK) on s.SucCod = t.TipSucCod
LEFT JOIN Nit n WITH (NOLOCK) on n.NitSec = d1.DisNitSec
LEFT JOIN Clientes c WITH (NOLOCK) on c.NitSec = d1.DisNitSec and c.CliSec = d1.DisCliSec
LEFT JOIN ContratosDispensacionReferenci cd WITH (NOLOCK) on cd.ConDisRefCod = fk.KarConDisRefCod and cd.ContDisCod = fk.KarContDisCod
INNER JOIN Articulos a WITH (NOLOCK) on CAST(fk.ArtSec AS VARCHAR) = a.ArtSec
LEFT JOIN ParametroContable pc WITH (NOLOCK) on pc.ParConCod = a.ParConCod
LEFT JOIN PresentacionArticulos pa WITH (NOLOCK) on pa.PreArtCod = fk.PreArtCod
LEFT JOIN Bodegas b WITH (NOLOCK) on fk.SubBodSucCCSec = b.BodSucCCSec
LEFT JOIN Pacientes p WITH (NOLOCK) on p.PacCedSec = d1.DisPacCedSec
LEFT JOIN DocumentosNit dn WITH (NOLOCK) ON dn.DocCod = p.PacDocCod
LEFT JOIN ciudades ciu WITH (NOLOCK) on ciu.CiuCod = p.PacCiuCod
LEFT JOIN Medicos m WITH (NOLOCK) on m.DisMedId = d1.DisDisMedId
LEFT JOIN Departamentos dep WITH (NOLOCK) on dep.DepCod = ciu.DepCod
LEFT JOIN Cie cie WITH (NOLOCK) on cie.CieCod = d1.DisCieCodPri
LEFT JOIN Cohorte co WITH (NOLOCK) on co.CohoId = cie.CohoId
LEFT JOIN ContratosDispensacion cdi WITH (NOLOCK) on cdi.ContDisCod = d2.ContDisCod
LEFT JOIN Ciudades ciud WITH (NOLOCK) ON ciud.CiuCod = t.TipSubCiuCod
LEFT JOIN Departamentos depa WITH (NOLOCK) ON depa.DepCod = ciud.DepCod
LEFT JOIN OrigenVenta ori WITH (NOLOCK) ON ori.OriVenCod = d1.DisOriVenCod
LEFT JOIN EspecialidadesMedicas esp WITH (NOLOCK) ON esp.EspMedCod = m.EspMedCod
LEFT JOIN InventarioFamilia invf WITH (NOLOCK) ON invf.InvFamCod = a.InvFamCod
LEFT JOIN InventarioSubGrupo invsg WITH (NOLOCK) ON invsg.InvSubGruCod = invf.InvSubGruCod
LEFT JOIN InventarioGrupo ig WITH (NOLOCK) ON ig.InvGruCod = invsg.InvGruCod
LEFT JOIN ParametricaEps pe WITH (NOLOCK) ON pe.ParEpsSec = c.ParEpsSec
LEFT JOIN DetalleAreaServicio das WITH (NOLOCK) ON das.DetAreSerSec = d2.SubDetAreSerSec
LEFT JOIN EpsDispensacion epsd WITH (NOLOCK) ON epsd.EpsDisId = d2.SubDisDetEpsDisId
LEFT JOIN IpsMedico ipsm WITH (NOLOCK) on ipsm.IpsMedSec = d1.DisIpsMedSec
LEFT JOIN RadicacionSoporteWeb rsw WITH (NOLOCK) ON rsw.RadSubDisId = d1.DisId
LEFT JOIN factura f3 WITH (NOLOCK) ON f3.FacSec = fk.FacSecRem
LEFT JOIN factura f4 WITH (NOLOCK) ON f4.FacSec = d2.FacCuoFacSec
LEFT JOIN FacturaKardex fk2 WITH (NOLOCK) ON  fk2.FacSec = f4.facsec

WHERE t.FueCod = 'DISP' 
    AND f.facfec BETWEEN '20260101' and  DATEADD(DAY, -1, GETDATE())
    AND f.facest = 'A'
    AND 
    (
        (f.FacTipcod = 'RB1' AND f.facfec >= '20260101')
        OR
        (f.FacTipcod = 'RC1' AND f.facfec >= '20260309')
        OR
        (f.FacTipcod = 'RE3' AND f.facfec >= '20260309')
        OR
        (f.FacTipcod = 'RG4' AND f.facfec >= '20260309')
        OR
        (f.FacTipcod = 'RL2' AND f.facfec >= '20260309')
        OR
        (f.FacTipcod = 'RM5' AND f.facfec >= '20260309')
        OR
        (f.FacTipcod = 'RM6' AND f.facfec >= '20260309')
        OR
        (f.FacTipcod = 'RQ1' AND f.facfec >= '20260101')
        OR
        (f.FacTipcod = 'RV8' AND f.facfec >= '20260309')
        OR
        (f.FacTipcod = 'RS7' AND f.facfec >= '20260309')
    )