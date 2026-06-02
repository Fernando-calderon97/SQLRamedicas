SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rmd_traoxwin](
	[tip] [varchar](20) NOT NULL,
	[doc] [varchar](155) NOT NULL,
	[fech] [datetime] NOT NULL,
	[nit] [varchar](155) NOT NULL,
	[nom] [varchar](500) NULL,
	[razscl] [varchar](500) NULL,
	[est] [varchar](155) NULL,
	[codart] [varchar](50) NOT NULL,
	[nomart] [varchar](500) NULL,
	[nomcme] [varchar](500) NULL,
	[pres] [varchar](500) NULL,
	[lote] [varchar](155) NULL,
	[fechv] [datetime] NULL,
	[emb] [int] NULL,
	[vlr] [numeric](18, 2) NULL,
	[caj] [int] NULL,
	[und] [int] NULL,
	[cedpac] [varchar](50) NULL,
	[nompaciente] [varchar](500) NULL,
	[id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[fech] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO