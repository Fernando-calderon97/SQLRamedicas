
USE RamedicasPBI
ALTER VIEW vw_rmd_maeproveedor_ficc AS
SELECT 
DISTINCT(MP.nitcc) AS 'Nit',
MP.nomprov AS 'Nombre',
UPPER(MP.estado) AS 'Estado',
CAST(MP.cupo AS NUMERIC(18,2)) AS 'Cupo',
MP.plazo AS 'Plazo',
MP.ciucod AS 'CodigoCiudad',
C.ciunom AS 'Ciudad',
MP.tipcod AS 'CodigoTipo',
MP.tipnom AS 'Tipo',
MP.clacod AS 'ClasificacionCodigo',
MP.clanom AS 'Clasificacion',
MP.percod AS 'PerfilCodigo',
MP.pernom AS 'Perfil',
MP.grucod AS 'GrupoCodigo',
MP.grunom AS 'Grupo',
MP.resiva AS 'ResponsableIva'
FROM [RamedicasBI_FICC].[dbo].[rmd_maeproveedor_ficc] MP
INNER JOIN [RamedicasBI_FICC].[dbo].[rmd_objciudad_ficc] C ON MP.ciucod = C.ciucod


