use ramedicas;
select distinct tp_doc, consol.origen
FROM
(
select
substring(comprobante.ComNum,1,2) as tp_doc,
substring(comprobante.ComNum,3,8) as cod_doc,
factura.FacTipCod as origen,
--tipos.TipNom as nomtiporg, /*eliminar solo lo cree para ver el nombre del tipo doc*/
comprobante.ComFecEnc as fecha,
articulos.ArtCod as codigo, 
articulos.ArtNom as descripcion,
kardex.KarUni as cant,
kardex.KarArtEmb as empaque,
kardex.KarPre as precio_uni,
kardex.KarUni * kardex.KarPre as precio_tot,
kardex.KarLot,
kardex.KarLotFec,
BodegaSucursalCC.BodCod,
BodegaSucursalCC.BodSucCCNom,
comprobante.ComNum,
comprobante.ComSec,
factura.FacSec,
comprobante.TipCod as tp
from Factura 
inner join Kardex on kardex.FacSec = factura.FacSec
inner join articulos on articulos.artsec = kardex.artsec
inner join BodegaSucursalCC on BodegaSucursalCC.BodSucCCSec = kardex.SubBodSucCCSec
inner join Comprobante on Factura.FacComSec = comprobante.ComSec
--inner join Tipos on factura.FacTipTra =  Tipos.TipCod /*eliminar solo lo cree para ver el nombre del tipo doc*/
where comprobante.ComFecEnc between '20250101' and '20251031' and factura.FacTipTra in ('inv','tra','ent','sal','ajt')
) as consol 
