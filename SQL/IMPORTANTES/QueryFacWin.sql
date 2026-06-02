
-- QUERY PARA SACAR FACTURACION DE WIN

SELECT
fecdoc AS 'Fecha',
docm AS 'Documento',
docped AS 'OrdenPedido',
nitclie AS 'Nit',
nomclie AS 'Nombre',
codciuent AS 'codigo_ciudad',
ciudent  AS 'nombre_ciudad',
codart AS 'CodigoArt',
CAST(SUM(cajart) AS INT) AS 'Cajas',
CAST(SUM(vlrart) AS NUMERIC(18,2)) AS 'Valor'
FROM
(
-- ENERO
select 
cast(ka4 as date) fecdoc,
--'' as fecdoc02,
k.con as con,
ka2+ka3 docm,
ka2 as tipfac,
--ka3 as docfac,
--ka24 pedconcat,
CONCAT(substring(ka24,1,2),substring(ka24,3,6) ) as docped,
k.ka13 as nitclie,
clie.cl3 nomclie,
--isnull(cna.ca2, '') as canal,
isnull(clie.cl13, '') as codven,
isnull(v.ve2, '') as nomven,
--ia125.in2 as nomart,
k.ka1 as codart,
--ia125.in3 presart,
--ia125.innc as nomcomart,
--ia125.invi as inviart,
--ia125.incum as cumart,
--ia125.in19 as codbarart,
--kalote as loteart,
ia125.in12 as embart,
(ka5s-ka5e) cajart,
--(ka6s-ka6e) cantart,
'vlrart'=case when t8 in('04','19') then case  WHEN f.IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when f.IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end, 
--(ka12 -ka11 ) as tven,
--(((ka5s*kaemb)+ka6s)* kapr ) as tcos,
--'trent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end, 
--nits.n4 as domppal,
--ciud.ci2 as ciudad,
--nits.n3 as coddepmun,
--customeraddress.dscustomeraddress as dirent,
PopulationCentre.nmPopCentre AS ciudent,
PopulationCentre.cdCity AS codciuent
--f.fa20 +' ' + f.fa21 + ' ' + f.fa22 as obsv
from [ka010125] k WITH(NOLOCK) 
inner join [iA125] WITH(NOLOCK) on ka1=in1 
inner join [tipo] WITH(NOLOCK) on ka2=t1 
left join [clie] WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join [ciud] WITH(NOLOCK) on cl36=ci1  
left join [facc] f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join [vend] v on cl13 = v.ve4 
left join [nits] on ka13 = n1
left join [cana] cna on cl18a = cna.ca1
left join [CustomerAddress] on f.idcustomeraddress = customeraddress.idcustomeraddress
left join [PopulationCentre] on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where tipo.t8 in('04','08','NR','19') AND CAST(PopulationCentre.cdCity AS VARCHAR) LIKE '08%'

UNION 

-- FEBRERO
select 
cast(ka4 as date) fecdoc,
--'' as fecdoc02,
k.con as con,
ka2+ka3 docm,
ka2 as tipfac,
--ka3 as docfac,
--ka24 pedconcat,
CONCAT(substring(ka24,1,2),substring(ka24,3,6) ) as docped,
k.ka13 as nitclie,
clie.cl3 nomclie,
--isnull(cna.ca2, '') as canal,
isnull(clie.cl13, '') as codven,
isnull(v.ve2, '') as nomven,
--ia125.in2 as nomart,
k.ka1 as codart,
--ia125.in3 presart,
--ia125.innc as nomcomart,
--ia125.invi as inviart,
--ia125.incum as cumart,
--ia125.in19 as codbarart,
--kalote as loteart,
ia125.in12 as embart,
(ka5s-ka5e) cajart,
--(ka6s-ka6e) cantart,
'vlrart'=case when t8 in('04','19') then case  WHEN f.IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when f.IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end, 
--(ka12 -ka11 ) as tven,
--(((ka5s*kaemb)+ka6s)* kapr ) as tcos,
--'trent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end, 
--nits.n4 as domppal,
--ciud.ci2 as ciudad,
--nits.n3 as coddepmun,
--customeraddress.dscustomeraddress as dirent,
PopulationCentre.nmPopCentre AS ciudent,
PopulationCentre.cdCity AS codciuent
--f.fa20 +' ' + f.fa21 + ' ' + f.fa22 as obsv
from [ka010225] k WITH(NOLOCK) 
inner join [iA125] WITH(NOLOCK) on ka1=in1 
inner join [tipo] WITH(NOLOCK) on ka2=t1 
left join [clie] WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join [ciud] WITH(NOLOCK) on cl36=ci1  
left join [facc] f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join [vend] v on cl13 = v.ve4 
left join [nits] on ka13 = n1
left join [cana] cna on cl18a = cna.ca1
left join [CustomerAddress] on f.idcustomeraddress = customeraddress.idcustomeraddress
left join [PopulationCentre] on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where tipo.t8 in('04','08','NR','19') AND CAST(PopulationCentre.cdCity AS VARCHAR) LIKE '08%'

UNION

-- MARZO
select 
cast(ka4 as date) fecdoc,
--'' as fecdoc02,
k.con as con,
ka2+ka3 docm,
ka2 as tipfac,
--ka3 as docfac,
--ka24 pedconcat,
CONCAT(substring(ka24,1,2),substring(ka24,3,6) ) as docped,
k.ka13 as nitclie,
clie.cl3 nomclie,
--isnull(cna.ca2, '') as canal,
isnull(clie.cl13, '') as codven,
isnull(v.ve2, '') as nomven,
--ia125.in2 as nomart,
k.ka1 as codart,
--ia125.in3 presart,
--ia125.innc as nomcomart,
--ia125.invi as inviart,
--ia125.incum as cumart,
--ia125.in19 as codbarart,
--kalote as loteart,
ia125.in12 as embart,
(ka5s-ka5e) cajart,
--(ka6s-ka6e) cantart,
'vlrart'=case when t8 in('04','19') then case  WHEN f.IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when f.IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end, 
--(ka12 -ka11 ) as tven,
--(((ka5s*kaemb)+ka6s)* kapr ) as tcos,
--'trent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end, 
--nits.n4 as domppal,
--ciud.ci2 as ciudad,
--nits.n3 as coddepmun,
--customeraddress.dscustomeraddress as dirent,
PopulationCentre.nmPopCentre AS ciudent,
PopulationCentre.cdCity AS codciuent
--f.fa20 +' ' + f.fa21 + ' ' + f.fa22 as obsv
from [ka010325] k WITH(NOLOCK) 
inner join [iA125] WITH(NOLOCK) on ka1=in1 
inner join [tipo] WITH(NOLOCK) on ka2=t1 
left join [clie] WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join [ciud] WITH(NOLOCK) on cl36=ci1  
left join [facc] f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join [vend] v on cl13 = v.ve4 
left join [nits] on ka13 = n1
left join [cana] cna on cl18a = cna.ca1
left join [CustomerAddress] on f.idcustomeraddress = customeraddress.idcustomeraddress
left join [PopulationCentre] on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where tipo.t8 in('04','08','NR','19') AND CAST(PopulationCentre.cdCity AS VARCHAR) LIKE '08%'

UNION

-- ABRIL
select 
cast(ka4 as date) fecdoc,
--'' as fecdoc02,
k.con as con,
ka2+ka3 docm,
ka2 as tipfac,
--ka3 as docfac,
--ka24 pedconcat,
CONCAT(substring(ka24,1,2),substring(ka24,3,6) ) as docped,
k.ka13 as nitclie,
clie.cl3 nomclie,
--isnull(cna.ca2, '') as canal,
isnull(clie.cl13, '') as codven,
isnull(v.ve2, '') as nomven,
--ia125.in2 as nomart,
k.ka1 as codart,
--ia125.in3 presart,
--ia125.innc as nomcomart,
--ia125.invi as inviart,
--ia125.incum as cumart,
--ia125.in19 as codbarart,
--kalote as loteart,
ia125.in12 as embart,
(ka5s-ka5e) cajart,
--(ka6s-ka6e) cantart,
'vlrart'=case when t8 in('04','19') then case  WHEN f.IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when f.IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end, 
--(ka12 -ka11 ) as tven,
--(((ka5s*kaemb)+ka6s)* kapr ) as tcos,
--'trent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end, 
--nits.n4 as domppal,
--ciud.ci2 as ciudad,
--nits.n3 as coddepmun,
--customeraddress.dscustomeraddress as dirent,
PopulationCentre.nmPopCentre AS ciudent,
PopulationCentre.cdCity AS codciuent
--f.fa20 +' ' + f.fa21 + ' ' + f.fa22 as obsv
from [ka010425] k WITH(NOLOCK) 
inner join [iA125] WITH(NOLOCK) on ka1=in1 
inner join [tipo] WITH(NOLOCK) on ka2=t1 
left join [clie] WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join [ciud] WITH(NOLOCK) on cl36=ci1  
left join [facc] f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join [vend] v on cl13 = v.ve4 
left join [nits] on ka13 = n1
left join [cana] cna on cl18a = cna.ca1
left join [CustomerAddress] on f.idcustomeraddress = customeraddress.idcustomeraddress
left join [PopulationCentre] on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where tipo.t8 in('04','08','NR','19') AND CAST(PopulationCentre.cdCity AS VARCHAR) LIKE '08%'

UNION

-- MAYO
select 
cast(ka4 as date) fecdoc,
--'' as fecdoc02,
k.con as con,
ka2+ka3 docm,
ka2 as tipfac,
--ka3 as docfac,
--ka24 pedconcat,
CONCAT(substring(ka24,1,2),substring(ka24,3,6) ) as docped,
k.ka13 as nitclie,
clie.cl3 nomclie,
--isnull(cna.ca2, '') as canal,
isnull(clie.cl13, '') as codven,
isnull(v.ve2, '') as nomven,
--ia125.in2 as nomart,
k.ka1 as codart,
--ia125.in3 presart,
--ia125.innc as nomcomart,
--ia125.invi as inviart,
--ia125.incum as cumart,
--ia125.in19 as codbarart,
--kalote as loteart,
ia125.in12 as embart,
(ka5s-ka5e) cajart,
--(ka6s-ka6e) cantart,
'vlrart'=case when t8 in('04','19') then case  WHEN f.IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when f.IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end, 
--(ka12 -ka11 ) as tven,
--(((ka5s*kaemb)+ka6s)* kapr ) as tcos,
--'trent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end, 
--nits.n4 as domppal,
--ciud.ci2 as ciudad,
--nits.n3 as coddepmun,
--customeraddress.dscustomeraddress as dirent,
PopulationCentre.nmPopCentre AS ciudent,
PopulationCentre.cdCity AS codciuent
--f.fa20 +' ' + f.fa21 + ' ' + f.fa22 as obsv
from [ka010525] k WITH(NOLOCK) 
inner join [iA125] WITH(NOLOCK) on ka1=in1 
inner join [tipo] WITH(NOLOCK) on ka2=t1 
left join [clie] WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join [ciud] WITH(NOLOCK) on cl36=ci1  
left join [facc] f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join [vend] v on cl13 = v.ve4 
left join [nits] on ka13 = n1
left join [cana] cna on cl18a = cna.ca1
left join [CustomerAddress] on f.idcustomeraddress = customeraddress.idcustomeraddress
left join [PopulationCentre] on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where tipo.t8 in('04','08','NR','19') AND CAST(PopulationCentre.cdCity AS VARCHAR) LIKE '08%'

UNION

-- JUNIO
select 
cast(ka4 as date) fecdoc,
--'' as fecdoc02,
k.con as con,
ka2+ka3 docm,
ka2 as tipfac,
--ka3 as docfac,
--ka24 pedconcat,
CONCAT(substring(ka24,1,2),substring(ka24,3,6) ) as docped,
k.ka13 as nitclie,
clie.cl3 nomclie,
--isnull(cna.ca2, '') as canal,
isnull(clie.cl13, '') as codven,
isnull(v.ve2, '') as nomven,
--ia125.in2 as nomart,
k.ka1 as codart,
--ia125.in3 presart,
--ia125.innc as nomcomart,
--ia125.invi as inviart,
--ia125.incum as cumart,
--ia125.in19 as codbarart,
--kalote as loteart,
ia125.in12 as embart,
(ka5s-ka5e) cajart,
--(ka6s-ka6e) cantart,
'vlrart'=case when t8 in('04','19') then case  WHEN f.IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when f.IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end, 
--(ka12 -ka11 ) as tven,
--(((ka5s*kaemb)+ka6s)* kapr ) as tcos,
--'trent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end, 
--nits.n4 as domppal,
--ciud.ci2 as ciudad,
--nits.n3 as coddepmun,
--customeraddress.dscustomeraddress as dirent,
PopulationCentre.nmPopCentre AS ciudent,
PopulationCentre.cdCity AS codciuent
--f.fa20 +' ' + f.fa21 + ' ' + f.fa22 as obsv
from [ka010625] k WITH(NOLOCK) 
inner join [iA125] WITH(NOLOCK) on ka1=in1 
inner join [tipo] WITH(NOLOCK) on ka2=t1 
left join [clie] WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join [ciud] WITH(NOLOCK) on cl36=ci1  
left join [facc] f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join [vend] v on cl13 = v.ve4 
left join [nits] on ka13 = n1
left join [cana] cna on cl18a = cna.ca1
left join [CustomerAddress] on f.idcustomeraddress = customeraddress.idcustomeraddress
left join [PopulationCentre] on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where tipo.t8 in('04','08','NR','19') AND CAST(PopulationCentre.cdCity AS VARCHAR) LIKE '08%'

UNION

-- JULIO
select 
cast(ka4 as date) fecdoc,
--'' as fecdoc02,
k.con as con,
ka2+ka3 docm,
ka2 as tipfac,
--ka3 as docfac,
--ka24 pedconcat,
CONCAT(substring(ka24,1,2),substring(ka24,3,6) ) as docped,
k.ka13 as nitclie,
clie.cl3 nomclie,
--isnull(cna.ca2, '') as canal,
isnull(clie.cl13, '') as codven,
isnull(v.ve2, '') as nomven,
--ia125.in2 as nomart,
k.ka1 as codart,
--ia125.in3 presart,
--ia125.innc as nomcomart,
--ia125.invi as inviart,
--ia125.incum as cumart,
--ia125.in19 as codbarart,
--kalote as loteart,
ia125.in12 as embart,
(ka5s-ka5e) cajart,
--(ka6s-ka6e) cantart,
'vlrart'=case when t8 in('04','19') then case  WHEN f.IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when f.IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end, 
--(ka12 -ka11 ) as tven,
--(((ka5s*kaemb)+ka6s)* kapr ) as tcos,
--'trent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end, 
--nits.n4 as domppal,
--ciud.ci2 as ciudad,
--nits.n3 as coddepmun,
--customeraddress.dscustomeraddress as dirent,
PopulationCentre.nmPopCentre AS ciudent,
PopulationCentre.cdCity AS codciuent
--f.fa20 +' ' + f.fa21 + ' ' + f.fa22 as obsv
from [ka010725] k WITH(NOLOCK) 
inner join [iA125] WITH(NOLOCK) on ka1=in1 
inner join [tipo] WITH(NOLOCK) on ka2=t1 
left join [clie] WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join [ciud] WITH(NOLOCK) on cl36=ci1  
left join [facc] f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join [vend] v on cl13 = v.ve4 
left join [nits] on ka13 = n1
left join [cana] cna on cl18a = cna.ca1
left join [CustomerAddress] on f.idcustomeraddress = customeraddress.idcustomeraddress
left join [PopulationCentre] on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where tipo.t8 in('04','08','NR','19') AND CAST(PopulationCentre.cdCity AS VARCHAR) LIKE '08%'

UNION

-- AGOSTO
select 
cast(ka4 as date) fecdoc,
--'' as fecdoc02,
k.con as con,
ka2+ka3 docm,
ka2 as tipfac,
--ka3 as docfac,
--ka24 pedconcat,
CONCAT(substring(ka24,1,2),substring(ka24,3,6) ) as docped,
k.ka13 as nitclie,
clie.cl3 nomclie,
--isnull(cna.ca2, '') as canal,
isnull(clie.cl13, '') as codven,
isnull(v.ve2, '') as nomven,
--ia125.in2 as nomart,
k.ka1 as codart,
--ia125.in3 presart,
--ia125.innc as nomcomart,
--ia125.invi as inviart,
--ia125.incum as cumart,
--ia125.in19 as codbarart,
--kalote as loteart,
ia125.in12 as embart,
(ka5s-ka5e) cajart,
--(ka6s-ka6e) cantart,
'vlrart'=case when t8 in('04','19') then case  WHEN f.IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when f.IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end, 
--(ka12 -ka11 ) as tven,
--(((ka5s*kaemb)+ka6s)* kapr ) as tcos,
--'trent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end, 
--nits.n4 as domppal,
--ciud.ci2 as ciudad,
--nits.n3 as coddepmun,
--customeraddress.dscustomeraddress as dirent,
PopulationCentre.nmPopCentre AS ciudent,
PopulationCentre.cdCity AS codciuent
--f.fa20 +' ' + f.fa21 + ' ' + f.fa22 as obsv
from [ka010825] k WITH(NOLOCK) 
inner join [iA125] WITH(NOLOCK) on ka1=in1 
inner join [tipo] WITH(NOLOCK) on ka2=t1 
left join [clie] WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join [ciud] WITH(NOLOCK) on cl36=ci1  
left join [facc] f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join [vend] v on cl13 = v.ve4 
left join [nits] on ka13 = n1
left join [cana] cna on cl18a = cna.ca1
left join [CustomerAddress] on f.idcustomeraddress = customeraddress.idcustomeraddress
left join [PopulationCentre] on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where tipo.t8 in('04','08','NR','19') AND CAST(PopulationCentre.cdCity AS VARCHAR) LIKE '08%'

UNION

-- SEPTIEMBRE
select 
cast(ka4 as date) fecdoc,
--'' as fecdoc02,
k.con as con,
ka2+ka3 docm,
ka2 as tipfac,
--ka3 as docfac,
--ka24 pedconcat,
CONCAT(substring(ka24,1,2),substring(ka24,3,6) ) as docped,
k.ka13 as nitclie,
clie.cl3 nomclie,
--isnull(cna.ca2, '') as canal,
isnull(clie.cl13, '') as codven,
isnull(v.ve2, '') as nomven,
--ia125.in2 as nomart,
k.ka1 as codart,
--ia125.in3 presart,
--ia125.innc as nomcomart,
--ia125.invi as inviart,
--ia125.incum as cumart,
--ia125.in19 as codbarart,
--kalote as loteart,
ia125.in12 as embart,
(ka5s-ka5e) cajart,
--(ka6s-ka6e) cantart,
'vlrart'=case when t8 in('04','19') then case  WHEN f.IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when f.IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end, 
--(ka12 -ka11 ) as tven,
--(((ka5s*kaemb)+ka6s)* kapr ) as tcos,
--'trent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end, 
--nits.n4 as domppal,
--ciud.ci2 as ciudad,
--nits.n3 as coddepmun,
--customeraddress.dscustomeraddress as dirent,
PopulationCentre.nmPopCentre AS ciudent,
PopulationCentre.cdCity AS codciuent
--f.fa20 +' ' + f.fa21 + ' ' + f.fa22 as obsv
from [ka010925] k WITH(NOLOCK) 
inner join [iA125] WITH(NOLOCK) on ka1=in1 
inner join [tipo] WITH(NOLOCK) on ka2=t1 
left join [clie] WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join [ciud] WITH(NOLOCK) on cl36=ci1  
left join [facc] f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join [vend] v on cl13 = v.ve4 
left join [nits] on ka13 = n1
left join [cana] cna on cl18a = cna.ca1
left join [CustomerAddress] on f.idcustomeraddress = customeraddress.idcustomeraddress
left join [PopulationCentre] on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where tipo.t8 in('04','08','NR','19') AND CAST(PopulationCentre.cdCity AS VARCHAR) LIKE '08%'

UNION


-- OCTUBRE
select 
cast(ka4 as date) fecdoc,
--'' as fecdoc02,
k.con as con,
ka2+ka3 docm,
ka2 as tipfac,
--ka3 as docfac,
--ka24 pedconcat,
CONCAT(substring(ka24,1,2),substring(ka24,3,6) ) as docped,
k.ka13 as nitclie,
clie.cl3 nomclie,
--isnull(cna.ca2, '') as canal,
isnull(clie.cl13, '') as codven,
isnull(v.ve2, '') as nomven,
--ia125.in2 as nomart,
k.ka1 as codart,
--ia125.in3 presart,
--ia125.innc as nomcomart,
--ia125.invi as inviart,
--ia125.incum as cumart,
--ia125.in19 as codbarart,
--kalote as loteart,
ia125.in12 as embart,
(ka5s-ka5e) cajart,
--(ka6s-ka6e) cantart,
'vlrart'=case when t8 in('04','19') then case  WHEN f.IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when f.IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end, 
--(ka12 -ka11 ) as tven,
--(((ka5s*kaemb)+ka6s)* kapr ) as tcos,
--'trent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end, 
--nits.n4 as domppal,
--ciud.ci2 as ciudad,
--nits.n3 as coddepmun,
--customeraddress.dscustomeraddress as dirent,
PopulationCentre.nmPopCentre AS ciudent,
PopulationCentre.cdCity AS codciuent
--f.fa20 +' ' + f.fa21 + ' ' + f.fa22 as obsv
from [ka011025] k WITH(NOLOCK) 
inner join [iA125] WITH(NOLOCK) on ka1=in1 
inner join [tipo] WITH(NOLOCK) on ka2=t1 
left join [clie] WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join [ciud] WITH(NOLOCK) on cl36=ci1  
left join [facc] f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join [vend] v on cl13 = v.ve4 
left join [nits] on ka13 = n1
left join [cana] cna on cl18a = cna.ca1
left join [CustomerAddress] on f.idcustomeraddress = customeraddress.idcustomeraddress
left join [PopulationCentre] on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where tipo.t8 in('04','08','NR','19') AND CAST(PopulationCentre.cdCity AS VARCHAR) LIKE '08%'

UNION

-- NOVIEMBRE

select 
cast(ka4 as date) fecdoc,
--'' as fecdoc02,
k.con as con,
ka2+ka3 docm,
ka2 as tipfac,
--ka3 as docfac,
--ka24 pedconcat,
--substring(ka24,1,2) as tipped,
CONCAT(substring(ka24,1,2),substring(ka24,3,6) ) as docped,
k.ka13 as nitclie,
clie.cl3 nomclie,
--isnull(cna.ca2, '') as canal,
isnull(clie.cl13, '') as codven,
isnull(v.ve2, '') as nomven,
--ia125.in2 as nomart,
k.ka1 as codart,
--ia125.in3 presart,
--ia125.innc as nomcomart,
--ia125.invi as inviart,
--ia125.incum as cumart,
--ia125.in19 as codbarart,
--kalote as loteart,
ia125.in12 as embart,
(ka5s-ka5e) cajart,
--(ka6s-ka6e) cantart,
'vlrart'=case when t8 in('04','19') then case  WHEN f.IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when f.IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end, 
--(ka12 -ka11 ) as tven,
--(((ka5s*kaemb)+ka6s)* kapr ) as tcos,
--'trent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end, 
--nits.n4 as domppal,
--ciud.ci2 as ciudad,
--nits.n3 as coddepmun,
--customeraddress.dscustomeraddress as dirent,
PopulationCentre.nmPopCentre AS ciudent,
PopulationCentre.cdCity AS codciuent
--f.fa20 +' ' + f.fa21 + ' ' + f.fa22 as obsv
from [ka011125] k WITH(NOLOCK) 
inner join [iA125] WITH(NOLOCK) on ka1=in1 
inner join [tipo] WITH(NOLOCK) on ka2=t1 
left join [clie] WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join [ciud] WITH(NOLOCK) on cl36=ci1  
left join [facc] f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join [vend] v on cl13 = v.ve4 
left join [nits] on ka13 = n1
left join [cana] cna on cl18a = cna.ca1
left join [CustomerAddress] on f.idcustomeraddress = customeraddress.idcustomeraddress
left join [PopulationCentre] on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where tipo.t8 in('04','08','NR','19') AND CAST(PopulationCentre.cdCity AS VARCHAR) LIKE '08%'

UNION

--DICIEMBRE

select 
cast(ka4 as date) fecdoc,
--'' as fecdoc02,
k.con as con,
ka2+ka3 docm,
ka2 as tipfac,
--ka3 as docfac,
--ka24 pedconcat,
--substring(ka24,1,2) as tipped,
CONCAT(substring(ka24,1,2),substring(ka24,3,6) ) as docped,
k.ka13 as nitclie,
clie.cl3 nomclie,
--isnull(cna.ca2, '') as canal,
isnull(clie.cl13, '') as codven,
isnull(v.ve2, '') as nomven,
--ia125.in2 as nomart,
k.ka1 as codart,
--ia125.in3 presart,
--ia125.innc as nomcomart,
--ia125.invi as inviart,
--ia125.incum as cumart,
--ia125.in19 as codbarart,
--kalote as loteart,
ia125.in12 as embart,
(ka5s-ka5e) cajart,
--(ka6s-ka6e) cantart,
'vlrart'=case when t8 in('04','19') then case  WHEN f.IsSubsidised=1 then 0 else(ka12 -ka11)  end else  case when f.IsSubsidised=1 then 0 else (ka12 -ka11 )*-1 end end, 
--(ka12 -ka11 ) as tven,
--(((ka5s*kaemb)+ka6s)* kapr ) as tcos,
--'trent'=case when kapr <>0 then ((ka7-(ka7*ka8/100))- kapr )*100/ kapr  else 0 end, 
--nits.n4 as domppal,
--ciud.ci2 as ciudad,
--nits.n3 as coddepmun,
--customeraddress.dscustomeraddress as dirent,
PopulationCentre.nmPopCentre AS ciudent,
PopulationCentre.cdCity AS codciuent
--f.fa20 +' ' + f.fa21 + ' ' + f.fa22 as obsv
from [ka011225] k WITH(NOLOCK) 
inner join [iA125] WITH(NOLOCK) on ka1=in1 
inner join [tipo] WITH(NOLOCK) on ka2=t1 
left join [clie] WITH(NOLOCK) on ka13=cl1 
left join nits2 WITH(NOLOCK) on kaprov=ced 
left join [ciud] WITH(NOLOCK) on cl36=ci1  
left join [facc] f (nolock) on k.ka2 = f.fa3 and k.ka3 = f.fa2  
left join [vend] v on cl13 = v.ve4 
left join [nits] on ka13 = n1
left join [cana] cna on cl18a = cna.ca1
left join [CustomerAddress] on f.idcustomeraddress = customeraddress.idcustomeraddress
left join [PopulationCentre] on customeraddress.idPopCentre = PopulationCentre.idPopCentre
where tipo.t8 in('04','08','NR','19') AND CAST(PopulationCentre.cdCity AS VARCHAR) LIKE '08%'
) as mc
GROUP BY 
fecdoc,
docm,
docped,
nitclie,
nomclie,
codciuent,
ciudent,
codart