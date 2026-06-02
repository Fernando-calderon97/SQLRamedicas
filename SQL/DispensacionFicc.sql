SELECT
    ISNULL(t.tipnom,'') as 'Tipo Comprobante',
    ISNULL(S.SucNom,'') as 'Sucursal',
    ISNULL(d2.DisDetNro,'') as 'Documento',
    CASE WHEN d2.DisDetEst = 'A' THEN 'Activo'
         WHEN d2.DisDetEst = 'I' THEN 'Inactivo'
         WHEN d2.DisDetEst = 'P' THEN 'En proceso' END AS 'Estado',
    d1.DisFecSol as 'Fecha Origen Dispensacion',
    f.FacFec AS 'Fecha Dispensacion',
    ISNULL(n.NitIde,'') AS 'Documento Cliente',
    ISNULL(n.NitCom,'') AS 'Razón Social',
    ISNULL(c.CliNom,'') AS 'Sigla Comercial Cliente',
    ISNULL(dn.DocHomMed,'') AS 'Documento Paciente',
    ISNULL(p.PacCedNum,'') AS 'Cédula Paciente',
    ISNULL(p.PacNomCom,'') AS 'Nombre Paciente',
    CASE ISNULL(p.PacRegSal,'') 
        WHEN 'S' THEN 'SUBSIDIADO' 
        WHEN 'C' THEN 'CONTRIBUTIVO' 
        WHEN 'V' THEN 'VINCULADO' 
        WHEN 'P' THEN 'PARTICULAR' 
        WHEN 'O' THEN 'OTROS' 
        WHEN 'E' THEN 'ESPECIAL' 
        ELSE '' END AS 'Regimen Paciente',
    CASE ISNULL(pe.ParEpsMedReg, '') 
        WHEN 'SUB' THEN 'SUBSIDIADO' 
        WHEN 'CON' THEN 'CONTRIBUTIVO' 
        WHEN 'VIN' THEN 'VINCULADO' 
        WHEN 'PAR' THEN 'PARTICULAR'  
        WHEN 'OTR' THEN 'OTROS' 
        WHEN 'ESP' THEN 'ESPECIAL' 
        ELSE '' END AS 'Regimen Cliente',
    ISNULL(p.PacPriNom,'') AS 'Primer Nombre',
    ISNULL(p.PacSegNom,'') AS 'Segundo Nombre',
    ISNULL(p.PacPriApe,'') AS 'Primer Apellido',
    ISNULL(p.PacSegApe,'') AS 'Segundo Apellido',
    p.PacFec AS 'Fecha Nacimiento Paciente',
    CASE 
        WHEN DATEDIFF(DAY, p.PacFec, GETDATE()) < 365 THEN 0 
        ELSE DATEDIFF(YEAR, p.PacFec, GETDATE()) 
             - CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, p.PacFec, GETDATE()), p.PacFec) > GETDATE() THEN 1 ELSE 0 END 
    END AS 'Edad Paciente',
    ISNULL(p.PacPes,0) AS 'Peso Paciente',
    CASE WHEN p.PacTutela = 'S' THEN 'SI'
         WHEN p.PacTutela = 'N' THEN 'NO' END AS 'Paciente Tutela',
    ISNULL(b.BodSucCCNom,'') AS 'Bodega Encabezado',
    CASE d2.DisTip 
        WHEN 'P' THEN 'POS' 
        WHEN 'A' THEN 'CAPITADO' 
        WHEN 'M' THEN 'MIPRES' 
        WHEN 'L' THEN 'AMBULANCIAS' 
        WHEN 'R' THEN 'ARL' END AS 'Tipo Servicio',
    d1.DisFecSol AS 'Fecha de Solicitud',
    d1.DisFecFor AS 'Fecha Formula Médica',
    ISNULL(p.PacCiuCod,'') AS 'Código Ciudad Paciente',
    ISNULL(ciu.CiuNom,'') AS 'Nombre Ciudad Paciente',
    ISNULL(dep.DepNom,'') AS 'Nombre Departamento Paciente',
    ISNULL(p.PacGenero,'') AS 'Genero',
    (select Top 1 DisDetFacDom from DispensacionFacturaDetalle WITH(NOLOCK) where DisId = d2.DisId and DisDetId = d2.DisDetId) as 'Domicilio',
    ISNULL(d1.DisCieCodPri,'') as 'Codigo CIE 10',
    ISNULL(cie.CieNom,'') as 'Descripcion CIE 10',
    ISNULL(co.CohoNom,'') as 'Cohorte',
    CASE 
        WHEN cdi.ContDisTipCont = 'CD' THEN 'Capita Codigo Directo' 
        WHEN cdi.ContDisTipCont = 'CP' THEN 'Capita Codigo Padre' 
        WHEN cdi.ContDisTipCont = 'EV' THEN 'Evento' 
        WHEN cdi.ContDisTipCont = 'MP' THEN 'Mipres' 
        WHEN cdi.ContDisTipCont = 'EM' THEN 'Evento Mipres' END AS 'Contrato',
    ISNULL(d1.DisEntDe,0) AS 'Entrega Inicial',
    ISNULL(d1.DisEntTot,0) AS 'Entrega Final',
    ISNULL(a.ArtCod,'') as 'Codigo Articulo',
    ISNULL(a.ArtNom,'') as 'Descripcion',
    ISNULL(pa.PreArtNom,'') as 'Presentacion',
    ISNULL(ig.InvGruNom,'') as 'Grupo',
    ISNULL(fk.KarUni,0) AS 'Unidades',
    ISNULL(fk.KarUniCP,0) AS 'Cantidad Autorizadas',
    ISNULL(fk.KarUniCP,0) AS 'Cantidad Prescrita',
    ISNULL(fk.KarUni,0) - ISNULL(fk.KarUniCp,0) as 'Diferencia',
    ISNULL(b.BodSucCCNom,'') as 'Bodega Detalle',
    ROUND(ISNULL(fk.KarPrePub, 0), 0) as 'Precio Publico',
    ISNULL(fk.KarDesVal,0) AS 'Descuento en Valor',
    ISNULL(fk.KarValTotMenDes,0) as 'TotalVenta',
    ISNULL(fk.KarPre,0) as 'Costo',
    ISNULL(fk.KarPre,0) * ISNULL(fk.KarUni,0) AS 'Costo Total',
    ISNULL(fk.KarMedCodCon,'') as 'Codigo Contrato',
    ISNULL(fk.KarMedCodMip,'') as 'Codigo Direccionamiento Mipres',
    ROUND(ISNULL(fk.KarPrePub, 0), 0) as 'Precio',
    ISNULL(depa.DepNom,'') as 'Municipio Tipo Comprobante',
    ISNULL(rsw.RadSopIde,0) as 'Id Solicitud Plataforma',
    ISNULL(a.ArtMedMin,0) AS 'Und Minima Dis',
    ISNULL(a.ArtMedMax,0) AS 'Und Maxima Dis',
    ISNULL(a.ArtAplDisFacMin,'') AS 'Aplica Factor en Dispensacion',
    ISNULL(d1.DisUsuCodMod,'') AS 'Usuario Modificacion',
    d1.DisFecMod AS 'Fecha Modificacion',
    ISNULL(ori.OriVenDesc,'') AS 'Origen Venta',
    ISNULL(m.DisMedCod,'') as 'Codigo Medico',
    ISNULL(m.DisMedNom,'') as 'Nombre Medico',
    ISNULL(esp.EspMedNom,'') as 'Especialidad Medico',
    ISNULL(fk.KarUniCie,0) as 'Unidades Cierre',
    d1.DisFecSol as 'Fecha en que se Genera el Pendiente',
    CASE WHEN fk.FacSecRem IS NULL OR fk.FacSecRem = '' OR fk.facsecrem = '0' THEN '' 
         ELSE CAST(f.FacFecTra AS VARCHAR) END as 'Fecha-Hora Entrega Pendiente',
    CASE WHEN fk.FacSecRem IS NULL OR fk.FacSecRem = '' OR fk.facsecrem = '0' THEN '' 
         ELSE f.FacUsuCod END as 'Usuario Pago Pendiente',
    ISNULL(cd.ContDisCod,0) as 'Id Contrato',
    ISNULL(f2.FacSecCop,'') as 'FacSec Factura Cuota Moderadora',
    ISNULL(f4.FacNro,'') as 'Numero Factura Cuota Moderadora',
    CASE WHEN p.PacExcCuoMod = 'S' THEN 'Si'
         WHEN p.PacExcCuoMod = 'N' THEN 'No' END AS '¿Excluir Cuota de manejo?',
    F2.FacFec as 'Fecha de Movimiento',
    ISNULL(p.PacTel,'') as 'Telefono',
    ISNULL(p.PacCelular,0) as 'Celular',
    ISNULL(a.ArtMedCon,'') as 'Concentracion',
    ISNULL(fk.KarLot,'') as 'Lote',
    fk.KarLotFec as 'Fecha de Vencimiento',
    ISNULL(a.ArtMedInv,'') as 'Lote Invima',
    ISNULL(pc.Parconiva,0) as '% Iva',
    ISNULL(a.ArtMedCum,'') as 'Cum',
    ISNULL(a.ArtMedVia,'') as 'Via Administracion',
    ISNULL(fk.KarMedDos,0) as 'Frecuencia del Tratamiento',
    ISNULL(fk.KarMedPer,0) as 'Duracion del Tratamiento',
    d2.DisDetAutFec as 'Fecha Autorizacion',
    CASE WHEN d2.DisTip = 'M' THEN 'NOPBS' ELSE 'PBS' END AS 'PBS/NOPBS',
    ISNULL(f2.FacNroCapPgp,'') as 'Factura Capita JSON',
    ISNULL(f2.FacSec,'') as 'FacSec',
    ISNULL(d1.DisUsuCodCre,'') as 'Usuario Creacion',
    ISNULL(d2.DisDetAut,'') as '# Autorizacion',
    ISNULL(d2.DisDetMipPre,'') as 'Prescripcion',
    ISNULL(d2.DisDetIdPrin,0) as 'Id Principal',
    ISNULL(d2.DisDetMipDir,0) as 'Id Direccionamiento',
    ISNULL(d2.DisDetMipPro,0) as 'Id Programacion',
    ISNULL(d2.DisDetMipEnt,0) as 'Id Entrega',
    ISNULL(d2.DisDetMipRep,0) as 'Id Reporte Entrega',
    ISNULL(epsd.EpsDisNom, '') AS 'EPS (Entidad Outsorcing)',
    CASE d2.DisDetAreSer 
        WHEN '1' THEN 'Urgencias' 
        WHEN '2' THEN 'Consulta Externa' 
        WHEN '3' THEN 'PyP' 
        WHEN '4' THEN 'Hospitalización' 
        WHEN '5' THEN 'Extramural' 
        WHEN '6' THEN 'Brigada Salud' 
        WHEN '0' THEN 'No Aplica' 
        ELSE '' END AS 'Area del Servicio',
    ISNULL(das.DetAreSerDes, '') AS 'Detalle Area del Servicio',
    ISNULL(d2.DisDetNumIngSif, '') AS 'Numero Ingreso',
    ISNULL(ipsm.IpsMedCod, '') AS 'Codigo IPS',
    ISNULL(ipsm.IpsMedNom,'') as 'Nombre IPS'

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
LEFT JOIN RadicacionSoporteWeb rsw WITH (NOLOCK) on rsw.RadSubDisId = d1.DisId
LEFT JOIN factura f3 WITH (NOLOCK) on f3.FacSec = fk.FacSecRem
LEFT JOIN factura f4 WITH (NOLOCK) on f4.FacSec = d2.FacCuoFacSec

