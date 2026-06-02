delete from [RamedicasBI].[dbo].[rmd_maearticulo_ficc]
insert into [RamedicasBI].[dbo].[rmd_maearticulo_ficc] 
select
art.artsec,
art.ArtCod,
art.ArtNom,
art.ArtUniMedDis,
art.ArtMedUndMed,
art.ArtCodBar1 as ArtCodBar,
artpres.preartfacconval as ArtEmb, 
art.ArtPasCaj,
art.ParConCod,
parcon.ParConNom,
art.ArtMedCum,
art.ArtMedForFar,
art.ArtMedInv,
art.ArtMedNomCom,
art.ArtAtc,
art.ArtMedCon,
art.LabCod,
lab.LabNom as artlabnom,
artpres.preartcod as codpres,
art.ArtNomPrePrin as artpres,
carago.artagoini as fec_ini_ago, 
carago.artagofin as fec_fin_ago,
art.artcontrolado, 
art.artmedaltcos,  
art.artcondalmac,
art.GInId,
art.InvFamCod,
Inv.InvFamId,
Inv.InvFamNom,
Inv.InvSubGruCod,
art.InvCatCod as CatCod,
art.InvSubCatCod as SubCatCod,
art.ArtFecCrea as ArtFecCre,
art.ArtFecVenInv,
art.artCos2,
art.artCost1,
art.ArtRanPreMol,
art.ArtAgrIntCod,
CASE WHEN (carago.artagofin IS NULL OR carago.artagofin < GETDATE()) then 'N' else 'S' END AS estado_carago,
art.ArtMedPos,
art.ArtVidaUtil,
art.ArtMedDesAtc,
art.ArtPreMax,
art.ArtMedPriAct,
art.InvCatCod, 
ic.InvCatNom
FROM 
[RamedicasFiccERP].[dbo].[Articulos] art
left join [RamedicasFiccERP].[dbo].[InventarioFamilia] inv ON inv.InvFamCod = art.InvFamCod
left join [RamedicasFiccERP].[dbo].[InventarioSubgrupo] invsub ON invsub.invsubgrucod = inv.invsubgrucod
left join [RamedicasFiccERP].[dbo].[laboratorio] lab ON lab.labcod = art.labcod
left join [RamedicasFiccERP].[dbo].[articulospresentacion] artpres ON art.artsec = artpres.artsec
left join [RamedicasFICCERP].[dbo].[parametrocontable] parcon ON art.parconcod = parcon.parconcod
left join [RamedicasFICCERP].[dbo].[artgestiondocumentalago] carago ON art.artsec = carago.artsec  
and carago.artagosec = (SELECT MAX(ArtAgoSec) FROM [RamedicasFICCERP].[dbo].[artgestiondocumentalago] WHERE artsec = art.artsec)
left join [RamedicasFiccERP].[dbo].[InventarioCategoria] ic ON ic.InvCatCod = art.InvCatCod
where art.ArtSec not in (select ArtSec from RamedicasBI.dbo.rmd_maearticulo_ficc)