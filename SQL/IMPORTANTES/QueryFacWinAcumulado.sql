
select 
codciuent AS 'codigo_ciudad',
ciudent  AS 'nombre_ciudad',
Month(fech) AS 'mes',
COUNt(DISTINCT(arti)) AS 'items',
sum(caja) AS 'cajas',
sum(vlr) AS 'valor'
from
(
--enero
select
k.con,
ka2+ka3 docm, 
--isnull(kaprov,'') cedpac, /*Vacio �Necesario?*/
--isnull(nom,'') nompac, /*Vacio �Necesario?*/
ka13 prov,
cl3 nomb,
ci2 ciudad, 
--nits.n3 codciud,
--nits.n4 dircli, 
customeraddress.dscustomeraddress dirent,
PopulationCentre.nmPopCentre ciudent,
PopulationCentre.cdCity codciuent,
ka24 ped,
convert(char(10),ka4,103) fech,
ka1 arti,
--in2 noma,
--in3 pres,
--innc nomc,
--in12 emb,
--invi,
incum cum,
--in19 codbar,
cast((ka5s-ka5e) as int) as  caja,
--cast((ka6s-ka6e) as int) as unid,  ----- /*Vacio �Necesario?, ya tenemos caja*/
'vlr'= cast(case when t8 in('04','19') then case  WHEN IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end as float), 
kalote lote
--convert(char(10),kafv,103) fecv,(ka12 -ka11 ) tven,
--(((ka5s*kaemb)+ka6s)* kapr ) tcos,
--'rent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end,
--cast(ka4 as date) nodefinido,  /*No defindido �Que fecha hace referencia? hay un car ka4 arriba*/
--isnull(cl13, '') cVend, 
--isnull(v.ve2, '') nVend, 
--isnull(cna.ca2, '') canal  
from ka010125 k WITH(NOLOCK) 
inner join iA125 WITH(NOLOCK) on ka1=in1 
inner join tipo WITH(NOLOCK) on ka2=t1 
left join clie WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join ciud WITH(NOLOCK) on cl36=ci1  
left join facc f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join vend v on cl13 = v.ve4 
left join nits on ka13 = n1
left join cana cna on cl18a = cna.ca1  
left join CustomerAddress on f.idcustomeraddress = customeraddress.idcustomeraddress
left join PopulationCentre on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where t8 in('04','08','NR','19') and (ka4 between '20250101'  and '20250131') /*and 
ka13 in (select n1 from nits where n3 like '85%')*/-- and CAST(PopulationCentre.cdCity AS VARCHAR) like '05%'

union

--febrero
select
k.con,
ka2+ka3 docm, 
--isnull(kaprov,'') cedpac, /*Vacio �Necesario?*/
--isnull(nom,'') nompac, /*Vacio �Necesario?*/
ka13 prov,
cl3 nomb,
ci2 ciudad, 
--nits.n3 codciud,
--nits.n4 dircli, 
customeraddress.dscustomeraddress dirent,
PopulationCentre.nmPopCentre ciudent,
PopulationCentre.cdCity codciuent,
ka24 ped,
convert(char(10),ka4,103) fech,
ka1 arti,
--in2 noma,
--in3 pres,
--innc nomc,
--in12 emb,
--invi,
incum cum,
--in19 codbar,
cast((ka5s-ka5e) as int) as  caja,
--cast((ka6s-ka6e) as int) as unid,  ----- /*Vacio �Necesario?, ya tenemos caja*/
'vlr'= cast(case when t8 in('04','19') then case  WHEN IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end as float), 
kalote lote
--convert(char(10),kafv,103) fecv,(ka12 -ka11 ) tven,
--(((ka5s*kaemb)+ka6s)* kapr ) tcos,
--'rent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end,
--cast(ka4 as date) nodefinido,  /*No defindido �Que fecha hace referencia? hay un car ka4 arriba*/
--isnull(cl13, '') cVend, 
--isnull(v.ve2, '') nVend, 
--isnull(cna.ca2, '') canal  
from ka010225 k WITH(NOLOCK) 
inner join iA125 WITH(NOLOCK) on ka1=in1 
inner join tipo WITH(NOLOCK) on ka2=t1 
left join clie WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join ciud WITH(NOLOCK) on cl36=ci1  
left join facc f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join vend v on cl13 = v.ve4 
left join nits on ka13 = n1
left join cana cna on cl18a = cna.ca1  
left join CustomerAddress on f.idcustomeraddress = customeraddress.idcustomeraddress
left join PopulationCentre on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where t8 in('04','08','NR','19') and (ka4 between '20250201'  and '20250228') /*and 
ka13 in (select n1 from nits where n3 like '85%')*/ --and CAST(PopulationCentre.cdCity AS VARCHAR) like '05%'

union

--marzo
select
k.con,
ka2+ka3 docm,
--isnull(kaprov,'') cedpac, /*Vacio �Necesario?*/
--isnull(nom,'') nompac, /*Vacio �Necesario?*/
ka13 prov,
cl3 nomb,
ci2 ciudad, 
--nits.n3 codciud,
--nits.n4 dircli, 
customeraddress.dscustomeraddress dirent,
PopulationCentre.nmPopCentre ciudent,
PopulationCentre.cdCity codciuent,
ka24 ped,
convert(char(10),ka4,103) fech,
ka1 arti,
--in2 noma,
--in3 pres,
--innc nomc,
--in12 emb,
--invi,
incum cum,
--in19 codbar,
cast((ka5s-ka5e) as int) as  caja,
--cast((ka6s-ka6e) as int) as unid,  ----- /*Vacio �Necesario?, ya tenemos caja*/
'vlr'= cast(case when t8 in('04','19') then case  WHEN IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end as float), 
kalote lote
--convert(char(10),kafv,103) fecv,(ka12 -ka11 ) tven,
--(((ka5s*kaemb)+ka6s)* kapr ) tcos,
--'rent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end,
--cast(ka4 as date) nodefinido, /*No defindido �Que fecha hace referencia? hay un car ka4 arriba*/
--isnull(cl13, '') cVend, 
--isnull(v.ve2, '') nVend, 
--isnull(cna.ca2, '') canal   
from ka010325 k WITH(NOLOCK) 
inner join iA125 WITH(NOLOCK) on ka1=in1 
inner join tipo WITH(NOLOCK) on ka2=t1 
left join clie WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join ciud WITH(NOLOCK) on cl36=ci1  
left join facc f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join vend v on cl13 = v.ve4 
left join nits on ka13 = n1
left join cana cna on cl18a = cna.ca1
left join CustomerAddress on f.idcustomeraddress = customeraddress.idcustomeraddress  
left join PopulationCentre on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where t8 in('04','08','NR','19') and (ka4 between '20250301'  and '20250331') /*and 
ka13 in (select n1 from nits where n3 like '85%')*/ --and CAST(PopulationCentre.cdCity AS VARCHAR) like '05%'

union

--abril
select
k.con,
ka2+ka3 docm,
--isnull(kaprov,'') cedpac, /*Vacio �Necesario?*/
--isnull(nom,'') nompac, /*Vacio �Necesario?*/
ka13 prov,
cl3 nomb,
ci2 ciudad, 
--nits.n3 codciud,
--nits.n4 dircli, 
customeraddress.dscustomeraddress dirent,
PopulationCentre.nmPopCentre ciudent,
PopulationCentre.cdCity codciuent,
ka24 ped,
convert(char(10),ka4,103) fech,
ka1 arti,
--in2 noma,
--in3 pres,
--innc nomc,
--in12 emb,
--invi,
incum cum,
--in19 codbar,
cast((ka5s-ka5e) as int) as  caja,
--cast((ka6s-ka6e) as int) as unid,  ----- /*Vacio �Necesario?, ya tenemos caja*/
'vlr'= cast(case when t8 in('04','19') then case  WHEN IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end as float), 
kalote lote
--convert(char(10),kafv,103) fecv,(ka12 -ka11 ) tven,
--(((ka5s*kaemb)+ka6s)* kapr ) tcos,
--'rent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end,
--cast(ka4 as date) nodefinido,  /*No defindido �Que fecha hace referencia? hay un car ka4 arriba*/
--isnull(cl13, '') cVend, 
--isnull(v.ve2, '') nVend, 
--isnull(cna.ca2, '') canal  
from ka010425 k WITH(NOLOCK) 
inner join iA125 WITH(NOLOCK) on ka1=in1 
inner join tipo WITH(NOLOCK) on ka2=t1 
left join clie WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join ciud WITH(NOLOCK) on cl36=ci1  
left join facc f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join vend v on cl13 = v.ve4 
left join nits on ka13 = n1
left join cana cna on cl18a = cna.ca1  
left join CustomerAddress on f.idcustomeraddress = customeraddress.idcustomeraddress
left join PopulationCentre on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where t8 in('04','08','NR','19') and (ka4 between '20250401'  and '20250430') /*and 
ka13 in (select n1 from nits where n3 like '85%')*/ --and CAST(PopulationCentre.cdCity AS VARCHAR) like '05%'

union

--mayo
select
k.con,
ka2+ka3 docm,
--isnull(kaprov,'') cedpac, /*Vacio �Necesario?*/
--isnull(nom,'') nompac, /*Vacio �Necesario?*/
ka13 prov,
cl3 nomb,
ci2 ciudad, 
--nits.n3 codciud,
--nits.n4 dircli, 
customeraddress.dscustomeraddress dirent,
PopulationCentre.nmPopCentre ciudent,
PopulationCentre.cdCity codciuent,
ka24 ped,
convert(char(10),ka4,103) fech,
ka1 arti,
--in2 noma,
--in3 pres,
--innc nomc,
--in12 emb,
--invi,
incum cum,
--in19 codbar,
cast((ka5s-ka5e) as int) as  caja,
--cast((ka6s-ka6e) as int) as unid,  ----- /*Vacio �Necesario?, ya tenemos caja*/
'vlr'= cast(case when t8 in('04','19') then case  WHEN IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end as float), 
kalote lote
--convert(char(10),kafv,103) fecv,(ka12 -ka11 ) tven,
--(((ka5s*kaemb)+ka6s)* kapr ) tcos,
--'rent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end,
--cast(ka4 as date) nodefinido,  /*No defindido �Que fecha hace referencia? hay un car ka4 arriba*/
--isnull(cl13, '') cVend, 
--isnull(v.ve2, '') nVend, 
--isnull(cna.ca2, '') canal  
from ka010525 k WITH(NOLOCK) 
inner join iA125 WITH(NOLOCK) on ka1=in1 
inner join tipo WITH(NOLOCK) on ka2=t1 
left join clie WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join ciud WITH(NOLOCK) on cl36=ci1  
left join facc f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join vend v on cl13 = v.ve4 
left join nits on ka13 = n1
left join cana cna on cl18a = cna.ca1 
left join CustomerAddress on f.idcustomeraddress = customeraddress.idcustomeraddress
left join PopulationCentre on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where t8 in('04','08','NR','19') and (ka4 between '20250501'  and '20250531') /*and 
ka13 in (select n1 from nits where n3 like '85%')*/ --and CAST(PopulationCentre.cdCity AS VARCHAR) like '05%'

union 

--junio
select
k.con,
ka2+ka3 docm,
--isnull(kaprov,'') cedpac, /*Vacio �Necesario?*/
--isnull(nom,'') nompac, /*Vacio �Necesario?*/
ka13 prov,
cl3 nomb,
ci2 ciudad, 
--nits.n3 codciud,
--nits.n4 dircli, 
customeraddress.dscustomeraddress dirent,
PopulationCentre.nmPopCentre ciudent,
PopulationCentre.cdCity codciuent,
ka24 ped,
convert(char(10),ka4,103) fech,
ka1 arti,
--in2 noma,
--in3 pres,
--innc nomc,
--in12 emb,
--invi,
incum cum,
--in19 codbar,
cast((ka5s-ka5e) as int) as  caja,
--cast((ka6s-ka6e) as int) as unid,  ----- /*Vacio �Necesario?, ya tenemos caja*/
'vlr'= cast(case when t8 in('04','19') then case  WHEN IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end as float), 
kalote lote
--convert(char(10),kafv,103) fecv,(ka12 -ka11 ) tven,
--(((ka5s*kaemb)+ka6s)* kapr ) tcos,
--'rent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end,
--cast(ka4 as date) nodefinido, /*No defindido �Que fecha hace referencia? hay un car ka4 arriba*/
--isnull(cl13, '') cVend, 
--isnull(v.ve2, '') nVend, 
--isnull(cna.ca2, '') canal  
from ka010625 k WITH(NOLOCK) 
inner join iA125 WITH(NOLOCK) on ka1=in1 
inner join tipo WITH(NOLOCK) on ka2=t1 
left join clie WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join ciud WITH(NOLOCK) on cl36=ci1  
left join facc f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join vend v on cl13 = v.ve4 
left join nits on ka13 = n1
left join cana cna on cl18a = cna.ca1 
left join CustomerAddress on f.idcustomeraddress = customeraddress.idcustomeraddress
left join PopulationCentre on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where t8 in('04','08','NR','19') and (ka4 between '20250601'  and '20250630') /*and 
ka13 in (select n1 from nits where n3 like '85%')*/ --and CAST(PopulationCentre.cdCity AS VARCHAR) like '05%'

union

--julio
select
k.con,
ka2+ka3 docm,
--isnull(kaprov,'') cedpac, /*Vacio �Necesario?*/
--isnull(nom,'') nompac, /*Vacio �Necesario?*/
ka13 prov,
cl3 nomb,
ci2 ciudad, 
--nits.n3 codciud,
--nits.n4 dircli, 
customeraddress.dscustomeraddress dirent,
PopulationCentre.nmPopCentre ciudent,
populationCentre.cdCity codciuent,
ka24 ped,
convert(char(10),ka4,103) fech,
ka1 arti,
--in2 noma,
--in3 pres,
--innc nomc,
--in12 emb,
--invi,
incum cum,
--in19 codbar,
cast((ka5s-ka5e) as int) caja,
--cast((ka6s-ka6e) as int) as unid,  ----- /*Vacio �Necesario?, ya tenemos caja*/
'vlr'= cast(case when t8 in('04','19') then case  WHEN IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end as float), 
kalote lote
--convert(char(10),kafv,103) fecv,(ka12 -ka11 ) tven,
--(((ka5s*kaemb)+ka6s)* kapr ) tcos,
--'rent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end,
--cast(ka4 as date) nodefinido,  /*No defindido �Que fecha hace referencia?*/
--isnull(cl13, '') cVend, 
--isnull(v.ve2, '') nVend, 
--isnull(cna.ca2, '') canal  
from ka010725 k WITH(NOLOCK) 
inner join iA125 WITH(NOLOCK) on ka1=in1 
inner join tipo WITH(NOLOCK) on ka2=t1 
left join clie WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join ciud WITH(NOLOCK) on cl36=ci1  
left join facc f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join vend v on cl13 = v.ve4 
left join nits on ka13 = n1
left join cana cna on cl18a = cna.ca1 
left join CustomerAddress on f.idcustomeraddress = customeraddress.idcustomeraddress
left join PopulationCentre on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where t8 in('04','08','NR','19') and (ka4 between '20250701'  and '20250731') /*and 
ka13 in (select n1 from nits where n3 like '85%')*/ --and CAST(PopulationCentre.cdCity AS VARCHAR) like '05%'

union

--agosto
select
k.con,
ka2+ka3 docm,
--isnull(kaprov,'') cedpac, /*Vacio �Necesario?*/
--isnull(nom,'') nompac, /*Vacio �Necesario?*/
ka13 prov,
cl3 nomb,
ci2 ciudad, 
--nits.n3 codciud,
--nits.n4 dircli, 
customeraddress.dscustomeraddress dirent,
PopulationCentre.nmPopCentre ciudent,
PopulationCentre.cdCity codciuent,
ka24 ped,
convert(char(10),ka4,103) fech,
ka1 arti,
--in2 noma,
--in3 pres,
--innc nomc,
--in12 emb,
--invi,
incum cum,
--in19 codbar,
cast((ka5s-ka5e) as int) as  caja,
--cast((ka6s-ka6e) as int) as unid,  ----- /*Vacio �Necesario?, ya tenemos caja*/
'vlr'= cast(case when t8 in('04','19') then case  WHEN IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end as float), 
kalote lote
--convert(char(10),kafv,103) fecv,(ka12 -ka11 ) tven,
--(((ka5s*kaemb)+ka6s)* kapr ) tcos,
--'rent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end,
--cast(ka4 as date) nodefinido,  /*No defindido �Que fecha hace referencia? hay un car ka4 arriba*/
--isnull(cl13, '') cVend, 
--isnull(v.ve2, '') nVend, 
--isnull(cna.ca2, '') canal  
from ka010825 k WITH(NOLOCK) 
inner join iA125 WITH(NOLOCK) on ka1=in1 
inner join tipo WITH(NOLOCK) on ka2=t1 
left join clie WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join ciud WITH(NOLOCK) on cl36=ci1  
left join facc f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join vend v on cl13 = v.ve4 
left join nits on ka13 = n1
left join cana cna on cl18a = cna.ca1 
left join CustomerAddress on f.idcustomeraddress = customeraddress.idcustomeraddress
left join PopulationCentre on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where t8 in('04','08','NR','19') and (ka4 between '20250801'  and '20250831') /*and 
ka13 in (select n1 from nits where n3 like '85%')*/ --and CAST(PopulationCentre.cdCity AS VARCHAR) like '05%'

union 

--septiembre
select
k.con,
ka2+ka3 docm,
--isnull(kaprov,'') cedpac, /*Vacio �Necesario?*/
--isnull(nom,'') nompac, /*Vacio �Necesario?*/
ka13 prov,
cl3 nomb,
ci2 ciudad, 
--nits.n3 codciud,
--nits.n4 dircli, 
customeraddress.dscustomeraddress dirent,
PopulationCentre.nmPopCentre ciudent,
PopulationCentre.cdCity codciuent,
ka24 ped,
convert(char(10),ka4,103) fech,
ka1 arti,
--in2 noma,
--in3 pres,
--innc nomc,
--in12 emb,
--invi,
incum cum,
--in19 codbar,
cast((ka5s-ka5e) as int) as  caja,
--cast((ka6s-ka6e) as int) as unid,  ----- /*Vacio �Necesario?, ya tenemos caja*/
'vlr'= cast(case when t8 in('04','19') then case  WHEN IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end as float), 
kalote lote
--convert(char(10),kafv,103) fecv,(ka12 -ka11 ) tven,
--(((ka5s*kaemb)+ka6s)* kapr ) tcos,
--'rent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end,
--cast(ka4 as date) nodefinido, /*No defindido �Que fecha hace referencia? hay un car ka4 arriba*/
--isnull(cl13, '') cVend, 
--isnull(v.ve2, '') nVend, 
--isnull(cna.ca2, '') canal  
from ka010925 k WITH(NOLOCK) 
inner join iA125 WITH(NOLOCK) on ka1=in1 
inner join tipo WITH(NOLOCK) on ka2=t1 
left join clie WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join ciud WITH(NOLOCK) on cl36=ci1  
left join facc f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join vend v on cl13 = v.ve4 
left join nits on ka13 = n1
left join cana cna on cl18a = cna.ca1 
left join CustomerAddress on f.idcustomeraddress = customeraddress.idcustomeraddress
left join PopulationCentre on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where t8 in('04','08','NR','19') and (ka4 between '20250901'  and '20250930') /*and 
ka13 in (select n1 from nits where n3 like '85%')*/ --and CAST(PopulationCentre.cdCity AS VARCHAR) like '05%'

union 

--octubre
select
k.con,
ka2+ka3 docm,
--isnull(kaprov,'') cedpac, /*Vacio �Necesario?*/
--isnull(nom,'') nompac, /*Vacio �Necesario?*/
ka13 prov,
cl3 nomb,
ci2 ciudad, 
--nits.n3 codciud,
--nits.n4 dircli, 
customeraddress.dscustomeraddress dirent,
PopulationCentre.nmPopCentre ciudent,
PopulationCentre.cdCity codciuent,
ka24 ped,
convert(char(10),ka4,103) fech,
ka1 arti,
--in2 noma,
--in3 pres,
--innc nomc,
--in12 emb,
--invi,
incum cum,
--in19 codbar,
cast((ka5s-ka5e) as int) as  caja,
--(ka6s-ka6e) unid,
'vlr'= cast(case when t8 in('04','19') then case  WHEN IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end as float), 
kalote lote
--convert(char(10),kafv,103) fecv,(ka12 -ka11 ) tven,
--(((ka5s*kaemb)+ka6s)* kapr ) tcos,
--'rent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end,
--cast(ka4 as date) nodefinido, /*No defindido �Que fecha hace referencia? hay un car ka4 arriba*/
--isnull(cl13, '') cVend, 
--isnull(v.ve2, '') nVend, 
--isnull(cna.ca2, '') canal    
from ka011025 k WITH(NOLOCK) 
inner join iA125 WITH(NOLOCK) on ka1=in1 
inner join tipo WITH(NOLOCK) on ka2=t1 
left join clie WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join ciud WITH(NOLOCK) on cl36=ci1  
left join facc f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join vend v on cl13 = v.ve4 
left join nits on ka13 = n1
left join cana cna on cl18a = cna.ca1 
left join CustomerAddress on f.idcustomeraddress = customeraddress.idcustomeraddress
left join PopulationCentre on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where t8 in('04','08','NR','19') and (ka4 between '20251001'  and '20251031') /*and 
ka13 in (select n1 from nits where n3 like '85%')*/ --and CAST(PopulationCentre.cdCity AS VARCHAR) like '05%'

union

--noviembre
select
k.con,
ka2+ka3 docm,
--isnull(kaprov,'') cedpac, /*Vacio �Necesario?*/
--isnull(nom,'') nompac, /*Vacio �Necesario?*/
ka13 prov,
cl3 nomb,
ci2 ciudad, 
--nits.n3 codciud,
--nits.n4 dircli, 
customeraddress.dscustomeraddress dirent,
PopulationCentre.nmPopCentre ciudent,
PopulationCentre.cdCity codciuent,
ka24 ped,
convert(char(10),ka4,103) fech,
ka1 arti,
--in2 noma,
--in3 pres,
--innc nomc,
--in12 emb,
--invi,
incum cum,
--in19 codbar,
cast((ka5s-ka5e) as int) as  caja,
--cast((ka6s-ka6e) as int) as unid,  ----- /*Vacio �Necesario?, ya tenemos caja*/
'vlr'= cast(case when t8 in('04','19') then case  WHEN IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end as float), 
kalote lote
--convert(char(10),kafv,103) fecv,(ka12 -ka11 ) tven,
--(((ka5s*kaemb)+ka6s)* kapr ) tcos,
--'rent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end,
--cast(ka4 as date) nodefinido, /*No defindido �Que fecha hace referencia? hay un car ka4 arriba*/
--isnull(cl13, '') cVend, 
--isnull(v.ve2, '') nVend, 
--isnull(cna.ca2, '') canal  
from ka011125 k WITH(NOLOCK) 
inner join iA125 WITH(NOLOCK) on ka1=in1 
inner join tipo WITH(NOLOCK) on ka2=t1 
left join clie WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join ciud WITH(NOLOCK) on cl36=ci1  
left join facc f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join vend v on cl13 = v.ve4 
left join nits on ka13 = n1
left join cana cna on cl18a = cna.ca1 
left join CustomerAddress on f.idcustomeraddress = customeraddress.idcustomeraddress
left join PopulationCentre on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where t8 in('04','08','NR','19') and (ka4 between '20251101'  and '20251130') /*and 
ka13 in (select n1 from nits where n3 like '85%')*/ --and CAST(PopulationCentre.cdCity AS VARCHAR) like '05%'

union

select
k.con,
ka2+ka3 docm,
--isnull(kaprov,'') cedpac, /*Vacio �Necesario?*/
--isnull(nom,'') nompac, /*Vacio �Necesario?*/
ka13 prov,
cl3 nomb,
ci2 ciudad, 
--nits.n3 codciud,
--nits.n4 dircli, 
customeraddress.dscustomeraddress dirent,
PopulationCentre.nmPopCentre ciudent,
PopulationCentre.cdCity codciuent,
ka24 ped,
convert(char(10),ka4,103) fech,
ka1 arti,
--in2 noma,
--in3 pres,
--innc nomc,
--in12 emb,
--invi,
incum cum,
--in19 codbar,
cast((ka5s-ka5e) as int) as  caja,
--cast((ka6s-ka6e) as int) as unid,  ----- /*Vacio �Necesario?, ya tenemos caja*/
'vlr'= cast(case when t8 in('04','19') then case  WHEN IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end as float), 
kalote lote
--convert(char(10),kafv,103) fecv,(ka12 -ka11 ) tven,
--(((ka5s*kaemb)+ka6s)* kapr ) tcos,
--'rent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end,
--cast(ka4 as date) nodefinido, /*No defindido �Que fecha hace referencia? hay un car ka4 arriba*/
--isnull(cl13, '') cVend, 
--isnull(v.ve2, '') nVend, 
--isnull(cna.ca2, '') canal  
from ka011225 k WITH(NOLOCK) 
inner join iA125 WITH(NOLOCK) on ka1=in1 
inner join tipo WITH(NOLOCK) on ka2=t1 
left join clie WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join ciud WITH(NOLOCK) on cl36=ci1  
left join facc f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join vend v on cl13 = v.ve4 
left join nits on ka13 = n1
left join cana cna on cl18a = cna.ca1 
left join CustomerAddress on f.idcustomeraddress = customeraddress.idcustomeraddress
left join PopulationCentre on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where t8 in('04','08','NR','19') and (ka4 between '20251201'  and '20251231') /*and 
ka13 in (select n1 from nits where n3 like '85%')*/ --and CAST(PopulationCentre.cdCity AS VARCHAR) like '05%'
) as mc
group by month(fech),codciuent,
ciudent
order by month(fech) asc