insert into rmd_traoxwin
select 
*,
row_number() over(order by doc,fech) as id
from
(
select 
    k.ka2 tip, 
    k.ka3 doc, 
    cast(k.ka4 as date) fech, 
    k.ka13 nitcli, 
    --c.cl2 nombre, 
    --c.cl3 razon_social, 
    pos.nmstatus est, 
    k.ka1 codart, 
    --i.in2 articulo, 
    
    --i.innc nomcomercial, 
    --i.in3 presentacion, 
    k.kalote lot, 
    cast(k.kafv as date) fechv, 
    k.kaemb emb, 
    case 
        when k.kaex<>0 then cast((k.ka7*k.kaex)*(1+(k.kaiva/100))as int) else 0 end  vlr,
    --0  caj , 
    cast(k.kaex as int)  und
    --n.ced CedPaciente, 
    --n.nom NomPaciente 
    from pedi f WITH(NOLOCK) 
    inner join PurchaseOrders20 po on f.con = po.idOrderExt 
    inner join clie c WITH(NOLOCK) on c.cl1=f.fa1 
    inner join pd011225 k WITH(NOLOCK) on f.fa3=k.ka2 and f.fa2=k.ka3 
    inner join iA125 i WITH(NOLOCK) on i.in1=k.ka1 
    inner join PurchaseOrderStatus20 pos WITH(NOLOCK) on po.idStatus = pos.idStatus 
    left join nits2 n with(nolock) on f.fapac = n.ced  
    where f.fa6 <> 0 and k.ka4 >= '20251201' and 
    (datepart(hh,f.fafr) between 0 and 23) and k.ka2 = 'OX' and po.idStatus = 9 and 
    k.kaex<>0
) as mc
