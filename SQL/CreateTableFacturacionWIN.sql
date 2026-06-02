SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rmd_trafacwin](
	[nomb] [nvarchar](100) NOT NULL, /*Nombre del cliente -- No necesario !Eliminar¡ Vendra del Maestro clientes*/
	[nit] [nvarchar](50) NOT NULL, /*Prov es el nit en la descarga*/
	[codrepr] [nvarchar] NOT NULL, 
	[nvend] [nvarchar](50) NOT NULL, /*Nombre del vendedor -- No necesario !Eliminar¡ Vendra del Maestro representante*/
	[ciudad] [nvarchar](50) NOT NULL, /*Ciudad del cliente*/
	[canal] [nvarchar](50) NOT NULL, /*No necesario !Eliminar¡*/
	[fech] [date] NOT NULL,
	[docm] [nvarchar](50) NOT NULL,
	[noma] [nvarchar](100) NOT NULL, /*Nombre del vendedor -- No necesario !Eliminar¡ Vendra del Maestro articulos*/
	[codart] [nvarchar](50) NOT NULL,
	[pres] [nvarchar](50) NOT NULL, /*Nombre del vendedor -- No necesario !Eliminar¡ Vendra del Maestro articulos*/
	[nomc] [nvarchar](50) NULL, /*Nombre del vendedor -- No necesario !Eliminar¡ Vendra del Maestro articulos*/
	[emb] [int] NOT NULL, /*Nombre del vendedor -- No necesario !Eliminar¡ Vendra del Maestro articulos*/
	[invi] [nvarchar](50) NOT NULL, /*Nombre del vendedor -- No necesario !Eliminar¡ Vendra del Maestro articulos*//*##*/
	[cum] [nvarchar](50) NOT NULL, /*Nombre del vendedor -- No necesario !Eliminar¡ Vendra del Maestro articulos*//*##*/
	[codbar] [float] NOT NULL, /*Nombre del vendedor -- No necesario !Eliminar¡ Vendra del Maestro articulos*//*##*/
	[caja] [int] NOT NULL, 
	[unid] [int] NOT NULL,
	[vlr] [int] NOT NULL,
	[lote] [nvarchar](50) NOT NULL,
	[fecv] [date] NOT NULL,
    [ciuent] [nvarchar](50) NOT NULL,
    [dirent] [nvarchar](500) NOT NULL,
    [opdocm] [nvarchar](500) NOT NULL,
    [id] [int] NOT NULL
PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[fech] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
