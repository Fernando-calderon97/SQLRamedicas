use ramedicasbi;
/*Eliminación movimiento tabla sync*/
delete from [RMD_10.192.4.2].[bd_ramedicas_sas].[dbo].[rmd_traoxwin]
/*Insertar movimiento mes tabla sync*/
insert into [RMD_10.192.4.2].[bd_ramedicas_sas].[dbo].[rmd_traoxwin]
select
*,
row_number() over(order by tip, doc) as Numerosecuencial
from
(
select 
    k.ka2 tip, 
    k.ka3 doc, 
    cast(k.ka4 as date) fech, 
    k.ka13 nitcli, 
    pos.nmstatus est, 
    k.ka1 codart, 
    k.kalote lot, 
    cast(k.kafv as date) fechv, 
    k.kaemb emb, 
    case 
        when k.kaex<>0 then cast((k.ka7*k.kaex)*(1+(k.kaiva/100))as int) else 0 end  vlr,
    cast(k.kaex as int)  und
    from [RMD_10.192.4.2].[bd_ramedicas_sas].[dbo].[pedi] f WITH(NOLOCK) 
    inner join [RMD_10.192.4.2].[bd_ramedicas_sas].[dbo].[PurchaseOrders20] po on f.con = po.idOrderExt 
    inner join [RMD_10.192.4.2].[bd_ramedicas_sas].[dbo].[clie] c WITH(NOLOCK) on c.cl1=f.fa1 
    inner join [RMD_10.192.4.2].[bd_ramedicas_sas].[dbo].[pd011225] k WITH(NOLOCK) on f.fa3=k.ka2 and f.fa2=k.ka3 
    inner join [RMD_10.192.4.2].[bd_ramedicas_sas].[dbo].[iA125] i WITH(NOLOCK) on i.in1=k.ka1 
    inner join [RMD_10.192.4.2].[bd_ramedicas_sas].[dbo].[PurchaseOrderStatus20] pos WITH(NOLOCK) on po.idStatus = pos.idStatus 
    left join [RMD_10.192.4.2].[bd_ramedicas_sas].[dbo].[nits2] n with(nolock) on f.fapac = n.ced  
    where f.fa6 <> 0 and k.ka4 >= '20251201' and 
    (datepart(hh,f.fafr) between 0 and 23) and k.ka2 = 'OX' and po.idStatus = 9 and 
    k.kaex<>0
)as mc
delete from [ramedicasbi].[dbo].[rmd_traoxwin]
where year(getdate()) = '2025' and month(getdate()) = '12'
/*Insertar movimiento mes tabla trabajo*/
insert into [ramedicasbi].[dbo].[rmd_traoxwin]
select
*
from [RMD_10.192.4.2][bd_ramedicas_sas].[dbo].[rmd_traoxwin]