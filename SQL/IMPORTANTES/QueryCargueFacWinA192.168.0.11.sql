use ramedicasbk;
delete from [ramedicasbk].[dbo].[rmd_trafacwin01]
where fecdoc01 >= '20251201'
/*Insertar movimiento mes*/
insert into [ramedicasbk].[dbo].[rmd_trafacwin01]
select
*,
row_number() over(order by tipfac, docfac) as Numerosecuencial
from
(
select 
cast(ka4 as date) fecdoc01,
--'' as fecdoc02,
convert(char(10),ka4,120) fecdoc02,
convert(char(10),kafv,120) fecfac,
k.con as con,
ka2+ka3 facconcat,
ka2 as tipfac,
ka3 as docfac,
ka24 pedconcat,
substring(ka24,1,2) as tipped,
substring(ka24,3,6) as docped,
k.ka13 as nitclie,
clie.cl3 nomclie,
isnull(cna.ca2, '') as canal,
isnull(clie.cl13, '') as codven,
isnull(v.ve2, '') as nomven,
ia125.in2 as nomart,
k.ka1 as codart,
ia125.in3 presart,
ia125.innc as nomcomart,
ia125.invi as inviart,
ia125.incum as cumart,
ia125.in19 as codbarart,
kalote as loteart,
ia125.in12 as embart,
(ka5s-ka5e) cajart,
(ka6s-ka6e) cantart,
'vlrart'=case when t8 in('04','19') then case  WHEN f.IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when f.IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end, 
(ka12 -ka11 ) as tven,
(((ka5s*kaemb)+ka6s)* kapr ) as tcos,
'trent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end, 
nits.n4 as domppal,
ciud.ci2 as ciudad,
nits.n3 as coddepmun,
customeraddress.dscustomeraddress as dirent,
PopulationCentre.nmPopCentre as mundp,
f.fa20 +' ' + f.fa21 + ' ' + f.fa22 as obsv
from [rmd_10.192.4.2].[bd_ramedicas_sas].[dbo].[ka011225] k WITH(NOLOCK) 
inner join [rmd_10.192.4.2].[bd_ramedicas_sas].[dbo].[iA125] WITH(NOLOCK) on ka1=in1 
inner join [rmd_10.192.4.2].[bd_ramedicas_sas].[dbo].[tipo] WITH(NOLOCK) on ka2=t1 
left join [rmd_10.192.4.2].[bd_ramedicas_sas].[dbo].[clie] WITH(NOLOCK) on ka13=cl1 
--left join nits2 WITH(NOLOCK) on kaprov=ced 
left join [rmd_10.192.4.2].[bd_ramedicas_sas].[dbo].[ciud] WITH(NOLOCK) on cl36=ci1  
left join [rmd_10.192.4.2].[bd_ramedicas_sas].[dbo].[facc] f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join [rmd_10.192.4.2].[bd_ramedicas_sas].[dbo].[vend] v on cl13 = v.ve4 
left join [rmd_10.192.4.2].[bd_ramedicas_sas].[dbo].[nits] on ka13 = n1
left join [rmd_10.192.4.2].[bd_ramedicas_sas].[dbo].[cana] cna on cl18a = cna.ca1
left join [rmd_10.192.4.2].[bd_ramedicas_sas].[dbo].[CustomerAddress] on f.idcustomeraddress = customeraddress.idcustomeraddress
left join [rmd_10.192.4.2].[bd_ramedicas_sas].[dbo].[PopulationCentre] on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where tipo.t8 in('04','08','NR','19') and k.ka4 >= '20251201'
)as mc
