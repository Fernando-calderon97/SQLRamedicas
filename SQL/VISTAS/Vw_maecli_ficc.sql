ALTER VIEW vw_maecli_ficc AS
SELECT 
MC.nitcc AS 'Nit',
UPPER(MC.nomcli) AS 'Nombre',
UPPER(MC.estado) AS 'Estado',
MC.plazo AS 'plazo',
MC.cupo AS 'Cupo',
MC.vencod AS 'CodigoVendedor',
MR.VenNom AS 'NombreVendedor',
CAST(MC.lisprecod AS INT) AS 'CodigoListaPrecio',
MLP.LisPreNom AS 'ListaNombre',
C.ciunom AS 'CiudadPrincipal',
MC.dirpri AS 'DireccionPrincipal',
MC.resiva AS 'ResponsableIva',
MC.undneg AS 'UnidadNegocio',
MC.tipclinom AS 'TipoCliente',
MC.email AS 'email'
FROM [RamedicasBI_FICC].[dbo].[rmd_maecliente_ficc] MC
LEFT JOIN [RamedicasBI_FICC].[dbo].[rmd_objciudad_ficc] C ON MC.ciucod = C.ciucod
LEFT JOIN [RamedicasBI_FICC].[dbo].[rmd_maerepresentante_ficc] MR ON MC.vencod = MR.VenCod 
LEFT JOIN [RamedicasBI_FICC].[dbo].[rmd_maelistaprecio_ficc] MLP ON MC.lisprecod =  MLP.LisPreCod