WHERE 1=1 
    AND t.FueCod = 'DISP' 
    AND fk.KarUniCp > 0 
/*    AND (@EncDisTipSucCod IS NULL OR t.TipSucCod = @EncDisTipSucCod)
    AND (@DisNitSec IS NULL OR f.FacNitSec = @DisNitSec)
    AND (@EncDisTipCod IS NULL OR d1.DisTipCod = @EncDisTipCod)
    AND (@DisDetNro IS NULL OR d2.DisDetNro LIKE '%' + @DisDetNro + '%')
    AND (@DisTip IS NULL OR d2.DisTip = @DisTip)
    AND (@FechaInicioFac IS NULL OR f.FacFec > @FechaInicioFac)
    AND (@FechaFinFac IS NULL OR f.FacFec < @FechaFinFac)
    AND (@FechaInicioDis IS NULL OR d1.DisFecSol > @FechaInicioDis)
    AND (@FechaFinDis IS NULL OR d1.DisFecSol < @FechaFinDis)
    AND (@FiltroPaciente IS NULL OR (p.PacNomCom LIKE '%' + @FiltroPaciente + '%' OR p.PacCedNum LIKE '%' + @FiltroPaciente + '%'))
    AND (@encDisDetAut IS NULL OR d2.DisDetAut LIKE '%' + @encDisDetAut + '%')
    AND (@encOriVenCod IS NULL OR d1.DisOriVenCod = @encOriVenCod)
    AND (@EncDisUsuCodCre IS NULL OR d1.DisUsuCodCre LIKE '%' + @EncDisUsuCodCre + '%')
    AND ((@EncCobroPaciente = 'SI' AND d2.DisValCob >= 1) OR
        (@EncCobroPaciente = 'NO' AND d2.DisValCob = 0) OR
        (@EncCobroPaciente IS NULL))
    AND (@EncDisDetMipPre IS NULL OR d2.DisDetMipPre LIKE '%' + @EncDisDetMipPre + '%')
    AND (@encDisEst IS NULL OR d2.DisDetEst = @encDisEst)
    AND (@DisDetCapFacNro IS NULL OR d2.DisDetCapFacNro = @DisDetCapFacNro)
*/