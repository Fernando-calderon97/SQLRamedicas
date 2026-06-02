use ramedicas;
select distinct(origendoc) from (
select
--substring(comprobante.ComNum,1,2) as tipodoc,
--substring(comprobante.ComNum,3,8) as codigodoc,
comprobante.ComNum documento,
factura.FacTipTra as origendoc,
cast(comprobante.ComFecEnc as date) as fecha,
articulos.ArtCod as codigo, 
articulos.ArtNom as descripcion,
--kardex.KarNat as naturaleza,
case
    when kardex.KarNat = '+' then cast(kardex.KarUni as int)
    when kardex.KarNat = '-' then -cast(kardex.KarUni as int)
end as cantidad,
kardex.KarArtEmb as empaque,
cast(kardex.KarPre as int) as preciounitario,
cast(kardex.KarUni as int) * cast(kardex.KarPre as int) as preciototal,
kardex.KarLot,
cast(kardex.KarLotFec as date) fechalote,
BodegaSucursalCC.BodCod as codbodega,
BodegaSucursalCC.BodSucCCNom as bodega
--comprobante.ComSec,
--factura.FacSec,
--comprobante.TipCod as tp
from Factura 
inner join Kardex on kardex.FacSec = factura.FacSec
inner join articulos on articulos.artsec = kardex.artsec
inner join BodegaSucursalCC on BodegaSucursalCC.BodSucCCSec = kardex.SubBodSucCCSec
inner join Comprobante on Factura.FacComSec = comprobante.ComSec
where comprobante.ComFecEnc between '20250101' and '20251126' and factura.FacTipTra in ('inv','tra','ent','sal','ajt') and articulos.ArtCod = 'NV0006' /*and comprobante.ComNum like 'ox%'*/
) as t

select * from comprobante where tipcod = 'ajt'
select top 1000 * from Kardex