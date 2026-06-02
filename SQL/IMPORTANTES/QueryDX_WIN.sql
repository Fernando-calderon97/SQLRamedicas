select 
  CAST(fecha AS DATE) AS 'Fecha',
  CONCAT(tpDoc, numDoc) AS Documento,
  codproducto AS 'codart',
  nitCliente AS Nit,
  embalaje,
  cajas,
  total,
  fecCreacion AS FechaCrea
  from Fomag 
  where tpDoc = 'DX'
  order by Fecha desc