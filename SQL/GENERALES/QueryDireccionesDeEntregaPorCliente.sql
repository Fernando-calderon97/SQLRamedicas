
select * from nits
select * from CustomerAddress

select 
    n.n1 as nit,
    n.n2 as nombre,
    ca.dsCustomerAddress as dirent
from nits n
inner join CustomerAddress ca on n.n1 = ca.cdCustomer
order by 
n.n1 asc;


select 
    n.n1 as nit,
    n.n2 as nombre,
    COUNT(ca.dsCustomerAddress) as total_direcciones
from nits n
inner join CustomerAddress ca 
    on n.n1 = ca.cdCustomer
group by 
    n.n1, 
    n.n2
order by 
    n.n1 asc;
