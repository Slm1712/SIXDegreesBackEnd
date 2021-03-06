USE [TecnoCEDI_bd]
GO
/****** Object:  UserDefinedFunction [dbo].[Add_PreRuteo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Juan D Cárdenas
-- Create date: 04-09-19
-- Description:	Agrega nuevo PreRuteo
-- =============================================
CREATE FUNCTION [dbo].[Add_PreRuteo] 
(
	-- Add the parameters for the function here
	@usuarioId BIGINT
)
RETURNS BIGINT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @preRuteo BIGINT
	DECLARE @sql VARCHAR(MAX)
	DECLARE @cmd varchar(4000) 
	SELECT @sql = 'INSERT INTO [dbo].[PreRuteos] 
			([preRuteoFecha]
		  ,[preRuteoUsuario]
		  ,[preRuteoConsecutivo]
		  ,[preRuteoPedidoEstado])
		  VALUES(GETDATE() ,1,1,0)' 
		  SELECT @cmd = 'sqlcmd -S ' + @@servername + ' -d ' + db_name() + ' -Q "' + @sql + '"' 
		  EXEC master..xp_cmdshell @cmd, 'no_output' 
	
	--	 EXECUTE sp_executesql  'INSERT INTO [TecnoCEDI_bd].[dbo].[PreRuteos] 
	--		([preRuteoFecha]
	--	  ,[preRuteoUsuario]
	--	  ,[preRuteoConsecutivo]
	--	  ,[preRuteoPedidoEstado])
	--	  VALUES(GETDATE() ,1,1,0)'
	SELECT top 1 @preRuteo =  MAX(preRuteoId) FROM [TecnoCEDI_bd].[dbo].[PreRuteos]
	 
	-- Return the result of the function
	RETURN @preRuteo

END
GO
/****** Object:  Table [dbo].[AtributosContenedores]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AtributosContenedores](
	[atributoContenedorId] [bigint] IDENTITY(1,1) NOT NULL,
	[atributoContenedorDescripcion] [varchar](100) NOT NULL,
	[atributoContenedorEstado] [tinyint] NOT NULL,
	[tipoAtributoId] [bigint] NOT NULL,
	[plantillaContenedorAtributoId] [bigint] NOT NULL,
 CONSTRAINT [PK_AtributosContenedores] PRIMARY KEY CLUSTERED 
(
	[atributoContenedorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AtributosLotes]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AtributosLotes](
	[atributoLoteId] [bigint] IDENTITY(1,1) NOT NULL,
	[atributoLoteDescripcion] [varchar](100) NOT NULL,
	[atributoLoteValorDefecto] [varchar](100) NOT NULL,
	[atributoLoteEstado] [tinyint] NOT NULL,
	[tipoAtributoId] [bigint] NOT NULL,
 CONSTRAINT [PK_AtributosLotes] PRIMARY KEY CLUSTERED 
(
	[atributoLoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AtributosProductos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AtributosProductos](
	[atributoProductoId] [bigint] IDENTITY(1,1) NOT NULL,
	[atributoProductoDescripcion] [varchar](100) NOT NULL,
	[atributoProductoEstado] [tinyint] NOT NULL,
	[tipoAtributoId] [bigint] NOT NULL,
	[plantillaProductoAtributoId] [bigint] NOT NULL,
 CONSTRAINT [PK_AtributosProductos] PRIMARY KEY CLUSTERED 
(
	[atributoProductoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AtributosPuntosOperaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AtributosPuntosOperaciones](
	[atrPuntosOperacionId] [bigint] IDENTITY(1,1) NOT NULL,
	[atrPuntosOperacionDescripcion] [varchar](100) NOT NULL,
	[atrPuntosOperacionEstado] [tinyint] NOT NULL,
	[atrPuntosOperacionValor] [varchar](100) NOT NULL,
	[tipoAtributoId] [bigint] NOT NULL,
	[listaPuntoOperacionId] [bigint] NOT NULL,
 CONSTRAINT [PK_AtributoPuntosOperacion] PRIMARY KEY CLUSTERED 
(
	[atrPuntosOperacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BodegasERP]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BodegasERP](
	[bodegaErpId] [bigint] IDENTITY(1,1) NOT NULL,
	[bodegaErpEstado] [tinyint] NOT NULL,
	[bodegaERPCodigo] [varchar](100) NOT NULL,
	[bodegaERPDescripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_BodegaERP] PRIMARY KEY CLUSTERED 
(
	[bodegaErpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BodegasLogicas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BodegasLogicas](
	[bodegaLogicaId] [bigint] IDENTITY(1,1) NOT NULL,
	[bodegaLogicaEstado] [tinyint] NOT NULL,
	[bodegaErpId] [bigint] NOT NULL,
	[bodegaLogicaCodigo] [varchar](100) NULL,
	[bodegaLogicaDescripcion] [varchar](100) NULL,
 CONSTRAINT [PK_BodegaLogica] PRIMARY KEY CLUSTERED 
(
	[bodegaLogicaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CentrosGestion]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentrosGestion](
	[centroGestionId] [bigint] IDENTITY(1,1) NOT NULL,
	[centroGestionCodigo] [varchar](100) NOT NULL,
	[centroGestionDescripcion] [varchar](100) NOT NULL,
	[ordenanteId] [bigint] NULL,
 CONSTRAINT [PK_CentrosGestion] PRIMARY KEY CLUSTERED 
(
	[centroGestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CentrosOperaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentrosOperaciones](
	[centroOperacionId] [bigint] IDENTITY(1,1) NOT NULL,
	[centroOperacionCodigo] [varchar](100) NOT NULL,
	[centroOperacionDescripcion] [varchar](100) NOT NULL,
	[centroOperacionEstado] [tinyint] NOT NULL,
	[ordenanteId] [bigint] NOT NULL,
 CONSTRAINT [PK_CentrosOperacion] PRIMARY KEY CLUSTERED 
(
	[centroOperacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ciudades]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ciudades](
	[ciudadId] [bigint] IDENTITY(1,1) NOT NULL,
	[ciudadCodigo] [varchar](100) NOT NULL,
	[ciudadCodigoDANE] [varchar](100) NOT NULL,
	[ciudadNombre] [varchar](100) NOT NULL,
	[estadoId] [bigint] NOT NULL,
 CONSTRAINT [PK_Ciudades] PRIMARY KEY CLUSTERED 
(
	[ciudadId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClasificacionesAtributosProductos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClasificacionesAtributosProductos](
	[clasificacionId] [bigint] NOT NULL,
	[atributoProductoId] [bigint] NOT NULL,
 CONSTRAINT [PK_ClasificacionesAtributosProductos] PRIMARY KEY CLUSTERED 
(
	[clasificacionId] ASC,
	[atributoProductoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClasificacionesPlantillasProductos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClasificacionesPlantillasProductos](
	[clasificacionId] [bigint] NOT NULL,
	[plantillaProductoId] [bigint] NOT NULL,
 CONSTRAINT [PK_ClasificacionesPlantillasProductos] PRIMARY KEY CLUSTERED 
(
	[clasificacionId] ASC,
	[plantillaProductoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClasificacionesPresentaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClasificacionesPresentaciones](
	[clasificacionPresentacionId] [bigint] IDENTITY(1,1) NOT NULL,
	[clasificacionPresentacionDescripcion] [varchar](100) NOT NULL,
	[clasificacionPresentacionEstado] [tinyint] NOT NULL,
	[criterioProductoId] [bigint] NOT NULL,
 CONSTRAINT [PK_ClasificacionesPresentacion] PRIMARY KEY CLUSTERED 
(
	[clasificacionPresentacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClasificacionesProductos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClasificacionesProductos](
	[clasificacionProductoId] [bigint] IDENTITY(1,1) NOT NULL,
	[clasificacionProductoDescripcion] [varchar](100) NOT NULL,
	[clasificacionProductoEstado] [tinyint] NOT NULL,
	[criterioProductoId] [bigint] NULL,
 CONSTRAINT [PK_ClasificacionesProducto] PRIMARY KEY CLUSTERED 
(
	[clasificacionProductoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[clienteId] [bigint] IDENTITY(1,1) NOT NULL,
	[clienteCodigo] [varchar](30) NOT NULL,
	[clienteNombre] [varchar](100) NOT NULL,
	[titularId] [bigint] NOT NULL,
	[clienteDireccion] [varchar](1024) NOT NULL,
	[ciudadId] [bigint] NOT NULL,
	[clienteTelefono] [varchar](20) NOT NULL,
	[clienteCodigoEAN] [varchar](30) NULL,
 CONSTRAINT [PK__Cliente__71ABD08748A308A5] PRIMARY KEY CLUSTERED 
(
	[clienteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contactos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contactos](
	[contactoId] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Contactos] PRIMARY KEY CLUSTERED 
(
	[contactoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactosPuntosOperaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactosPuntosOperaciones](
	[contactoId] [bigint] NOT NULL,
	[puntoOperacionId] [bigint] NOT NULL,
 CONSTRAINT [PK_ContactosPuntosOperacion] PRIMARY KEY CLUSTERED 
(
	[contactoId] ASC,
	[puntoOperacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contenedores]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contenedores](
	[contenedorId] [bigint] NOT NULL,
	[contenedorCodigo] [varchar](100) NOT NULL,
	[contenedorPadreId] [bigint] NULL,
	[tipoContenedorId] [bigint] NOT NULL,
 CONSTRAINT [PK_Contenedores] PRIMARY KEY CLUSTERED 
(
	[contenedorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Coordenadas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Coordenadas](
	[coordenadaId] [bigint] IDENTITY(1,1) NOT NULL,
	[coordenadaSecuencia] [int] NOT NULL,
	[coordenadaNivel] [int] NOT NULL,
	[puntoOperacionId] [bigint] NOT NULL,
	[tipoCoordenada] [bigint] NOT NULL,
	[coordenadaPadreId] [bigint] NULL,
 CONSTRAINT [PK_Coordenadas] PRIMARY KEY CLUSTERED 
(
	[coordenadaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CriteriosPresentaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CriteriosPresentaciones](
	[criterioPresentacionId] [bigint] IDENTITY(1,1) NOT NULL,
	[criterioPresentacionDescripcion] [varchar](100) NOT NULL,
	[criterioPresentacionEstado] [tinyint] NOT NULL,
	[criterioProductoMultiple] [tinyint] NOT NULL,
 CONSTRAINT [PK_CriteriosPresentacion] PRIMARY KEY CLUSTERED 
(
	[criterioPresentacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CriteriosProductos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CriteriosProductos](
	[criterioProductoId] [bigint] IDENTITY(1,1) NOT NULL,
	[criterioProductoDescripcion] [varchar](100) NOT NULL,
	[criterioProductoEstado] [tinyint] NOT NULL,
	[criterioProductoMultiple] [tinyint] NOT NULL,
 CONSTRAINT [PK_CriteriosProductos] PRIMARY KEY CLUSTERED 
(
	[criterioProductoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Custodios]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Custodios](
	[custodioId] [bigint] IDENTITY(1,1) NOT NULL,
	[custodioDescripcion] [varchar](100) NOT NULL,
	[custodioCodigo] [varchar](100) NOT NULL,
	[ordenanteId] [bigint] NOT NULL,
 CONSTRAINT [PK_Custodios] PRIMARY KEY CLUSTERED 
(
	[custodioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Despachos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Despachos](
	[despachoId] [bigint] IDENTITY(1,1) NOT NULL,
	[despachoFecha] [datetime] NOT NULL,
	[usuarioId] [bigint] NOT NULL,
	[despachoConsecutivo] [int] NOT NULL,
	[despachoEstado] [tinyint] NOT NULL,
	[documentoId] [bigint] NULL,
 CONSTRAINT [PK_Despachos] PRIMARY KEY CLUSTERED 
(
	[despachoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DespachosDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DespachosDetalle](
	[despachoId] [bigint] NOT NULL,
	[despachoDetalleId] [bigint] IDENTITY(1,1) NOT NULL,
	[despachoDetalleCantTotal] [decimal](17, 2) NULL,
	[despachoDetalleCantSolicitada] [decimal](17, 2) NULL,
	[despachoDetalleCantPreparada] [decimal](17, 2) NULL,
	[despachoDetalleCantNovedad] [decimal](17, 2) NULL,
	[ubicacionId] [bigint] NOT NULL,
	[presentacionId] [bigint] NOT NULL,
	[ruteoId] [bigint] NOT NULL,
	[ruteoDetalleId] [bigint] NOT NULL,
	[novedadId] [bigint] NULL,
	[pedidoId] [bigint] NULL,
	[pedidoDetalleId] [bigint] NULL,
	[despachoEstado] [tinyint] NOT NULL,
	[ubicacionActualId] [bigint] NULL,
 CONSTRAINT [PK_DespachosDetalle] PRIMARY KEY CLUSTERED 
(
	[despachoDetalleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetalleUnidadesEscalares]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleUnidadesEscalares](
	[detalleUnidadEscalarId] [bigint] IDENTITY(1,1) NOT NULL,
	[detalleUnidadEscalarCodigo] [varchar](100) NOT NULL,
	[detalleUnidadEscalarCantidad] [decimal](18, 4) NULL,
	[unidadEscalarId] [bigint] NOT NULL,
	[detalleUnidadEscalarTipo] [tinyint] NULL,
	[detalleUnidadEscalarDescripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_DetalleUnidadesEscalares] PRIMARY KEY CLUSTERED 
(
	[detalleUnidadEscalarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Documentos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Documentos](
	[documentoId] [bigint] IDENTITY(1,1) NOT NULL,
	[documentoCodigo] [varchar](50) NOT NULL,
	[documentoNombre] [varchar](100) NOT NULL,
	[documentoSerial] [char](20) NOT NULL,
	[documentoContador] [int] NOT NULL,
	[documentoInicial] [int] NOT NULL,
	[documentoFinal] [int] NOT NULL,
	[documentoVigenciaInicial] [datetime] NOT NULL,
	[documentoVigenciaFinal] [datetime] NOT NULL,
	[documentoUltDetalle] [smallint] NOT NULL,
	[ubicacionId] [bigint] NULL,
	[bodegaLogicaId] [bigint] NULL,
	[titularId] [bigint] NOT NULL,
	[procesoId] [bigint] NOT NULL,
	[bodegaLogicaComboId] [bigint] NULL,
 CONSTRAINT [PK_Documentos] PRIMARY KEY CLUSTERED 
(
	[documentoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentosDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentosDetalle](
	[documentoDetalleId] [bigint] IDENTITY(1,1) NOT NULL,
	[documentoId] [bigint] NOT NULL,
	[documentoDetalleCodigo] [varchar](30) NOT NULL,
	[documentoDetalleNombre] [varchar](100) NOT NULL,
	[ruteoMetodoId] [bigint] NULL,
	[documentoDetalleMetodoOrden] [int] NOT NULL,
	[documentoDetalleMetodo] [varchar](500) NOT NULL,
	[documentoDetalleTipoId] [bigint] NULL,
	[documentoDetalleDataOrigen] [smallint] NULL,
 CONSTRAINT [PK_DocumentosDetalle] PRIMARY KEY CLUSTERED 
(
	[documentoDetalleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentosDetalleTipo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentosDetalleTipo](
	[documentoDetalleTipoId] [bigint] IDENTITY(1,1) NOT NULL,
	[documentoDetalleTipoCodigo] [varchar](50) NOT NULL,
	[documentoDetalleTipoDescripcion] [varchar](1000) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentosGruposListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentosGruposListas](
	[documentoId] [int] NOT NULL,
	[grupoListaId] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentosListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentosListas](
	[documentoId] [int] NOT NULL,
	[ListaId] [int] NOT NULL,
	[documentoListaId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentosPresentacionesListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentosPresentacionesListas](
	[documentoId] [bigint] NOT NULL,
	[presentacionListaId] [bigint] NOT NULL,
	[documentoPresentacionListaId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentosProductosListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentosProductosListas](
	[documentoId] [bigint] NOT NULL,
	[productoListaId] [bigint] NOT NULL,
	[documentoProductoListaId] [bigint] NOT NULL,
	[documentoProductoListaManejaSerial] [char](1) NOT NULL,
	[controlCantidad] [char](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentosPuntosEnvioListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentosPuntosEnvioListas](
	[documentoId] [bigint] NOT NULL,
	[puntoEnvioListaId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentosPuntosOperaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentosPuntosOperaciones](
	[documentoPuntoOperacionId] [bigint] IDENTITY(1,1) NOT NULL,
	[documentoId] [bigint] NOT NULL,
	[ubicacionId] [bigint] NOT NULL,
	[puntoOperacionId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentosPuntosOperacionesListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentosPuntosOperacionesListas](
	[documentoId] [bigint] NOT NULL,
	[puntoOperacionListaId] [bigint] NOT NULL,
	[documentoPuntoOperacionListaId] [bigint] NOT NULL,
	[documentoPuntoOperacionListaManejaContenedor] [char](1) NOT NULL,
	[documentoPuntoOperacionListaAfectaReserva] [char](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentosReglas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentosReglas](
	[documentoId] [bigint] NOT NULL,
	[reglaId] [bigint] NOT NULL,
	[documentoReglaOrden] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentosRutas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentosRutas](
	[documentoId] [bigint] NOT NULL,
	[rutaId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentosSeries]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentosSeries](
	[documentoSerieId] [bigint] IDENTITY(1,1) NOT NULL,
	[documentoId] [bigint] NOT NULL,
	[documentoSerieNumeroOperador] [varchar](40) NULL,
	[documentoSerieNumeroValor] [varchar](40) NULL,
	[documentoSerieFechaOperador] [varchar](40) NULL,
	[documentoSerieFechaValor] [varchar](40) NULL,
	[documentoERP] [varchar](30) NULL,
	[documentoSerieDirigidos] [char](1) NULL,
	[documentoSerieVersionar] [char](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentosUbicacionesListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentosUbicacionesListas](
	[documentoId] [bigint] NOT NULL,
	[ubicacionListaId] [bigint] NOT NULL,
	[documentoUbicacionListaLista] [smallint] NOT NULL,
	[documentoUbicacionListaId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentosUbicacionesLogicasListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentosUbicacionesLogicasListas](
	[documentoId] [bigint] NOT NULL,
	[ubicacionLogicaListaId] [bigint] NOT NULL,
	[documentoUbicacionLogicaListaLista] [smallint] NOT NULL,
	[documentoUbicacionLogicaListaId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentosUsuariosListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentosUsuariosListas](
	[documentoId] [bigint] NOT NULL,
	[usuarioListaId] [bigint] NOT NULL,
	[documentoUsuarioListaId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estaciones](
	[estacionId] [bigint] IDENTITY(1,1) NOT NULL,
	[estacionDescripcion] [varchar](100) NOT NULL,
	[estacionEstado] [tinyint] NULL,
	[bodegaLogicaId] [bigint] NULL,
	[operacionId] [bigint] NOT NULL,
 CONSTRAINT [PK_Estaciones] PRIMARY KEY CLUSTERED 
(
	[estacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstacionesPerifericos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstacionesPerifericos](
	[estacionId] [bigint] NOT NULL,
	[PerifericoId] [bigint] NOT NULL,
 CONSTRAINT [PK_EstacionesPerifericos] PRIMARY KEY CLUSTERED 
(
	[estacionId] ASC,
	[PerifericoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estados]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estados](
	[estadoId] [bigint] IDENTITY(1,1) NOT NULL,
	[estadoCodigo] [varchar](100) NOT NULL,
	[estadoCodigoDANE] [varchar](100) NULL,
	[estadoNombre] [varchar](100) NOT NULL,
	[paisId] [bigint] NOT NULL,
 CONSTRAINT [PK_Estados] PRIMARY KEY CLUSTERED 
(
	[estadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grupos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grupos](
	[grupoId] [bigint] NOT NULL,
	[grupoCodigo] [varchar](30) NOT NULL,
	[grupoNombre] [varchar](100) NOT NULL,
	[puntoOperacionId] [bigint] NOT NULL,
 CONSTRAINT [PK_Grupos] PRIMARY KEY CLUSTERED 
(
	[grupoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GruposListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GruposListas](
	[grupoListaId] [bigint] NOT NULL,
	[grupoListaCodigo] [varchar](30) NOT NULL,
	[grupoListaNombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK_GruposListas] PRIMARY KEY CLUSTERED 
(
	[grupoListaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistoricosPlantillas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoricosPlantillas](
	[historicoPlantillaId] [bigint] IDENTITY(1,1) NOT NULL,
	[historicoPlantillaNombre] [varchar](50) NOT NULL,
	[historicoPlantillaValorActual] [varchar](50) NOT NULL,
	[historicoPlantillaValorAnterior] [varchar](50) NOT NULL,
	[historicoPlantillaUsuario] [varchar](50) NOT NULL,
	[historicoPlantillaFechaModificacion] [varchar](50) NOT NULL,
	[productoId] [bigint] NOT NULL,
	[productoPlantillaId] [bigint] NOT NULL,
 CONSTRAINT [PK_HistoricosPlantillas] PRIMARY KEY CLUSTERED 
(
	[historicoPlantillaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Identificaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Identificaciones](
	[identificacionId] [bigint] IDENTITY(1,1) NOT NULL,
	[identificacionCodigo] [varchar](50) NOT NULL,
	[identificacionEstado] [tinyint] NOT NULL,
	[presentacionId] [bigint] NOT NULL,
	[tipoIdentificacionId] [bigint] NOT NULL,
 CONSTRAINT [PK_Identificaciones] PRIMARY KEY CLUSTERED 
(
	[identificacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IdentificadorApp]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IdentificadorApp](
	[IdentificadorAppId] [int] IDENTITY(1,1) NOT NULL,
	[IdentificadorAppCodigo] [varchar](30) NOT NULL,
	[IdentificadorAppDescripcion] [varchar](1000) NOT NULL,
	[IdentificadorAppFormato] [varchar](1000) NOT NULL,
 CONSTRAINT [PK__Identifi__5B14637AEC5DA5DF] PRIMARY KEY CLUSTERED 
(
	[IdentificadorAppId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ListasPuntosOperacion]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ListasPuntosOperacion](
	[listaPuntoOperacionId] [bigint] IDENTITY(1,1) NOT NULL,
	[listaPuntoOperacionDescripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_ListasPuntosOperacion] PRIMARY KEY CLUSTERED 
(
	[listaPuntoOperacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Motivos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Motivos](
	[motivoId] [bigint] IDENTITY(1,1) NOT NULL,
	[motivoDescripcion] [varchar](100) NOT NULL,
	[motivoCodigo] [varbinary](50) NOT NULL,
 CONSTRAINT [PK_Motivos] PRIMARY KEY CLUSTERED 
(
	[motivoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Novedades]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Novedades](
	[novedadId] [bigint] IDENTITY(1,1) NOT NULL,
	[novedadDescripcion] [varchar](1000) NULL,
	[novedadCodigo] [varchar](30) NULL,
	[novedadNombre] [varchar](100) NULL,
	[novedadAfectaSaldo] [char](10) NULL,
	[documentoId] [bigint] NULL,
	[novedadAccionId] [bigint] NULL,
	[tipoNovedadId] [tinyint] NULL,
	[procesoId] [int] NULL,
 CONSTRAINT [PK_Novedades] PRIMARY KEY CLUSTERED 
(
	[novedadId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NovedadesAcciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NovedadesAcciones](
	[novedadAccionId] [bigint] IDENTITY(1,1) NOT NULL,
	[novedadAccionCodigo] [varchar](30) NOT NULL,
	[novedadAccionNombre] [varchar](100) NOT NULL,
	[novedadAccion] [varchar](20) NULL,
 CONSTRAINT [PK_NovedadesAcciones] PRIMARY KEY CLUSTERED 
(
	[novedadAccionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Operaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Operaciones](
	[operacionId] [bigint] IDENTITY(1,1) NOT NULL,
	[operacionDescripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Operaciones] PRIMARY KEY CLUSTERED 
(
	[operacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ordenantes]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ordenantes](
	[ordenanteId] [bigint] IDENTITY(1,1) NOT NULL,
	[ordenanteDescripcion] [varchar](100) NOT NULL,
	[ordenanteCodigo] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Ordenantes] PRIMARY KEY CLUSTERED 
(
	[ordenanteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Packing]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Packing](
	[packingId] [bigint] IDENTITY(1,1) NOT NULL,
	[packingFecha] [datetime] NOT NULL,
	[usuarioId] [bigint] NOT NULL,
	[packingConsecutivo] [int] NOT NULL,
	[packingEstado] [tinyint] NOT NULL,
	[documentoId] [bigint] NULL,
 CONSTRAINT [PK_Packing] PRIMARY KEY CLUSTERED 
(
	[packingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PackingDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackingDetalle](
	[packingId] [bigint] NOT NULL,
	[packingDetalleId] [bigint] IDENTITY(1,1) NOT NULL,
	[packingDetalleCantTotal] [decimal](17, 2) NULL,
	[packingDetalleCantSolicitada] [decimal](17, 2) NULL,
	[packingDetalleCantPreparada] [decimal](17, 2) NULL,
	[packingDetalleCantNovedad] [decimal](17, 2) NULL,
	[ubicacionMedioId] [bigint] NOT NULL,
	[presentacionId] [bigint] NOT NULL,
	[ruteoId] [bigint] NOT NULL,
	[ruteoDetalleId] [bigint] NOT NULL,
	[novedadId] [bigint] NULL,
	[pedidoId] [bigint] NULL,
	[pedidoDetalleId] [bigint] NULL,
	[packingEstado] [tinyint] NOT NULL,
 CONSTRAINT [PK_PackingDetalle] PRIMARY KEY CLUSTERED 
(
	[packingDetalleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Paises]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paises](
	[paisId] [bigint] IDENTITY(1,1) NOT NULL,
	[paisCodigo] [varchar](100) NOT NULL,
	[paisCodigoDANE] [varchar](100) NULL,
	[paisNombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Paises] PRIMARY KEY CLUSTERED 
(
	[paisId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[pedidoId] [bigint] IDENTITY(1,1) NOT NULL,
	[sucursalId] [bigint] NOT NULL,
	[pedidoConsecutivo] [int] NOT NULL,
	[pedidoFecha] [datetime] NOT NULL,
	[pedidoFechaEntrega] [datetime] NOT NULL,
	[pedidoFechaCarga] [datetime] NOT NULL,
	[pedidoFechaMalla] [datetime] NOT NULL,
	[pedidoObservacion] [varchar](500) NOT NULL,
	[pedidoDocumentoERP] [varchar](20) NOT NULL,
	[pedidoConsecutivoERP] [varchar](20) NOT NULL,
	[pedidoVersion] [smallint] NOT NULL,
	[pedidoEstado] [tinyint] NOT NULL,
	[pedidoFuente] [varchar](30) NULL,
	[puntoOperacionId] [bigint] NULL,
 CONSTRAINT [PK__Pedido__09BA14307B3C60ED] PRIMARY KEY CLUSTERED 
(
	[pedidoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PedidosDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PedidosDetalle](
	[pedidoId] [bigint] NOT NULL,
	[pedidoDetalleId] [bigint] NOT NULL,
	[puntoEnvioId] [bigint] NOT NULL,
	[consolidadorId] [bigint] NULL,
	[productoId] [bigint] NOT NULL,
	[productoTipoId] [bigint] NOT NULL,
	[presentacionId] [bigint] NULL,
	[pedidoDetalleCantidad] [decimal](18, 4) NOT NULL,
	[pedidoDetalleEstado] [tinyint] NOT NULL,
	[pedidoDetalleFecha] [datetime] NOT NULL,
	[pedidoDetalleVersion] [smallint] NOT NULL,
 CONSTRAINT [PK__PedidoDe__289B42F40F046596] PRIMARY KEY CLUSTERED 
(
	[pedidoId] ASC,
	[pedidoDetalleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PedidosPreRuteo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PedidosPreRuteo](
	[pedidoId] [bigint] NOT NULL,
	[UserNameId] [bigint] NOT NULL,
	[UniqueProcessId] [uniqueidentifier] NULL,
	[Estado] [bit] NULL,
 CONSTRAINT [PK_PedidosPreRuteo] PRIMARY KEY CLUSTERED 
(
	[pedidoId] ASC,
	[UserNameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Perifericos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perifericos](
	[PerifericoId] [bigint] IDENTITY(1,1) NOT NULL,
	[PerifericoDescripcion] [varchar](100) NOT NULL,
	[tipoPerifericoId] [bigint] NOT NULL,
 CONSTRAINT [PK_Perifericos] PRIMARY KEY CLUSTERED 
(
	[PerifericoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantillasContenedores]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantillasContenedores](
	[plantillaContenedorAtributoId] [bigint] NOT NULL,
	[contenedorId] [bigint] NOT NULL,
 CONSTRAINT [PK_PlantillasContenedores] PRIMARY KEY CLUSTERED 
(
	[plantillaContenedorAtributoId] ASC,
	[contenedorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantillasContenedoresAtributos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantillasContenedoresAtributos](
	[plantillaContenedorAtributoId] [bigint] IDENTITY(1,1) NOT NULL,
	[plantillaContenedorAtributoDescripcion] [varchar](100) NOT NULL,
	[plantillaContenedorAtributoEstado] [tinyint] NOT NULL,
 CONSTRAINT [PK_PlantillasContenedoresAtributos] PRIMARY KEY CLUSTERED 
(
	[plantillaContenedorAtributoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantillasLotes]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantillasLotes](
	[plantillaLoteId] [bigint] IDENTITY(1,1) NOT NULL,
	[plantillaLoteDescripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_PlantillasLotes] PRIMARY KEY CLUSTERED 
(
	[plantillaLoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantillasLotesAtributos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantillasLotesAtributos](
	[plantillaLoteId] [bigint] NOT NULL,
	[atributoLoteId] [bigint] NOT NULL,
 CONSTRAINT [PK_PlantillasLotesAtributos] PRIMARY KEY CLUSTERED 
(
	[plantillaLoteId] ASC,
	[atributoLoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantillasProductos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantillasProductos](
	[plantillaProductoId] [bigint] IDENTITY(1,1) NOT NULL,
	[plantillaProductoAtributoId] [bigint] NULL,
	[productoId] [bigint] NULL,
 CONSTRAINT [PK_PlantillasProductos] PRIMARY KEY CLUSTERED 
(
	[plantillaProductoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantillasProductosAtributos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantillasProductosAtributos](
	[plantillaProductoAtributoId] [bigint] IDENTITY(1,1) NOT NULL,
	[plantillaProductoAtributoDescripcion] [varchar](100) NULL,
	[plantillaProductoAtributoEstado] [tinyint] NULL,
 CONSTRAINT [PK_PlantillasProductosAtributos] PRIMARY KEY CLUSTERED 
(
	[plantillaProductoAtributoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PreRuteos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PreRuteos](
	[preRuteoId] [bigint] IDENTITY(1,1) NOT NULL,
	[preRuteoFecha] [datetime] NOT NULL,
	[preRuteoUsuario] [varchar](100) NOT NULL,
	[preRuteoConsecutivo] [bigint] NOT NULL,
	[documentoId] [bigint] NULL,
	[preRuteoPedidoEstado] [tinyint] NOT NULL,
 CONSTRAINT [PK__PreRuteo__CD4C7BE719217ACB] PRIMARY KEY CLUSTERED 
(
	[preRuteoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PreRuteosDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PreRuteosDetalle](
	[preRuteoId] [bigint] NOT NULL,
	[preRuteoDetalleId] [bigint] IDENTITY(1,1) NOT NULL,
	[novedadId] [bigint] NOT NULL,
	[preRuteoPedidoEstado] [tinyint] NOT NULL,
	[presentacionId] [bigint] NULL,
	[bodegaLogicaId] [bigint] NULL,
	[ubicacionId] [bigint] NULL,
	[preRuteoDetalleCantidad] [decimal](18, 4) NULL,
	[preRuteoDetalleCantNovedad] [decimal](18, 4) NULL,
	[preRuteoDetalleCantRequerida] [decimal](18, 4) NULL,
	[preRuteoDetalleEstado] [tinyint] NOT NULL,
	[contenedorId] [bigint] NULL,
	[valorProductoLoteId] [bigint] NULL,
	[saldoId] [bigint] NULL,
	[saldoUbicacionId] [bigint] NULL,
 CONSTRAINT [PK__PreRuteo__D1D2DE1862E57593] PRIMARY KEY CLUSTERED 
(
	[preRuteoId] ASC,
	[preRuteoDetalleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PreRuteosPedidos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PreRuteosPedidos](
	[preRuteoId] [bigint] NOT NULL,
	[pedidoId] [bigint] NOT NULL,
 CONSTRAINT [PK_PreRuteosPedidos] PRIMARY KEY CLUSTERED 
(
	[preRuteoId] ASC,
	[pedidoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Presentaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Presentaciones](
	[presentacionId] [bigint] IDENTITY(1,1) NOT NULL,
	[presentacionCodigo] [varchar](100) NOT NULL,
	[presentacionDescripcion] [varchar](100) NULL,
	[presentacionNumUnidad] [int] NOT NULL,
	[presentacionManejaTecnico] [tinyint] NOT NULL,
	[presentacionAncho] [decimal](18, 4) NULL,
	[presentacionAlto] [decimal](18, 4) NULL,
	[presentacionProfundidad] [decimal](18, 4) NULL,
	[presentacionPesoBruto] [decimal](18, 4) NULL,
	[presentacionPesoNeto] [decimal](18, 4) NULL,
	[presentacionVolumen] [decimal](18, 4) NULL,
	[presentacionOrden] [smallint] NULL,
	[presentacionEsUnidadDespacho] [tinyint] NOT NULL,
	[presentacionEstado] [tinyint] NOT NULL,
	[longitudEscalarId] [bigint] NULL,
	[pesoEscalarId] [bigint] NULL,
	[volumenEscalarId] [bigint] NULL,
	[productoId] [bigint] NOT NULL,
	[Estiba] [int] NULL,
 CONSTRAINT [PK_Presentaciones] PRIMARY KEY CLUSTERED 
(
	[presentacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PresentacionesClasificacion]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PresentacionesClasificacion](
	[clasificacionPresentacionId] [bigint] NOT NULL,
	[presentacionId] [bigint] NOT NULL,
 CONSTRAINT [PK_PresentacionesClasificacion] PRIMARY KEY CLUSTERED 
(
	[clasificacionPresentacionId] ASC,
	[presentacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PresentacionesListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PresentacionesListas](
	[presentacionListaId] [bigint] IDENTITY(1,1) NOT NULL,
	[presentacionListaCodigo] [varchar](30) NOT NULL,
	[presentacionListaNombre] [varchar](100) NOT NULL,
	[procesoId] [bigint] NOT NULL,
	[titularId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PresentacionesListasDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PresentacionesListasDetalle](
	[presentacionListaId] [bigint] NOT NULL,
	[presentacionId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Procesos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Procesos](
	[ProcesoId] [int] IDENTITY(1,1) NOT NULL,
	[ProcesoCodigo] [varchar](20) NULL,
	[ProcesoNombre] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProcesoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[productoId] [bigint] IDENTITY(1,1) NOT NULL,
	[productoCodigo] [varchar](100) NOT NULL,
	[productoDescripcion] [varchar](100) NOT NULL,
	[productoCantidadManejo] [int] NOT NULL,
	[productoCantidadEscalar] [decimal](18, 4) NULL,
	[productoUnidadInventario] [tinyint] NULL,
	[productoManejaLote] [tinyint] NOT NULL,
	[productoEstado] [tinyint] NOT NULL,
	[productoCodigoAlternativo] [varchar](100) NULL,
	[productoManejaDimension] [tinyint] NULL,
	[titularId] [bigint] NULL,
	[unidadManejoId] [bigint] NULL,
	[unidadEscalarId] [bigint] NULL,
	[productoTipo] [smallint] NOT NULL,
 CONSTRAINT [PK_productos] PRIMARY KEY CLUSTERED 
(
	[productoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductosAtributos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductosAtributos](
	[productoId] [bigint] NOT NULL,
	[productoAtributoValor] [varchar](100) NULL,
	[productoPlantillaId] [bigint] NOT NULL,
 CONSTRAINT [PK_ProductosAtributos] PRIMARY KEY CLUSTERED 
(
	[productoId] ASC,
	[productoPlantillaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductosClasificaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductosClasificaciones](
	[productoId] [bigint] NOT NULL,
	[clasificacionId] [bigint] NOT NULL,
 CONSTRAINT [PK_ProductosClasificaciones] PRIMARY KEY CLUSTERED 
(
	[productoId] ASC,
	[clasificacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductosCombos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductosCombos](
	[productoIdCombo] [bigint] NOT NULL,
	[presentacionIdCombo] [bigint] NOT NULL,
	[productoIdDestino] [bigint] NOT NULL,
	[presentacionIdDestino] [bigint] NOT NULL,
	[productoComboCantidad] [decimal](18, 4) NOT NULL,
	[productoComboEstado] [tinyint] NOT NULL,
 CONSTRAINT [PK__Producto__10F77F0761D524CF] PRIMARY KEY CLUSTERED 
(
	[productoIdCombo] ASC,
	[presentacionIdDestino] ASC,
	[presentacionIdCombo] ASC,
	[productoIdDestino] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductosContenedores]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductosContenedores](
	[productoId] [bigint] NOT NULL,
	[contenedorId] [bigint] NOT NULL,
 CONSTRAINT [PK_ProductosContenedores] PRIMARY KEY CLUSTERED 
(
	[productoId] ASC,
	[contenedorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductosListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductosListas](
	[productoListaId] [bigint] IDENTITY(1,1) NOT NULL,
	[productoListaCodigo] [varchar](30) NOT NULL,
	[productoListaNombre] [varchar](100) NOT NULL,
	[procesoId] [bigint] NOT NULL,
	[titularId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductosListasDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductosListasDetalle](
	[productoListaId] [bigint] NOT NULL,
	[productoId] [bigint] NOT NULL,
	[productoListaDetalleEstado] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductosLotes]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductosLotes](
	[productoLoteId] [bigint] IDENTITY(1,1) NOT NULL,
	[productoId] [bigint] NOT NULL,
	[plantillaLoteId] [bigint] NOT NULL,
 CONSTRAINT [PK_ProductosLotes] PRIMARY KEY CLUSTERED 
(
	[productoLoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductosSustituciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductosSustituciones](
	[productoSustitucionId] [bigint] IDENTITY(1,1) NOT NULL,
	[productoIdOrigenPS] [bigint] NOT NULL,
	[productoIdDestinoPS] [bigint] NOT NULL,
	[productoSustitucionOrden] [bigint] NOT NULL,
	[productoSustitucionEstado] [tinyint] NOT NULL,
	[productoSustitucionCantidad] [decimal](18, 4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[productoSustitucionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PuntosEnvio]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PuntosEnvio](
	[puntoEnvioId] [bigint] IDENTITY(1,1) NOT NULL,
	[puntoEnvioCodigo] [varchar](30) NOT NULL,
	[puntoEnvioNombre] [varchar](100) NOT NULL,
	[sucursalId] [bigint] NOT NULL,
	[puntoEnvioDireccion] [varchar](1024) NOT NULL,
	[ciudadId] [bigint] NOT NULL,
	[puntoEnvioTelefono] [char](20) NOT NULL,
	[puntoEnvioCodigoEAN] [varchar](30) NULL,
 CONSTRAINT [PK__PuntoEnv__405A4C37D05CF31A] PRIMARY KEY CLUSTERED 
(
	[puntoEnvioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PuntosEnviosListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PuntosEnviosListas](
	[puntoEnvioListaId] [bigint] IDENTITY(1,1) NOT NULL,
	[puntoEnvioListaCodigo] [varchar](30) NOT NULL,
	[puntoEnvioListaNombre] [varchar](100) NOT NULL,
	[procesoId] [bigint] NOT NULL,
	[titularId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PuntosEnviosListasDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PuntosEnviosListasDetalle](
	[puntoEnvioListaId] [bigint] NOT NULL,
	[puntoEnvioId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PuntosOperaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PuntosOperaciones](
	[puntoOperacionId] [bigint] IDENTITY(1,1) NOT NULL,
	[puntoOperacionCodigo] [varchar](100) NOT NULL,
	[puntoOperacionDescripcion] [varchar](100) NOT NULL,
	[puntoOperacionEstado] [tinyint] NOT NULL,
	[centroOperacionId] [bigint] NOT NULL,
	[custodioId] [bigint] NOT NULL,
	[ciudadId] [bigint] NOT NULL,
	[listaPuntoOperacionId] [bigint] NULL,
	[puntoOperacionDireccion] [varchar](500) NULL,
 CONSTRAINT [PK_PuntosOperacion] PRIMARY KEY CLUSTERED 
(
	[puntoOperacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PuntosOperacionesListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PuntosOperacionesListas](
	[puntoOperacionListaId] [bigint] IDENTITY(1,1) NOT NULL,
	[puntoOperacionListaCodigo] [varchar](30) NOT NULL,
	[puntoOperacionListaNombre] [varchar](100) NOT NULL,
	[procesoId] [bigint] NOT NULL,
	[titularId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PuntosOperacionesListasDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PuntosOperacionesListasDetalle](
	[puntoOperacionListaId] [bigint] NOT NULL,
	[puntoOperacionId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReglaCaducidad]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReglaCaducidad](
	[PuntoEnvioId] [bigint] NOT NULL,
	[ProductoId] [bigint] NOT NULL,
	[Caducidad] [int] NOT NULL,
	[motivoId] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reglas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reglas](
	[ReglaId] [bigint] IDENTITY(1,1) NOT NULL,
	[PuntoEnvioId] [bigint] NOT NULL,
	[ProductoId] [bigint] NOT NULL,
	[reglaCaducidadValor] [int] NOT NULL,
 CONSTRAINT [PK_Reglas] PRIMARY KEY CLUSTERED 
(
	[ReglaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RFIDTag]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RFIDTag](
	[RFIDTagId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[RFIDTagContador] [numeric](18, 0) NULL,
	[RFIDTagTipo_EPC] [nvarchar](50) NULL,
	[RFIDTagEPC] [nvarchar](50) NULL,
	[RFIDTagAntena] [nvarchar](50) NULL,
	[RFIDTagReader] [nvarchar](50) NULL,
	[RFIDTagFecha] [datetime] NULL,
	[RFIDTagInicioEvento] [nvarchar](50) NULL,
	[RFIDTagTagEvento] [nvarchar](50) NULL,
	[RFIDTagRSSI] [nvarchar](50) NULL,
	[RFIDTagMaquina] [nvarchar](50) NULL,
	[RFIDTagEPCNueva] [nvarchar](50) NULL,
	[GETDATE] [datetime] NULL,
 CONSTRAINT [PK_RFIDTag] PRIMARY KEY CLUSTERED 
(
	[RFIDTagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[roleId] [bigint] IDENTITY(1,1) NOT NULL,
	[roleDescripcion] [varchar](100) NOT NULL,
	[roleEstado] [smallint] NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RutasGrupos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RutasGrupos](
	[rutaId] [bigint] NOT NULL,
	[GrupoId] [bigint] NOT NULL,
 CONSTRAINT [PK_RutasGrupos] PRIMARY KEY CLUSTERED 
(
	[rutaId] ASC,
	[GrupoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RutasUbicaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RutasUbicaciones](
	[rutaUbicacionId] [bigint] NOT NULL,
	[rutaId] [bigint] NOT NULL,
	[ubicacionId] [bigint] NOT NULL,
	[rutaUbicacionOrden] [int] NOT NULL,
 CONSTRAINT [PK_RutasUbicaciones] PRIMARY KEY CLUSTERED 
(
	[rutaUbicacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ruteos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ruteos](
	[ruteoId] [bigint] NOT NULL,
	[ruteoFecha] [datetime] NOT NULL,
	[ruteoUsuario] [varchar](100) NOT NULL,
	[ruteoConsecutivo] [bigint] NOT NULL,
	[documentoId] [bigint] NULL,
	[ruteoPedidoEstado] [tinyint] NOT NULL,
 CONSTRAINT [PK__Ruteo__CD4C7BE719217ACB] PRIMARY KEY CLUSTERED 
(
	[ruteoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RuteosDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RuteosDetalle](
	[ruteoId] [bigint] NOT NULL,
	[ruteoDetalleId] [bigint] IDENTITY(1,1) NOT NULL,
	[novedadId] [bigint] NOT NULL,
	[ruteoPedidoEstado] [tinyint] NOT NULL,
	[presentacionId] [bigint] NULL,
	[bodegaLogicaId] [bigint] NULL,
	[ubicacionId] [bigint] NULL,
	[ruteoDetalleCantidad] [decimal](18, 4) NULL,
	[ruteoDetalleCantNovedad] [decimal](18, 4) NULL,
	[ruteoDetalleCantRequerida] [decimal](18, 4) NULL,
	[ruteoDetalleEstado] [tinyint] NOT NULL,
	[contenedorId] [bigint] NULL,
	[valorProductoLoteId] [bigint] NULL,
	[grupoId] [bigint] NULL,
 CONSTRAINT [PK_RuteosDetalle] PRIMARY KEY CLUSTERED 
(
	[ruteoDetalleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RuteosPedidos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RuteosPedidos](
	[ruteoId] [bigint] NOT NULL,
	[pedidoId] [bigint] NOT NULL,
	[bahiaId] [bigint] NULL,
	[pedidoOrden] [smallint] NULL,
	[pedidoProcesado] [bit] NOT NULL,
 CONSTRAINT [PK_RuteosPedidos] PRIMARY KEY CLUSTERED 
(
	[ruteoId] ASC,
	[pedidoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RuteosUbicacionesOrden]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RuteosUbicacionesOrden](
	[ruteoUbicacionOrdenId] [int] NOT NULL,
	[ubicacionIdRuteoUbicacionOrden] [int] NOT NULL,
	[documentoIdRuteoUbicacionOrden] [int] NOT NULL,
	[ordenUbicacion] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Saldos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Saldos](
	[saldoId] [bigint] IDENTITY(1,1) NOT NULL,
	[productoId] [bigint] NOT NULL,
	[saldoComprometidoManejo] [decimal](18, 4) NULL,
	[saldoInmovilizadoManejo] [decimal](18, 4) NULL,
	[saldoRealManejo] [decimal](18, 4) NULL,
	[saldoDisponibleManejo] [decimal](18, 4) NULL,
	[saldoComprometidoEscalar] [decimal](18, 4) NULL,
	[saldoInmovilizadoEscalar] [decimal](18, 4) NULL,
	[saldoRealEscalar] [decimal](18, 4) NULL,
	[saldoDisponibleEscalar] [decimal](18, 4) NULL,
	[centroGestionId] [bigint] NOT NULL,
	[separaSaldo] [tinyint] NOT NULL,
 CONSTRAINT [PK_Saldos] PRIMARY KEY CLUSTERED 
(
	[saldoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaldosDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaldosDetalle](
	[saldoDetalleId] [bigint] IDENTITY(1,1) NOT NULL,
	[saldoId] [bigint] NOT NULL,
	[presentacionId] [bigint] NULL,
	[contenedorId] [bigint] NULL,
	[valorProductoLoteId] [bigint] NULL,
	[ubicacionId] [bigint] NOT NULL,
	[bodegaLogicaId] [bigint] NOT NULL,
	[saldoDetalleRealManejo] [decimal](18, 4) NULL,
	[saldoDetalleComprometidoManejo] [decimal](18, 4) NULL,
	[saldoDetalleInmovilizadoManejo] [decimal](18, 4) NULL,
	[saldoDetalleRealEscalar] [decimal](18, 4) NULL,
	[saldoDetalleDisponibleManejo] [decimal](18, 4) NULL,
	[saldoDetalleComprometidoEscalar] [decimal](18, 4) NULL,
	[saldoDetalleInmovilizadoEscalar] [decimal](18, 4) NULL,
	[saldoDetalleDisponibleEscalar] [decimal](18, 4) NULL,
 CONSTRAINT [PK_SaldosDetalle] PRIMARY KEY CLUSTERED 
(
	[saldoDetalleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaldosUbicaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaldosUbicaciones](
	[saldoUbicacionId] [bigint] IDENTITY(1,1) NOT NULL,
	[saldoId] [bigint] NULL,
	[ubicacionId] [bigint] NOT NULL,
	[saldoUbicacionRealManejo] [decimal](18, 4) NULL,
	[saldoUbicacionComprometidoManejo] [decimal](18, 4) NULL,
	[saldoUbicacionInmovilizadoManejo] [decimal](18, 4) NULL,
	[saldoUbicacionRealEscalar] [decimal](18, 4) NULL,
	[saldoUbicacionDisponibleManejo] [decimal](18, 4) NULL,
	[saldoUbicacionComprometidoEscalar] [decimal](18, 4) NULL,
	[saldoUbicacionInmovilizadoEscalar] [decimal](18, 4) NULL,
	[saldoUbicacionDisponibleEscalar] [decimal](18, 4) NULL,
 CONSTRAINT [PK_SaldosUbicaciones] PRIMARY KEY CLUSTERED 
(
	[saldoUbicacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sucursales]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sucursales](
	[sucursalId] [bigint] IDENTITY(1,1) NOT NULL,
	[sucursalCodigo] [varchar](30) NOT NULL,
	[sucursalNombre] [varchar](100) NOT NULL,
	[clienteId] [bigint] NOT NULL,
	[sucursalDireccion] [varchar](1024) NOT NULL,
	[ciudadId] [bigint] NOT NULL,
	[sucursalTelefono] [char](20) NOT NULL,
	[sucursalCodigoEAN] [varchar](30) NULL,
 CONSTRAINT [PK__Sucursal__6CB482E1CE9CA881] PRIMARY KEY CLUSTERED 
(
	[sucursalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposAtributos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposAtributos](
	[tipoAtributoId] [bigint] IDENTITY(1,1) NOT NULL,
	[tipoAtributoDescripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TiposAtributos] PRIMARY KEY CLUSTERED 
(
	[tipoAtributoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposContenedores]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposContenedores](
	[tipoContenedorId] [bigint] IDENTITY(1,1) NOT NULL,
	[tipoContenedorAncho] [decimal](18, 4) NULL,
	[tipoContenedorAlto] [decimal](18, 4) NULL,
	[tipoContenedorProfundidad] [decimal](18, 4) NULL,
	[tipoContenedorMultiproducto] [tinyint] NOT NULL,
	[tipoContenedorMultilote] [tinyint] NOT NULL,
	[tipoContenedorDescripcion] [varchar](100) NOT NULL,
	[tipoContenedorCodigo] [varchar](100) NOT NULL,
	[tipoContenedorPeso] [decimal](18, 4) NULL,
	[tipoContenedorVolumen] [decimal](18, 4) NULL,
 CONSTRAINT [PK_TiposContenedores] PRIMARY KEY CLUSTERED 
(
	[tipoContenedorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposCoordenadas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposCoordenadas](
	[tipoCoordenadaId] [bigint] IDENTITY(1,1) NOT NULL,
	[tipoCoordenadaDescripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TipoCoordenada] PRIMARY KEY CLUSTERED 
(
	[tipoCoordenadaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposIdentificaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposIdentificaciones](
	[tipoIdentificacionId] [bigint] IDENTITY(1,1) NOT NULL,
	[tipoIdentificacionCodigo] [varchar](100) NOT NULL,
	[tipoIdentificacionDescripcion] [varchar](100) NOT NULL,
	[tipoIdentificacionEstado] [tinyint] NOT NULL,
 CONSTRAINT [PK_TiposIdentificacion] PRIMARY KEY CLUSTERED 
(
	[tipoIdentificacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposNovedades]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposNovedades](
	[TipoNovedadId] [bigint] IDENTITY(1,1) NOT NULL,
	[novedadTipoCodigo] [varchar](30) NOT NULL,
	[novedadTipoNombre] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposPerifericos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposPerifericos](
	[tipoPerifericoId] [bigint] IDENTITY(1,1) NOT NULL,
	[tipoPerifericoDescripcion] [varchar](100) NOT NULL,
	[tipoPerifericoEstado] [smallint] NOT NULL,
 CONSTRAINT [PK_TiposPeriferico] PRIMARY KEY CLUSTERED 
(
	[tipoPerifericoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposUbicaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposUbicaciones](
	[tipoUbicacionId] [int] IDENTITY(1,1) NOT NULL,
	[tipoUbicacionCodigo] [varchar](20) NOT NULL,
	[tipoUbicacionDescripcion] [varchar](100) NOT NULL,
	[tipoUbicacionEstado] [tinyint] NOT NULL,
 CONSTRAINT [PK_TiposUbicaciones] PRIMARY KEY CLUSTERED 
(
	[tipoUbicacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Titulares]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Titulares](
	[titularId] [bigint] IDENTITY(1,1) NOT NULL,
	[titularDescripcion] [varchar](100) NOT NULL,
	[titularCodigo] [varchar](100) NOT NULL,
	[ordenanteId] [bigint] NOT NULL,
 CONSTRAINT [PK_Titular] PRIMARY KEY CLUSTERED 
(
	[titularId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TxDespacho]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TxDespacho](
	[txDespachoId] [bigint] IDENTITY(1,1) NOT NULL,
	[txDespachoConcepto] [int] NOT NULL,
	[txDespachoConsecutivo] [bigint] NOT NULL,
	[presentacionId] [bigint] NULL,
	[identificacionId] [bigint] NULL,
	[contenedorId] [bigint] NULL,
	[valorProductoLoteId] [bigint] NULL,
	[ubicacionId] [bigint] NOT NULL,
	[bodegaLogicaId] [bigint] NOT NULL,
	[txDespachoRealManejo] [decimal](18, 4) NULL,
	[txDespachoRealEscalar] [decimal](18, 4) NULL,
	[novedadId] [bigint] NULL,
	[ruteoId] [bigint] NULL,
	[ruteoDetalleId] [bigint] NULL,
	[documentoId] [bigint] NULL,
	[txDespachoEstado] [tinyint] NOT NULL,
	[txDespachoParentId] [bigint] NULL,
 CONSTRAINT [PK_TxDespacho] PRIMARY KEY CLUSTERED 
(
	[txDespachoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TXPacking]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TXPacking](
	[tXPackingId] [bigint] IDENTITY(1,1) NOT NULL,
	[tXPackingConcepto] [int] NOT NULL,
	[tXPackingConsecutivo] [bigint] NOT NULL,
	[presentacionId] [bigint] NULL,
	[identificacionId] [bigint] NULL,
	[contenedorId] [bigint] NULL,
	[valorProductoLoteId] [bigint] NULL,
	[ubicacionId] [bigint] NOT NULL,
	[bodegaLogicaId] [bigint] NOT NULL,
	[tXPackingRealManejo] [decimal](18, 4) NULL,
	[tXPackingRealEscalar] [decimal](18, 4) NULL,
	[novedadId] [bigint] NULL,
	[ruteoId] [bigint] NULL,
	[ruteoDetalleId] [bigint] NULL,
	[documentoId] [bigint] NULL,
	[tXPackingEstado] [tinyint] NOT NULL,
	[tXPackingParentId] [bigint] NULL,
 CONSTRAINT [PK_tXPacking] PRIMARY KEY CLUSTERED 
(
	[tXPackingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TXPicking]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TXPicking](
	[tXPickingId] [bigint] IDENTITY(1,1) NOT NULL,
	[tXPickingConcepto] [int] NOT NULL,
	[tXPickingConsecutivo] [bigint] NOT NULL,
	[presentacionId] [bigint] NULL,
	[identificacionId] [bigint] NULL,
	[contenedorId] [bigint] NULL,
	[valorProductoLoteId] [bigint] NULL,
	[ubicacionId] [bigint] NOT NULL,
	[bodegaLogicaId] [bigint] NOT NULL,
	[tXPickingRealManejo] [decimal](18, 4) NULL,
	[tXPickingRealEscalar] [decimal](18, 4) NULL,
	[novedadId] [bigint] NULL,
	[ruteoId] [bigint] NULL,
	[ruteoDetalleId] [bigint] NULL,
	[documentoId] [bigint] NULL,
	[tXPickingEstado] [tinyint] NOT NULL,
	[txPickingParentId] [bigint] NULL,
 CONSTRAINT [PK_TXPicking] PRIMARY KEY CLUSTERED 
(
	[tXPickingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ubicaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ubicaciones](
	[ubicacionId] [bigint] IDENTITY(1,1) NOT NULL,
	[ubicacionCodigo] [varchar](100) NOT NULL,
	[ubicacionEtiqueta] [varchar](100) NOT NULL,
	[ubicacionDescripcion] [varchar](100) NOT NULL,
	[ubicacionEstado] [tinyint] NOT NULL,
	[ubicacionFisicaId] [bigint] NULL,
	[tipoUbicacionId] [int] NULL,
	[ubicacionPadreId] [bigint] NULL,
 CONSTRAINT [PK_Ubicaciones] PRIMARY KEY CLUSTERED 
(
	[ubicacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UbicacionesFisicas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UbicacionesFisicas](
	[ubicacionFisicaId] [bigint] IDENTITY(1,1) NOT NULL,
	[ubicacionFisicaCoordenada] [varchar](100) NOT NULL,
	[ubicacionFisicaEstado] [tinyint] NOT NULL,
	[coordenadaId] [bigint] NOT NULL,
 CONSTRAINT [PK_UbicacionesFisicas] PRIMARY KEY CLUSTERED 
(
	[ubicacionFisicaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UbicacionesListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UbicacionesListas](
	[ubicacionListaId] [int] IDENTITY(1,1) NOT NULL,
	[ubicacionListaCodigo] [varchar](30) NOT NULL,
	[ubicacionListaNombre] [varchar](100) NOT NULL,
	[procesoId] [bigint] NOT NULL,
	[titularId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UbicacionesListasDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UbicacionesListasDetalle](
	[ubicacionListaId] [bigint] NOT NULL,
	[ubicacionId] [bigint] NOT NULL,
	[orden] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UbicacionesLogicasListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UbicacionesLogicasListas](
	[ubicacionLogicaListaId] [bigint] IDENTITY(1,1) NOT NULL,
	[ubicacionLogicaListaCodigo] [varchar](30) NOT NULL,
	[ubicacionLogicaListaNombre] [varchar](100) NOT NULL,
	[procesoId] [bigint] NOT NULL,
	[titularId] [bigint] NOT NULL,
	[ubicacionLogicaListaRelacion] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UbicacionesLogicasListasDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UbicacionesLogicasListasDetalle](
	[ubicacionLogicaListaId] [bigint] NOT NULL,
	[bodegaLogicaId] [bigint] NOT NULL,
	[ubicacionLogicaListaOrden] [smallint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnidadesEscalares]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnidadesEscalares](
	[unidadEscalarId] [bigint] IDENTITY(1,1) NOT NULL,
	[unidadEscalarDescripcion] [varchar](100) NOT NULL,
	[unidadEscalarCodigo] [varchar](100) NOT NULL,
	[unidadEscalarCantidad] [decimal](18, 4) NULL,
	[unidadEscalarTipo] [smallint] NOT NULL,
 CONSTRAINT [PK_UnidadesEscalares] PRIMARY KEY CLUSTERED 
(
	[unidadEscalarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnidadesManejo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnidadesManejo](
	[unidadManejoId] [bigint] IDENTITY(1,1) NOT NULL,
	[unidadManejoCodigo] [varchar](100) NOT NULL,
	[unidadManejoDescripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_unidades_manejo] PRIMARY KEY CLUSTERED 
(
	[unidadManejoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[UsuarioId] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioNombre] [varchar](100) NOT NULL,
	[UsuarioIdentificacion] [varchar](20) NULL,
	[UsuarioApellido] [varchar](100) NOT NULL,
	[UsuarioGUID] [char](40) NOT NULL,
	[UsuarioTerminal] [char](1) NOT NULL,
	[UsuarioUltPO] [smallint] NOT NULL,
	[UsuarioUser] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioGrupo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioGrupo](
	[UsuarioGrupoId] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioPuntoOperacionId] [int] NOT NULL,
	[GrupoId] [int] NOT NULL,
	[TurnoIdUsuarioGrupo] [int] NOT NULL,
	[DocumentoId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[usuarioId] [bigint] IDENTITY(1,1) NOT NULL,
	[usuarioNombre] [varchar](100) NOT NULL,
	[usuarioIdentificacion] [varchar](20) NULL,
	[usuarioApellido] [varchar](100) NULL,
	[usuarioGUID] [uniqueidentifier] NULL,
	[usuarioTerminal] [nchar](1) NULL,
	[usuarioUltPO] [smallint] NULL,
	[usuarioUser] [varchar](100) NULL,
 CONSTRAINT [PK_usuarios] PRIMARY KEY CLUSTERED 
(
	[usuarioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuariosEstaciones]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuariosEstaciones](
	[usuarioId] [bigint] NOT NULL,
	[estacionId] [bigint] NOT NULL,
 CONSTRAINT [PK_UsuariosEstaciones] PRIMARY KEY CLUSTERED 
(
	[usuarioId] ASC,
	[estacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuariosListas]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuariosListas](
	[usuarioListaId] [bigint] IDENTITY(1,1) NOT NULL,
	[usuarioListaCodigo] [varchar](30) NOT NULL,
	[usuarioListaNombre] [varchar](100) NOT NULL,
	[procesoId] [bigint] NOT NULL,
	[titularId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuariosListasDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuariosListasDetalle](
	[usuarioListaId] [bigint] NOT NULL,
	[usuarioId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuariosRoles]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuariosRoles](
	[usuarioId] [bigint] NOT NULL,
	[roleId] [bigint] NOT NULL,
 CONSTRAINT [PK_UsuariosRoles] PRIMARY KEY CLUSTERED 
(
	[usuarioId] ASC,
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ValoresPlantillasLotes]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValoresPlantillasLotes](
	[valorProductoLoteId] [bigint] NOT NULL,
	[productoLoteId] [bigint] NOT NULL,
	[atributoLoteId] [bigint] NOT NULL,
	[valorPlantillaLoteValor] [varchar](100) NOT NULL,
 CONSTRAINT [PK_ValoresPlantillasLotes_1] PRIMARY KEY CLUSTERED 
(
	[valorProductoLoteId] ASC,
	[productoLoteId] ASC,
	[atributoLoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ValoresProductosLotes]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValoresProductosLotes](
	[valorProductoLoteId] [bigint] IDENTITY(1,1) NOT NULL,
	[valorProductoLoteDescripcion] [varchar](100) NULL,
	[valorProductoLoteFecha] [datetime] NULL,
 CONSTRAINT [PK_ValoresProductosLotes] PRIMARY KEY CLUSTERED 
(
	[valorProductoLoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AtributosContenedores] ADD  DEFAULT ((1)) FOR [atributoContenedorEstado]
GO
ALTER TABLE [dbo].[ClasificacionesProductos] ADD  DEFAULT ((1)) FOR [clasificacionProductoEstado]
GO
ALTER TABLE [dbo].[CriteriosProductos] ADD  DEFAULT ((1)) FOR [criterioProductoEstado]
GO
ALTER TABLE [dbo].[Despachos] ADD  CONSTRAINT [DF_Despachos_despachoFecha]  DEFAULT (getutcdate()) FOR [despachoFecha]
GO
ALTER TABLE [dbo].[DespachosDetalle] ADD  CONSTRAINT [DF_DespachosDetalle_despachoDetalleCantTotal]  DEFAULT ((0)) FOR [despachoDetalleCantTotal]
GO
ALTER TABLE [dbo].[Identificaciones] ADD  CONSTRAINT [DF__Identific__ident__4B7734FF]  DEFAULT ((100)) FOR [identificacionCodigo]
GO
ALTER TABLE [dbo].[Packing] ADD  CONSTRAINT [DF_Packing_packingFecha]  DEFAULT (getutcdate()) FOR [packingFecha]
GO
ALTER TABLE [dbo].[PackingDetalle] ADD  CONSTRAINT [DF_PackingDetalle_packingDetalleCantTotal]  DEFAULT ((0)) FOR [packingDetalleCantTotal]
GO
ALTER TABLE [dbo].[PedidosPreRuteo] ADD  CONSTRAINT [DF_PedidosPreRuteo_Estado]  DEFAULT ((0)) FOR [Estado]
GO
ALTER TABLE [dbo].[PlantillasProductosAtributos] ADD  DEFAULT ((1)) FOR [plantillaProductoAtributoEstado]
GO
ALTER TABLE [dbo].[Presentaciones] ADD  CONSTRAINT [DF__Presentac__prese__4D5F7D71]  DEFAULT ((0)) FOR [presentacionAncho]
GO
ALTER TABLE [dbo].[Presentaciones] ADD  CONSTRAINT [DF__Presentac__prese__4E53A1AA]  DEFAULT ((0)) FOR [presentacionAlto]
GO
ALTER TABLE [dbo].[Presentaciones] ADD  CONSTRAINT [DF__Presentac__prese__4F47C5E3]  DEFAULT ((0)) FOR [presentacionProfundidad]
GO
ALTER TABLE [dbo].[Presentaciones] ADD  CONSTRAINT [DF__Presentac__prese__503BEA1C]  DEFAULT ((0)) FOR [presentacionPesoBruto]
GO
ALTER TABLE [dbo].[Presentaciones] ADD  CONSTRAINT [DF__Presentac__prese__51300E55]  DEFAULT ((0)) FOR [presentacionPesoNeto]
GO
ALTER TABLE [dbo].[Presentaciones] ADD  CONSTRAINT [DF__Presentac__prese__5224328E]  DEFAULT ((0)) FOR [presentacionVolumen]
GO
ALTER TABLE [dbo].[Presentaciones] ADD  CONSTRAINT [DF_Presentaciones_presentacionOrden]  DEFAULT ((0)) FOR [presentacionOrden]
GO
ALTER TABLE [dbo].[Productos] ADD  DEFAULT ((0)) FOR [productoCantidadEscalar]
GO
ALTER TABLE [dbo].[Productos] ADD  DEFAULT ((0)) FOR [productoUnidadInventario]
GO
ALTER TABLE [dbo].[Productos] ADD  DEFAULT ((1)) FOR [productoManejaLote]
GO
ALTER TABLE [dbo].[RFIDTag] ADD  CONSTRAINT [DF_RFIDTag_RFIDTagContador]  DEFAULT ((1)) FOR [RFIDTagContador]
GO
ALTER TABLE [dbo].[RFIDTag] ADD  CONSTRAINT [DF_RFIDTag_GETDATE]  DEFAULT (getdate()) FOR [GETDATE]
GO
ALTER TABLE [dbo].[RuteosPedidos] ADD  CONSTRAINT [DF_RuteosPedidos_pedidoProcesado]  DEFAULT ((0)) FOR [pedidoProcesado]
GO
ALTER TABLE [dbo].[Saldos] ADD  CONSTRAINT [DF__Saldos__saldoCom__4E53A1AA]  DEFAULT ((0)) FOR [saldoComprometidoManejo]
GO
ALTER TABLE [dbo].[Saldos] ADD  CONSTRAINT [DF__Saldos__saldoInm__4F47C5E3]  DEFAULT ((0)) FOR [saldoInmovilizadoManejo]
GO
ALTER TABLE [dbo].[Saldos] ADD  CONSTRAINT [DF__Saldos__saldoRea__503BEA1C]  DEFAULT ((0)) FOR [saldoRealManejo]
GO
ALTER TABLE [dbo].[Saldos] ADD  CONSTRAINT [DF__Saldos__saldoDis__51300E55]  DEFAULT ((0)) FOR [saldoDisponibleManejo]
GO
ALTER TABLE [dbo].[Saldos] ADD  CONSTRAINT [DF__Saldos__saldoCom__5224328E]  DEFAULT ((0)) FOR [saldoComprometidoEscalar]
GO
ALTER TABLE [dbo].[Saldos] ADD  CONSTRAINT [DF__Saldos__saldoInm__531856C7]  DEFAULT ((0)) FOR [saldoInmovilizadoEscalar]
GO
ALTER TABLE [dbo].[Saldos] ADD  CONSTRAINT [DF__Saldos__saldoRea__540C7B00]  DEFAULT ((0)) FOR [saldoRealEscalar]
GO
ALTER TABLE [dbo].[Saldos] ADD  CONSTRAINT [DF__Saldos__saldoDis__55009F39]  DEFAULT ((0)) FOR [saldoDisponibleEscalar]
GO
ALTER TABLE [dbo].[Saldos] ADD  CONSTRAINT [DF__Saldos__saldoCom__5E53A132]  DEFAULT ((0)) FOR [separaSaldo]
GO
ALTER TABLE [dbo].[SaldosDetalle] ADD  CONSTRAINT [DF__SaldosDet__saldo__607251E5]  DEFAULT ((0)) FOR [saldoDetalleRealManejo]
GO
ALTER TABLE [dbo].[SaldosDetalle] ADD  CONSTRAINT [DF__SaldosDet__saldo__6166761E]  DEFAULT ((0)) FOR [saldoDetalleComprometidoManejo]
GO
ALTER TABLE [dbo].[SaldosDetalle] ADD  CONSTRAINT [DF__SaldosDet__saldo__625A9A57]  DEFAULT ((0)) FOR [saldoDetalleInmovilizadoManejo]
GO
ALTER TABLE [dbo].[SaldosDetalle] ADD  CONSTRAINT [DF__SaldosDet__saldo__634EBE90]  DEFAULT ((0)) FOR [saldoDetalleRealEscalar]
GO
ALTER TABLE [dbo].[SaldosDetalle] ADD  CONSTRAINT [DF_SaldosDetalle_saldoDetalleDisponibleManejo]  DEFAULT ((0)) FOR [saldoDetalleDisponibleManejo]
GO
ALTER TABLE [dbo].[SaldosDetalle] ADD  CONSTRAINT [DF__SaldosDet__saldo__65370702]  DEFAULT ((0)) FOR [saldoDetalleComprometidoEscalar]
GO
ALTER TABLE [dbo].[SaldosDetalle] ADD  CONSTRAINT [DF__SaldosDet__saldo__662B2B3B]  DEFAULT ((0)) FOR [saldoDetalleInmovilizadoEscalar]
GO
ALTER TABLE [dbo].[SaldosDetalle] ADD  CONSTRAINT [DF__SaldosDet__saldo__671F4F74]  DEFAULT ((0)) FOR [saldoDetalleDisponibleEscalar]
GO
ALTER TABLE [dbo].[SaldosUbicaciones] ADD  CONSTRAINT [DF__SaldosUbi__saldo__681373AD]  DEFAULT ((0)) FOR [saldoUbicacionRealManejo]
GO
ALTER TABLE [dbo].[SaldosUbicaciones] ADD  CONSTRAINT [DF__SaldosUbi__saldo__690797E6]  DEFAULT ((0)) FOR [saldoUbicacionComprometidoManejo]
GO
ALTER TABLE [dbo].[SaldosUbicaciones] ADD  CONSTRAINT [DF__SaldosUbi__saldo__69FBBC1F]  DEFAULT ((0)) FOR [saldoUbicacionInmovilizadoManejo]
GO
ALTER TABLE [dbo].[SaldosUbicaciones] ADD  CONSTRAINT [DF__SaldosUbi__saldo__6AEFE058]  DEFAULT ((0)) FOR [saldoUbicacionRealEscalar]
GO
ALTER TABLE [dbo].[SaldosUbicaciones] ADD  CONSTRAINT [DF__SaldosUbi__saldo__6BE40491]  DEFAULT ((0)) FOR [saldoUbicacionDisponibleManejo]
GO
ALTER TABLE [dbo].[SaldosUbicaciones] ADD  CONSTRAINT [DF__SaldosUbi__saldo__6CD828CA]  DEFAULT ((0)) FOR [saldoUbicacionComprometidoEscalar]
GO
ALTER TABLE [dbo].[SaldosUbicaciones] ADD  CONSTRAINT [DF__SaldosUbi__saldo__6DCC4D03]  DEFAULT ((0)) FOR [saldoUbicacionInmovilizadoEscalar]
GO
ALTER TABLE [dbo].[SaldosUbicaciones] ADD  CONSTRAINT [DF__SaldosUbi__saldo__6EC0713C]  DEFAULT ((0)) FOR [saldoUbicacionDisponibleEscalar]
GO
ALTER TABLE [dbo].[TiposContenedores] ADD  DEFAULT ((0)) FOR [tipoContenedorAncho]
GO
ALTER TABLE [dbo].[TiposContenedores] ADD  DEFAULT ((0)) FOR [tipoContenedorAlto]
GO
ALTER TABLE [dbo].[TiposContenedores] ADD  DEFAULT ((0)) FOR [tipoContenedorProfundidad]
GO
ALTER TABLE [dbo].[TiposContenedores] ADD  DEFAULT ((0)) FOR [tipoContenedorPeso]
GO
ALTER TABLE [dbo].[TiposContenedores] ADD  DEFAULT ((0)) FOR [tipoContenedorVolumen]
GO
ALTER TABLE [dbo].[TiposUbicaciones] ADD  CONSTRAINT [DF_TiposUbicaciones_tipoUbicacionEstado]  DEFAULT ((0)) FOR [tipoUbicacionEstado]
GO
ALTER TABLE [dbo].[TxDespacho] ADD  CONSTRAINT [DF__TxDespacho__tXPic__2E90DD8E]  DEFAULT ((0)) FOR [txDespachoRealManejo]
GO
ALTER TABLE [dbo].[TxDespacho] ADD  CONSTRAINT [DF__TxDespacho__tXPic__2F8501C7]  DEFAULT ((0)) FOR [txDespachoRealEscalar]
GO
ALTER TABLE [dbo].[TxDespacho] ADD  CONSTRAINT [DF__TxDespacho__tXPic__30792600]  DEFAULT ((0)) FOR [txDespachoEstado]
GO
ALTER TABLE [dbo].[TXPacking] ADD  CONSTRAINT [DF__tXPacking__tXPic__2E90DD8E]  DEFAULT ((0)) FOR [tXPackingRealManejo]
GO
ALTER TABLE [dbo].[TXPacking] ADD  CONSTRAINT [DF__tXPacking__tXPic__2F8501C7]  DEFAULT ((0)) FOR [tXPackingRealEscalar]
GO
ALTER TABLE [dbo].[TXPacking] ADD  CONSTRAINT [DF__tXPacking__tXPic__30792600]  DEFAULT ((0)) FOR [tXPackingEstado]
GO
ALTER TABLE [dbo].[TXPicking] ADD  CONSTRAINT [DF__TXPicking__tXPic__2E90DD8E]  DEFAULT ((0)) FOR [tXPickingRealManejo]
GO
ALTER TABLE [dbo].[TXPicking] ADD  CONSTRAINT [DF__TXPicking__tXPic__2F8501C7]  DEFAULT ((0)) FOR [tXPickingRealEscalar]
GO
ALTER TABLE [dbo].[TXPicking] ADD  CONSTRAINT [DF__TXPicking__tXPic__30792600]  DEFAULT ((0)) FOR [tXPickingEstado]
GO
ALTER TABLE [dbo].[ValoresProductosLotes] ADD  CONSTRAINT [DF_ValoresProductosLotes_valorProductoLoteFecha]  DEFAULT (getutcdate()) FOR [valorProductoLoteFecha]
GO
ALTER TABLE [dbo].[AtributosContenedores]  WITH CHECK ADD  CONSTRAINT [FK_AtributosContenedores_PlantillasContenedoresAtributos] FOREIGN KEY([plantillaContenedorAtributoId])
REFERENCES [dbo].[PlantillasContenedoresAtributos] ([plantillaContenedorAtributoId])
GO
ALTER TABLE [dbo].[AtributosContenedores] CHECK CONSTRAINT [FK_AtributosContenedores_PlantillasContenedoresAtributos]
GO
ALTER TABLE [dbo].[AtributosContenedores]  WITH CHECK ADD  CONSTRAINT [FK_AtributosContenedores_TiposAtributos] FOREIGN KEY([tipoAtributoId])
REFERENCES [dbo].[TiposAtributos] ([tipoAtributoId])
GO
ALTER TABLE [dbo].[AtributosContenedores] CHECK CONSTRAINT [FK_AtributosContenedores_TiposAtributos]
GO
ALTER TABLE [dbo].[AtributosLotes]  WITH CHECK ADD  CONSTRAINT [FK_AtributosLotes_TiposAtributos] FOREIGN KEY([tipoAtributoId])
REFERENCES [dbo].[TiposAtributos] ([tipoAtributoId])
GO
ALTER TABLE [dbo].[AtributosLotes] CHECK CONSTRAINT [FK_AtributosLotes_TiposAtributos]
GO
ALTER TABLE [dbo].[AtributosProductos]  WITH CHECK ADD  CONSTRAINT [FK_AtributosProductos_PlantillasProductosAtributos] FOREIGN KEY([plantillaProductoAtributoId])
REFERENCES [dbo].[PlantillasProductosAtributos] ([plantillaProductoAtributoId])
GO
ALTER TABLE [dbo].[AtributosProductos] CHECK CONSTRAINT [FK_AtributosProductos_PlantillasProductosAtributos]
GO
ALTER TABLE [dbo].[AtributosProductos]  WITH CHECK ADD  CONSTRAINT [FK_AtributosProductos_TiposAtributos] FOREIGN KEY([tipoAtributoId])
REFERENCES [dbo].[TiposAtributos] ([tipoAtributoId])
GO
ALTER TABLE [dbo].[AtributosProductos] CHECK CONSTRAINT [FK_AtributosProductos_TiposAtributos]
GO
ALTER TABLE [dbo].[AtributosPuntosOperaciones]  WITH CHECK ADD  CONSTRAINT [FK_AtributoPuntosOperacion_ListasPuntosOperacion] FOREIGN KEY([listaPuntoOperacionId])
REFERENCES [dbo].[ListasPuntosOperacion] ([listaPuntoOperacionId])
GO
ALTER TABLE [dbo].[AtributosPuntosOperaciones] CHECK CONSTRAINT [FK_AtributoPuntosOperacion_ListasPuntosOperacion]
GO
ALTER TABLE [dbo].[AtributosPuntosOperaciones]  WITH CHECK ADD  CONSTRAINT [FK_AtributoPuntosOperacion_TiposAtributos] FOREIGN KEY([tipoAtributoId])
REFERENCES [dbo].[TiposAtributos] ([tipoAtributoId])
GO
ALTER TABLE [dbo].[AtributosPuntosOperaciones] CHECK CONSTRAINT [FK_AtributoPuntosOperacion_TiposAtributos]
GO
ALTER TABLE [dbo].[BodegasLogicas]  WITH CHECK ADD  CONSTRAINT [FK_BodegasLogicas_BodegasERP] FOREIGN KEY([bodegaErpId])
REFERENCES [dbo].[BodegasERP] ([bodegaErpId])
GO
ALTER TABLE [dbo].[BodegasLogicas] CHECK CONSTRAINT [FK_BodegasLogicas_BodegasERP]
GO
ALTER TABLE [dbo].[CentrosGestion]  WITH CHECK ADD  CONSTRAINT [FK_CentrosGestion_Ordenantes] FOREIGN KEY([ordenanteId])
REFERENCES [dbo].[Ordenantes] ([ordenanteId])
GO
ALTER TABLE [dbo].[CentrosGestion] CHECK CONSTRAINT [FK_CentrosGestion_Ordenantes]
GO
ALTER TABLE [dbo].[CentrosOperaciones]  WITH CHECK ADD  CONSTRAINT [FK_CentrosOperacion_Ordenantes] FOREIGN KEY([ordenanteId])
REFERENCES [dbo].[Ordenantes] ([ordenanteId])
GO
ALTER TABLE [dbo].[CentrosOperaciones] CHECK CONSTRAINT [FK_CentrosOperacion_Ordenantes]
GO
ALTER TABLE [dbo].[Ciudades]  WITH CHECK ADD  CONSTRAINT [FK_Ciudades_Estados] FOREIGN KEY([estadoId])
REFERENCES [dbo].[Estados] ([estadoId])
GO
ALTER TABLE [dbo].[Ciudades] CHECK CONSTRAINT [FK_Ciudades_Estados]
GO
ALTER TABLE [dbo].[ClasificacionesAtributosProductos]  WITH CHECK ADD  CONSTRAINT [FK_ClasificacionesAtributosProductos_AtributosProductos] FOREIGN KEY([atributoProductoId])
REFERENCES [dbo].[AtributosProductos] ([atributoProductoId])
GO
ALTER TABLE [dbo].[ClasificacionesAtributosProductos] CHECK CONSTRAINT [FK_ClasificacionesAtributosProductos_AtributosProductos]
GO
ALTER TABLE [dbo].[ClasificacionesAtributosProductos]  WITH CHECK ADD  CONSTRAINT [FK_ClasificacionesAtributosProductos_ClasificacionesProducto] FOREIGN KEY([clasificacionId])
REFERENCES [dbo].[ClasificacionesProductos] ([clasificacionProductoId])
GO
ALTER TABLE [dbo].[ClasificacionesAtributosProductos] CHECK CONSTRAINT [FK_ClasificacionesAtributosProductos_ClasificacionesProducto]
GO
ALTER TABLE [dbo].[ClasificacionesPlantillasProductos]  WITH CHECK ADD  CONSTRAINT [FK_ClasificacionesPlantillasProductos_ClasificacionesProducto] FOREIGN KEY([clasificacionId])
REFERENCES [dbo].[ClasificacionesProductos] ([clasificacionProductoId])
GO
ALTER TABLE [dbo].[ClasificacionesPlantillasProductos] CHECK CONSTRAINT [FK_ClasificacionesPlantillasProductos_ClasificacionesProducto]
GO
ALTER TABLE [dbo].[ClasificacionesPlantillasProductos]  WITH CHECK ADD  CONSTRAINT [FK_ClasificacionesPlantillasProductos_PlantillasProductosAtributos] FOREIGN KEY([plantillaProductoId])
REFERENCES [dbo].[PlantillasProductosAtributos] ([plantillaProductoAtributoId])
GO
ALTER TABLE [dbo].[ClasificacionesPlantillasProductos] CHECK CONSTRAINT [FK_ClasificacionesPlantillasProductos_PlantillasProductosAtributos]
GO
ALTER TABLE [dbo].[ClasificacionesPresentaciones]  WITH CHECK ADD  CONSTRAINT [FK_ClasificacionesPresentacion_CriteriosPresentacion] FOREIGN KEY([criterioProductoId])
REFERENCES [dbo].[CriteriosPresentaciones] ([criterioPresentacionId])
GO
ALTER TABLE [dbo].[ClasificacionesPresentaciones] CHECK CONSTRAINT [FK_ClasificacionesPresentacion_CriteriosPresentacion]
GO
ALTER TABLE [dbo].[ClasificacionesProductos]  WITH CHECK ADD  CONSTRAINT [FK_ClasificacionesProducto_CriteriosProductos] FOREIGN KEY([criterioProductoId])
REFERENCES [dbo].[CriteriosProductos] ([criterioProductoId])
GO
ALTER TABLE [dbo].[ClasificacionesProductos] CHECK CONSTRAINT [FK_ClasificacionesProducto_CriteriosProductos]
GO
ALTER TABLE [dbo].[Clientes]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Titulares] FOREIGN KEY([titularId])
REFERENCES [dbo].[Titulares] ([titularId])
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [FK_Cliente_Titulares]
GO
ALTER TABLE [dbo].[ContactosPuntosOperaciones]  WITH CHECK ADD  CONSTRAINT [FK_ContactosPuntosOperacion_Contactos] FOREIGN KEY([contactoId])
REFERENCES [dbo].[Contactos] ([contactoId])
GO
ALTER TABLE [dbo].[ContactosPuntosOperaciones] CHECK CONSTRAINT [FK_ContactosPuntosOperacion_Contactos]
GO
ALTER TABLE [dbo].[ContactosPuntosOperaciones]  WITH CHECK ADD  CONSTRAINT [FK_ContactosPuntosOperacion_PuntosOperacion] FOREIGN KEY([puntoOperacionId])
REFERENCES [dbo].[PuntosOperaciones] ([puntoOperacionId])
GO
ALTER TABLE [dbo].[ContactosPuntosOperaciones] CHECK CONSTRAINT [FK_ContactosPuntosOperacion_PuntosOperacion]
GO
ALTER TABLE [dbo].[Contenedores]  WITH CHECK ADD  CONSTRAINT [FK_Contenedores_Contenedores] FOREIGN KEY([contenedorPadreId])
REFERENCES [dbo].[Contenedores] ([contenedorId])
GO
ALTER TABLE [dbo].[Contenedores] CHECK CONSTRAINT [FK_Contenedores_Contenedores]
GO
ALTER TABLE [dbo].[Contenedores]  WITH CHECK ADD  CONSTRAINT [FK_Contenedores_TiposContenedores] FOREIGN KEY([tipoContenedorId])
REFERENCES [dbo].[TiposContenedores] ([tipoContenedorId])
GO
ALTER TABLE [dbo].[Contenedores] CHECK CONSTRAINT [FK_Contenedores_TiposContenedores]
GO
ALTER TABLE [dbo].[Coordenadas]  WITH CHECK ADD  CONSTRAINT [FK_Coordenadas_Coordenadas] FOREIGN KEY([coordenadaPadreId])
REFERENCES [dbo].[Coordenadas] ([coordenadaId])
GO
ALTER TABLE [dbo].[Coordenadas] CHECK CONSTRAINT [FK_Coordenadas_Coordenadas]
GO
ALTER TABLE [dbo].[Coordenadas]  WITH CHECK ADD  CONSTRAINT [FK_Coordenadas_PuntosOperacion] FOREIGN KEY([puntoOperacionId])
REFERENCES [dbo].[PuntosOperaciones] ([puntoOperacionId])
GO
ALTER TABLE [dbo].[Coordenadas] CHECK CONSTRAINT [FK_Coordenadas_PuntosOperacion]
GO
ALTER TABLE [dbo].[Coordenadas]  WITH CHECK ADD  CONSTRAINT [FK_Coordenadas_TipoCoordenada] FOREIGN KEY([tipoCoordenada])
REFERENCES [dbo].[TiposCoordenadas] ([tipoCoordenadaId])
GO
ALTER TABLE [dbo].[Coordenadas] CHECK CONSTRAINT [FK_Coordenadas_TipoCoordenada]
GO
ALTER TABLE [dbo].[Custodios]  WITH CHECK ADD  CONSTRAINT [FK_Custodios_Ordenantes] FOREIGN KEY([ordenanteId])
REFERENCES [dbo].[Ordenantes] ([ordenanteId])
GO
ALTER TABLE [dbo].[Custodios] CHECK CONSTRAINT [FK_Custodios_Ordenantes]
GO
ALTER TABLE [dbo].[Despachos]  WITH CHECK ADD  CONSTRAINT [FK_Despachos_Usuarios] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[Usuarios] ([usuarioId])
GO
ALTER TABLE [dbo].[Despachos] CHECK CONSTRAINT [FK_Despachos_Usuarios]
GO
ALTER TABLE [dbo].[DespachosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_despachoDetalle_Pedidos] FOREIGN KEY([pedidoId])
REFERENCES [dbo].[Pedidos] ([pedidoId])
GO
ALTER TABLE [dbo].[DespachosDetalle] CHECK CONSTRAINT [FK_despachoDetalle_Pedidos]
GO
ALTER TABLE [dbo].[DespachosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_despachoDetalle_Presentaciones] FOREIGN KEY([presentacionId])
REFERENCES [dbo].[Presentaciones] ([presentacionId])
GO
ALTER TABLE [dbo].[DespachosDetalle] CHECK CONSTRAINT [FK_despachoDetalle_Presentaciones]
GO
ALTER TABLE [dbo].[DespachosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_despachoDetalle_Ruteos] FOREIGN KEY([ruteoId])
REFERENCES [dbo].[Ruteos] ([ruteoId])
GO
ALTER TABLE [dbo].[DespachosDetalle] CHECK CONSTRAINT [FK_despachoDetalle_Ruteos]
GO
ALTER TABLE [dbo].[DespachosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_despachoDetalle_RuteosDetalle] FOREIGN KEY([ruteoDetalleId])
REFERENCES [dbo].[RuteosDetalle] ([ruteoDetalleId])
GO
ALTER TABLE [dbo].[DespachosDetalle] CHECK CONSTRAINT [FK_despachoDetalle_RuteosDetalle]
GO
ALTER TABLE [dbo].[DespachosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_despachoDetalle_Ubicaciones] FOREIGN KEY([ubicacionId])
REFERENCES [dbo].[Ubicaciones] ([ubicacionId])
GO
ALTER TABLE [dbo].[DespachosDetalle] CHECK CONSTRAINT [FK_despachoDetalle_Ubicaciones]
GO
ALTER TABLE [dbo].[DespachosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_DespachosDetalle_despachos] FOREIGN KEY([despachoId])
REFERENCES [dbo].[Despachos] ([despachoId])
GO
ALTER TABLE [dbo].[DespachosDetalle] CHECK CONSTRAINT [FK_DespachosDetalle_despachos]
GO
ALTER TABLE [dbo].[DespachosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_DespachosDetalle_Novedades] FOREIGN KEY([novedadId])
REFERENCES [dbo].[Novedades] ([novedadId])
GO
ALTER TABLE [dbo].[DespachosDetalle] CHECK CONSTRAINT [FK_DespachosDetalle_Novedades]
GO
ALTER TABLE [dbo].[DetalleUnidadesEscalares]  WITH CHECK ADD  CONSTRAINT [FK_DetalleUnidadesEscalares_UnidadesEscalares] FOREIGN KEY([unidadEscalarId])
REFERENCES [dbo].[UnidadesEscalares] ([unidadEscalarId])
GO
ALTER TABLE [dbo].[DetalleUnidadesEscalares] CHECK CONSTRAINT [FK_DetalleUnidadesEscalares_UnidadesEscalares]
GO
ALTER TABLE [dbo].[Documentos]  WITH CHECK ADD  CONSTRAINT [FK_Documentos_BodegasLogicas] FOREIGN KEY([bodegaLogicaId])
REFERENCES [dbo].[BodegasLogicas] ([bodegaLogicaId])
GO
ALTER TABLE [dbo].[Documentos] CHECK CONSTRAINT [FK_Documentos_BodegasLogicas]
GO
ALTER TABLE [dbo].[Documentos]  WITH CHECK ADD  CONSTRAINT [FK_Documentos_BodegasLogicas1] FOREIGN KEY([bodegaLogicaComboId])
REFERENCES [dbo].[BodegasLogicas] ([bodegaLogicaId])
GO
ALTER TABLE [dbo].[Documentos] CHECK CONSTRAINT [FK_Documentos_BodegasLogicas1]
GO
ALTER TABLE [dbo].[Documentos]  WITH CHECK ADD  CONSTRAINT [FK_Documentos_Titulares] FOREIGN KEY([titularId])
REFERENCES [dbo].[Titulares] ([titularId])
GO
ALTER TABLE [dbo].[Documentos] CHECK CONSTRAINT [FK_Documentos_Titulares]
GO
ALTER TABLE [dbo].[DocumentosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_DocumentosDetalle_Documentos] FOREIGN KEY([documentoId])
REFERENCES [dbo].[Documentos] ([documentoId])
GO
ALTER TABLE [dbo].[DocumentosDetalle] CHECK CONSTRAINT [FK_DocumentosDetalle_Documentos]
GO
ALTER TABLE [dbo].[DocumentosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_DocumentosDetalle_DocumentosDetalle] FOREIGN KEY([documentoDetalleId])
REFERENCES [dbo].[DocumentosDetalle] ([documentoDetalleId])
GO
ALTER TABLE [dbo].[DocumentosDetalle] CHECK CONSTRAINT [FK_DocumentosDetalle_DocumentosDetalle]
GO
ALTER TABLE [dbo].[DocumentosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_DocumentosDetalle_DocumentosDetalle1] FOREIGN KEY([documentoDetalleId])
REFERENCES [dbo].[DocumentosDetalle] ([documentoDetalleId])
GO
ALTER TABLE [dbo].[DocumentosDetalle] CHECK CONSTRAINT [FK_DocumentosDetalle_DocumentosDetalle1]
GO
ALTER TABLE [dbo].[Estaciones]  WITH CHECK ADD  CONSTRAINT [FK_Estaciones_BodegasLogicas] FOREIGN KEY([bodegaLogicaId])
REFERENCES [dbo].[BodegasLogicas] ([bodegaLogicaId])
GO
ALTER TABLE [dbo].[Estaciones] CHECK CONSTRAINT [FK_Estaciones_BodegasLogicas]
GO
ALTER TABLE [dbo].[Estaciones]  WITH CHECK ADD  CONSTRAINT [FK_Estaciones_Operaciones] FOREIGN KEY([operacionId])
REFERENCES [dbo].[Operaciones] ([operacionId])
GO
ALTER TABLE [dbo].[Estaciones] CHECK CONSTRAINT [FK_Estaciones_Operaciones]
GO
ALTER TABLE [dbo].[EstacionesPerifericos]  WITH CHECK ADD  CONSTRAINT [FK_EstacionesPerifericos_Estaciones] FOREIGN KEY([estacionId])
REFERENCES [dbo].[Estaciones] ([estacionId])
GO
ALTER TABLE [dbo].[EstacionesPerifericos] CHECK CONSTRAINT [FK_EstacionesPerifericos_Estaciones]
GO
ALTER TABLE [dbo].[EstacionesPerifericos]  WITH CHECK ADD  CONSTRAINT [FK_EstacionesPerifericos_Perifericos] FOREIGN KEY([PerifericoId])
REFERENCES [dbo].[Perifericos] ([PerifericoId])
GO
ALTER TABLE [dbo].[EstacionesPerifericos] CHECK CONSTRAINT [FK_EstacionesPerifericos_Perifericos]
GO
ALTER TABLE [dbo].[Estados]  WITH CHECK ADD  CONSTRAINT [FK_Estados_Paises] FOREIGN KEY([paisId])
REFERENCES [dbo].[Paises] ([paisId])
GO
ALTER TABLE [dbo].[Estados] CHECK CONSTRAINT [FK_Estados_Paises]
GO
ALTER TABLE [dbo].[Grupos]  WITH CHECK ADD  CONSTRAINT [FK_Grupos_Grupos] FOREIGN KEY([puntoOperacionId])
REFERENCES [dbo].[PuntosOperaciones] ([puntoOperacionId])
GO
ALTER TABLE [dbo].[Grupos] CHECK CONSTRAINT [FK_Grupos_Grupos]
GO
ALTER TABLE [dbo].[Identificaciones]  WITH CHECK ADD  CONSTRAINT [FK_Identificaciones_Presentaciones] FOREIGN KEY([presentacionId])
REFERENCES [dbo].[Presentaciones] ([presentacionId])
GO
ALTER TABLE [dbo].[Identificaciones] CHECK CONSTRAINT [FK_Identificaciones_Presentaciones]
GO
ALTER TABLE [dbo].[Identificaciones]  WITH CHECK ADD  CONSTRAINT [FK_Identificaciones_TiposIdentificacion] FOREIGN KEY([tipoIdentificacionId])
REFERENCES [dbo].[TiposIdentificaciones] ([tipoIdentificacionId])
GO
ALTER TABLE [dbo].[Identificaciones] CHECK CONSTRAINT [FK_Identificaciones_TiposIdentificacion]
GO
ALTER TABLE [dbo].[Novedades]  WITH CHECK ADD  CONSTRAINT [FK_Novedades_Procesos] FOREIGN KEY([procesoId])
REFERENCES [dbo].[Procesos] ([ProcesoId])
GO
ALTER TABLE [dbo].[Novedades] CHECK CONSTRAINT [FK_Novedades_Procesos]
GO
ALTER TABLE [dbo].[Packing]  WITH CHECK ADD  CONSTRAINT [FK_Packing_Usuarios] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[Usuarios] ([usuarioId])
GO
ALTER TABLE [dbo].[Packing] CHECK CONSTRAINT [FK_Packing_Usuarios]
GO
ALTER TABLE [dbo].[PackingDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PackingDetalle_Novedades] FOREIGN KEY([novedadId])
REFERENCES [dbo].[Novedades] ([novedadId])
GO
ALTER TABLE [dbo].[PackingDetalle] CHECK CONSTRAINT [FK_PackingDetalle_Novedades]
GO
ALTER TABLE [dbo].[PackingDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PackingDetalle_Packing] FOREIGN KEY([packingId])
REFERENCES [dbo].[Packing] ([packingId])
GO
ALTER TABLE [dbo].[PackingDetalle] CHECK CONSTRAINT [FK_PackingDetalle_Packing]
GO
ALTER TABLE [dbo].[PackingDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PackingDetalle_Pedidos] FOREIGN KEY([pedidoId])
REFERENCES [dbo].[Pedidos] ([pedidoId])
GO
ALTER TABLE [dbo].[PackingDetalle] CHECK CONSTRAINT [FK_PackingDetalle_Pedidos]
GO
ALTER TABLE [dbo].[PackingDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PackingDetalle_Presentaciones] FOREIGN KEY([presentacionId])
REFERENCES [dbo].[Presentaciones] ([presentacionId])
GO
ALTER TABLE [dbo].[PackingDetalle] CHECK CONSTRAINT [FK_PackingDetalle_Presentaciones]
GO
ALTER TABLE [dbo].[PackingDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PackingDetalle_Ruteos] FOREIGN KEY([ruteoId])
REFERENCES [dbo].[Ruteos] ([ruteoId])
GO
ALTER TABLE [dbo].[PackingDetalle] CHECK CONSTRAINT [FK_PackingDetalle_Ruteos]
GO
ALTER TABLE [dbo].[PackingDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PackingDetalle_RuteosDetalle] FOREIGN KEY([ruteoDetalleId])
REFERENCES [dbo].[RuteosDetalle] ([ruteoDetalleId])
GO
ALTER TABLE [dbo].[PackingDetalle] CHECK CONSTRAINT [FK_PackingDetalle_RuteosDetalle]
GO
ALTER TABLE [dbo].[PackingDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PackingDetalle_Ubicaciones] FOREIGN KEY([ubicacionMedioId])
REFERENCES [dbo].[Ubicaciones] ([ubicacionId])
GO
ALTER TABLE [dbo].[PackingDetalle] CHECK CONSTRAINT [FK_PackingDetalle_Ubicaciones]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedido_Sucursal] FOREIGN KEY([sucursalId])
REFERENCES [dbo].[Sucursales] ([sucursalId])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedido_Sucursal]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_PuntosOperaciones] FOREIGN KEY([puntoOperacionId])
REFERENCES [dbo].[PuntosOperaciones] ([puntoOperacionId])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_PuntosOperaciones]
GO
ALTER TABLE [dbo].[PedidosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PedidoDetalle_Pedido] FOREIGN KEY([pedidoId])
REFERENCES [dbo].[Pedidos] ([pedidoId])
GO
ALTER TABLE [dbo].[PedidosDetalle] CHECK CONSTRAINT [FK_PedidoDetalle_Pedido]
GO
ALTER TABLE [dbo].[PedidosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PedidoDetalle_PuntoEnvio1] FOREIGN KEY([puntoEnvioId])
REFERENCES [dbo].[PuntosEnvio] ([puntoEnvioId])
GO
ALTER TABLE [dbo].[PedidosDetalle] CHECK CONSTRAINT [FK_PedidoDetalle_PuntoEnvio1]
GO
ALTER TABLE [dbo].[PedidosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PedidosDetalle_Presentaciones] FOREIGN KEY([presentacionId])
REFERENCES [dbo].[Presentaciones] ([presentacionId])
GO
ALTER TABLE [dbo].[PedidosDetalle] CHECK CONSTRAINT [FK_PedidosDetalle_Presentaciones]
GO
ALTER TABLE [dbo].[PedidosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PedidosDetalle_Productos] FOREIGN KEY([productoId])
REFERENCES [dbo].[Productos] ([productoId])
GO
ALTER TABLE [dbo].[PedidosDetalle] CHECK CONSTRAINT [FK_PedidosDetalle_Productos]
GO
ALTER TABLE [dbo].[Perifericos]  WITH CHECK ADD  CONSTRAINT [FK_Perifericos_TiposPeriferico] FOREIGN KEY([tipoPerifericoId])
REFERENCES [dbo].[TiposPerifericos] ([tipoPerifericoId])
GO
ALTER TABLE [dbo].[Perifericos] CHECK CONSTRAINT [FK_Perifericos_TiposPeriferico]
GO
ALTER TABLE [dbo].[PlantillasContenedores]  WITH CHECK ADD  CONSTRAINT [FK_PlantillasContenedores_Contenedores] FOREIGN KEY([contenedorId])
REFERENCES [dbo].[Contenedores] ([contenedorId])
GO
ALTER TABLE [dbo].[PlantillasContenedores] CHECK CONSTRAINT [FK_PlantillasContenedores_Contenedores]
GO
ALTER TABLE [dbo].[PlantillasContenedores]  WITH CHECK ADD  CONSTRAINT [FK_PlantillasContenedores_PlantillasContenedoresAtributos] FOREIGN KEY([plantillaContenedorAtributoId])
REFERENCES [dbo].[PlantillasContenedoresAtributos] ([plantillaContenedorAtributoId])
GO
ALTER TABLE [dbo].[PlantillasContenedores] CHECK CONSTRAINT [FK_PlantillasContenedores_PlantillasContenedoresAtributos]
GO
ALTER TABLE [dbo].[PlantillasLotesAtributos]  WITH CHECK ADD  CONSTRAINT [FK_PlantillasLotesAtributos_AtributosLotes] FOREIGN KEY([atributoLoteId])
REFERENCES [dbo].[AtributosLotes] ([atributoLoteId])
GO
ALTER TABLE [dbo].[PlantillasLotesAtributos] CHECK CONSTRAINT [FK_PlantillasLotesAtributos_AtributosLotes]
GO
ALTER TABLE [dbo].[PlantillasLotesAtributos]  WITH CHECK ADD  CONSTRAINT [FK_PlantillasLotesAtributos_PlantillasLotes] FOREIGN KEY([plantillaLoteId])
REFERENCES [dbo].[PlantillasLotes] ([plantillaLoteId])
GO
ALTER TABLE [dbo].[PlantillasLotesAtributos] CHECK CONSTRAINT [FK_PlantillasLotesAtributos_PlantillasLotes]
GO
ALTER TABLE [dbo].[PlantillasProductos]  WITH CHECK ADD  CONSTRAINT [FK_PlantillasProductos_PlantillasProductosAtributos] FOREIGN KEY([plantillaProductoAtributoId])
REFERENCES [dbo].[PlantillasProductosAtributos] ([plantillaProductoAtributoId])
GO
ALTER TABLE [dbo].[PlantillasProductos] CHECK CONSTRAINT [FK_PlantillasProductos_PlantillasProductosAtributos]
GO
ALTER TABLE [dbo].[PlantillasProductos]  WITH CHECK ADD  CONSTRAINT [FK_PlantillasProductos_Productos] FOREIGN KEY([productoId])
REFERENCES [dbo].[Productos] ([productoId])
GO
ALTER TABLE [dbo].[PlantillasProductos] CHECK CONSTRAINT [FK_PlantillasProductos_Productos]
GO
ALTER TABLE [dbo].[PreRuteosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PreRuteoDetalle_Coordenadas] FOREIGN KEY([contenedorId])
REFERENCES [dbo].[Contenedores] ([contenedorId])
GO
ALTER TABLE [dbo].[PreRuteosDetalle] CHECK CONSTRAINT [FK_PreRuteoDetalle_Coordenadas]
GO
ALTER TABLE [dbo].[PreRuteosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PreRuteoDetalle_PreRuteo] FOREIGN KEY([preRuteoId])
REFERENCES [dbo].[PreRuteos] ([preRuteoId])
GO
ALTER TABLE [dbo].[PreRuteosDetalle] CHECK CONSTRAINT [FK_PreRuteoDetalle_PreRuteo]
GO
ALTER TABLE [dbo].[PreRuteosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PreRuteoDetalle_Presentaciones] FOREIGN KEY([presentacionId])
REFERENCES [dbo].[Presentaciones] ([presentacionId])
GO
ALTER TABLE [dbo].[PreRuteosDetalle] CHECK CONSTRAINT [FK_PreRuteoDetalle_Presentaciones]
GO
ALTER TABLE [dbo].[PreRuteosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PreRuteoDetalle_Ubicaciones] FOREIGN KEY([ubicacionId])
REFERENCES [dbo].[Ubicaciones] ([ubicacionId])
GO
ALTER TABLE [dbo].[PreRuteosDetalle] CHECK CONSTRAINT [FK_PreRuteoDetalle_Ubicaciones]
GO
ALTER TABLE [dbo].[PreRuteosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PreRuteosDetalle_BodegasLogicas] FOREIGN KEY([bodegaLogicaId])
REFERENCES [dbo].[BodegasLogicas] ([bodegaLogicaId])
GO
ALTER TABLE [dbo].[PreRuteosDetalle] CHECK CONSTRAINT [FK_PreRuteosDetalle_BodegasLogicas]
GO
ALTER TABLE [dbo].[PreRuteosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PreRuteosDetalle_SaldosUbicaciones] FOREIGN KEY([saldoUbicacionId])
REFERENCES [dbo].[SaldosUbicaciones] ([saldoUbicacionId])
GO
ALTER TABLE [dbo].[PreRuteosDetalle] CHECK CONSTRAINT [FK_PreRuteosDetalle_SaldosUbicaciones]
GO
ALTER TABLE [dbo].[PreRuteosPedidos]  WITH CHECK ADD  CONSTRAINT [FK_PreRuteosPedidos_Pedidos] FOREIGN KEY([pedidoId])
REFERENCES [dbo].[Pedidos] ([pedidoId])
GO
ALTER TABLE [dbo].[PreRuteosPedidos] CHECK CONSTRAINT [FK_PreRuteosPedidos_Pedidos]
GO
ALTER TABLE [dbo].[PreRuteosPedidos]  WITH CHECK ADD  CONSTRAINT [FK_PreRuteosPedidos_PreRuteos] FOREIGN KEY([preRuteoId])
REFERENCES [dbo].[PreRuteos] ([preRuteoId])
GO
ALTER TABLE [dbo].[PreRuteosPedidos] CHECK CONSTRAINT [FK_PreRuteosPedidos_PreRuteos]
GO
ALTER TABLE [dbo].[Presentaciones]  WITH CHECK ADD  CONSTRAINT [FK_Presentaciones_pesoEscalar] FOREIGN KEY([pesoEscalarId])
REFERENCES [dbo].[UnidadesEscalares] ([unidadEscalarId])
GO
ALTER TABLE [dbo].[Presentaciones] CHECK CONSTRAINT [FK_Presentaciones_pesoEscalar]
GO
ALTER TABLE [dbo].[Presentaciones]  WITH CHECK ADD  CONSTRAINT [FK_Presentaciones_Productos] FOREIGN KEY([productoId])
REFERENCES [dbo].[Productos] ([productoId])
GO
ALTER TABLE [dbo].[Presentaciones] CHECK CONSTRAINT [FK_Presentaciones_Productos]
GO
ALTER TABLE [dbo].[Presentaciones]  WITH CHECK ADD  CONSTRAINT [FK_Presentaciones_UnidadesEscalares] FOREIGN KEY([longitudEscalarId])
REFERENCES [dbo].[UnidadesEscalares] ([unidadEscalarId])
GO
ALTER TABLE [dbo].[Presentaciones] CHECK CONSTRAINT [FK_Presentaciones_UnidadesEscalares]
GO
ALTER TABLE [dbo].[Presentaciones]  WITH CHECK ADD  CONSTRAINT [FK_Presentaciones_VolumenUnidadesEscalares] FOREIGN KEY([volumenEscalarId])
REFERENCES [dbo].[UnidadesEscalares] ([unidadEscalarId])
GO
ALTER TABLE [dbo].[Presentaciones] CHECK CONSTRAINT [FK_Presentaciones_VolumenUnidadesEscalares]
GO
ALTER TABLE [dbo].[PresentacionesClasificacion]  WITH CHECK ADD  CONSTRAINT [FK_PresentacionesClasificacion_ClasificacionesPresentacion] FOREIGN KEY([clasificacionPresentacionId])
REFERENCES [dbo].[ClasificacionesPresentaciones] ([clasificacionPresentacionId])
GO
ALTER TABLE [dbo].[PresentacionesClasificacion] CHECK CONSTRAINT [FK_PresentacionesClasificacion_ClasificacionesPresentacion]
GO
ALTER TABLE [dbo].[PresentacionesClasificacion]  WITH CHECK ADD  CONSTRAINT [FK_PresentacionesClasificacion_Presentaciones] FOREIGN KEY([presentacionId])
REFERENCES [dbo].[Presentaciones] ([presentacionId])
GO
ALTER TABLE [dbo].[PresentacionesClasificacion] CHECK CONSTRAINT [FK_PresentacionesClasificacion_Presentaciones]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Productos] FOREIGN KEY([titularId])
REFERENCES [dbo].[Titulares] ([titularId])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Productos]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_UnidadesEscalares] FOREIGN KEY([unidadEscalarId])
REFERENCES [dbo].[UnidadesEscalares] ([unidadEscalarId])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_UnidadesEscalares]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_UnidadesManejo] FOREIGN KEY([unidadManejoId])
REFERENCES [dbo].[UnidadesManejo] ([unidadManejoId])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_UnidadesManejo]
GO
ALTER TABLE [dbo].[ProductosAtributos]  WITH CHECK ADD  CONSTRAINT [FK_ProductosAtributos_PlantillasProductos] FOREIGN KEY([productoPlantillaId])
REFERENCES [dbo].[PlantillasProductos] ([plantillaProductoId])
GO
ALTER TABLE [dbo].[ProductosAtributos] CHECK CONSTRAINT [FK_ProductosAtributos_PlantillasProductos]
GO
ALTER TABLE [dbo].[ProductosAtributos]  WITH CHECK ADD  CONSTRAINT [FK_ProductosAtributos_Productos] FOREIGN KEY([productoId])
REFERENCES [dbo].[Productos] ([productoId])
GO
ALTER TABLE [dbo].[ProductosAtributos] CHECK CONSTRAINT [FK_ProductosAtributos_Productos]
GO
ALTER TABLE [dbo].[ProductosClasificaciones]  WITH CHECK ADD  CONSTRAINT [FK_ProductosClasificaciones_ClasificacionesProducto] FOREIGN KEY([clasificacionId])
REFERENCES [dbo].[ClasificacionesProductos] ([clasificacionProductoId])
GO
ALTER TABLE [dbo].[ProductosClasificaciones] CHECK CONSTRAINT [FK_ProductosClasificaciones_ClasificacionesProducto]
GO
ALTER TABLE [dbo].[ProductosClasificaciones]  WITH CHECK ADD  CONSTRAINT [FK_ProductosClasificaciones_Productos] FOREIGN KEY([productoId])
REFERENCES [dbo].[Productos] ([productoId])
GO
ALTER TABLE [dbo].[ProductosClasificaciones] CHECK CONSTRAINT [FK_ProductosClasificaciones_Productos]
GO
ALTER TABLE [dbo].[ProductosCombos]  WITH CHECK ADD  CONSTRAINT [FK_ProductoCombo_Presentaciones] FOREIGN KEY([presentacionIdCombo])
REFERENCES [dbo].[Presentaciones] ([presentacionId])
GO
ALTER TABLE [dbo].[ProductosCombos] CHECK CONSTRAINT [FK_ProductoCombo_Presentaciones]
GO
ALTER TABLE [dbo].[ProductosCombos]  WITH CHECK ADD  CONSTRAINT [FK_ProductoCombo_Presentaciones1] FOREIGN KEY([presentacionIdDestino])
REFERENCES [dbo].[Presentaciones] ([presentacionId])
GO
ALTER TABLE [dbo].[ProductosCombos] CHECK CONSTRAINT [FK_ProductoCombo_Presentaciones1]
GO
ALTER TABLE [dbo].[ProductosCombos]  WITH CHECK ADD  CONSTRAINT [FK_ProductoCombo_Productos] FOREIGN KEY([productoIdDestino])
REFERENCES [dbo].[Productos] ([productoId])
GO
ALTER TABLE [dbo].[ProductosCombos] CHECK CONSTRAINT [FK_ProductoCombo_Productos]
GO
ALTER TABLE [dbo].[ProductosCombos]  WITH CHECK ADD  CONSTRAINT [FK_ProductoCombo_Productos1] FOREIGN KEY([productoIdCombo])
REFERENCES [dbo].[Productos] ([productoId])
GO
ALTER TABLE [dbo].[ProductosCombos] CHECK CONSTRAINT [FK_ProductoCombo_Productos1]
GO
ALTER TABLE [dbo].[ProductosContenedores]  WITH CHECK ADD  CONSTRAINT [FK_ProductosContenedores_Contenedores] FOREIGN KEY([contenedorId])
REFERENCES [dbo].[Contenedores] ([contenedorId])
GO
ALTER TABLE [dbo].[ProductosContenedores] CHECK CONSTRAINT [FK_ProductosContenedores_Contenedores]
GO
ALTER TABLE [dbo].[ProductosContenedores]  WITH CHECK ADD  CONSTRAINT [FK_ProductosContenedores_Productos] FOREIGN KEY([productoId])
REFERENCES [dbo].[Productos] ([productoId])
GO
ALTER TABLE [dbo].[ProductosContenedores] CHECK CONSTRAINT [FK_ProductosContenedores_Productos]
GO
ALTER TABLE [dbo].[ProductosLotes]  WITH CHECK ADD  CONSTRAINT [FK_ProductosLotes_PlantillasLotes] FOREIGN KEY([plantillaLoteId])
REFERENCES [dbo].[PlantillasLotes] ([plantillaLoteId])
GO
ALTER TABLE [dbo].[ProductosLotes] CHECK CONSTRAINT [FK_ProductosLotes_PlantillasLotes]
GO
ALTER TABLE [dbo].[ProductosLotes]  WITH CHECK ADD  CONSTRAINT [FK_ProductosLotes_Productos] FOREIGN KEY([productoId])
REFERENCES [dbo].[Productos] ([productoId])
GO
ALTER TABLE [dbo].[ProductosLotes] CHECK CONSTRAINT [FK_ProductosLotes_Productos]
GO
ALTER TABLE [dbo].[PuntosEnvio]  WITH CHECK ADD  CONSTRAINT [FK_PuntoEnvio_Ciudades] FOREIGN KEY([ciudadId])
REFERENCES [dbo].[Ciudades] ([ciudadId])
GO
ALTER TABLE [dbo].[PuntosEnvio] CHECK CONSTRAINT [FK_PuntoEnvio_Ciudades]
GO
ALTER TABLE [dbo].[PuntosEnvio]  WITH CHECK ADD  CONSTRAINT [FK_PuntoEnvio_Sucursal] FOREIGN KEY([sucursalId])
REFERENCES [dbo].[Sucursales] ([sucursalId])
GO
ALTER TABLE [dbo].[PuntosEnvio] CHECK CONSTRAINT [FK_PuntoEnvio_Sucursal]
GO
ALTER TABLE [dbo].[PuntosOperaciones]  WITH CHECK ADD  CONSTRAINT [FK_PuntosOperacion_CentrosOperacion] FOREIGN KEY([centroOperacionId])
REFERENCES [dbo].[CentrosOperaciones] ([centroOperacionId])
GO
ALTER TABLE [dbo].[PuntosOperaciones] CHECK CONSTRAINT [FK_PuntosOperacion_CentrosOperacion]
GO
ALTER TABLE [dbo].[PuntosOperaciones]  WITH CHECK ADD  CONSTRAINT [FK_PuntosOperacion_Ciudades] FOREIGN KEY([ciudadId])
REFERENCES [dbo].[Ciudades] ([ciudadId])
GO
ALTER TABLE [dbo].[PuntosOperaciones] CHECK CONSTRAINT [FK_PuntosOperacion_Ciudades]
GO
ALTER TABLE [dbo].[PuntosOperaciones]  WITH CHECK ADD  CONSTRAINT [FK_PuntosOperacion_Custodios] FOREIGN KEY([custodioId])
REFERENCES [dbo].[Custodios] ([custodioId])
GO
ALTER TABLE [dbo].[PuntosOperaciones] CHECK CONSTRAINT [FK_PuntosOperacion_Custodios]
GO
ALTER TABLE [dbo].[PuntosOperaciones]  WITH CHECK ADD  CONSTRAINT [FK_PuntosOperacion_ListasPuntosOperacion] FOREIGN KEY([listaPuntoOperacionId])
REFERENCES [dbo].[ListasPuntosOperacion] ([listaPuntoOperacionId])
GO
ALTER TABLE [dbo].[PuntosOperaciones] CHECK CONSTRAINT [FK_PuntosOperacion_ListasPuntosOperacion]
GO
ALTER TABLE [dbo].[ReglaCaducidad]  WITH CHECK ADD  CONSTRAINT [FK_ReglaCaducidad_Motivos] FOREIGN KEY([motivoId])
REFERENCES [dbo].[Motivos] ([motivoId])
GO
ALTER TABLE [dbo].[ReglaCaducidad] CHECK CONSTRAINT [FK_ReglaCaducidad_Motivos]
GO
ALTER TABLE [dbo].[Reglas]  WITH CHECK ADD  CONSTRAINT [FK_Reglas_Productos] FOREIGN KEY([ProductoId])
REFERENCES [dbo].[Productos] ([productoId])
GO
ALTER TABLE [dbo].[Reglas] CHECK CONSTRAINT [FK_Reglas_Productos]
GO
ALTER TABLE [dbo].[Reglas]  WITH CHECK ADD  CONSTRAINT [FK_Reglas_PuntosEnvio] FOREIGN KEY([PuntoEnvioId])
REFERENCES [dbo].[PuntosEnvio] ([puntoEnvioId])
GO
ALTER TABLE [dbo].[Reglas] CHECK CONSTRAINT [FK_Reglas_PuntosEnvio]
GO
ALTER TABLE [dbo].[RuteosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_RuteosDetalle_BodegasLogicas] FOREIGN KEY([bodegaLogicaId])
REFERENCES [dbo].[BodegasLogicas] ([bodegaLogicaId])
GO
ALTER TABLE [dbo].[RuteosDetalle] CHECK CONSTRAINT [FK_RuteosDetalle_BodegasLogicas]
GO
ALTER TABLE [dbo].[RuteosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_RuteosDetalle_Coordenadas] FOREIGN KEY([contenedorId])
REFERENCES [dbo].[Coordenadas] ([coordenadaId])
GO
ALTER TABLE [dbo].[RuteosDetalle] CHECK CONSTRAINT [FK_RuteosDetalle_Coordenadas]
GO
ALTER TABLE [dbo].[RuteosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_RuteosDetalle_Presentaciones] FOREIGN KEY([presentacionId])
REFERENCES [dbo].[Presentaciones] ([presentacionId])
GO
ALTER TABLE [dbo].[RuteosDetalle] CHECK CONSTRAINT [FK_RuteosDetalle_Presentaciones]
GO
ALTER TABLE [dbo].[RuteosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_RuteosDetalle_ruteo] FOREIGN KEY([ruteoId])
REFERENCES [dbo].[Ruteos] ([ruteoId])
GO
ALTER TABLE [dbo].[RuteosDetalle] CHECK CONSTRAINT [FK_RuteosDetalle_ruteo]
GO
ALTER TABLE [dbo].[RuteosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_RuteosDetalle_Ubicaciones] FOREIGN KEY([ubicacionId])
REFERENCES [dbo].[Ubicaciones] ([ubicacionId])
GO
ALTER TABLE [dbo].[RuteosDetalle] CHECK CONSTRAINT [FK_RuteosDetalle_Ubicaciones]
GO
ALTER TABLE [dbo].[RuteosPedidos]  WITH CHECK ADD  CONSTRAINT [FK_RuteosPedidos_Pedidos] FOREIGN KEY([pedidoId])
REFERENCES [dbo].[Pedidos] ([pedidoId])
GO
ALTER TABLE [dbo].[RuteosPedidos] CHECK CONSTRAINT [FK_RuteosPedidos_Pedidos]
GO
ALTER TABLE [dbo].[RuteosPedidos]  WITH CHECK ADD  CONSTRAINT [FK_RuteosPedidos_Ruteos] FOREIGN KEY([ruteoId])
REFERENCES [dbo].[Ruteos] ([ruteoId])
GO
ALTER TABLE [dbo].[RuteosPedidos] CHECK CONSTRAINT [FK_RuteosPedidos_Ruteos]
GO
ALTER TABLE [dbo].[Saldos]  WITH CHECK ADD  CONSTRAINT [FK_Saldos_Productos] FOREIGN KEY([productoId])
REFERENCES [dbo].[Productos] ([productoId])
GO
ALTER TABLE [dbo].[Saldos] CHECK CONSTRAINT [FK_Saldos_Productos]
GO
ALTER TABLE [dbo].[SaldosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_SaldosDetalle_BodegasLogicas] FOREIGN KEY([bodegaLogicaId])
REFERENCES [dbo].[BodegasLogicas] ([bodegaLogicaId])
GO
ALTER TABLE [dbo].[SaldosDetalle] CHECK CONSTRAINT [FK_SaldosDetalle_BodegasLogicas]
GO
ALTER TABLE [dbo].[SaldosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_SaldosDetalle_Contenedores] FOREIGN KEY([contenedorId])
REFERENCES [dbo].[Contenedores] ([contenedorId])
GO
ALTER TABLE [dbo].[SaldosDetalle] CHECK CONSTRAINT [FK_SaldosDetalle_Contenedores]
GO
ALTER TABLE [dbo].[SaldosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_SaldosDetalle_Presentaciones] FOREIGN KEY([presentacionId])
REFERENCES [dbo].[Presentaciones] ([presentacionId])
GO
ALTER TABLE [dbo].[SaldosDetalle] CHECK CONSTRAINT [FK_SaldosDetalle_Presentaciones]
GO
ALTER TABLE [dbo].[SaldosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_SaldosDetalle_Saldos] FOREIGN KEY([saldoId])
REFERENCES [dbo].[Saldos] ([saldoId])
GO
ALTER TABLE [dbo].[SaldosDetalle] CHECK CONSTRAINT [FK_SaldosDetalle_Saldos]
GO
ALTER TABLE [dbo].[SaldosDetalle]  WITH CHECK ADD  CONSTRAINT [FK_SaldosDetalle_Ubicaciones] FOREIGN KEY([ubicacionId])
REFERENCES [dbo].[Ubicaciones] ([ubicacionId])
GO
ALTER TABLE [dbo].[SaldosDetalle] CHECK CONSTRAINT [FK_SaldosDetalle_Ubicaciones]
GO
ALTER TABLE [dbo].[SaldosUbicaciones]  WITH CHECK ADD  CONSTRAINT [FK_SaldosUbicaciones_Saldos] FOREIGN KEY([saldoId])
REFERENCES [dbo].[Saldos] ([saldoId])
GO
ALTER TABLE [dbo].[SaldosUbicaciones] CHECK CONSTRAINT [FK_SaldosUbicaciones_Saldos]
GO
ALTER TABLE [dbo].[SaldosUbicaciones]  WITH CHECK ADD  CONSTRAINT [FK_SaldosUbicaciones_Ubicaciones] FOREIGN KEY([ubicacionId])
REFERENCES [dbo].[Ubicaciones] ([ubicacionId])
GO
ALTER TABLE [dbo].[SaldosUbicaciones] CHECK CONSTRAINT [FK_SaldosUbicaciones_Ubicaciones]
GO
ALTER TABLE [dbo].[Sucursales]  WITH CHECK ADD  CONSTRAINT [FK_Sucursal_Ciudades] FOREIGN KEY([ciudadId])
REFERENCES [dbo].[Ciudades] ([ciudadId])
GO
ALTER TABLE [dbo].[Sucursales] CHECK CONSTRAINT [FK_Sucursal_Ciudades]
GO
ALTER TABLE [dbo].[Sucursales]  WITH CHECK ADD  CONSTRAINT [FK_Sucursal_Ciudades1] FOREIGN KEY([ciudadId])
REFERENCES [dbo].[Ciudades] ([ciudadId])
GO
ALTER TABLE [dbo].[Sucursales] CHECK CONSTRAINT [FK_Sucursal_Ciudades1]
GO
ALTER TABLE [dbo].[Titulares]  WITH CHECK ADD  CONSTRAINT [FK_Titular_Ordenantes] FOREIGN KEY([ordenanteId])
REFERENCES [dbo].[Ordenantes] ([ordenanteId])
GO
ALTER TABLE [dbo].[Titulares] CHECK CONSTRAINT [FK_Titular_Ordenantes]
GO
ALTER TABLE [dbo].[TxDespacho]  WITH CHECK ADD  CONSTRAINT [FK_TxDespacho_BodegasLogicas] FOREIGN KEY([bodegaLogicaId])
REFERENCES [dbo].[BodegasLogicas] ([bodegaLogicaId])
GO
ALTER TABLE [dbo].[TxDespacho] CHECK CONSTRAINT [FK_TxDespacho_BodegasLogicas]
GO
ALTER TABLE [dbo].[TxDespacho]  WITH CHECK ADD  CONSTRAINT [FK_TxDespacho_Contenedores] FOREIGN KEY([contenedorId])
REFERENCES [dbo].[Contenedores] ([contenedorId])
GO
ALTER TABLE [dbo].[TxDespacho] CHECK CONSTRAINT [FK_TxDespacho_Contenedores]
GO
ALTER TABLE [dbo].[TxDespacho]  WITH CHECK ADD  CONSTRAINT [FK_TxDespacho_Identificaciones] FOREIGN KEY([identificacionId])
REFERENCES [dbo].[Identificaciones] ([identificacionId])
GO
ALTER TABLE [dbo].[TxDespacho] CHECK CONSTRAINT [FK_TxDespacho_Identificaciones]
GO
ALTER TABLE [dbo].[TxDespacho]  WITH CHECK ADD  CONSTRAINT [FK_TxDespacho_Novedades] FOREIGN KEY([novedadId])
REFERENCES [dbo].[Novedades] ([novedadId])
GO
ALTER TABLE [dbo].[TxDespacho] CHECK CONSTRAINT [FK_TxDespacho_Novedades]
GO
ALTER TABLE [dbo].[TxDespacho]  WITH CHECK ADD  CONSTRAINT [FK_TxDespacho_Presentaciones] FOREIGN KEY([presentacionId])
REFERENCES [dbo].[Presentaciones] ([presentacionId])
GO
ALTER TABLE [dbo].[TxDespacho] CHECK CONSTRAINT [FK_TxDespacho_Presentaciones]
GO
ALTER TABLE [dbo].[TxDespacho]  WITH CHECK ADD  CONSTRAINT [FK_TxDespacho_TxDespacho] FOREIGN KEY([txDespachoId])
REFERENCES [dbo].[TxDespacho] ([txDespachoId])
GO
ALTER TABLE [dbo].[TxDespacho] CHECK CONSTRAINT [FK_TxDespacho_TxDespacho]
GO
ALTER TABLE [dbo].[TxDespacho]  WITH CHECK ADD  CONSTRAINT [FK_TxDespacho_Ubicaciones] FOREIGN KEY([ubicacionId])
REFERENCES [dbo].[Ubicaciones] ([ubicacionId])
GO
ALTER TABLE [dbo].[TxDespacho] CHECK CONSTRAINT [FK_TxDespacho_Ubicaciones]
GO
ALTER TABLE [dbo].[TxDespacho]  WITH CHECK ADD  CONSTRAINT [FK_TxDespacho_ValoresProductosLotes] FOREIGN KEY([valorProductoLoteId])
REFERENCES [dbo].[ValoresProductosLotes] ([valorProductoLoteId])
GO
ALTER TABLE [dbo].[TxDespacho] CHECK CONSTRAINT [FK_TxDespacho_ValoresProductosLotes]
GO
ALTER TABLE [dbo].[TXPacking]  WITH CHECK ADD  CONSTRAINT [FK_tXPacking_BodegasLogicas] FOREIGN KEY([bodegaLogicaId])
REFERENCES [dbo].[BodegasLogicas] ([bodegaLogicaId])
GO
ALTER TABLE [dbo].[TXPacking] CHECK CONSTRAINT [FK_tXPacking_BodegasLogicas]
GO
ALTER TABLE [dbo].[TXPacking]  WITH CHECK ADD  CONSTRAINT [FK_tXPacking_Contenedores] FOREIGN KEY([contenedorId])
REFERENCES [dbo].[Contenedores] ([contenedorId])
GO
ALTER TABLE [dbo].[TXPacking] CHECK CONSTRAINT [FK_tXPacking_Contenedores]
GO
ALTER TABLE [dbo].[TXPacking]  WITH CHECK ADD  CONSTRAINT [FK_tXPacking_Identificaciones] FOREIGN KEY([identificacionId])
REFERENCES [dbo].[Identificaciones] ([identificacionId])
GO
ALTER TABLE [dbo].[TXPacking] CHECK CONSTRAINT [FK_tXPacking_Identificaciones]
GO
ALTER TABLE [dbo].[TXPacking]  WITH CHECK ADD  CONSTRAINT [FK_tXPacking_Novedades] FOREIGN KEY([novedadId])
REFERENCES [dbo].[Novedades] ([novedadId])
GO
ALTER TABLE [dbo].[TXPacking] CHECK CONSTRAINT [FK_tXPacking_Novedades]
GO
ALTER TABLE [dbo].[TXPacking]  WITH CHECK ADD  CONSTRAINT [FK_tXPacking_Presentaciones] FOREIGN KEY([presentacionId])
REFERENCES [dbo].[Presentaciones] ([presentacionId])
GO
ALTER TABLE [dbo].[TXPacking] CHECK CONSTRAINT [FK_tXPacking_Presentaciones]
GO
ALTER TABLE [dbo].[TXPacking]  WITH CHECK ADD  CONSTRAINT [FK_tXPacking_tXPacking] FOREIGN KEY([tXPackingId])
REFERENCES [dbo].[TXPacking] ([tXPackingId])
GO
ALTER TABLE [dbo].[TXPacking] CHECK CONSTRAINT [FK_tXPacking_tXPacking]
GO
ALTER TABLE [dbo].[TXPacking]  WITH CHECK ADD  CONSTRAINT [FK_tXPacking_Ubicaciones] FOREIGN KEY([ubicacionId])
REFERENCES [dbo].[Ubicaciones] ([ubicacionId])
GO
ALTER TABLE [dbo].[TXPacking] CHECK CONSTRAINT [FK_tXPacking_Ubicaciones]
GO
ALTER TABLE [dbo].[TXPacking]  WITH CHECK ADD  CONSTRAINT [FK_tXPacking_ValoresProductosLotes] FOREIGN KEY([valorProductoLoteId])
REFERENCES [dbo].[ValoresProductosLotes] ([valorProductoLoteId])
GO
ALTER TABLE [dbo].[TXPacking] CHECK CONSTRAINT [FK_tXPacking_ValoresProductosLotes]
GO
ALTER TABLE [dbo].[TXPicking]  WITH CHECK ADD  CONSTRAINT [FK_TXPicking_BodegasLogicas] FOREIGN KEY([bodegaLogicaId])
REFERENCES [dbo].[BodegasLogicas] ([bodegaLogicaId])
GO
ALTER TABLE [dbo].[TXPicking] CHECK CONSTRAINT [FK_TXPicking_BodegasLogicas]
GO
ALTER TABLE [dbo].[TXPicking]  WITH CHECK ADD  CONSTRAINT [FK_TXPicking_Contenedores] FOREIGN KEY([contenedorId])
REFERENCES [dbo].[Contenedores] ([contenedorId])
GO
ALTER TABLE [dbo].[TXPicking] CHECK CONSTRAINT [FK_TXPicking_Contenedores]
GO
ALTER TABLE [dbo].[TXPicking]  WITH CHECK ADD  CONSTRAINT [FK_TXPicking_Identificaciones] FOREIGN KEY([identificacionId])
REFERENCES [dbo].[Identificaciones] ([identificacionId])
GO
ALTER TABLE [dbo].[TXPicking] CHECK CONSTRAINT [FK_TXPicking_Identificaciones]
GO
ALTER TABLE [dbo].[TXPicking]  WITH CHECK ADD  CONSTRAINT [FK_TXPicking_Novedades] FOREIGN KEY([novedadId])
REFERENCES [dbo].[Novedades] ([novedadId])
GO
ALTER TABLE [dbo].[TXPicking] CHECK CONSTRAINT [FK_TXPicking_Novedades]
GO
ALTER TABLE [dbo].[TXPicking]  WITH CHECK ADD  CONSTRAINT [FK_TXPicking_Presentaciones] FOREIGN KEY([presentacionId])
REFERENCES [dbo].[Presentaciones] ([presentacionId])
GO
ALTER TABLE [dbo].[TXPicking] CHECK CONSTRAINT [FK_TXPicking_Presentaciones]
GO
ALTER TABLE [dbo].[TXPicking]  WITH CHECK ADD  CONSTRAINT [FK_TXPicking_TXPicking] FOREIGN KEY([tXPickingId])
REFERENCES [dbo].[TXPicking] ([tXPickingId])
GO
ALTER TABLE [dbo].[TXPicking] CHECK CONSTRAINT [FK_TXPicking_TXPicking]
GO
ALTER TABLE [dbo].[TXPicking]  WITH CHECK ADD  CONSTRAINT [FK_TXPicking_Ubicaciones] FOREIGN KEY([ubicacionId])
REFERENCES [dbo].[Ubicaciones] ([ubicacionId])
GO
ALTER TABLE [dbo].[TXPicking] CHECK CONSTRAINT [FK_TXPicking_Ubicaciones]
GO
ALTER TABLE [dbo].[TXPicking]  WITH CHECK ADD  CONSTRAINT [FK_TXPicking_ValoresProductosLotes] FOREIGN KEY([valorProductoLoteId])
REFERENCES [dbo].[ValoresProductosLotes] ([valorProductoLoteId])
GO
ALTER TABLE [dbo].[TXPicking] CHECK CONSTRAINT [FK_TXPicking_ValoresProductosLotes]
GO
ALTER TABLE [dbo].[Ubicaciones]  WITH CHECK ADD  CONSTRAINT [FK_Ubicaciones_TiposUbicaciones] FOREIGN KEY([tipoUbicacionId])
REFERENCES [dbo].[TiposUbicaciones] ([tipoUbicacionId])
GO
ALTER TABLE [dbo].[Ubicaciones] CHECK CONSTRAINT [FK_Ubicaciones_TiposUbicaciones]
GO
ALTER TABLE [dbo].[Ubicaciones]  WITH CHECK ADD  CONSTRAINT [FK_Ubicaciones_UbicacionesFisicas] FOREIGN KEY([ubicacionFisicaId])
REFERENCES [dbo].[UbicacionesFisicas] ([ubicacionFisicaId])
GO
ALTER TABLE [dbo].[Ubicaciones] CHECK CONSTRAINT [FK_Ubicaciones_UbicacionesFisicas]
GO
ALTER TABLE [dbo].[UbicacionesFisicas]  WITH CHECK ADD  CONSTRAINT [FK_UbicacionesFisicas_Coordenadas] FOREIGN KEY([coordenadaId])
REFERENCES [dbo].[Coordenadas] ([coordenadaId])
GO
ALTER TABLE [dbo].[UbicacionesFisicas] CHECK CONSTRAINT [FK_UbicacionesFisicas_Coordenadas]
GO
ALTER TABLE [dbo].[UsuariosEstaciones]  WITH CHECK ADD  CONSTRAINT [FK_UsuariosEstaciones_Estaciones] FOREIGN KEY([estacionId])
REFERENCES [dbo].[Estaciones] ([estacionId])
GO
ALTER TABLE [dbo].[UsuariosEstaciones] CHECK CONSTRAINT [FK_UsuariosEstaciones_Estaciones]
GO
ALTER TABLE [dbo].[UsuariosEstaciones]  WITH CHECK ADD  CONSTRAINT [FK_UsuariosEstaciones_Usuarios] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[Usuarios] ([usuarioId])
GO
ALTER TABLE [dbo].[UsuariosEstaciones] CHECK CONSTRAINT [FK_UsuariosEstaciones_Usuarios]
GO
ALTER TABLE [dbo].[UsuariosRoles]  WITH CHECK ADD  CONSTRAINT [FK_UsuariosRoles_Roles] FOREIGN KEY([roleId])
REFERENCES [dbo].[Roles] ([roleId])
GO
ALTER TABLE [dbo].[UsuariosRoles] CHECK CONSTRAINT [FK_UsuariosRoles_Roles]
GO
ALTER TABLE [dbo].[UsuariosRoles]  WITH CHECK ADD  CONSTRAINT [FK_UsuariosRoles_Usuarios] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[Usuarios] ([usuarioId])
GO
ALTER TABLE [dbo].[UsuariosRoles] CHECK CONSTRAINT [FK_UsuariosRoles_Usuarios]
GO
ALTER TABLE [dbo].[ValoresPlantillasLotes]  WITH CHECK ADD  CONSTRAINT [FK_ValoresPlantillasLotes_AtributosLotes] FOREIGN KEY([atributoLoteId])
REFERENCES [dbo].[AtributosLotes] ([atributoLoteId])
GO
ALTER TABLE [dbo].[ValoresPlantillasLotes] CHECK CONSTRAINT [FK_ValoresPlantillasLotes_AtributosLotes]
GO
ALTER TABLE [dbo].[ValoresPlantillasLotes]  WITH CHECK ADD  CONSTRAINT [FK_ValoresPlantillasLotes_ProductosLotes] FOREIGN KEY([productoLoteId])
REFERENCES [dbo].[ProductosLotes] ([productoLoteId])
GO
ALTER TABLE [dbo].[ValoresPlantillasLotes] CHECK CONSTRAINT [FK_ValoresPlantillasLotes_ProductosLotes]
GO
/****** Object:  StoredProcedure [dbo].[SetPreRuteo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SetPreRuteo]

AS
BEGIN



SELECT GETDATE()
	--			SET DATEFORMAT YMD
	--			IF OBJECT_ID('tempdb..#PedidosProductosCaducidad') is not null DROP TABLE #PedidosProductosCaducidad
	--			IF OBJECT_ID('tempdb..#SaldosProductos') is not null DROP TABLE #SaldosProductos
	--			IF OBJECT_ID('tempdb..#SaldosDetalleProductosLotes') is not null DROP TABLE #SaldosDetalleProductosLotes
	--			IF OBJECT_ID('tempdb..#PreRuteoDetalleTemp') is not null DROP TABLE #PreRuteoDetalleTemp
	--			IF OBJECT_ID('tempdb..#PreRuteoTemp') is not null DROP TABLE #PreRuteoTemp
	--			IF OBJECT_ID('tempdb..#PreRuteoPedidosTemp') is not null DROP TABLE #PreRuteoPedidosTemp
	--			IF OBJECT_ID('tempdb..#SaldosProductosUbicaciones') is not null DROP TABLE #SaldosProductosUbicaciones

	--			CREATE TABLE #PreRuteoDetalleTemp (		
	--					 preRuteoId BIGINT
	--					,productoId BIGINT 
	--					,presentacionId BIGINT NULL
	--					,Cantidad DECIMAL(18,4) DEFAULT 0
	--					,caducidadValor DATE		
	--			)

	--			CREATE TABLE #PreRuteoTemp (
	--					 preRuteoId BIGINT	
	--					,FechaCreacion DATETIME DEFAULT GETDATE()	
	--			)
	--			CREATE TABLE #PreRuteoPedidosTemp (
	--					 preRuteoId BIGINT	
	--					,pedidoId BIGINT 		
	--					,pedidoDetalleId BIGINT
	--			)
	--			CREATE TABLE #PedidosProductosCaducidad (
	--					 pedidoId BIGINT
	--					,pedidoDetalleId BIGINT
	--					,productoId BIGINT 
	--					,presentacionId BIGINT NULL
	--					,CantidadConsolidada DECIMAL(18,4) DEFAULT 0 
	--					,caducidadValor INT 
	--					,FechaCaducidad DATE NULL
	--			)
	--			CREATE TABLE #SaldosProductos (
	--					 saldoId BIGINT	
	--					,productoId BIGINT		
	--			)
	--			CREATE TABLE #SaldosProductosUbicaciones (
	--					 productoId BIGINT 
	--					,presentacionId BIGINT
	--					,valorProductoLoteId BIGINT 
	--					,ubicacionId BIGINT 
	--					,CantidadDisponible DECIMAL(18,4)
	--					,FechaVencimiento DATE						
	--					,CantidadComprometida DECIMAL(18,4) DEFAULT 0
	--					,CantidadInmovilizada DECIMAL(18,4) DEFAULT 0
	--			)
	--			CREATE TABLE #SaldosDetalleProductosLotes (						
	--					 productoId BIGINT 
	--					,presentacionId BIGINT						
	--					,saldoDetalleDisponibleManejo DECIMAL(18,4) DEFAULT 0 
	--					,valorPlantillaLoteValor DATE		
	--					,CantidadCompromete DECIMAL(18,4) DEFAULT 0
	--					,CantidadDisponible DECIMAL(18,4) DEFAULT 0	
	--			)@ubicacionIdDestino
	--			;WITH 
	--					Consolida_Pedido_Normal (
	--								 pedidoId
	--								,pedidoDetalleId
	--								,productoId
	--								,productoTipoId
	--								,presentacionId
	--								,pedidoDetalleCantidad
	--								,caducidadValor
	--								,FechaCaducidad
	--								) AS (
	--											SELECT	p.pedidoId, 
	--													dp.pedidoDetalleId,
	--													dp.productoId, 
	--													dp.productoTipoId, 
	--													(CASE WHEN dp.presentacionId IS NULL THEN (SELECT TOP 1 p.presentacionId FROM dbo.Presentaciones p 
	--													WHERE p.productoId = dp.productoId ORDER BY presentacionOrden ASC) ELSE dp.presentacionId END),
	--													dp.pedidoDetalleCantidad,
	--													r.Caducidad,
	--													DATEADD(DAY,r.Caducidad,GETDATE())
	--													FROM PedidosPreRuteo vp
	--													INNER JOIN [dbo].[Pedidos] p ON vp.pedidoId = p.pedidoId AND p.pedidoEstado= 0 
	--													INNER JOIN [dbo].[PedidosDetalle] dp ON p.pedidoId = dp.pedidoId AND dp.pedidoDetalleEstado= 0 AND dp.productoTipoId = 0 --Normal
	--													INNER JOIN [dbo].[productos] prod ON dp.productoId = prod.productoId AND prod.productoEstado = 1
	--													LEFT JOIN [dbo].[ReglaCaducidad] r ON dp.puntoEnvioId = r.PuntoEnvioId AND dp.productoId = r.ProductoId
	--													WHERE vp.Estado = 0
	--										)
	--										,Consolida_Pedido_Combo (
	--													 pedidoId
	--													,pedidoDetalleId
	--													,productoId
	--													,productoTipoId
	--													,presentacionId
	--													,pedidoDetalleCantidad
	--													,caducidadValor
	--													,FechaCaducidad
	--												) AS (
	--													SELECT	p.pedidoId, 
	--															dp.pedidoDetalleId, 
	--															prod2.productoId,
	--															dp.productoTipoId, 
	--															pc.presentacionIdDestino, 
	--															(pc.productoComboCantidad * dp.pedidoDetalleCantidad),
	--															r.Caducidad,
	--															DATEADD(DAY,r.Caducidad,
	--															--TRY_CONVERT(DATETIME,GETDATE()))
	--															GETDATE())
	--															FROM PedidosPreRuteo vp
	--															INNER JOIN [dbo].[Pedidos] p ON vp.pedidoId = p.pedidoId AND p.pedidoEstado= 0 
	--															INNER JOIN [dbo].[PedidosDetalle] dp ON p.pedidoId = dp.pedidoId AND dp.pedidoDetalleEstado = 0 AND dp.productoTipoId = 1 --Combo
	--															INNER JOIN [dbo].[ProductosCombos] pc ON dp.productoId = pc.productoIdCombo AND pc.productoComboEstado = 1
	--															INNER JOIN [dbo].[productos] prod ON pc.productoIdCombo = prod.productoId AND prod.productoEstado = 1
	--															INNER JOIN [dbo].[productos] prod2 ON pc.productoIdDestino = prod2.productoId AND prod.productoEstado = 1
	--															LEFT JOIN [dbo].[ReglaCaducidad] r ON dp.puntoEnvioId = r.PuntoEnvioId AND prod2.productoId = r.ProductoId
	--															WHERE vp.Estado = 0
	--												)
	--										,Consolida_Pedido_Kit (
	--													 pedidoId
	--													,pedidoDetalleId
	--													,productoId
	--													,productoTipoId
	--													,presentacionId
	--													,pedidoDetalleCantidad
	--													,caducidadValor
	--													,FechaCaducidad
	--												) AS (
	--														SELECT	 p.pedidoId
	--																,dp.pedidoDetalleId
	--																,dp.productoId
	--																,dp.productoTipoId
	--																,(CASE WHEN dp.presentacionId IS NULL THEN 
	--																 (SELECT TOP 1 p.presentacionId FROM dbo.Presentaciones p 
	--																  WHERE p.productoId = dp.productoId ORDER BY presentacionOrden ASC) 
	--																  ELSE dp.presentacionId END)
	--																,dp.pedidoDetalleCantidad
	--																,r.Caducidad
	--																,DATEADD(DAY,r.Caducidad
	--																,GETDATE())
	--																FROM PedidosPreRuteo vp
	--																INNER JOIN [dbo].[Pedidos] p ON vp.pedidoId = p.pedidoId AND p.pedidoEstado= 0 
	--																INNER JOIN [dbo].[PedidosDetalle] dp ON p.pedidoId = dp.pedidoId AND dp.pedidoDetalleEstado= 0 AND dp.productoTipoId = 2 --Normal
	--																INNER JOIN [dbo].[productos] prod ON dp.productoId = prod.productoId AND prod.productoEstado = 1
	--																LEFT JOIN [dbo].[ReglaCaducidad] r ON dp.puntoEnvioId = r.PuntoEnvioId AND dp.productoId = r.ProductoId
	--																WHERE vp.Estado = 0
	--												)
	--										,Consolida_ProductosxTipo (
	--														 pedidoId
	--														,pedidoDetalleId
	--														,productoId
	--														,presentacionId
	--														,Cantidad
	--														,caducidadValor
	--														,FechaCaducidad
	--													) AS (
	--														SELECT	 n.pedidoId
	--																,n.pedidoDetalleId
	--																,n.productoId
	--																,n.presentacionId
	--																,SUM(n.pedidoDetalleCantidad)
	--																,caducidadValor
	--																,n.FechaCaducidad
	--																FROM Consolida_Pedido_Normal n
	--																GROUP BY n.pedidoId
	--																		,n.pedidoDetalleId
	--																		,n.productoId
	--																		,n.presentacionId
	--																		,n.caducidadValor
	--																		,n.FechaCaducidad
	--																		UNION ALL
	--														SELECT	 c.pedidoId
	--																,c.pedidoDetalleId
	--																,c.productoId
	--																,c.presentacionId
	--																,SUM(c.pedidoDetalleCantidad)
	--																,caducidadValor
	--																,c.FechaCaducidad
	--																FROM Consolida_Pedido_Combo c 
	--																GROUP BY c.pedidoId
	--																		,c.pedidoDetalleId
	--																		,c.productoId
	--																		,c.presentacionId
	--																		,c.caducidadValor
	--																		,c.FechaCaducidad
	--																		UNION ALL
	--														SELECT	 k.pedidoId
	--																,k.pedidoDetalleId
	--																,k.productoId
	--																,k.presentacionId
	--																,SUM(k.pedidoDetalleCantidad)
	--																,caducidadValor
	--																,k.FechaCaducidad
	--																FROM Consolida_Pedido_Kit k 
	--																GROUP BY k.pedidoId
	--																		,k.pedidoDetalleId
	--																		,k.productoId
	--																		,k.presentacionId
	--																		,k.caducidadValor
	--																		,k.FechaCaducidad
	--												)
	--												,Consolida_Productos(
	--														 pedidoId	
	--														,pedidoDetalleId
	--														,productoId
	--														,presentacionId
	--														,CantidadConsolidada
	--														,caducidadValor
	--														,FechaCaducidad
	--												) AS (
	--														SELECT	pedidoId
	--																,pedidoDetalleId
	--																,productoId 
	--																,presentacionId
	--																,SUM(Cantidad)
	--																,caducidadValor
	--																,FechaCaducidad
	--																FROM Consolida_ProductosxTipo 
	--																GROUP BY pedidoId
	--																		,pedidoDetalleId
	--																		,productoId
	--																		,presentacionId
	--																		,caducidadValor
	--																		,FechaCaducidad
	--													) 
	
	---- Se insertan en una temporal los pedidos con sus productos y caducidad por punto de envio
	--				INSERT	INTO	#PedidosProductosCaducidad	(
	--										 pedidoId 
	--										,pedidoDetalleId 
	--										,productoId  
	--										,presentacionId 
	--										,CantidadConsolidada 
	--										,caducidadValor  
	--										,FechaCaducidad)
	--						SELECT	 pedidoId
	--								,pedidoDetalleId
	--								,productoId
	--								,presentacionId
	--								,CantidadConsolidada
	--								,caducidadValor
	--								,FechaCaducidad
	--						FROM Consolida_Productos

	--				;WITH 
	--					Saldos_Productos_Pedido(
	--								 saldoId
	--								,productoId
	--						) AS (
	--							SELECT DISTINCT
	--								s.saldoId
	--								,ppc.productoId		
	--							FROM #PedidosProductosCaducidad ppc 
	--							INNER JOIN [dbo].[Saldos] s ON ppc.productoId = s.productoId
	--					)

	--				-- Se insertan en una temporal los saldos segun los productos solicitados
	--				INSERT INTO #SaldosProductos
	--				SELECT * FROM Saldos_Productos_Pedido 

	--				;WITH
	--					Saldos_Productos_Ubicacion(
	--								productoId
	--								,presentacionId
	--								,valorProductoLoteId
	--								,ubicacionId
	--								,CantidadDisponible
	--								,FechaVencimiento
									
	--						) AS (
	--								SELECT		s.productoId
	--											,sd.presentacionId
	--											,sd.valorProductoLoteId
	--											,u.ubicacionId
	--											,sd.saldoDetalleRealManejo -(sd.saldoDetalleComprometidoManejo+sd.saldoDetalleInmovilizadoManejo)
	--											,CONVERT(DATE,vpl.valorPlantillaLoteValor)
											
	--								FROM [dbo].[saldos] s
	--								INNER JOIN #SaldosProductos sp ON s.saldoId = sp.saldoId AND s.productoId = sp.productoId
	--								INNER JOIN [dbo].[SaldosDetalle] sd ON sp.saldoId = sd.saldoId AND sd.bodegaLogicaId = 2 	
	--								INNER JOIN [dbo].[Ubicaciones] u ON sd.ubicacionId = u.ubicacionId AND u.ubicacionDescripcion LIKE 'GENERAL'
	--								LEFT JOIN [dbo].[ValoresPlantillasLotes] vpl ON sd.valorProductoLoteId = vpl.valorProductoLoteId	
	--				)

	--				INSERT INTO #SaldosProductosUbicaciones (productoId, presentacionId, valorProductoLoteId, ubicacionId, CantidadDisponible, FechaVencimiento)
	--				SELECT productoId, presentacionId, valorProductoLoteId, ubicacionId, SUM(CantidadDisponible), FechaVencimiento FROM Saldos_Productos_Ubicacion
	--				GROUP BY productoId,presentacionId,valorProductoLoteId , ubicacionId , FechaVencimiento
					
	--				--INSERT INTO #SaldosDetalleProductosLotes (productoId, presentacionId, saldoDetalleDisponibleManejo,valorPlantillaLoteValor)
	--				--SELECT spu.productoId, spu.presentacionId, SUM(spu.CantidadDisponible) ,CONVERT(DATE,spu.FechaVencimiento)		
	--				--FROM #SaldosProductosUbicaciones spu 			
	--				--GROUP BY spu.productoId
	--				--		,spu.presentacionId				
	--				--		,spu.FechaVencimiento		
			
	--				DECLARE @preRuteoId BIGINT
				
				
	--				--TEMPORALMENTE ELIMINO MIENTRAS TEST
	--				DELETE FROM [dbo].[PreRuteosPedidos] 
	--				DELETE FROM [dbo].[PreRuteosDetalle] DBCC CHECKIDENT ('[PreRuteosDetalle]', RESEED, 0)
	--				DELETE FROM [dbo].[PreRuteos] DBCC CHECKIDENT ('[PreRuteos]', RESEED, 0)

			
	--				/******		Generar el registro del PreRuteo	******/
	--				INSERT INTO [dbo].[PreRuteos] (
	--								 preRuteoFecha
	--								,preRuteoUsuario
	--								,preRuteoConsecutivo
	--								,preRuteoPedidoEstado
	--							)
	--							VALUES (
	--										 GETDATE() 
	--										,1
	--										,1
	--										,0
	--							)


	--						--	SELECT productoId
	--						--	,presentacionId
	--						--	,SUM(CantidadConsolidada)
	--						--	--,caducidadValor
	--						--	--,FechaCaducidad
	--						--FROM #PedidosProductosCaducidad
	--						--GROUP BY  productoId
	--						--		 ,presentacionId

	--				/******		Capturo el id del registro PreRuteo agregado	******/
	--				SELECT @preRuteoId =  SCOPE_IDENTITY()  	
	--				INSERT INTO [dbo].[PreRuteosPedidos](preRuteoId,pedidoId)
	--				SELECT DISTINCT  @preRuteoId,pedidoId FROM #PedidosProductosCaducidad		
					
	--				DECLARE @productoTempId BIGINT
	--				DECLARE @presentacionTempId BIGINT
	--				DECLARE @CantidadTemp DECIMAL(18,4)
	--				--DECLARE @caducidadValorTemp INT
	--				DECLARE @FechaCaducidadTemp DATETIME
	--				DECLARE PreRuteoInfo CURSOR FOR 
	--						SELECT productoId
	--							,presentacionId
	--							,SUM(CantidadConsolidada)
	--							--,caducidadValor
	--							--,FechaCaducidad
	--						FROM #PedidosProductosCaducidad
	--						GROUP BY  productoId
	--								 ,presentacionId
							
	--						SELECT productoId
	--							,presentacionId
	--							,CantidadConsolidada
	--							--,caducidadValor
	--							--,FechaCaducidad
	--						FROM #PedidosProductosCaducidad

	--				OPEN PreRuteoInfo

	--				FETCH NEXT FROM PreRuteoInfo 
	--				INTO @productoTempId
	--					,@presentacionTempId
	--					,@CantidadTemp
	--					--,@caducidadValorTemp
	--					--,@FechaCaducidadTemp
					
	--				WHILE @@fetch_status = 0
	--					BEGIN					  
	--						DECLARE @CantidadAux DECIMAL(18,4)= 0
					   
	--						WHILE (@CantidadAux < @CantidadTemp)
	--						BEGIN									
	--								DECLARE @ubicacionId BIGINT = 0
	--								DECLARE @contenedorId BIGINT = 0
	--								DECLARE @CantidadDetalleAux DECIMAL(18,4)= 0
	--								DECLARE @saldoComprometidoManejo DECIMAL(18,4)= 0
	--								DECLARE @saldoDisponibleManejo DECIMAL(18,4)= 0
	--								DECLARE @valorProductoLoteId BIGINT = 0
	--								DECLARE @saldoId BIGINT = 0
	--								DECLARE @date date
									
	--								IF EXISTS	(
	--												SELECT 1											
	--												FROM	#SaldosProductosUbicaciones sd
	--													INNER JOIN [dbo].[Presentaciones] p On sd.presentacionId = p.presentacionId 
	--													AND p.Estiba = sd.CantidadDisponible									
	--												 WHERE 
	--													sd.presentacionId = @presentacionTempId 
	--													AND sd.productoId = @productoTempId 
	--													AND  sd.CantidadDisponible -(CantidadComprometida + CantidadInmovilizada) > 0
	--											)
	--									BEGIN
	--														SELECT TOP 1 
	--																@CantidadDetalleAux =  sd.CantidadDisponible,									
	--																@ubicacionId = ubicacionId,
	--																@valorProductoLoteId = valorProductoLoteId,
	--																@date = FechaVencimiento
	--														FROM	#SaldosProductosUbicaciones sd
	--																INNER JOIN [dbo].[Presentaciones] p On sd.presentacionId = p.presentacionId 
	--																AND p.Estiba = sd.CantidadDisponible									
	--														WHERE 
	--																sd.presentacionId = @presentacionTempId 
	--																AND sd.productoId = @productoTempId 
	--																AND  sd.CantidadDisponible -(CantidadComprometida + CantidadInmovilizada) > 0
	--																--AND ISNULL(FechaVencimiento, 0) >= ISNULL(@caducidadValorTemp,0)		
	--																ORDER BY sd.FechaVencimiento ASC	

	--														IF @CantidadDetalleAux <= 0 BREAK;

	--														SET @CantidadAux= @CantidadAux + @CantidadDetalleAux
	--														SET @saldoComprometidoManejo = @CantidadDetalleAux
												
	--														IF @CantidadAux > @CantidadTemp --Se debe ir a bodega logica de unidades sueltas para
	--														--validar si se tiene el restante, sino se deve tomar una estiba completa e inmovilizar lo demas
	--														SET @saldoComprometidoManejo = @CantidadDetalleAux -(@CantidadAux - @CantidadTemp)			

	--														--SELECT @saldoComprometidoManejo as disponible, @CantidadDetalleAux as detalleaux, @CantidadAux as CantidadAux, @CantidadTemp as cantidad
	--														UPDATE #SaldosProductosUbicaciones
	--														SET CantidadComprometida = @saldoComprometidoManejo,
	--															CantidadInmovilizada = @CantidadDetalleAux - @saldoComprometidoManejo
	--														WHERE	presentacionId = @presentacionTempId 
	--																AND productoId = @productoTempId 
	--																AND ubicacionId = @ubicacionId 							
										
	--															/****** Agregar el detalle asociado a un PreRuteo  ******/
	--														INSERT INTO [dbo].[PreRuteosDetalle] 
	--																			([preRuteoId]							  
	--																			,[novedadId]
	--																			,[preRuteoPedidoEstado]
	--																			,[presentacionId]
	--																			,[ubicacionId]
	--																			,[preRuteoDetalleCantidad]
	--																			,[preRuteoDetalleEstado]
	--																			,[contenedorId]
	--																			,[valorProductoLoteId])																	
	--														SELECT				@preRuteoId
	--																			,1
	--																			,0
	--																			,@presentacionTempId
	--																			,@ubicacionId
	--																			,@CantidadDetalleAux
	--																			,0
	--																			,NULL
	--																			,@valorProductoLoteId

										

	--									SELECT @saldoId = saldoId FROM [dbo].[saldos] WHERE productoId = @productoTempId

	--									IF @saldoId IS NULL OR @saldoId = 0 BREAK;


	--												UPDATE [dbo].[SaldosDetalle]
	--												SET		saldoDetalleComprometidoManejo = saldoDetalleComprometidoManejo + saldoDetalleDisponibleManejo
	--														,saldoDetalleInmovilizadoManejo = saldoDetalleInmovilizadoManejo + 
	--															(saldoDetalleRealManejo - (saldoDetalleComprometidoManejo + saldoDetalleDisponibleManejo))
	--														,saldoDetalleDisponibleManejo = saldoDetalleDisponibleManejo - (saldoDetalleRealManejo - 
	--															((saldoDetalleComprometidoManejo + saldoDetalleDisponibleManejo)- 
	--															saldoDetalleInmovilizadoManejo + (saldoDetalleRealManejo - 
	--															(saldoDetalleComprometidoManejo + saldoDetalleDisponibleManejo))))
	--												WHERE presentacionId = @presentacionTempId AND ubicacionId = @ubicacionId AND saldoId = @saldoId


	--												UPDATE [dbo].[Saldos]
	--												SET  saldoComprometidoManejo = saldoComprometidoManejo + @saldoComprometidoManejo,
	--												saldoInmovilizadoManejo = saldoInmovilizadoManejo + 
	--																				(@CantidadDetalleAux - @saldoComprometidoManejo),
	--												saldoDisponibleManejo = saldoRealManejo - ((saldoComprometidoManejo + @saldoComprometidoManejo)+ 
	--																					(saldoInmovilizadoManejo + 
	--																				(@CantidadDetalleAux - @saldoComprometidoManejo)))
	--												WHERE productoId = @productoTempId AND saldoId = @saldoId
	--								END	

	--							ELSE
	--							BEGIN
	--							 SELECT * FROM #SaldosProductosUbicaciones 
	--							 WHERE productoId = @productoTempId AND presentacionId = @presentacionTempId
												

	--											BREAK;
	--							END
	--					END			

	--					FETCH NEXT FROM PreRuteoInfo 
	--					INTO	@productoTempId,@presentacionTempId,@CantidadTemp
	--					--,@caducidadValorTemp
	--					--,@FechaCaducidadTemp
						
	--				END

	--				CLOSE PreRuteoInfo
	--				DEALLOCATE PreRuteoInfo

	--				--SELECT * FROM	#SaldosProductosUbicaciones
	--				--SELECT * FROM  #SaldosDetalleProductosLotes 
	--				--WHERE productoId = 40 AND presentacionId = 8
	--				--SELECT * FROM #SaldosProductosUbicaciones sd INNER JOIN [dbo].[Presentaciones] p On sd.presentacionId = p.presentacionId 
	--				--				AND p.Estiba = sd.CantidadDisponible
	--				--						WHERE sd.productoId = 39 AND sd.presentacionId = 27	
					

	--				--SELECT * FROM Saldos WHERE productoId = 39

	--				--SELECT * FROM #SaldosProductosUbicaciones2 WHERE productoId = 39 AND presentacionId = 27 
	--				--and ubicacionId=69
					

	--				--SELECT  productoId, presentacionId,CantidadDisponible,CantidadComprometida, COUNT(*) FROM #SaldosProductosUbicaciones2 
	--				--WHERE CantidadComprometida = 1
	--				--GROUP BY productoId, presentacionId, CantidadDisponible, CantidadComprometida
	--				--HAVING COUNT(*) > 0

	--				--SELECT productoId, presentacionId,CantidadDisponible, COUNT(*) 
	--				--FROM #SaldosProductosUbicaciones
	--				----WHERE productoId = 39 AND presentacionId = 27				
	--				--GROUP BY productoId, presentacionId, CantidadDisponible
	--				--HAVING COUNT(*) > 0
				
					

END

GO
/****** Object:  StoredProcedure [dbo].[SP_ADD_NovedadRuteo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_ADD_NovedadRuteo] 
(@novedadId BIGINT,
@ruteoId BIGINT,
 @ruteoDetalleId BIGINT,
  @usuarioId BIGINT)

  AS

   BEGIN

  DECLARE @novedadIdAux BIGINT


  SELECT  @novedadIdAux = novedadId From [dbo].[Novedades] WHERE novedadId = @novedadId

  IF @novedadIdAux IS NULL RETURN;


  IF EXISTS (SELECT 1 FROM [dbo].[RuteosDetalle] WHERE ruteoDetalleId = @ruteoDetalleId AND ruteoId = @ruteoId AND ruteoDetalleEstado = 0 )
			  BEGIN

						UPDATE  [dbo].[RuteosDetalle]
						SET		novedadId = @novedadId
						WHERE	ruteoDetalleId = @ruteoDetalleId 
								AND ruteoId = @ruteoId AND ruteoDetalleEstado = 0

								SELECT 'Se ha asignado la novedad al ruteo'
								RETURN	

			  END

			SELECT 'Error asignando la novedad'
			RETURN  


   END
GO
/****** Object:  StoredProcedure [dbo].[SP_CANCEL_PreRuteo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_CANCEL_PreRuteo]
		(
		@preRuteoId AS BIGINT
		)
		AS
			BEGIN
			
			IF OBJECT_ID('tempdb..#PreRuteoContenedorUbicacionTemp') IS NOT NULL DROP TABLE #PreRuteoContenedorUbicacionTemp
			IF OBJECT_ID('tempdb..#CantidadConsolidadaSaldo') IS NOT NULL DROP TABLE #CantidadConsolidadaSaldo
			
					CREATE TABLE #PreRuteoContenedorUbicacionTemp 
															(
																saldoId BIGINT, 
																saldoUbicacionId BIGINT,
																saldoDetalleId BIGINT, 
																ubicacionId BIGINT, 
																presentacionId BIGINT, 
																contenedorId BIGINT, 
																valorProductoLote BIGINT,
																CantidadComprometidoManejo DECIMAL(18,4), 
																CantidadInmovilizadoManejo DECIMAL(18,4),
																CantidadComprometidoEscalar DECIMAL(18,4),
																CantidadInmovilizadoEscalar DECIMAL(18,4)
															)



					CREATE TABLE #CantidadConsolidadaSaldo 
															(
																 saldoId BIGINT
																,CantidadComprometidoManejo DECIMAL(18,4) 
																,CantidadInmovilizadoManejo DECIMAL(18,4)
																,CantidadComprometidoEscalar DECIMAL(18,4)
																,CantidadInmovilizadoEscalar DECIMAL(18,4)
															)

				;WITH preRuteoData 
				(
							 preRuteoId
							,presentacionId
							,bodegaLogicaId
							,ubicacionId
							,valorProductoLoteId
							,preRuteoDetalleCantidad
							,saldoId
							,saldoUbicacionId
				) AS (

							SELECT 
										 pd.preRuteoId
										,pd.presentacionId
										,pd.bodegaLogicaId
										,pd.ubicacionId
										,pd.valorProductoLoteId
										,pd.preRuteoDetalleCantidad
										,pd.saldoId
										,pd.saldoUbicacionId
							FROM		[dbo].[PreRuteosDetalle] AS pd													
							WHERE		 pd.preRuteoId = @preRuteoId 		
										AND pd.preRuteoDetalleEstado = 0
															
					),	PreRuteoContenedorUbicacion(
															 saldoId
															,saldoUbicacionId
															,saldoDetalleId
															,ubicacionId
															,presentacionId
															,contenedorId
															,valorProductoLote
															,CantidadComprometidoManejo 
															,CantidadInmovilizadoManejo
															,CantidadComprometidoEscalar
															,CantidadInmovilizadoEscalar
													) AS (
													SELECT   sd.saldoId
															,pd.saldoUbicacionId
															,sd.saldoDetalleId
															,sd.ubicacionId
															,sd.presentacionId
															,sd.contenedorId
															,sd.valorProductoLoteId
															,sd.saldoDetalleComprometidoManejo
															,sd.saldoDetalleInmovilizadoManejo
															,sd.saldoDetalleComprometidoEscalar
															,saldoDetalleInmovilizadoEscalar
													FROM	[dbo].[SaldosDetalle] sd 
															INNER JOIN preRuteoData pd ON sd.ubicacionId = pd.ubicacionId 
																						  AND sd.saldoId = pd.saldoId 
														)

				INSERT INTO #PreRuteoContenedorUbicacionTemp 
														(
																 saldoId 
																,saldoUbicacionId
																,saldoDetalleId
																,ubicacionId 
																,presentacionId
																,contenedorId 
																,valorProductoLote
																,CantidadComprometidoManejo 
																,CantidadInmovilizadoManejo
																,CantidadComprometidoEscalar
																,CantidadInmovilizadoEscalar 
														)				
													SELECT		 saldoId
																,saldoUbicacionId
																,saldoDetalleId
																,ubicacionId
																,presentacionId
																,contenedorId
																,valorProductoLote
																,CantidadComprometidoManejo 
																,CantidadInmovilizadoManejo
																,CantidadComprometidoEscalar
																,CantidadInmovilizadoEscalar 
													FROM		 PreRuteoContenedorUbicacion 

				;WITH saldosPreruteoConsolidado				
				(
						saldoId
						,CantidadComprometidoManejo
						,CantidadInmovilizadoManejo
						,CantidadComprometidoEscalar
						,CantidadInmovilizadoEscalar
				) AS (
						SELECT		 pd.saldoId
									,SUM(CantidadComprometidoManejo)  
									,SUM(CantidadInmovilizadoManejo) 
									,SUM(CantidadComprometidoEscalar) 
									,SUM(CantidadInmovilizadoEscalar) 
						FROM		#PreRuteoContenedorUbicacionTemp AS pd	
						INNER JOIN	SaldosUbicaciones su ON pd.saldoId = su.saldoId
						GROUP BY	pd.saldoId
								), saldosUbicacionesPreruteoConsolidado
									(
												 saldoId
												,CantidadComprometidoManejo
												,CantidadInmovilizadoManejo
												,CantidadComprometidoEscalar
												,CantidadInmovilizadoEscalar
									) AS (
												SELECT		 su.saldoId
															,su.saldoUbicacionComprometidoManejo + spc. CantidadComprometidoManejo 
															,su.saldoUbicacionInmovilizadoManejo + spc.CantidadInmovilizadoManejo 
															,su.saldoUbicacionComprometidoEscalar + spc.CantidadComprometidoEscalar 
															,su.saldoUbicacionInmovilizadoEscalar + spc.CantidadInmovilizadoEscalar
												FROM		 SaldosUbicaciones AS su	
												INNER JOIN   saldosPreruteoConsolidado spc ON su.saldoId = spc.saldoId  

				)
				INSERT INTO #CantidadConsolidadaSaldo 
				(
								 saldoId
								,CantidadComprometidoManejo
								,CantidadInmovilizadoManejo
								,CantidadComprometidoEscalar
								,CantidadInmovilizadoEscalar
				)
								SELECT		 saldoId
											,CantidadComprometidoManejo
											,CantidadInmovilizadoManejo
											,CantidadComprometidoEscalar
											,CantidadInmovilizadoEscalar 
								FROM		 saldosUbicacionesPreruteoConsolidado													

				UPDATE		[dbo].[SaldosDetalle] 
				SET			 saldoDetalleComprometidoManejo		= 	(saldoDetalleComprometidoManejo		-	pd.CantidadComprometidoManejo) 
							,saldoDetalleInmovilizadoManejo		=	(saldoDetalleInmovilizadoManejo		-	pd.CantidadInmovilizadoManejo)		
							,saldoDetalleDisponibleManejo		=	(pd.CantidadComprometidoManejo		+	pd.CantidadInmovilizadoManejo)															
							,saldoDetalleComprometidoEscalar	=   (saldoDetalleComprometidoEscalar	-	pd.CantidadComprometidoEscalar)
							,saldoDetalleInmovilizadoEscalar	=	(saldoDetalleInmovilizadoEscalar	-	pd.CantidadInmovilizadoEscalar)
							,saldoDetalleDisponibleEscalar		=	(pd.CantidadComprometidoEscalar		+	pd.CantidadInmovilizadoEscalar)	
				FROM		 #PreRuteoContenedorUbicacionTemp AS pd													
				WHERE		 pd.saldoDetalleId = [dbo].[SaldosDetalle].saldoDetalleId 
							 AND pd.ubicacionId = [dbo].[SaldosDetalle].ubicacionId
							 AND ([dbo].[SaldosDetalle].saldoDetalleComprometidoManejo > 0 AND [dbo].[SaldosDetalle].saldoDetalleInmovilizadoManejo >= 0)
							 AND pd.contenedorId = [dbo].[SaldosDetalle].contenedorId 
							 AND pd.presentacionId  = [dbo].[SaldosDetalle].presentacionId
							 AND pd.saldoId = [dbo].[SaldosDetalle].saldoid
							 AND pd.saldoUbicacionId IS NULL

				UPDATE		 [dbo].[SaldosUbicaciones] 
				SET			 saldoUbicacionComprometidoManejo	= 	0 
							,saldoUbicacionInmovilizadoManejo	=	0		
							,saldoUbicacionDisponibleManejo		=	0															
							,saldoUbicacionComprometidoEscalar	=   0
							,saldoUbicacionInmovilizadoEscalar	=	0
							,saldoUbicacionDisponibleEscalar	=	0		
				FROM		#PreRuteoContenedorUbicacionTemp AS pd													
				WHERE		pd.saldoUbicacionId	=	[dbo].[SaldosUbicaciones].saldoUbicacionId 
							AND pd.ubicacionId	=	[dbo].[SaldosUbicaciones].ubicacionId
							AND ([dbo].[SaldosUbicaciones].saldoUbicacionComprometidoManejo > 0 
							AND [dbo].[SaldosUbicaciones].saldoUbicacionInmovilizadoManejo >= 0)															
							AND pd.saldoId = [dbo].[SaldosUbicaciones].saldoid
							AND pd.saldoUbicacionId IS NOT NULL
														
				DELETE		su 
				FROM		[dbo].[SaldosUbicaciones] su
				INNER JOIN #PreRuteoContenedorUbicacionTemp pr ON	su.saldoId = pr.saldoId 
																	AND su.ubicacionId = pr.ubicacionId
				WHERE		su.saldoUbicacionComprometidoManejo = 0		
							AND su.saldoUbicacionInmovilizadoManejo = 0				
				
				UPDATE		 [dbo].[Saldos] 
				SET			 saldoComprometidoManejo	= 	saldoComprometidoManejo - pd.CantidadComprometidoManejo
							,saldoInmovilizadoManejo	=	saldoInmovilizadoManejo - pd.CantidadInmovilizadoManejo 	
							,saldoDisponibleManejo		=	saldoDisponibleManejo	+ saldoComprometidoManejo + saldoInmovilizadoManejo
							,saldoComprometidoEscalar	=   saldoComprometidoEscalar	- pd.CantidadComprometidoEscalar
							,saldoInmovilizadoEscalar	=	saldoInmovilizadoEscalar	-  pd.CantidadInmovilizadoEscalar
							,saldoDisponibleEscalar		=	saldoDisponibleEscalar		+ saldoComprometidoEscalar + saldoInmovilizadoEscalar
				FROM		#CantidadConsolidadaSaldo AS pd													
				WHERE		pd.saldoId = [dbo].[Saldos].saldoId 															
							AND ([dbo].[Saldos].saldoComprometidoManejo > 0 
							AND [dbo].[Saldos].saldoInmovilizadoManejo >= 0)
							AND  pd.CantidadComprometidoManejo > 0																			

				UPDATE		[dbo].[Pedidos] 
				SET			pedidoEstado = 0
				FROM		[dbo].[PreRuteosPedidos] prp
				WHERE		prp.pedidoId = [dbo].[Pedidos].pedidoId 
							AND  [dbo].[Pedidos].pedidoEstado = 1
							AND prp.preRuteoId = @preRuteoId

				DELETE		ppr 
				FROM		[dbo].[PedidosPreRuteo] ppr
				INNER JOIN	[dbo].[PreRuteosPedidos] prp ON ppr.pedidoId = prp.pedidoId 
															AND ppr.Estado = 1

				UPDATE		[dbo].[PreRuteosDetalle] 
				SET			 preRuteoPedidoEstado = 4 ---validar codigos estado 4 cancelado
							,preRuteoDetalleEstado = 4 ---validar codigos estado 4 cancelado
				WHERE		 preRuteoId = @preRuteoId


				UPDATE		[dbo].[PreRuteos] 
				SET			preRuteoPedidoEstado = 4  ---validar codigos estado 4 cancelado
				WHERE		preRuteoId = @preRuteoId

END




GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CodigoUbicacionByBahiaPadreId]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_GET_CodigoUbicacionByBahiaPadreId] (@bahiaPadreId AS BIGINT, @usuarioId AS BIGINT)
AS
BEGIN

DECLARE @rFIDTagEPC VARCHAR(50)

SELECT TOP 1 @rFIDTagEPC = REPLACE(r.RFIDTagEPC, '00000092', '') FROM [dbo].[Usuarios] u
INNER JOIN [RFIDTag] r ON u.usuarioUser = r.RFIDTagMaquina AND RFIDTagTipo_EPC LIKE 'Ubicacion'
WHERE u.usuarioId = @usuarioId


SELECT u.ubicacionCodigo AS RFIDTagEPC, 
(CASE WHEN (u.ubicacionCodigo IS NULL OR u.ubicacionCodigo LIKE '')  THEN 'No se encuentra ubicación asociada al usuario ' + CONVERT(varchar(10), @usuarioId)
ELSE '' END) AS resultado FROM [dbo].[Ubicaciones] u 
WHERE ubicacionPadreId = @bahiaPadreId AND u.ubicacionCodigo = @rFIDTagEPC 



END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CodigoUbicacionByUsuarioId]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC [dbo].[SP_GET_CodigoUbicacionByUsuarioId]  67
CREATE PROCEDURE  [dbo].[SP_GET_CodigoUbicacionByUsuarioId] (@usuarioId AS BIGINT)
AS
BEGIN

DECLARE @ubicacionCapturadaId BIGINT
DECLARE @usuarioIdentificacion VARCHAR(50)
DECLARE @tipoUbicacion VARCHAR(50)
DECLARE @resultadoUsuario VARCHAR(50)
DECLARE @resultadoUbicacion VARCHAR(50)

DECLARE @ubicacionDescripcion VARCHAR(50)
DECLARE @RFIDTagEPC VARCHAR(100)

SELECT TOP 1 @RFIDTagEPC= REPLACE(r.RFIDTagEPC, '00000092', '') , @usuarioIdentificacion = u.usuarioIdentificacion
FROM [dbo].[Usuarios] u
INNER JOIN RFIDTag r ON u.usuarioUser = r.RFIDTagMaquina AND RFIDTagTipo_EPC LIKE 'Ubicacion'
WHERE u.usuarioId = @usuarioId





SELECT TOP 1 @ubicacionCapturadaId = ubicacionId, @ubicacionDescripcion = ubicacionDescripcion,  @tipoUbicacion = tipoUbicacionId FROM [dbo].[Ubicaciones] WHERE ubicacionCodigo = @RFIDTagEPC


IF @tipoUbicacion = 2 OR @tipoUbicacion = 4
						BEGIN

						

								SELECT  TOP 1 @resultadoUbicacion = 'La bahía ' + @ubicacionDescripcion + ' tiene saldo activo'    FROM [dbo].[SaldosDetalle]  sd
								INNER JOIN [dbo].[Ubicaciones]  u ON sd.ubicacionId =u.ubicacionId AND u.tipoUbicacionId = @tipoUbicacion AND u.ubicacionCodigo LIKE @RFIDTagEPC
								WHERE  sd.saldoDetalleRealManejo > 0 AND sd.saldoDetalleComprometidoManejo > 0
								
						END
ELSE IF @tipoUbicacion = 1 OR @tipoUbicacion = 3
						BEGIN 

						

								SELECT  TOP 1 @resultadoUsuario = 'El usuario tiene saldo activo'      FROM [dbo].[SaldosDetalle]  sd
								INNER JOIN [dbo].[Ubicaciones]  u ON sd.ubicacionId = u.ubicacionId AND u.tipoUbicacionId = @tipoUbicacion AND u.ubicacionCodigo LIKE @usuarioIdentificacion
								WHERE  sd.saldoDetalleRealManejo > 0 AND sd.saldoDetalleComprometidoManejo > 0
								 

						END


ELSE
BEGIN
SET @resultadoUbicacion = ''
SET @resultadoUsuario = ''
END


SELECT @RFIDTagEPC AS RFIDTagEPC, ISNULL(@resultadoUsuario,'') AS resultadoUsuario, ISNULL(@resultadoUbicacion,'') AS resultadoUbicacion 







END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_DespachoArqueo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_GET_DespachoArqueo](@ubicacionPuertaId BIGINT)
AS BEGIN 

SELECT CONVERT(varchar(max), productoId) as number , * FROM Productos
--SELECT * FROM [dbo].[DespachosDetalle]

END

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_despachoDetalle_despachoId]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		

CREATE PROCEDURE  [dbo].[SP_GET_despachoDetalle_despachoId](@ruteoId AS BIGINT)

AS
BEGIN

DECLARE @result INT
	SELECT	@result =	COUNT(*)
				FROM [dbo].[DespachosDetalle] desp
				INNER JOIN [dbo].[Presentaciones] p ON desp.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON desp.ubicacionId = u.ubicacionId				
				LEFT JOIN [dbo].[Ubicaciones] uaux ON desp.ubicacionActualId = uaux.ubicacionId
				WHERE desp.ruteoId = @ruteoId  AND desp.despachoEstado = 0

IF @result > 0
BEGIN
				SELECT		TOP 1		 desp.despachoId
									,desp.despachoDetalleId
									,pro.productoId
									,pro.productoCodigo
									,pro.productoDescripcion
									,p.presentacionId
									,p.presentacionCodigo
									,p.presentacionDescripcion
									,desp.despachoDetalleCantTotal
									,u.ubicacionId
									,u.ubicacionCodigo
									,u.ubicacionDescripcion
									,uaux.ubicacionId
									,uaux.ubicacionCodigo
									,uaux.ubicacionDescripcion	
									,'' AS resultado
				FROM [dbo].[DespachosDetalle] desp
				INNER JOIN [dbo].[Presentaciones] p ON desp.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON desp.ubicacionId = u.ubicacionId				
				LEFT JOIN [dbo].[Ubicaciones] uaux ON desp.ubicacionActualId = uaux.ubicacionId
				WHERE desp.ruteoId = @ruteoId  AND desp.despachoEstado = 0
		END		
ELSE BEGIN

SELECT 'No se encuentra despacho asociado al ruteoId ' + CONVERT(varchar(10), @ruteoId) AS resultado
			END	

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_DespachoDetalleByUbicacion]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		

CREATE PROCEDURE  [dbo].[SP_GET_DespachoDetalleByUbicacion](@ubicacionCodigo AS VARCHAR(50))

AS
BEGIN

DECLARE @result INT
	SELECT	@result =	COUNT(*) FROM [dbo].[DespachosDetalle] desp
				INNER JOIN [dbo].[Presentaciones] p ON desp.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON desp.ubicacionId = u.ubicacionId AND 	 @ubicacionCodigo LIKE  '%' +u.ubicacionCodigo		
				LEFT JOIN [dbo].[Ubicaciones] uaux ON desp.ubicacionActualId = uaux.ubicacionId 
				WHERE desp.despachoEstado = 0

IF @result > 0
BEGIN 
				SELECT		TOP 1	 desp.despachoId
									,desp.despachoDetalleId
									,pro.productoId
									,pro.productoCodigo
									,pro.productoDescripcion
									,p.presentacionId
									,p.presentacionCodigo
									,p.presentacionDescripcion
									,desp.despachoDetalleCantTotal
									,u.ubicacionId
									,u.ubicacionCodigo
									,u.ubicacionDescripcion
									,uaux.ubicacionId as ubicacionIdActual
									,uaux.ubicacionCodigo as ubicacionCodigoActual
									,uaux.ubicacionDescripcion		 as ubicacionDescripcionActual	
									,'' as resultado
				FROM [dbo].[DespachosDetalle] desp
				INNER JOIN [dbo].[Presentaciones] p ON desp.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON desp.ubicacionId = u.ubicacionId AND 	 @ubicacionCodigo LIKE  '%' +u.ubicacionCodigo		
				LEFT JOIN [dbo].[Ubicaciones] uaux ON desp.ubicacionActualId = uaux.ubicacionId 
				WHERE desp.despachoEstado = 0
			END		
ELSE BEGIN

SELECT 'No se encuentra despacho asociado a la ubicación capturada' AS resultado
			END	

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_DespachoDetalleUbicacionDestino]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		

CREATE PROCEDURE  [dbo].[SP_GET_DespachoDetalleUbicacionDestino](@despachoDetalleId AS BIGINT)

AS
BEGIN
DECLARE @result INT
	SELECT	@result =	COUNT(*) 
				FROM [dbo].[DespachosDetalle] desp
				INNER JOIN [dbo].[Presentaciones] p ON desp.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON desp.ubicacionId = u.ubicacionId 			 
				INNER JOIN [dbo].[Ubicaciones] ubahia ON u.ubicacionPadreId = ubahia.ubicacionId
				INNER JOIN [dbo].[Ubicaciones] upuerta ON ubahia.ubicacionPadreId = upuerta.ubicacionId
				WHERE desp.despachoDetalleId = @despachoDetalleId

IF @result > 0
BEGIN 
				
				SELECT		TOP 1	 desp.despachoId
									,desp.despachoDetalleId
									,pro.productoId
									,pro.productoCodigo
									,pro.productoDescripcion
									,p.presentacionId
									,p.presentacionCodigo
									,p.presentacionDescripcion
									,desp.despachoDetalleCantTotal									
									,upuerta.ubicacionId 
									,upuerta.ubicacionCodigo
									,upuerta.ubicacionDescripcion 
									,u.ubicacionId AS ubicacionActualId
									,u.ubicacionCodigo AS ubicacionActualId
									,u.ubicacionDescripcion AS ubicacionActualId
									,'' as resultado
				FROM [dbo].[DespachosDetalle] desp
				INNER JOIN [dbo].[Presentaciones] p ON desp.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON desp.ubicacionId = u.ubicacionId 			 
				INNER JOIN [dbo].[Ubicaciones] ubahia ON u.ubicacionPadreId = ubahia.ubicacionId
				INNER JOIN [dbo].[Ubicaciones] upuerta ON ubahia.ubicacionPadreId = upuerta.ubicacionId
				WHERE desp.despachoDetalleId = @despachoDetalleId
	END			
ELSE 
BEGIN

SELECT 'No se encuentra despacho asociado al despachoDetalleId ' + CONVERT(varchar(10), @despachoDetalleId) AS resultado
			END	

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_packingDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		

CREATE PROCEDURE  [dbo].[SP_GET_packingDetalle](@packingId BIGINT, @packingDetalleId BIGINT)

AS
BEGIN
DECLARE @result INT
	SELECT	@result =	COUNT(*) 
				FROM [dbo].[PackingDetalle] pac
				INNER JOIN [dbo].[Presentaciones] p ON pac.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON pac.ubicacionMedioId = u.ubicacionId
				INNER JOIN [dbo].[RuteosPedidos] rp ON pac.pedidoId = rp.pedidoId
				INNER JOIN [dbo].[Ubicaciones] ubahia ON rp.bahiaId = ubahia.ubicacionId
				WHERE pac.packingId = @packingId AND pac.packingDetalleId = @packingDetalleId

IF @result > 0
BEGIN 
		
				SELECT		TOP 1		 pac.packingId
									,pac.packingDetalleId
									,pro.productoId
									,pro.productoCodigo
									,pro.productoDescripcion
									,p.presentacionId
									,p.presentacionCodigo
									,p.presentacionDescripcion
									,pac.packingDetalleCantTotal
									,u.ubicacionId
									,u.ubicacionCodigo
									,u.ubicacionDescripcion
									,ubahia.ubicacionId AS  bahiaId
									,ubahia.ubicacionCodigo AS  bahiaCodigo
									,ubahia.ubicacionDescripcion  AS  bahiaDescripcion	
									,'' as resultado
				FROM [dbo].[PackingDetalle] pac
				INNER JOIN [dbo].[Presentaciones] p ON pac.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON pac.ubicacionMedioId = u.ubicacionId
				INNER JOIN [dbo].[RuteosPedidos] rp ON pac.pedidoId = rp.pedidoId
				INNER JOIN [dbo].[Ubicaciones] ubahia ON rp.bahiaId = ubahia.ubicacionId
				WHERE pac.packingId = @packingId AND pac.packingDetalleId = @packingDetalleId

	END			
ELSE 
BEGIN

SELECT 'No se encuentra packing asociado al pakingDetalleId ' + CONVERT(varchar(10), @packingDetalleId) AS resultado
			END	

END

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_packingDetalle_PackingId]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		

CREATE PROCEDURE  [dbo].[SP_GET_packingDetalle_PackingId](@packingId BIGINT, @packingDetalleId BIGINT)

AS
BEGIN
DECLARE @result INT
	SELECT	@result =	COUNT(*) 
				FROM [dbo].[PackingDetalle] pac
				INNER JOIN [dbo].[Presentaciones] p ON pac.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON pac.ubicacionMedioId = u.ubicacionId
				INNER JOIN [dbo].[RuteosPedidos] rp ON pac.pedidoId = rp.pedidoId
				INNER JOIN [dbo].[Ubicaciones] ubahia ON rp.bahiaId = ubahia.ubicacionId
				WHERE pac.packingId = @packingId AND pac.packingDetalleId = @packingDetalleId

IF @result > 0
BEGIN 
				SELECT		TOP 1		 pac.packingId
									,pac.packingDetalleId
									,pro.productoId
									,pro.productoCodigo
									,pro.productoDescripcion
									,p.presentacionId
									,p.presentacionCodigo
									,p.presentacionDescripcion
									,pac.packingDetalleCantTotal
									,u.ubicacionId
									,u.ubicacionCodigo
									,u.ubicacionDescripcion
									,ubahia.ubicacionId
									,ubahia.ubicacionCodigo
									,ubahia.ubicacionDescripcion	
									,'' as resultado
				FROM [dbo].[PackingDetalle] pac
				INNER JOIN [dbo].[Presentaciones] p ON pac.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON pac.ubicacionMedioId = u.ubicacionId
				INNER JOIN [dbo].[RuteosPedidos] rp ON pac.pedidoId = rp.pedidoId
				INNER JOIN [dbo].[Ubicaciones] ubahia ON rp.bahiaId = ubahia.ubicacionId
				WHERE pac.packingId = @packingId AND pac.packingDetalleId = @packingDetalleId

	END			
ELSE 
BEGIN

SELECT 'No se encuentra packing asociado al pakingDetalleId ' + CONVERT(varchar(10), @packingDetalleId) AS resultado
			END	

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_packingDetalle_ubicacionCodigo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		--EXEC [dbo].[SP_GET_packingDetalle_ubicacionCodigo] 67

CREATE PROCEDURE  [dbo].[SP_GET_packingDetalle_ubicacionCodigo](@usuarioId BIGINT)

AS
BEGIN


DECLARE @packingId BIGINT
DECLARE @packingDetalleId BIGINT
DECLARE @ubicacionId BIGINT
DECLARE @ubicacionCodigo VARCHAR(100)
DECLARE @ruteoId BIGINT
DECLARE @ruteoDetalleId BIGINT
DECLARE @totalRow VARCHAR(20)

IF @usuarioId IS NULL 
		BEGIN 
				SELECT   @packingId AS packingId
						,@packingDetalleId AS packingDetalleId
						,@ubicacionId  AS ubicacionId
						,@ubicacionCodigo AS ubicacionCodigo
						,@ruteoId  AS ruteoId
						,@ruteoDetalleId  AS ruteoDetalleId
						,'No existe el usuario ' + CONVERT(VARCHAR(20),@usuarioId) AS resultado
				RETURN
		END

		SELECT TOP(1)	@ubicacionId = ub.ubicacionId, @ubicacionCodigo = ub.ubicacionCodigo FROM [dbo].[Usuarios] u 
						INNER JOIN [dbo].[Ubicaciones] ub ON u.usuarioIdentificacion = ub.ubicacionCodigo
						WHERE u.usuarioId = @usuarioId

IF  @ubicacionCodigo IS NULL OR @ubicacionCodigo LIKE ''
		BEGIN 

		

				SELECT   @packingId AS packingId
						,@packingDetalleId AS packingDetalleId
						,@ubicacionId  AS ubicacionId
						,@ubicacionCodigo AS ubicacionCodigo
						,@ruteoId  AS ruteoId
						,@ruteoDetalleId  AS ruteoDetalleId
						,'No existe ubicación código para el usuario '  + CONVERT(VARCHAR(20),@usuarioId) AS resultado
				RETURN
		END
ELSE

		BEGIN	
				SELECT		TOP 1	 
									 @packingId = pac.packingId 
									,@packingDetalleId = pac.packingDetalleId
									,@ruteoId = pac.ruteoId
									,@ruteoDetalleId = pac.ruteoDetalleId
									,@totalRow = CONVERT(VARCHAR(20), ROW_NUMBER() OVER(ORDER BY pac.packingId ASC)) 																		
				FROM [dbo].[PackingDetalle] pac				
				WHERE pac.ubicacionMedioId = @ubicacionId AND pac.packingEstado = 0


				SELECT   @packingId AS packingId
						,@packingDetalleId AS packingDetalleId
						,@ubicacionId  AS ubicacionId
						,@ubicacionCodigo AS ubicacionCodigo
						,@ruteoId  AS ruteoId
						,@ruteoDetalleId  AS ruteoDetalleId
						,ISNULL(@totalRow,'')  AS resultado --Si es 0 no tiene asigando packing saldo continua a bandeja picking 

		END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_PedidoDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE   [dbo].[SP_GET_PedidoDetalle](@pedidoId BIGINT)

AS
BEGIN

DECLARE @result INT
	SELECT	@result =	COUNT(*) 
				FROM [dbo].[PedidosDetalle] p
INNER JOIN [dbo].[Presentaciones] pres ON p.presentacionId = pres.presentacionId
INNER JOIN [dbo].[Productos] prod ON p.productoId = prod.productoId
INNER JOIN [dbo].[PuntosEnvio] pto ON  p.puntoEnvioId = pto.puntoEnvioId
INNER JOIN [dbo].[Ciudades] ciu ON  pto.ciudadId = ciu.ciudadId
INNER JOIN [dbo].[Estados] est ON  ciu.estadoId = est.estadoId
WHERE p.pedidoId = @pedidoId
IF @result > 0
BEGIN 
SELECT			 p.pedidoId
				,p.pedidoDetalleId
				,p.pedidoDetalleVersion
				,p.productoTipoId
				,(	CASE	WHEN p.productoTipoId = 0 THEN 'NORMAL' 
							WHEN p.productoTipoId = 1 THEN 'COMBO'
							WHEN p.productoTipoId = 2 THEN 'KIT'
							ELSE '' 
					END	) AS productoTipoDescripcion
				,prod.productoId
				,prod.productoDescripcion
				,pres.presentacionId
				,pres.presentacionDescripcion
				,p.pedidoDetalleCantidad
				,pto.puntoEnvioId
				,pto.puntoEnvioCodigo
				,pto.puntoEnvioNombre
				,pto.puntoEnvioDireccion
				,pto.puntoEnvioTelefono
				,est.estadoId
				,est.estadoNombre
				,ciu.ciudadId
				,ciu.ciudadNombre 
				,'' AS resultado
FROM [dbo].[PedidosDetalle] p
INNER JOIN [dbo].[Presentaciones] pres ON p.presentacionId = pres.presentacionId
INNER JOIN [dbo].[Productos] prod ON p.productoId = prod.productoId
INNER JOIN [dbo].[PuntosEnvio] pto ON  p.puntoEnvioId = pto.puntoEnvioId
INNER JOIN [dbo].[Ciudades] ciu ON  pto.ciudadId = ciu.ciudadId
INNER JOIN [dbo].[Estados] est ON  ciu.estadoId = est.estadoId
WHERE p.pedidoId = @pedidoId
	
	END			
ELSE 
BEGIN

SELECT 'No se encuentra detalle asociado al pedidoId ' + CONVERT(varchar(10), @pedidoId) AS resultado
			END	

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_Pedidos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE   [dbo].[SP_GET_Pedidos]

AS
BEGIN
SET DATEFORMAT DMY
SELECT				[pedidoId]
				  ,[sucursalId]
				  ,[pedidoConsecutivo]
				 ,CONVERT(VARCHAR(10),[pedidoFecha], 103) AS [pedidoFecha]
				  ,CONVERT(VARCHAR(10),[pedidoFechaEntrega], 103)  AS [pedidoFechaEntrega]
				  ,CONVERT(VARCHAR(10),[pedidoFechaCarga], 103)  AS [pedidoFechaCarga]
				  ,CONVERT(VARCHAR(10),[pedidoFechaMalla], 103)  AS [pedidoFechaMalla]
				  ,[pedidoObservacion]
				  ,[pedidoDocumentoERP]
				  ,[pedidoConsecutivoERP]
				  ,[pedidoVersion]
				  ,[pedidoEstado]
				  ,[pedidoFuente]
				  ,[puntoOperacionId] 
FROM [dbo].[Pedidos] p


WHERE p.pedidoEstado = 0  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_PreruteoDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_GET_PreruteoDetalle] (@preRuteoId AS BIGINT)
AS
BEGIN

DECLARE @documentoId BIGINT = 0



IF OBJECT_ID('tempdb..#RutasUbicaciones')	IS NOT NULL DROP TABLE #RutasUbicaciones

		CREATE TABLE #RutasUbicaciones (
											 rutaUbicacionId					BIGINT
											,rutaId								BIGINT 		
											,ubicacionId						BIGINT
											,rutaUbicacionOrden					INT
											,ubicacionCodigo					VARCHAR(100)
											,ubicacionDescripcion				VARCHAR(50)
									)


				/******								FIN									******/					
				
				
SELECT				TOP 1 @documentoId	=  d.documentoId 
						FROM				[dbo].[Documentos] AS d
						WHERE				d.documentoCodigo='RUT'



				INSERT INTO #RutasUbicaciones (rutaUbicacionId, rutaId, ubicacionId, rutaUbicacionOrden, ubicacionCodigo, ubicacionDescripcion)
				SELECT ru.rutaUbicacionId,ru.rutaId,ru.UbicacionId,ru.rutaUbicacionOrden, u.ubicacionCodigo, u.ubicacionDescripcion FROM [dbo].[RutasUbicaciones] ru
				INNER JOIN     Ubicaciones u on ru.ubicacionId = u.ubicacionId AND u.ubicacionDescripcion LIKE 'GENERAL'
				
				ORDER BY ru.rutaUbicacionOrden

				DECLARE @result INT
	SELECT	@result =	COUNT(*) 
				FROM			 [dbo].[PreRuteos] pr
								INNER JOIN		 [dbo].[PreRuteosDetalle] prd ON pr.preRuteoId = prd.preRuteoId
								INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId =	p.presentacionId
								INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 #RutasUbicaciones u 	ON prd.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId AND vpl.atributoLoteId = 2  	
								WHERE prd.preRuteoId = @preRuteoId AND prd.preRuteoDetalleEstado = 0 AND pr.preRuteoPedidoEstado = 0
								

IF @result > 0
BEGIN 


SELECT			 pr.[preRuteoId]
												,pr.[preRuteoFecha]
												,pr.[preRuteoUsuario]
												,pr.[preRuteoConsecutivo]	
												,prd.[preRuteoDetalleId]
												,prd.[novedadId]
												,n.novedadDescripcion
												,prd.[presentacionId]
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,prd.[bodegaLogicaId]
												,bl.bodegaLogicaDescripcion
												--,prd.[ubicacionId]
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,prd.[preRuteoDetalleCantidad]
												,prd.[preRuteoDetalleCantNovedad]
												,prd.[preRuteoDetalleCantRequerida]												
												,prd.[contenedorId]
												,vpl.valorPlantillaLoteValor
												, '' AS resultado
								FROM			 [dbo].[PreRuteos] pr
								INNER JOIN		 [dbo].[PreRuteosDetalle] prd ON pr.preRuteoId = prd.preRuteoId
								INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId =	p.presentacionId
								INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 #RutasUbicaciones u 	ON prd.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId AND vpl.atributoLoteId = 2  	
								WHERE prd.preRuteoId = @preRuteoId AND prd.preRuteoDetalleEstado = 0 AND pr.preRuteoPedidoEstado = 0
								ORDER BY u.rutaUbicacionOrden
	END			
ELSE 
BEGIN

SELECT 'No se encuentra pre ruteo asociado al preruteoId ' + CONVERT(varchar(10), @preRuteoId) AS resultado
			END	

END			
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_Preruteos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE  [dbo].[SP_GET_Preruteos]

AS
BEGIN
SET DATEFORMAT DMY
SELECT		
       [preRuteoId] 
	  ,CONVERT(VARCHAR(10),[preRuteoFecha], 103) AS [preRuteoFecha]
      ,[preRuteoUsuario]
      ,[preRuteoConsecutivo]
      ,[documentoId]
      ,[preRuteoPedidoEstado]

 FROM [dbo].[Preruteos] p


WHERE p.preRuteoPedidoEstado = 0
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_RutasRuteoxGrupoId]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_GET_RutasRuteoxGrupoId] (@preRuteoId BIGINT, @grupoId BIGINT)

AS
BEGIN

								SELECT ru.rutaId, rg.grupoId, 0
								
														FROM RuteosDetalle rd
														 INNER JOIN RutasUbicaciones ru ON rd.ubicacionId = ru.ubicacionId 
														 INNER JOIN DocumentosRutas dr ON ru.rutaId = dr.rutaId
														 INNER JOIN Documentos d ON dr.documentoId = d.documentoId AND documentoCodigo LIKE  'RUT'
														 INNER JOIN RutasGrupos rg ON ru.rutaId = rg.rutaId
														WHERE  rd.ruteoId = @preRuteoId AND  rg.grupoId = @grupoId

								GROUP BY ru.rutaId, rg.grupoId
								HAVING COUNT(rd.ruteoDetalleId) > 0


								END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_RuteoDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_GET_RuteoDetalle] (@ruteoId AS BIGINT, @ruteoDetalleId AS BIGINT)
AS
BEGIN


IF( @ruteoDetalleId = 0)
BEGIN
SELECT											 pr.[ruteoId]
												,pr.[ruteoFecha]
												,pr.[ruteoUsuario]
												,pr.[ruteoConsecutivo]
												,pr.ruteoPedidoEstado
												,prd.[ruteoDetalleId]
												,prd.[novedadId]
												,n.novedadDescripcion
												,prd.[presentacionId]
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,prd.[bodegaLogicaId]
												,bl.bodegaLogicaDescripcion
												,prd.[ubicacionId]
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,prd.[ruteoDetalleCantidad]
												,prd.[ruteoDetalleCantNovedad]
												,prd.[ruteoDetalleCantRequerida]												
												,prd.[contenedorId]
												,vpl.valorPlantillaLoteValor	
								FROM			 [dbo].[ruteos] pr								
								
								INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = pr.ruteoId AND prd.ruteoDetalleCantidad > 0 
								INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId =	p.presentacionId
								INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON prd.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId	
								WHERE pr.ruteoId = @ruteoId 
									END		
ELSE 
BEGIN
		SELECT			 pr.[ruteoId]
												,pr.[ruteoFecha]
												,pr.[ruteoUsuario]
												,pr.[ruteoConsecutivo]
												,pr.ruteoPedidoEstado
												,prd.[ruteoDetalleId]
												,prd.[novedadId]
												,n.novedadDescripcion
												,prd.[presentacionId]
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,prd.[bodegaLogicaId]
												,bl.bodegaLogicaDescripcion
												--,prd.[ubicacionId]
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,prd.[ruteoDetalleCantidad]
												,prd.[ruteoDetalleCantNovedad]
												,prd.[ruteoDetalleCantRequerida]												
												,prd.[contenedorId]
												,vpl.valorPlantillaLoteValor	
								FROM			 [dbo].[ruteos] pr
								INNER JOIN		 [dbo].[ruteosPedidos] rp ON pr.ruteoId = rp.ruteoId
								INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = prd.ruteoId
								INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId =	p.presentacionId
								INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON prd.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId	
								WHERE prd.ruteoId = @ruteoId AND prd.[ruteoDetalleId] = @ruteoDetalleId
			END		
		
		END					
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_RuteoDetalle_ProductoId_BahiaId]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		--EXEC  [dbo].[SP_GET_RuteoDetalle_ProductoId_BahiaId] 0,0,1
			
	CREATE PROCEDURE  [dbo].[SP_GET_RuteoDetalle_ProductoId_BahiaId]
	(
	         @bahiaId AS BIGINT 
			,@productoId AS BIGINT 	
			,@ruteoId AS BIGINT
	
	
	)
	AS

	BEGIN

	SET NOCOUNT ON
						
					
						DECLARE @pedidoId BIGINT
						DECLARE @pedidoDetalleId BIGINT
						DECLARE @puntoEnvioId BIGINT
						DECLARE @ruteoFecha DATETIME
						DECLARE @ruteoUsuario BIGINT
						DECLARE @ruteoConsecutivo INT
						DECLARE @ruteoPedidoEstado TINYINT
						DECLARE @productoTipoId BIGINT
						DECLARE @presentacionId BIGINT
						DECLARE @pedidoDetalleCantidad  DECIMAL(18,3)
						DECLARE @pedidoDetalleFecha DATETIME
						DECLARE @pedidoDetalleVersion  SMALLINT
						DECLARE @ruteoIdAUX BIGINT
						DECLARE @productoIdAUX BIGINT
						DECLARE @bahiaIdAUX BIGINT
						DECLARE @pedidoOrden INT
						DECLARE @pedidoProcesado BIT
						DECLARE @Caducidad INT
						DECLARE @FechaCaducidad	 DATE
						IF OBJECT_ID('tempdb..#RuteoPedidosDetalleTemp') IS NOT NULL DROP TABLE #RuteoPedidosDetalleTemp		
						IF OBJECT_ID('tempdb..#RuteosDetalleTemp') IS NOT NULL DROP TABLE #RuteosDetalleTemp
						IF OBJECT_ID('tempdb..#AsignacionRuteoDetallePedidoTemp') IS NOT NULL DROP TABLE #AsignacionRuteoDetallePedidoTemp
						IF OBJECT_ID('tempdb..#packingProcesadoTemp')  IS NOT NULL DROP TABLE #packingProcesadoTemp



								CREATE TABLE #RuteoPedidosDetalleTemp (
													 pedidoId BIGINT
													,pedidoDetalleId BIGINT
													,puntoEnvioId BIGINT
													,productoId BIGINT
													,productoTipoId BIGINT
													,presentacionId BIGINT
													,pedidoDetalleCantidad DECIMAL(18,3)
													,pedidoDetalleFecha DATETIME
													,pedidoDetalleVersion SMALLINT
													,ruteoId BIGINT
													,bahiaId BIGINT
													,pedidoOrden INT
													,pedidoProcesado BIT
													,Caducidad INT
													,FechaCaducidad DATE
													)
							CREATE TABLE #RuteosDetalleTemp(
												id INT PRIMARY KEY IDENTITY(1,1),
												ruteoId BIGINT,
												ruteoDetalleId BIGINT,
												novedadId BIGINT,
												ruteoPedidoEstado TINYINT,
												presentacionId BIGINT,
												bodegaLogicaId BIGINT,
												ubicacionId BIGINT,
												ruteoDetalleCantidad DECIMAL(18, 4),
												ruteoDetalleCantNovedad DECIMAL(18, 4),
												ruteoDetalleCantRequerida DECIMAL(18, 4),
												ruteoDetalleEstado TINYINT DEFAULT 0,
												contenedorId BIGINT,
												valorProductoLoteId BIGINT,
												fechaVencimiento DATE,
												grupoId BIGINT,
												rutaUbicacionOrden INT
												)
												CREATE NONCLUSTERED INDEX ix_RuteosDetalle ON #RuteosDetalleTemp (id);
							
							
							CREATE TABLE #packingProcesadoTemp			(
													   ruteoId BIGINT
													  ,ruteoDetalleId BIGINT												 
													  ,pedidoId BIGINT
													  ,presentacionId  BIGINT
													  ,pedidoDetalleId BIGINT
													  ,packingDetalleCantTotal DECIMAL(18, 4) 
													  ,packingDetalleCantSolicitada DECIMAL(18, 4)
													  ,packingDetalleCantPreparada DECIMAL(18, 4)
													  ,packingDetalleCantNovedad DECIMAL(18, 4)													  
													   )

						
						CREATE TABLE #AsignacionRuteoDetallePedidoTemp(
												id BIGINT IDENTITY(1,1) PRIMARY KEY,
												ruteoId BIGINT,
												ruteoFecha DATETIME,
												ruteoUsuario BIGINT ,
												ruteoConsecutivo BIGINT,
												ruteoPedidoEstado TINYINT,											
												novedadId BIGINT,
												bodegaLogicaId BIGINT,
												ubicacionId BIGINT,						
												contenedorId BIGINT,
												pedidoId BIGINT,
												bahiaId BIGINT,
												ordenRuteo INT,
												ruteoDetalleId BIGINT,
												productoId BIGINT,
												presentacionId BIGINT,
												ruteoDetalleCantidad DECIMAL(18, 4),
												ruteoDetallePesoTotal DECIMAL(18, 4),
												ruteoDetalleCantRequerida DECIMAL(18, 4),
												ruteoDetalleCantNovedad DECIMAL(18, 4),
												valorProductoLoteId BIGINT,
												rutaUbicacionOrden INT
												)
SELECT  @ruteoFecha  = ruteoFecha,
						 @ruteoUsuario  = ruteoUsuario,
						 @ruteoConsecutivo  = ruteoConsecutivo,
						 @ruteoPedidoEstado  = ruteoPedidoEstado
						 FROM [dbo].[Ruteos] WHERE ruteoId = @ruteoId



						;WITH RuteoPedidosAux (ruteoId, pedidoId,bahiaId, pedidoOrden, pedidoProcesado)

						AS 
						(
						SELECT ruteoId, pedidoId,bahiaId, ISNULL(pedidoOrden,0 +ROW_NUMBER() OVER(ORDER BY pedidoId ASC)), pedidoProcesado 
						FROM [dbo].[RuteosPedidos] WHERE ruteoId = @ruteoId
						), RuteoPedidosDetalleAux (
										 pedidoId
										,pedidoDetalleId
										,puntoEnvioId
										,productoId
										,productoTipoId
										,presentacionId
										,pedidoDetalleCantidad
										,pedidoDetalleFecha
										,pedidoDetalleVersion
										,ruteoId
										,bahiaId
										,pedidoOrden
										,pedidoProcesado
										,Caducidad
						)

						AS 
						(
						SELECT  
										 pd.pedidoId
										,pd.pedidoDetalleId
										,pd.puntoEnvioId
										,pd.productoId
										,pd.productoTipoId
										,pd.presentacionId
										,pd.pedidoDetalleCantidad
										,pd.pedidoDetalleFecha
										,pd.pedidoDetalleVersion
										,rp.ruteoId
										,rp.bahiaId
										,rp.pedidoOrden
										,rp.pedidoProcesado
										,rc.Caducidad
						FROM [dbo].[PedidosDetalle] pd 
						INNER JOIN RuteoPedidosAux rp ON pd.pedidoId = rp.pedidoId
						INNER JOIN [dbo].[ReglaCaducidad] rc ON pd.puntoEnvioId = rc.puntoEnvioId AND pd.productoId = rc.productoId
						
						)
						INSERT INTO #RuteoPedidosDetalleTemp (
																 pedidoId
																,pedidoDetalleId
																,puntoEnvioId
																,productoId
																,productoTipoId
																,presentacionId
																,pedidoDetalleCantidad
																,pedidoDetalleFecha
																,pedidoDetalleVersion
																,ruteoId
																,bahiaId
																,pedidoOrden
																,pedidoProcesado
																,Caducidad
																,FechaCaducidad

						) 


						SELECT 
										 pedidoId
										,pedidoDetalleId
										,puntoEnvioId
										,productoId
										,productoTipoId
										,presentacionId
										,pedidoDetalleCantidad
										,pedidoDetalleFecha
										,pedidoDetalleVersion
										,ruteoId
										,bahiaId
										,pedidoOrden
										,pedidoProcesado
										,Caducidad
										,DATEADD(DAY,Caducidad,GETDATE())
						FROM RuteoPedidosDetalleAux 


						--SELECT * FROM #RuteoPedidosDetalleTemp
						

						;WITH RuteoDetalleAUX (
												ruteoId,
												ruteoDetalleId,
												novedadId,
												ruteoPedidoEstado,
												presentacionId,
												bodegaLogicaId,
												ubicacionId,
												ruteoDetalleCantidad,
												ruteoDetalleCantNovedad,
												ruteoDetalleCantRequerida,
												ruteoDetalleEstado,
												contenedorId,
												valorProductoLoteId, 
												grupoId,
												rutaUbicacionOrden
						
						
						
						) AS (
						SELECT					ruteoId,
												ruteoDetalleId,
												novedadId,
												ruteoPedidoEstado,
												presentacionId,
												bodegaLogicaId,
												rd.ubicacionId,
												ruteoDetalleCantidad,
												ruteoDetalleCantNovedad,
												ruteoDetalleCantRequerida,
												ruteoDetalleEstado,
												contenedorId,
												valorProductoLoteId, 
												grupoId,
												ru.rutaUbicacionOrden
												FROM [dbo].[RuteosDetalle] rd
												INNER JOIN [dbo].[RutasUbicaciones] ru ON rd.ubicacionId = ru.ubicacionId
												WHERE ruteoId = @ruteoId AND rd.ubicacionId IS NOT NULL AND rd.ruteoDetalleEstado = 0
												AND ruteoDetalleCantidad > 0 AND ruteoDetalleEstado = 0

								)

								INSERT INTO #RuteosDetalleTemp (
												ruteoId,
												ruteoDetalleId,
												novedadId,
												ruteoPedidoEstado,
												presentacionId,
												bodegaLogicaId,
												ubicacionId,
												ruteoDetalleCantidad,
												ruteoDetalleCantNovedad,
												ruteoDetalleCantRequerida,
												ruteoDetalleEstado,
												contenedorId,
												valorProductoLoteId,
												fechaVencimiento,
												grupoId,
												rutaUbicacionOrden
												)
								SELECT			rd.ruteoId,
												rd.ruteoDetalleId,
												rd.novedadId,
												rd.ruteoPedidoEstado,
												rd.presentacionId,
												rd.bodegaLogicaId,
												rd.ubicacionId,
												rd.ruteoDetalleCantidad,
												rd.ruteoDetalleCantNovedad,
												rd.ruteoDetalleCantRequerida,
												rd.ruteoDetalleEstado,
												rd.contenedorId,
												rd.valorProductoLoteId, 
												TRY_CONVERT(DATE,vpl.valorPlantillaLoteValor),
												rd.grupoId,
												rutaUbicacionOrden
									FROM RuteoDetalleAUX rd
									LEFT JOIN [dbo].[ValoresPlantillasLotes] vpl ON rd.valorProductoLoteId = vpl.valorProductoLoteId AND vpl.atributoLoteId = 2

									--SELECT * FROM #RuteosDetalleTemp
									--RETURN
					;WITH packingProcesadoAUX			(
													   ruteoId
													  ,ruteoDetalleId													 
													  ,pedidoId
													  ,pedidoDetalleId
													  ,presentacionId
													  ,packingDetalleCantTotal
													  ,packingDetalleCantSolicitada
													  ,packingDetalleCantPreparada
													  ,packingDetalleCantNovedad													  
													  
													  
													  )
													  AS (
									SELECT			   
													   ruteoId
													  ,ruteoDetalleId													 
													  ,pedidoId
													  ,pedidoDetalleId
													  ,presentacionId
													  ,packingDetalleCantTotal
													  ,packingDetalleCantSolicitada
													  ,packingDetalleCantPreparada
													  ,packingDetalleCantNovedad
													  
													  
												  FROM [dbo].[PackingDetalle]
												  WHERE ruteoId = @ruteoId
												  )

												  INSERT INTO #packingProcesadoTemp (
																   ruteoId
																  ,ruteoDetalleId													 
																  ,pedidoId
																  ,pedidoDetalleId
																  ,presentacionId
																  ,packingDetalleCantTotal
																  ,packingDetalleCantSolicitada
																  ,packingDetalleCantPreparada
																  ,packingDetalleCantNovedad
																) 

											SELECT	  
													   ruteoId
													  ,ruteoDetalleId													 
													  ,pedidoId
													  ,pedidoDetalleId
													  ,presentacionId
													  ,packingDetalleCantTotal
													  ,packingDetalleCantSolicitada
													  ,packingDetalleCantPreparada
													  ,packingDetalleCantNovedad
											FROM packingProcesadoAUX
											

											

	DECLARE							RuteoPedidosTempInfo			
					CURSOR FOR 
									SELECT						 pedidoId
																,pedidoDetalleId																
																,productoId
																,productoTipoId
																,presentacionId
																,pedidoDetalleCantidad																
																,ruteoId
																,bahiaId
																,pedidoOrden
																,pedidoProcesado
																,Caducidad
																,FechaCaducidad
									FROM		 #RuteoPedidosDetalleTemp
									
												ORDER BY pedidoOrden ASC
					OPEN						RuteoPedidosTempInfo
									FETCH NEXT 
									FROM		 RuteoPedidosTempInfo 
									INTO		 @pedidoId
												,@pedidoDetalleId												
												,@productoIdAUX
												,@productoTipoId
												,@presentacionId
												,@pedidoDetalleCantidad												
												,@ruteoIdAUX
												,@bahiaIdAUX
												,@pedidoOrden
												,@pedidoProcesado
												,@Caducidad
												,@FechaCaducidad					
					
									WHILE	@@fetch_status = 0
										BEGIN					
										DECLARE @cantidadAsignadaPedidoRuteo DECIMAL(18,3) = 0
									
										SELECT			@cantidadAsignadaPedidoRuteo = SUM(packingDetalleCantTotal)														
														
										FROM			#packingProcesadoTemp										
										WHERE			presentacionId = @presentacionId 
														AND pedidoId = @pedidoId
										GROUP BY		presentacionId, pedidoId

									--SELECT 	@cantidadAsignadaPedidoRuteo, @presentacionId, @pedidoId
									WHILE @cantidadAsignadaPedidoRuteo < @pedidoDetalleCantidad
										BEGIN
										DECLARE @cantidadAsignadaAux DECIMAL(18,3) = 0
										DECLARE @cantidadRequeridaAux DECIMAL(18,3) = 0
										DECLARE @cantidadNovedadAux DECIMAL(18,3) = 0
										DECLARE @pesoAux DECIMAL(18,3) = 0
										DECLARE @ruteoDetalleIdAux BIGINT
										DECLARE @ruteoDetalleIdAsignadaAux BIGINT = 0
										DECLARE @valorProductoLoteIdAux BIGINT
										DECLARE @id INT = 0
										DECLARE @cantidadFaltante DECIMAL(18,3) = 0
										DECLARE @novedadId BIGINT
										DECLARE @bodegaLogicaId BIGINT
										DECLARE @ubicacionId BIGINT
										DECLARE @contenedorId BIGINT
										DECLARE @rutaUbicacionOrden INT
										--SELECT  rd.ruteoDetalleId,ar.ruteoDetalleId FROM #AsignacionRuteoDetallePedidoTemp ar 
										--RIGHT JOIN #RuteosDetalleTemp rd ON ar.ruteoDetalleId <> rd.ruteoDetalleId							
										--WHERE 	ar.pedidoId = @pedidoId	

											
									
										
										
										SELECT TOP 1	@cantidadAsignadaAux = rd.ruteoDetalleCantidad,
														@cantidadRequeridaAux = rd.ruteoDetalleCantRequerida,
														@cantidadNovedadAux = rd.ruteoDetalleCantNovedad,
														@ruteoDetalleIdAux = rd.ruteoDetalleId,
														@valorProductoLoteIdAux = rd.valorProductoLoteId,
														@novedadId = novedadId,
														@bodegaLogicaId = bodegaLogicaId,
														@ubicacionId = ubicacionId,
														@contenedorId = contenedorId,														 
														@id = id,
														@rutaUbicacionOrden = rutaUbicacionOrden
										FROM			#RuteosDetalleTemp rd
										
										WHERE			presentacionId = @presentacionId 
														AND fechaVencimiento >= @FechaCaducidad
														AND ruteoDetalleEstado = 0
														


										IF (@cantidadAsignadaAux + @cantidadAsignadaPedidoRuteo) > @pedidoDetalleCantidad
										BEGIN
										
										SET @cantidadFaltante  = @pedidoDetalleCantidad - @cantidadAsignadaPedidoRuteo
										
										SET @cantidadAsignadaAux = 0

										SELECT TOP 1	@cantidadAsignadaAux = MIN(ruteoDetalleCantRequerida), 
														@cantidadRequeridaAux = ruteoDetalleCantRequerida,
														@cantidadNovedadAux = ruteoDetalleCantNovedad,
														@ruteoDetalleIdAux = ruteoDetalleId,
														@valorProductoLoteIdAux = valorProductoLoteId,
														@novedadId = novedadId,
														@bodegaLogicaId = bodegaLogicaId,
														@ubicacionId = ubicacionId,
														@contenedorId = contenedorId,
														@id = id,
														@rutaUbicacionOrden = rutaUbicacionOrden
										FROM			#RuteosDetalleTemp

										WHERE			presentacionId = @presentacionId 
														AND fechaVencimiento >= @FechaCaducidad 
														AND ruteoDetalleCantidad >=  @cantidadFaltante
														AND ruteoDetalleEstado = 0
														GROUP BY ruteoDetalleCantRequerida
														, ruteoDetalleCantNovedad
														, ruteoDetalleId
														,valorProductoLoteId
														,novedadId
														,bodegaLogicaId
														,ubicacionId
														,contenedorId
														,id
														,rutaUbicacionOrden
										
										END 

										


										INSERT INTO #AsignacionRuteoDetallePedidoTemp (	
																			ruteoId,
																			ruteoFecha,
																			ruteoUsuario,
																			ruteoConsecutivo,
																			ruteoPedidoEstado,											
																			novedadId,
																			bodegaLogicaId,
																			ubicacionId, 						
																			contenedorId,
																			pedidoId,
																			bahiaId,
																			ordenRuteo,
																			ruteoDetalleId,
																			productoId,
																			presentacionId,
																			ruteoDetalleCantidad,																			
																			ruteoDetalleCantRequerida,
																			ruteoDetalleCantNovedad,
																			valorProductoLoteId,
																			rutaUbicacionOrden
															  )
										SELECT			 @ruteoId
														,@ruteoFecha
														,@ruteoUsuario
														,@ruteoConsecutivo
														,@ruteoPedidoEstado
														,@novedadId
														,@bodegaLogicaId
														,@ubicacionId
														,@contenedorId
														,@pedidoId
														,@bahiaIdAUX
														,@pedidoOrden
														,@ruteoDetalleIdAux
														,@productoIdAUX
														,@presentacionId
														,@cantidadAsignadaAux  
														,@pedidoDetalleCantidad - @cantidadAsignadaPedidoRuteo
														,@cantidadNovedadAux
														,@valorProductoLoteIdAux
														,@rutaUbicacionOrden
										
										IF @cantidadAsignadaAux IS NULL OR @cantidadAsignadaAux = 0 BEGIN


										SET @cantidadAsignadaPedidoRuteo = @pedidoDetalleCantidad

										END
										ELSE
										BEGIN
										SET			@cantidadAsignadaPedidoRuteo += @cantidadAsignadaAux
										END


										UPDATE #RuteosDetalleTemp
										SET ruteoDetalleEstado = 1
										WHERE id = @id
										
										END
																		
											FETCH NEXT 
												FROM	 RuteoPedidosTempInfo 
												INTO	@pedidoId
												,@pedidoDetalleId												
												,@productoIdAUX
												,@productoTipoId
												,@presentacionId
												,@pedidoDetalleCantidad												
												,@ruteoIdAUX
												,@bahiaIdAUX
												,@pedidoOrden
												,@pedidoProcesado
												,@Caducidad
												,@FechaCaducidad	
										END
								CLOSE		RuteoPedidosTempInfo
								DEALLOCATE	RuteoPedidosTempInfo

							

--SELECT * FROM #AsignacionRuteoDetallePedidoTemp ORDER BY rutaUbicacionOrden

	IF (@bahiaId > 0  AND @productoId > 0  )
	BEGIN
				SELECT					TOP 1
												 pr.ruteoId
												,pr.ruteoFecha
												,pr.ruteoUsuario
												,pr.ruteoConsecutivo
												,pr.ruteoPedidoEstado
												,pr.ruteoDetalleId
												,pr.novedadId
												,n.novedadDescripcion
												,pro.productoId
												,pro.productoCodigo
												,pro.productoDescripcion
												,pr.presentacionId
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,pr.bodegaLogicaId
												,bl.bodegaLogicaDescripcion
												,pr.ubicacionId
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,pr.ruteoDetalleCantidad
												,pr.ruteoDetalleCantNovedad
												,pr.ruteoDetalleCantRequerida											
												,pr.contenedorId
												,vpl.valorPlantillaLoteValor	
								FROM #AsignacionRuteoDetallePedidoTemp pr
								--FROM			 [dbo].[ruteos] pr							
								--INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = prd.ruteoId AND prd.ruteoDetalleCantidad > 0 AND prd.ubicacionId IS NOT NULL AND prd.ruteoDetalleEstado = 0
								INNER JOIN		 [dbo].[Presentaciones] p ON pr.presentacionId =	p.presentacionId 
								INNER JOIN		[dbo].[Productos] pro ON p.productoId = pro.productoId 
								INNER JOIN		[dbo].[UnidadesManejo] um ON pro.unidadManejoId = um.unidadManejoId
								INNER JOIN		 [dbo].[Novedades] n ON pr.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON pr.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON pr.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  pr.[valorProductoLoteId] = vpl.valorProductoLoteId	 AND vpl.atributoLoteId = 2
								WHERE pr.productoId = @productoId AND pr.bahiaId = @bahiaId  AND pr.ruteoDetalleCantidad > 0
								--ORDER BY ordenRuteo ASC,rutaUbicacionOrden ASC, um.unidadManejoCodigo DESC, (pr.ruteoDetalleCantidad * p.presentacionPesoBruto ) DESC
									ORDER BY  um.unidadManejoCodigo DESC, (p.presentacionPesoBruto ) DESC,ordenRuteo ASC,rutaUbicacionOrden ASC
									
			END

	ELSE IF (@bahiaId = 0  ) AND (@productoId > 0   )
				BEGIN
							SELECT					TOP 1
												 pr.ruteoId
												,pr.ruteoFecha
												,pr.ruteoUsuario
												,pr.ruteoConsecutivo
												,pr.ruteoPedidoEstado
												,pr.ruteoDetalleId
												,pr.novedadId
												,n.novedadDescripcion
												,pro.productoId
												,pro.productoCodigo
												,pro.productoDescripcion
												,pr.presentacionId
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,pr.bodegaLogicaId
												,bl.bodegaLogicaDescripcion
												,pr.ubicacionId
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,pr.ruteoDetalleCantidad
												,pr.ruteoDetalleCantNovedad
												,pr.ruteoDetalleCantRequerida											
												,pr.contenedorId
												,vpl.valorPlantillaLoteValor	
								FROM #AsignacionRuteoDetallePedidoTemp pr
								--FROM			 [dbo].[ruteos] pr							
								--INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = prd.ruteoId AND prd.ruteoDetalleCantidad > 0 AND prd.ubicacionId IS NOT NULL AND prd.ruteoDetalleEstado = 0
								INNER JOIN		 [dbo].[Presentaciones] p ON pr.presentacionId =	p.presentacionId 
								INNER JOIN		[dbo].[Productos] pro ON p.productoId = pro.productoId 
								INNER JOIN		[dbo].[UnidadesManejo] um ON pro.unidadManejoId = um.unidadManejoId
								INNER JOIN		 [dbo].[Novedades] n ON pr.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON pr.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON pr.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  pr.[valorProductoLoteId] = vpl.valorProductoLoteId	AND vpl.atributoLoteId = 2
								WHERE  pr.productoId = @productoId  AND pr.ruteoDetalleCantidad > 0
								--ORDER BY ordenRuteo ASC,rutaUbicacionOrden ASC, um.unidadManejoCodigo DESC, (pr.ruteoDetalleCantidad * p.presentacionPesoBruto ) DESC
								ORDER BY  um.unidadManejoCodigo DESC, (p.presentacionPesoBruto ) DESC,ordenRuteo ASC,rutaUbicacionOrden ASC
						END

			ELSE IF (@productoId = 0 ) AND (@bahiaId > 0   )
							BEGIN
								SELECT					TOP 1
												 pr.ruteoId
												,pr.ruteoFecha
												,pr.ruteoUsuario
												,pr.ruteoConsecutivo
												,pr.ruteoPedidoEstado
												,pr.ruteoDetalleId
												,pr.novedadId
												,n.novedadDescripcion
												,pro.productoId
												,pro.productoCodigo
												,pro.productoDescripcion
												,pr.presentacionId
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,pr.bodegaLogicaId
												,bl.bodegaLogicaDescripcion
												,pr.ubicacionId
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,pr.ruteoDetalleCantidad
												,pr.ruteoDetalleCantNovedad
												,pr.ruteoDetalleCantRequerida											
												,pr.contenedorId
												,vpl.valorPlantillaLoteValor	
								FROM #AsignacionRuteoDetallePedidoTemp pr
								--FROM			 [dbo].[ruteos] pr							
								--INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = prd.ruteoId AND prd.ruteoDetalleCantidad > 0 AND prd.ubicacionId IS NOT NULL AND prd.ruteoDetalleEstado = 0
								INNER JOIN		 [dbo].[Presentaciones] p ON pr.presentacionId =	p.presentacionId 
								INNER JOIN		[dbo].[Productos] pro ON p.productoId = pro.productoId 
								INNER JOIN		[dbo].[UnidadesManejo] um ON pro.unidadManejoId = um.unidadManejoId
								INNER JOIN		 [dbo].[Novedades] n ON pr.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON pr.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON pr.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  pr.[valorProductoLoteId] = vpl.valorProductoLoteId	AND vpl.atributoLoteId = 2
								WHERE pr.bahiaId = @bahiaId  AND pr.ruteoDetalleCantidad > 0
								ORDER BY  um.unidadManejoCodigo DESC, (p.presentacionPesoBruto ) DESC,ordenRuteo ASC,rutaUbicacionOrden ASC

						END

						ELSE 
						BEGIN

								SELECT	TOP 1			
												 pr.ruteoId
												,pr.ruteoFecha
												,pr.ruteoUsuario
												,pr.ruteoConsecutivo
												,pr.ruteoPedidoEstado
												,pr.ruteoDetalleId
												,pr.novedadId
												,n.novedadDescripcion
												
												,pro.productoId
												,pro.productoCodigo
												,pro.productoDescripcion
												,pr.presentacionId
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,pr.bodegaLogicaId
												,bl.bodegaLogicaDescripcion
												,pr.ubicacionId
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,pr.ruteoDetalleCantidad
												,pr.ruteoDetalleCantNovedad
												,pr.ruteoDetalleCantRequerida											
												,pr.contenedorId
												,vpl.valorPlantillaLoteValor	
								FROM #AsignacionRuteoDetallePedidoTemp pr
								--FROM			 [dbo].[ruteos] pr							
								--INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = prd.ruteoId AND prd.ruteoDetalleCantidad > 0 AND prd.ubicacionId IS NOT NULL AND prd.ruteoDetalleEstado = 0
								INNER JOIN		 [dbo].[Presentaciones] p ON pr.presentacionId =	p.presentacionId 
								INNER JOIN		[dbo].[Productos] pro ON p.productoId = pro.productoId 
								INNER JOIN		[dbo].[UnidadesManejo] um ON pro.unidadManejoId = um.unidadManejoId
								INNER JOIN		 [dbo].[Novedades] n ON pr.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON pr.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON pr.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  pr.[valorProductoLoteId] = vpl.valorProductoLoteId	AND vpl.atributoLoteId = 2
								 WHERE pr.ruteoDetalleCantidad > 0
							ORDER BY  um.unidadManejoCodigo DESC, (p.presentacionPesoBruto ) DESC,ordenRuteo ASC, rutaUbicacionOrden ASC
								

						END


						
		

			
									

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_RuteoDetalle_ProductoId_BahiaIdTEMP]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		
			
	CREATE PROCEDURE  [dbo].[SP_GET_RuteoDetalle_ProductoId_BahiaIdTEMP]
	(
	         @bahiaId AS BIGINT 
			,@productoId AS BIGINT 	
			,@ruteoId AS BIGINT
	
	
	)
	AS

	BEGIN

	IF (@bahiaId > 0 ) AND (@productoId > 0  )
	BEGIN
				SELECT					TOP 1
												 pr.[ruteoId]
												,pr.[ruteoFecha]
												,pr.[ruteoUsuario]
												,pr.[ruteoConsecutivo]
												,pr.ruteoPedidoEstado
												,prd.[ruteoDetalleId]
												,prd.[novedadId]
												,n.novedadDescripcion
												,prd.[presentacionId]
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,prd.[bodegaLogicaId]
												,bl.bodegaLogicaDescripcion
												,prd.[ubicacionId]
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,prd.[ruteoDetalleCantidad]
												,prd.[ruteoDetalleCantNovedad]
												,prd.[ruteoDetalleCantRequerida]												
												,prd.[contenedorId]
												,vpl.valorPlantillaLoteValor	
								FROM			 [dbo].[ruteos] pr							
								INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = prd.ruteoId AND prd.ruteoDetalleCantidad > 0 AND prd.ubicacionId IS NOT NULL AND prd.ruteoDetalleEstado = 0
								INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId =	p.presentacionId AND p.productoId = @productoId
								INNER JOIN		[dbo].[RuteosPedidos] rp ON prd.ruteoId = rp.ruteoId AND rp.bahiaId = @bahiaId
								INNER JOIN		[dbo].[PedidosDetalle] pd ON rp.pedidoId = pd.pedidoId AND p.presentacionId = pd.presentacionId
								INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON prd.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId	
								WHERE pr.ruteoId = @ruteoId 
								GROUP BY  pr.[ruteoId]
												,pr.[ruteoFecha]
												,pr.[ruteoUsuario]
												,pr.[ruteoConsecutivo]
												,pr.ruteoPedidoEstado
												,prd.[ruteoDetalleId]
												,prd.[novedadId]
												,n.novedadDescripcion
												,prd.[presentacionId]
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,prd.[bodegaLogicaId]
												,bl.bodegaLogicaDescripcion
												,prd.[ubicacionId]
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,prd.[ruteoDetalleCantidad]
												,prd.[ruteoDetalleCantNovedad]
												,prd.[ruteoDetalleCantRequerida]												
												,prd.[contenedorId]
												,vpl.valorPlantillaLoteValor
										ORDER BY prd.[ubicacionId]
			END

	ELSE IF (@bahiaId = 0  ) AND (@productoId > 0   )
				BEGIN
							SELECT			TOP 1
							
															pr.[ruteoId]
															,pr.[ruteoFecha]
															,pr.[ruteoUsuario]
															,pr.[ruteoConsecutivo]
															,pr.ruteoPedidoEstado
															,prd.[ruteoDetalleId]
															,prd.[novedadId]
															,n.novedadDescripcion
															,prd.[presentacionId]
															,p.presentacionCodigo
															,p.presentacionDescripcion
															,prd.[bodegaLogicaId]
															,bl.bodegaLogicaDescripcion
															,prd.[ubicacionId]
															,u.ubicacionCodigo
															,u.ubicacionDescripcion
															,prd.[ruteoDetalleCantidad]
															,prd.[ruteoDetalleCantNovedad]
															,prd.[ruteoDetalleCantRequerida]												
															,prd.[contenedorId]
															,vpl.valorPlantillaLoteValor	
											FROM			 [dbo].[ruteos] pr							
											INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = prd.ruteoId AND prd.ruteoDetalleCantidad > 0 AND  prd.ubicacionId IS NOT NULL AND prd.ruteoDetalleEstado = 0
											INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId = p.presentacionId	AND p.productoId = @productoId							
											INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
											INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
											INNER JOIN		 [dbo].[Ubicaciones] u 	ON prd.[ubicacionId] = u.ubicacionId
											INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId	
											WHERE pr.ruteoId = @ruteoId 
											GROUP BY  pr.[ruteoId]
															,pr.[ruteoFecha]
															,pr.[ruteoUsuario]
															,pr.[ruteoConsecutivo]
															,pr.ruteoPedidoEstado
															,prd.[ruteoDetalleId]
															,prd.[novedadId]
															,n.novedadDescripcion
															,prd.[presentacionId]
															,p.presentacionCodigo
															,p.presentacionDescripcion
															,prd.[bodegaLogicaId]
															,bl.bodegaLogicaDescripcion
															,prd.[ubicacionId]
															,u.ubicacionCodigo
															,u.ubicacionDescripcion
															,prd.[ruteoDetalleCantidad]
															,prd.[ruteoDetalleCantNovedad]
															,prd.[ruteoDetalleCantRequerida]												
															,prd.[contenedorId]
															,vpl.valorPlantillaLoteValor
													ORDER BY prd.[ubicacionId]
						END

			ELSE IF (@productoId = 0 ) AND (@bahiaId > 0   )
							BEGIN
							SELECT				TOP 1
																pr.[ruteoId]
																,pr.[ruteoFecha]
																,pr.[ruteoUsuario]
																,pr.[ruteoConsecutivo]
																,pr.ruteoPedidoEstado
																,prd.[ruteoDetalleId]
																,prd.[novedadId]
																,n.novedadDescripcion
																,prd.[presentacionId]
																,p.presentacionCodigo
																,p.presentacionDescripcion
																,prd.[bodegaLogicaId]
																,bl.bodegaLogicaDescripcion
																,prd.[ubicacionId]
																,u.ubicacionCodigo
																,u.ubicacionDescripcion
																,prd.[ruteoDetalleCantidad]
																,prd.[ruteoDetalleCantNovedad]
																,prd.[ruteoDetalleCantRequerida]												
																,prd.[contenedorId]
																,vpl.valorPlantillaLoteValor	
												FROM			 [dbo].[ruteos] pr							
												INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = prd.ruteoId AND prd.ruteoDetalleCantidad > 0 AND prd.ubicacionId IS NOT NULL AND prd.ruteoDetalleEstado = 0
												INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId =	p.presentacionId
												INNER JOIN		[dbo].[RuteosPedidos] rp ON prd.ruteoId = rp.ruteoId AND rp.bahiaId = @bahiaId
												INNER JOIN		[dbo].[PedidosDetalle] pd ON rp.pedidoId = pd.pedidoId AND p.presentacionId = pd.presentacionId
												INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
												INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
												INNER JOIN		 [dbo].[Ubicaciones] u 	ON prd.[ubicacionId] = u.ubicacionId
												INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId	
												WHERE pr.ruteoId = @ruteoId 
												GROUP BY  pr.[ruteoId]
																,pr.[ruteoFecha]
																,pr.[ruteoUsuario]
																,pr.[ruteoConsecutivo]
																,pr.ruteoPedidoEstado
																,prd.[ruteoDetalleId]
																,prd.[novedadId]
																,n.novedadDescripcion
																,prd.[presentacionId]
																,p.presentacionCodigo
																,p.presentacionDescripcion
																,prd.[bodegaLogicaId]
																,bl.bodegaLogicaDescripcion
																,prd.[ubicacionId]
																,u.ubicacionCodigo
																,u.ubicacionDescripcion
																,prd.[ruteoDetalleCantidad]
																,prd.[ruteoDetalleCantNovedad]
																,prd.[ruteoDetalleCantRequerida]												
																,prd.[contenedorId]
																,vpl.valorPlantillaLoteValor
														ORDER BY prd.[ubicacionId]

						END

						ELSE 
						BEGIN

							SELECT				TOP 1
												pr.[ruteoId]
												,pr.[ruteoFecha]
												,pr.[ruteoUsuario]
												,pr.[ruteoConsecutivo]
												,pr.ruteoPedidoEstado
												,prd.[ruteoDetalleId]
												,prd.[novedadId]
												,n.novedadDescripcion
												,prd.[presentacionId]
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,prd.[bodegaLogicaId]
												,bl.bodegaLogicaDescripcion
												,prd.[ubicacionId]
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,prd.[ruteoDetalleCantidad]
												,prd.[ruteoDetalleCantNovedad]
												,prd.[ruteoDetalleCantRequerida]												
												,prd.[contenedorId]
												,vpl.valorPlantillaLoteValor	
								FROM			 [dbo].[ruteos] pr							
								INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = prd.ruteoId AND prd.ruteoDetalleCantidad > 0 AND prd.ubicacionId IS NOT NULL AND prd.ruteoDetalleEstado = 0
								INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId =	p.presentacionId 
							
								
								INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON prd.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId	
								WHERE pr.ruteoId = @ruteoId 
								GROUP BY  pr.[ruteoId]
												,pr.[ruteoFecha]
												,pr.[ruteoUsuario]
												,pr.[ruteoConsecutivo]
												,pr.ruteoPedidoEstado
												,prd.[ruteoDetalleId]
												,prd.[novedadId]
												,n.novedadDescripcion
												,prd.[presentacionId]
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,prd.[bodegaLogicaId]
												,bl.bodegaLogicaDescripcion
												,prd.[ubicacionId]
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,prd.[ruteoDetalleCantidad]
												,prd.[ruteoDetalleCantNovedad]
												,prd.[ruteoDetalleCantRequerida]												
												,prd.[contenedorId]
												,vpl.valorPlantillaLoteValor
									


						END


						
		



END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_RuteoDetalle_ubicacionCapturada]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
			
	CREATE PROCEDURE  [dbo].[SP_GET_RuteoDetalle_ubicacionCapturada]
	(
	       
			@ubicacionRequerida AS VARCHAR(50),
			@ubicacionCapturada AS VARCHAR(50) 
	
	
	)
	AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION ubicacionCapturada

			
							SET DATEFORMAT YMD

	SET NOCOUNT ON
	DECLARE @UbicacionActualizadaId BIGINT
	DECLARE @presentacionId BIGINT
	DECLARE @bodegaLogicaId BIGINT
	DECLARE @ruteoId BIGINT
	DECLARE @ruteoDetalleId BIGINT
	DECLARE @ValorProductoLoteId BIGINT
	DECLARE @saldoId BIGINT = 0
	DECLARE @ubicacionId BIGINT
	DECLARE @ubicacionCapturadaId BIGINT
	DECLARE @ubicacionRequeridaId BIGINT
	

	SELECT TOP 1 @ubicacionCapturadaId = ubicacionId FROM [dbo].[Ubicaciones] WHERE ubicacionCodigo LIKE @ubicacionCapturada

	SELECT TOP 1 @ubicacionRequeridaId = ubicacionId FROM [dbo].[Ubicaciones] WHERE ubicacionCodigo LIKE @ubicacionRequerida
	
	IF NOT EXISTS (SELECT 1 FROM [dbo].[RuteosDetalle] rd 
				INNER JOIN [dbo].[Ubicaciones] u ON rd.ubicacionId = u.ubicacionId AND ubicacionCodigo LIKE @ubicacionCapturada
				WHERE rd.ruteoDetalleEstado = 0
				) AND @ubicacionCapturadaId > 0 AND @ubicacionRequeridaId > 0
	BEGIN
	
							;WITH ruteoDetalleUbicacionCapturada( presentacionId
																,productoId
																,bodegaLogicaId
																,ubicacionId
																,valorProductoLoteId
																,valorPlantillaLoteValor
																,ruteoDetalleCantidad
																,ruteoDetalleCantRequerida
																,ruteoId
																,ruteoDetalleId)
																AS
																(
									SELECT 
												 rd.presentacionId
												,pro.productoId
												,rd.bodegaLogicaId
												,rd.ubicacionId
												,vpl.valorProductoLoteId
												,vpl.valorPlantillaLoteValor
												,rd.ruteoDetalleCantidad
												,rd.ruteoDetalleCantRequerida
												,rd.ruteoId
												,rd.ruteoDetalleId 
									FROM		[dbo].[RuteosDetalle] rd
									INNER JOIN  [dbo].[Ubicaciones] u ON rd.ubicacionId = u.ubicacionId AND u.ubicacionId = @ubicacionRequeridaId									
									INNER JOIN  [dbo].[ValoresPlantillasLotes] vpl ON rd.valorProductoLoteId = vpl.valorProductoLoteId AND vpl.atributoLoteId = 2
									INNER JOIN	[dbo].[Presentaciones] p ON rd.presentacionId = p.presentacionId AND presentacionEstado = 1
									INNER JOIN	[dbo].[Productos] pro ON pro.productoId = p.productoId AND pro.productoEstado = 1
									WHERE		rd.ruteoDetalleEstado = 0
									GROUP BY	rd.presentacionId
												,pro.productoId
												,rd.bodegaLogicaId
												,rd.ubicacionId
												,vpl.valorProductoLoteId
												,vpl.valorPlantillaLoteValor
												,rd.ruteoDetalleCantidad
												,rd.ruteoDetalleCantRequerida
												,rd.ruteoId
												,rd.ruteoDetalleId 
												),
												 saldoDetalleUbicacionActual(	
																		 presentacionId
																		,productoId
																		,bodegaLogicaId
																		,ubicacionId
																		,valorProductoLoteId
																		,valorPlantillaLoteValor
																		,saldoDetalleCantidad									
																		,saldoId
																		)
																		AS
																		(
									SELECT 
												 sd.presentacionId
												,s.productoId
												,sd.bodegaLogicaId
												,sd.ubicacionId
												,vpl.valorProductoLoteId
												,vpl.valorPlantillaLoteValor
												,SUM(sd.saldoDetalleDisponibleManejo)			
												,s.saldoId

			 
									FROM		[dbo].[Saldos] s
									INNER JOIN [dbo].[SaldosDetalle] sd ON s.saldoId = sd.saldoId AND sd.saldoDetalleDisponibleManejo > 0
									INNER JOIN  [dbo].[Ubicaciones] u ON sd.ubicacionId = u.ubicacionId AND u.ubicacionId = @ubicacionCapturadaId -- codigo codigocapturado
									INNER JOIN  [dbo].[RutasUbicaciones] ru ON u.ubicacionId = ru.ubicacionId
									INNER JOIN  [dbo].[ValoresPlantillasLotes] vpl ON sd.valorProductoLoteId = vpl.valorProductoLoteId AND vpl.atributoLoteId = 2
									INNER JOIN	[dbo].[Presentaciones] p ON sd.presentacionId = p.presentacionId AND presentacionEstado = 1

									GROUP BY	sd.presentacionId
												,s.productoId
												,sd.bodegaLogicaId
												,sd.ubicacionId
												,vpl.valorProductoLoteId
												,vpl.valorPlantillaLoteValor						
												,s.saldoId
		



												)


												SELECT TOP 1 
												 @presentacionId = sd.presentacionId
												--,sd.productoId
												,@bodegaLogicaId =sd.bodegaLogicaId
												,@UbicacionActualizadaId = sd.ubicacionId
												,@valorProductoLoteId =sd.valorProductoLoteId
												--,sd.valorPlantillaLoteValor
												--,sd.saldoDetalleCantidad
												,@saldoId = sd.saldoId
												,@ruteoDetalleId = rd.ruteoDetalleId
												,@ruteoId =  rd.ruteoId
												FROM saldoDetalleUbicacionActual sd
												INNER JOIN ruteoDetalleUbicacionCapturada rd ON sd.presentacionId = rd.presentacionId 
																								AND sd.bodegaLogicaId = rd.bodegaLogicaId
																								AND sd.productoId = rd.productoId
																								AND sd.ubicacionId != rd.ubicacionId
																								AND sd.valorPlantillaLoteValor >=  rd.valorPlantillaLoteValor
																								AND sd.saldoDetalleCantidad  >= rd.ruteoDetalleCantRequerida 


												--SELECT TOP 1 
												--  sd.presentacionId
												----,sd.productoId
												--,sd.bodegaLogicaId
												--, sd.ubicacionId
												--,sd.valorProductoLoteId
												----,sd.valorPlantillaLoteValor
												----,sd.saldoDetalleCantidad
												--, sd.saldoId
												--, rd.ruteoDetalleId
												--,  rd.ruteoId
												--FROM saldoDetalleUbicacionActual sd
												--INNER JOIN ruteoDetalleUbicacionCapturada rd ON sd.presentacionId = rd.presentacionId 
												--												AND sd.bodegaLogicaId = rd.bodegaLogicaId
												--												AND sd.productoId = rd.productoId
												--												AND sd.ubicacionId != rd.ubicacionId
												--												AND sd.valorPlantillaLoteValor >=  rd.valorPlantillaLoteValor
												--												AND sd.saldoDetalleCantidad >= rd.ruteoDetalleCantRequerida

															--GROUP BY							 sd.presentacionId
															--									--,sd.productoId
															--									,sd.bodegaLogicaId
															--									--,sd.ubicacionId
															--									,sd.valorProductoLoteId
															--									--,sd.valorPlantillaLoteValor
															--									--,sd.saldoDetalleCantidad
															--									--,sd.saldoId
															--									,rd.ruteoDetalleId
															--									,rd.ruteoId
			
												IF (@saldoId > 0)
												BEGIN
						
															UPDATE [dbo].[RuteosDetalle]
															SET		ubicacionId = @UbicacionActualizadaId
																	,valorProductoLoteId = @ValorProductoLoteId
																	

															WHERE	ruteoId = @ruteoId AND @ruteoId > 0
																	AND ubicacionId =  @ubicacionRequeridaId
																	AND ruteoDetalleId = @ruteoDetalleId AND @ruteoDetalleId > 0
																	AND presentacionId = @presentacionId AND @presentacionId > 0
																	AND bodegaLogicaId = @bodegaLogicaId AND @bodegaLogicaId > 0
								

															UPDATE [dbo].[saldosDetalle]															
															SET		saldoDetalleComprometidoManejo			= 
																										(saldoDetalleComprometidoManejo	 +	saldoDetalleDisponibleManejo) 
																	,saldoDetalleInmovilizadoManejo			=	
																										saldoDetalleInmovilizadoManejo	+ 
																										(saldoDetalleRealManejo		-	(saldoDetalleComprometidoManejo		+	saldoDetalleDisponibleManejo))	
																	,saldoDetalleDisponibleManejo			=	
																										saldoDetalleRealManejo	-
																										(saldoDetalleInmovilizadoManejo		+ 
																										(saldoDetalleRealManejo		-	(saldoDetalleComprometidoManejo		+	saldoDetalleDisponibleManejo)))	-
																										(saldoDetalleComprometidoManejo	 +	saldoDetalleDisponibleManejo) 	
																	,saldoDetalleComprometidoEscalar		= 
																										(saldoDetalleComprometidoEscalar	+	saldoDetalleDisponibleEscalar) 	
																	,saldoDetalleInmovilizadoEscalar		=	
																										saldoDetalleInmovilizadoEscalar		+ 
																										(saldoDetalleRealEscalar	-	(saldoDetalleComprometidoEscalar	+	saldoDetalleDisponibleEscalar))	
																	,saldoDetalleDisponibleEscalar			=	
																										saldoDetalleRealEscalar	-
																										(saldoDetalleInmovilizadoEscalar	+ 
																										(saldoDetalleRealEscalar	-	(saldoDetalleComprometidoEscalar	+	saldoDetalleDisponibleEscalar))) -
																										(saldoDetalleComprometidoEscalar	 +	saldoDetalleDisponibleEscalar) 	

															WHERE	saldoId = @saldoId 
																	AND valorProductoLoteId = @ValorProductoLoteId AND @ValorProductoLoteId > 0
																	AND ubicacionId = @UbicacionActualizadaId  AND @UbicacionActualizadaId > 0
																	AND presentacionId = @presentacionId  AND @presentacionId > 0
																	AND bodegaLogicaId = @bodegaLogicaId  AND @bodegaLogicaId > 0
																	AND saldoDetalleDisponibleManejo > 0 AND saldoDetalleRealManejo > 0


															UPDATE [dbo].[saldosDetalle]															
															SET		saldoDetalleComprometidoManejo			= (saldoDetalleComprometidoManejo	 -	saldoDetalleRealManejo) 
																	,saldoDetalleInmovilizadoManejo			=	0	
																	,saldoDetalleDisponibleManejo			=	saldoDetalleDisponibleManejo + saldoDetalleRealManejo																									 
																	,saldoDetalleComprometidoEscalar		=  (saldoDetalleComprometidoEscalar	-	saldoDetalleDisponibleEscalar) 	
																	,saldoDetalleInmovilizadoEscalar		=	0																									
																	,saldoDetalleDisponibleEscalar			=	saldoDetalleDisponibleEscalar + saldoDetalleComprometidoEscalar	
															WHERE	saldoId = @saldoId 
																	AND valorProductoLoteId = @ValorProductoLoteId AND @ValorProductoLoteId > 0
																	AND ubicacionId = @UbicacionRequeridaId  AND @UbicacionActualizadaId > 0
																	AND presentacionId = @presentacionId  AND @presentacionId > 0
																	AND bodegaLogicaId = @bodegaLogicaId  AND @bodegaLogicaId > 0
																	AND saldoDetalleComprometidoManejo > 0 AND saldoDetalleRealManejo > 0




								
												END

END
												IF(@UbicacionActualizadaId > 0) SET @ubicacionId = @UbicacionActualizadaId
												ELSE  SET @ubicacionId = @ubicacionCapturadaId


DECLARE @result INT
	SELECT	@result =	COUNT(*) 
					FROM		[dbo].[Ruteos] r
								INNER JOIN		RuteosDetalle rd	ON r.ruteoId = rd.ruteoId 	AND rd.ruteoDetalleEstado = 0			
								INNER JOIN		 [dbo].[Presentaciones] p ON rd.presentacionId =	p.presentacionId 
								INNER JOIN		[dbo].[Productos] pro ON p.productoId = pro.productoId 
								INNER JOIN		[dbo].[UnidadesManejo] um ON pro.unidadManejoId = um.unidadManejoId
								INNER JOIN		 [dbo].[Novedades] n ON rd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON rd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON rd.[ubicacionId] = u.ubicacionId 
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  rd.[valorProductoLoteId] = vpl.valorProductoLoteId	 AND vpl.atributoLoteId = 2
								WHERE   u.ubicacionId = @UbicacionId

IF @result > 0
BEGIN 


						SELECT TOP 1
				
												 r.ruteoId
												,r.ruteoFecha
												,r.ruteoUsuario
												,r.ruteoConsecutivo
												,r.ruteoPedidoEstado
												,rd.ruteoDetalleId
												,rd.novedadId
												,n.novedadDescripcion
												,rd.presentacionId
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,rd.bodegaLogicaId
												,bl.bodegaLogicaDescripcion
												,rd.ubicacionId
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,rd.ruteoDetalleCantidad
												,rd.ruteoDetalleCantNovedad
												,rd.ruteoDetalleCantRequerida											
												,rd.contenedorId
												,vpl.valorPlantillaLoteValor	
												,'' as resultado
								FROM		[dbo].[Ruteos] r
								INNER JOIN		RuteosDetalle rd	ON r.ruteoId = rd.ruteoId 	AND rd.ruteoDetalleEstado = 0			
								INNER JOIN		 [dbo].[Presentaciones] p ON rd.presentacionId =	p.presentacionId 
								INNER JOIN		[dbo].[Productos] pro ON p.productoId = pro.productoId 
								INNER JOIN		[dbo].[UnidadesManejo] um ON pro.unidadManejoId = um.unidadManejoId
								INNER JOIN		 [dbo].[Novedades] n ON rd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON rd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON rd.[ubicacionId] = u.ubicacionId 
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  rd.[valorProductoLoteId] = vpl.valorProductoLoteId	 AND vpl.atributoLoteId = 2
								WHERE   u.ubicacionId = @UbicacionId
									
			END			
ELSE 
BEGIN

SELECT 'No se encuentra  registro asociado a la ubicación capturada' AS resultado
			END	


COMMIT TRANSACTION ubicacionCapturada
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION ubicacionCapturada;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION ubicacionCapturada;     
											END;  

							END CATCH
							END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_RuteoDetalle_ubicacionCapturadaAux]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
			
	CREATE PROCEDURE  [dbo].[SP_GET_RuteoDetalle_ubicacionCapturadaAux]
	(
	       
			@ubicacionCapturada AS VARCHAR(50)
	
	
	)
	AS

	BEGIN

	SET NOCOUNT ON
	




						SELECT TOP 1
				
												 r.ruteoId
												,r.ruteoFecha
												,r.ruteoUsuario
												,r.ruteoConsecutivo
												,r.ruteoPedidoEstado
												,rd.ruteoDetalleId
												,rd.novedadId
												,n.novedadDescripcion
												,rd.presentacionId
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,rd.bodegaLogicaId
												,bl.bodegaLogicaDescripcion
												,rd.ubicacionId
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,rd.ruteoDetalleCantidad
												,rd.ruteoDetalleCantNovedad
												,rd.ruteoDetalleCantRequerida											
												,rd.contenedorId
												,vpl.valorPlantillaLoteValor	
								FROM		[dbo].[Ruteos] r
								INNER JOIN		RuteosDetalle rd	ON r.ruteoId = rd.ruteoId 	AND rd.ruteoDetalleEstado = 0			
								INNER JOIN		 [dbo].[Presentaciones] p ON rd.presentacionId =	p.presentacionId 
								INNER JOIN		[dbo].[Productos] pro ON p.productoId = pro.productoId 
								INNER JOIN		[dbo].[UnidadesManejo] um ON pro.unidadManejoId = um.unidadManejoId
								INNER JOIN		 [dbo].[Novedades] n ON rd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON rd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON rd.[ubicacionId] = u.ubicacionId AND u.ubicacionCodigo LIKE @ubicacionCapturada
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  rd.[valorProductoLoteId] = vpl.valorProductoLoteId	 AND vpl.atributoLoteId = 2
								WHERE r.ruteoPedidoEstado = 0
									
		

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_RuteoDetalle_ubicacionCapturadaAux2]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
			
	CREATE PROCEDURE  [dbo].[SP_GET_RuteoDetalle_ubicacionCapturadaAux2]
	(
	       
			@ubicacionCapturada AS VARCHAR(50)
	
	
	)
	AS

	BEGIN

	SET NOCOUNT ON
	




						SELECT TOP 1
				
												 r.ruteoId
												,r.ruteoFecha
												,r.ruteoUsuario
												,r.ruteoConsecutivo
												,r.ruteoPedidoEstado
												,rd.ruteoDetalleId
												,rd.novedadId
												,n.novedadDescripcion
												,rd.presentacionId
												,pro.productoId
												,pro.productoCodigo
												,pro.productoDescripcion
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,rd.bodegaLogicaId
												,bl.bodegaLogicaDescripcion
												,rd.ubicacionId
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,rd.ruteoDetalleCantidad
												,rd.ruteoDetalleCantNovedad
												,rd.ruteoDetalleCantRequerida											
												,rd.contenedorId
												,vpl.valorPlantillaLoteValor	
								FROM		[dbo].[Ruteos] r
								INNER JOIN		RuteosDetalle rd	ON r.ruteoId = rd.ruteoId 	AND rd.ruteoDetalleEstado = 0			
								INNER JOIN		 [dbo].[Presentaciones] p ON rd.presentacionId =	p.presentacionId 
								INNER JOIN		[dbo].[Productos] pro ON p.productoId = pro.productoId 
								INNER JOIN		[dbo].[UnidadesManejo] um ON pro.unidadManejoId = um.unidadManejoId
								INNER JOIN		 [dbo].[Novedades] n ON rd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON rd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON rd.[ubicacionId] = u.ubicacionId AND u.ubicacionCodigo LIKE @ubicacionCapturada
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  rd.[valorProductoLoteId] = vpl.valorProductoLoteId	 AND vpl.atributoLoteId = 2
								WHERE r.ruteoPedidoEstado = 0
									
		

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_RuteoDetalle_ubicacionCapturadaId]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		--EXEC  [dbo].[SP_GET_RuteoDetalle_ProductoId_BahiaId] 0,0,1
			
	CREATE PROCEDURE  [dbo].[SP_GET_RuteoDetalle_ubicacionCapturadaId]
	(
	       
			@ubicacionCapturada AS BIGINT
	
	
	)
	AS

	BEGIN

	SET NOCOUNT ON





						SELECT TOP 1
				
												 r.ruteoId
												,r.ruteoFecha
												,r.ruteoUsuario
												,r.ruteoConsecutivo
												,r.ruteoPedidoEstado
												,rd.ruteoDetalleId
												,rd.novedadId
												,n.novedadDescripcion
												,rd.presentacionId
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,rd.bodegaLogicaId
												,bl.bodegaLogicaDescripcion
												,rd.ubicacionId
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,rd.ruteoDetalleCantidad
												,rd.ruteoDetalleCantNovedad
												,rd.ruteoDetalleCantRequerida											
												,rd.contenedorId
												,rd.valorProductoLoteId	
								FROM		[dbo].[Ruteos] r
								INNER JOIN		RuteosDetalle rd	ON r.ruteoId = rd.ruteoId 	AND rd.ruteoDetalleEstado = 0			
								INNER JOIN		 [dbo].[Presentaciones] p ON rd.presentacionId =	p.presentacionId 
								INNER JOIN		[dbo].[Productos] pro ON p.productoId = pro.productoId 
								INNER JOIN		[dbo].[UnidadesManejo] um ON pro.unidadManejoId = um.unidadManejoId
								INNER JOIN		 [dbo].[Novedades] n ON rd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON rd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON rd.[ubicacionId] = u.ubicacionId AND u.ubicacionCodigo LIKE @ubicacionCapturada
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  rd.[valorProductoLoteId] = vpl.valorProductoLoteId	 AND vpl.atributoLoteId = 2
								WHERE r.ruteoPedidoEstado = 0
									
		

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_RuteosPedidosBahias]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_GET_RuteosPedidosBahias](@ruteoId BIGINT)
AS
BEGIN 

				SELECT				 u.ubicacionId
									,u.ubicacionCodigo
									,u.ubicacionDescripcion
									,u.tipoUbicacionId
									,rp.ruteoId
				FROM				[dbo].[RuteosPedidos] rp 
				INNER JOIN			[dbo].[Ubicaciones] u ON rp.bahiaId = u.ubicacionId
				INNER JOIN			[dbo].[TiposUbicaciones] t ON u.tipoUbicacionId = t.tipoUbicacionId
				WHERE				rp.ruteoId = @ruteoId
				GROUP BY			 u.ubicacionId
									,u.ubicacionCodigo
									,u.ubicacionDescripcion
									,u.tipoUbicacionId
									,rp.ruteoId
				ORDER BY			u.ubicacionDescripcion




END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_RuteosPedidosProductos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_GET_RuteosPedidosProductos](@ruteoId BIGINT)
AS
BEGIN 

				SELECT			 pr.productoId
								,pr.productoCodigo
								,pr.productoDescripcion
								,p.presentacionId
								,p.presentacionCodigo
								,p.presentacionDescripcion
								,rd.ruteoId
							
				FROM			[dbo].[RuteosDetalle] rd 
				INNER JOIN		[dbo].[Presentaciones] p ON rd.presentacionId = p.presentacionId
				INNER JOIN		[dbo].[Productos] pr ON p.productoId = pr.productoId
				WHERE			 rd.ruteoId = @ruteoId AND rd.ubicacionId IS NOT NULL AND rd.ruteoDetalleEstado = 0
				GROUP BY		 pr.productoId
								,pr.productoCodigo
								,pr.productoDescripcion
								,p.presentacionId
								,p.presentacionCodigo
								,p.presentacionDescripcion
								,rd.ruteoId
				ORDER BY		pr.productoDescripcion
								




END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_ValidarDespachoCargaUsuario]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		--EXEC  [dbo].[SP_GET_ValidarDespachoCargaUsuario] 67

CREATE PROCEDURE  [dbo].[SP_GET_ValidarDespachoCargaUsuario](@usuarioId AS BIGINT)

AS
BEGIN


DECLARE @ubicacionUsuarioId BIGINT


SELECT TOP 1 @ubicacionUsuarioId = ubicacionId
FROM [dbo].[Usuarios] u
INNER JOIn [dbo].[Ubicaciones] ub ON u.usuarioIdentificacion = ub.ubicacionCodigo
WHERE u.usuarioId = @usuarioId


DECLARE @result INT
	SELECT	@result =	COUNT(*)
				FROM [dbo].[DespachosDetalle] desp
				INNER JOIN [dbo].[Presentaciones] p ON desp.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON desp.ubicacionId = u.ubicacionId 	
				INNER JOIN [dbo].[Ubicaciones] uaux ON desp.ubicacionActualId = @ubicacionUsuarioId 
				WHERE desp.despachoEstado = 0

IF @result > 0
BEGIN 
				SELECT	TOP 1		 desp.despachoId
									,desp.despachoDetalleId
									,pro.productoId
									,pro.productoCodigo
									,pro.productoDescripcion
									,p.presentacionId
									,p.presentacionCodigo
									,p.presentacionDescripcion
									,desp.despachoDetalleCantTotal
									,u.ubicacionId
									,u.ubicacionCodigo
									,u.ubicacionDescripcion
									,uaux.ubicacionId as ubicacionIdActual
									,uaux.ubicacionCodigo as ubicacionCodigoActual
									,uaux.ubicacionDescripcion		 as ubicacionDescripcionActual	
									,'El usuario tiene saldo activo' as resultado
				FROM [dbo].[DespachosDetalle] desp
				INNER JOIN [dbo].[Presentaciones] p ON desp.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON desp.ubicacionId = u.ubicacionId 	
				INNER JOIN [dbo].[Ubicaciones] uaux ON   uaux.ubicacionId = @ubicacionUsuarioId 
				WHERE desp.despachoEstado = 0
			END		
ELSE BEGIN

SELECT '' AS resultado
END	

END
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_Despacho]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_INSERT_Despacho](
									@usuarioId AS BIGINT,
									@documentoId AS BIGINT, 									
									@despachoId AS BIGINT OUTPUT
									)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION despachoItem

			
							SET DATEFORMAT YMD
			DECLARE @consecutivo INT = 0
						DECLARE @documentoAuxId BIGINT = 0
						
						SELECT				TOP 1 @documentoAuxId	=  d.documentoId 
						FROM				[dbo].[Documentos] AS d
						WHERE				d.documentoCodigo='DESP'
						
						
															

															--Se consulta la secuencia actual del consecutivo 														
															SELECT TOP 1 @consecutivo =  DocumentoContador + 1
															FROM [dbo].[Documentos] 
															WHERE documentoId = @documentoAuxId

															--Se actualiza el consecutivo 
															IF @consecutivo IS NULL OR @consecutivo = 0
															BEGIN
															SELECT 'No se ha configurado consecutivo para este documento'  AS resultado
															COMMIT TRANSACTION despachoItem;  
															RETURN
															END
															UPDATE [dbo].[Documentos]
															SET DocumentoContador = @consecutivo			
															WHERE DocumentoId = @documentoAuxId
			
								INSERT INTO [dbo].[Despachos] (
									   UsuarioId
									  ,despachoConsecutivo
									  ,despachoEstado
									  ,documentoId
								)
								VALUES (											
											 @usuarioId
											,@consecutivo
											,0
											,@documentoId
											
								)

			SELECT @despachoId = SCOPE_IDENTITY() 


COMMIT TRANSACTION despachoItem
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION despachoItem;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION despachoItem;     
											END;  

							END CATCH
							END
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_NovedadPreRuteo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_INSERT_NovedadPreRuteo](
											 @novedadId AS BIGINT	
											,@productoTempId AS BIGINT
											,@presentacionTempId AS BIGINT
											,@contenedorId AS BIGINT
											,@valorProductoLoteId AS BIGINT
											,@usuarioId AS BIGINT
											,@preRuteoId AS BIGINT
)

AS
BEGIN
			SET NOCOUNT ON
			SET DATEFORMAT YMD
							
							

END

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_Packing]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_INSERT_Packing](
									@usuarioId AS BIGINT,
									@documentoId AS BIGINT, 
									@packingId AS BIGINT OUTPUT
									)
AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION packingItem

			
							SET DATEFORMAT YMD

			
			DECLARE @consecutivo INT = 0
						DECLARE @documentoAuxId BIGINT = 0
						
						SELECT				TOP 1 @documentoAuxId	=  d.documentoId 
						FROM				[dbo].[Documentos] AS d
						WHERE				d.documentoCodigo='PACK'
						
						
															

															--Se consulta la secuencia actual del consecutivo 														
															SELECT TOP 1 @consecutivo =  DocumentoContador + 1
															FROM [dbo].[Documentos] 
															WHERE documentoId = @documentoAuxId

															--Se actualiza el consecutivo 
															IF @consecutivo IS NULL OR @consecutivo = 0
															BEGIN 
																SELECT 'No se ha configurado consecutivo para este documento'
																ROLLBACK TRANSACTION packingItem;
																RETURN
															END
															
															UPDATE [dbo].[Documentos]
															SET DocumentoContador = @consecutivo			
															WHERE DocumentoId = @documentoAuxId
								INSERT INTO [dbo].[Packing] (
									   UsuarioId
									  ,packingConsecutivo
									  ,packingEstado
									  ,documentoId
								)
								VALUES (											
											 @usuarioId
											,@consecutivo
											,0
											,@documentoId
											
								)

			SELECT @packingId = SCOPE_IDENTITY() 


COMMIT TRANSACTION packingItem
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION packingItem;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION packingItem;     
											END;  

							END CATCH
							END

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_PreRuteo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_INSERT_PreRuteo](
									@usuarioId AS BIGINT,
									@documentoId AS BIGINT,
									@consecutivo AS INT,
									@preRuteoId AS BIGINT OUTPUT
									)
AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION Preruteo

			
							SET DATEFORMAT YMD
						
						
						
						/****** Se inserta el preruteo confirmado a la tabla de ruteos	******/
						
														
								INSERT INTO [dbo].[PreRuteos] (
									 preRuteoFecha
									,preRuteoUsuario
									,preRuteoConsecutivo
									,documentoId
									,preRuteoPedidoEstado
								)
								VALUES (
											 GETDATE() 
											,@usuarioId
											,@consecutivo
											,@documentoId
											,0
								)


								UPDATE [dbo].[Documentos]
															SET DocumentoContador = @consecutivo			
															WHERE DocumentoId = @documentoId

			SELECT @preRuteoId = SCOPE_IDENTITY() 
	COMMIT TRANSACTION Preruteo
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION Preruteo;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION Preruteo;     
											END;  

							END CATCH
							END
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_PreRuteoPedidoDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_INSERT_PreRuteoPedidoDetalle](
											 @preRuteoId AS BIGINT
											,@presentacionTempId AS BIGINT
											,@contenedorId AS BIGINT
											,@bodegaLogicaId AS BIGINT
											,@ubicacionId AS BIGINT
											,@CantidadDetalleAux AS BIGINT
											,@cantidadDetalleRequeridaAux AS BIGINT
											,@valorProductoLoteId AS BIGINT
)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION PreRuteoPedidoDetalle

			
							SET DATEFORMAT YMD
									INSERT INTO [dbo].[PreRuteosDetalle] 
																				([preRuteoId]							  
																				,[novedadId]
																				,[preRuteoPedidoEstado]
																				,[presentacionId]
																				,[contenedorId]
																				,[bodegaLogicaId]
																				,[ubicacionId]
																				,[preRuteoDetalleCantidad]
																				,[preRuteoDetalleCantRequerida]
																				,[preRuteoDetalleEstado]																				
																				,[valorProductoLoteId])																	
															SELECT				@preRuteoId
																				,1
																				,0
																				,@presentacionTempId
																				,@contenedorId
																				,@bodegaLogicaId
																				,@ubicacionId
																				,@CantidadDetalleAux
																				,@cantidadDetalleRequeridaAux
																				,0																			
																				,@valorProductoLoteId




COMMIT TRANSACTION PreRuteoPedidoDetalle
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION PreRuteoPedidoDetalle;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION PreRuteoPedidoDetalle;     
											END;  

							END CATCH
							END


GO
/****** Object:  StoredProcedure [dbo].[SP_SET_DespachoRuteo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_SET_DespachoRuteo](	@despachoId BIGINT, 
												@despachoDetalleId BIGINT,
												@ubicacionCodigo AS VARCHAR(50), 
												@novedadId  AS BIGINT, 
												@novedadAccionId AS BIGINT,
												@usuarioId AS BIGINT)


AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION despacho

			
							SET DATEFORMAT YMD


							DECLARE @tagUbicacionIdOrigen VARCHAR(50)
							DECLARE @ubicacionIdOrigen BIGINT
							DECLARE @ubicacionBahiaId BIGINT
							DECLARE @ruteoId BIGINT
							DECLARE @ubicacionPuertaId BIGINT
							DECLARE @ubicacionIdDestino BIGINT
							DECLARE @consecutivo INT = 0
							DECLARE @packingId BIGINT
							DECLARE @ruteoDetalleId BIGINT
						
							DECLARE @ubicacionBahiaHijaId BIGINT

								SET @novedadId = CASE WHEN @novedadId IS NULL OR @novedadId LIKE  '' OR @novedadId = 0 THEN 1 ELSE @novedadId END


								SELECT @consecutivo =	despachoConsecutivo FROM [dbo].[Despachos] WHERE despachoId = @despachoId
								IF (@despachoDetalleId IS NULL)
								BEGIN 
										SELECT  @despachoId AS despachoId,@despachoDetalleId AS despachoDetalleId
												,@consecutivo AS despachoConsecutivo
												,'No se encuentra saldos en la ubicación'  AS resultado		
											ROLLBACK TRANSACTION despacho;  								
										RETURN 								
								END
				



								IF(@ubicacionCodigo LIKE '')
								BEGIN 
															SELECT TOP(1)   @ubicacionIdOrigen = ub.ubicacionId
															FROM [dbo].[Usuarios] u
															INNER JOIN [dbo].[Ubicaciones] ub ON ub.ubicacionCodigo  LIKE  u.usuarioIdentificacion
															WHERE u.usuarioId = @usuarioId 
															
															SELECT TOP 1 @ubicacionBahiaHijaId = ubicacionId 
															FROM [dbo].[DespachosDetalle] 
															WHERE despachoId= @despachoId AND despachoDetalleId = @despachoDetalleId AND despachoEstado = 0

															SELECT TOP 1 @ubicacionBahiaId = ubicacionPadreId 
															FROM [dbo].[Ubicaciones] 
															WHERE ubicacionId= @ubicacionBahiaHijaId
						
															SELECT TOP 1 @ubicacionPuertaId = ubicacionPadreId 
															FROM [dbo].[Ubicaciones] 
															WHERE ubicacionId= @ubicacionBahiaId							
								
																IF @ubicacionPuertaId IS NULL
																BEGIN 

																	SELECT   @despachoId AS despachoId,@despachoDetalleId AS despachoDetalleId
																			,@consecutivo AS despachoConsecutivo
																			,'No existe la ubicacion destino'  AS resultado
																	COMMIT TRANSACTION despacho;  
																	RETURN
																END
																ELSE 
																SET @ubicacionIdDestino = @ubicacionPuertaId
								
								END
								ELSE
								BEGIN 
															SELECT TOP(1)   @ubicacionIdOrigen = ub.ubicacionId
															FROM [dbo].[Ubicaciones] ub 
															WHERE ub.ubicacionCodigo  LIKE @ubicacionCodigo
							

															SELECT TOP(1)   @ubicacionIdDestino = ub.ubicacionId
															FROM [dbo].[Usuarios] u
															INNER JOIN [dbo].[Ubicaciones] ub ON ub.ubicacionCodigo  LIKE  u.usuarioIdentificacion
															WHERE u.usuarioId = @usuarioId 
							
							

								END

						

														IF @ubicacionIdOrigen IS NULL BEGIN 

															SELECT   @despachoId AS despachoId,@despachoDetalleId AS despachoDetalleId
																	,@consecutivo AS despachoConsecutivo 
																	,'No existe la ubicacion origen capturada'  AS resultado
															COMMIT TRANSACTION despacho;  
															RETURN
															END
														IF @ubicacionIdDestino IS NULL BEGIN 

															SELECT			 @despachoId AS despachoId,@despachoDetalleId AS despachoDetalleId
																			,@consecutivo AS despachoConsecutivo
																			,'No existe la ubicacion destino'  AS resultado
															COMMIT TRANSACTION despacho;  
															RETURN
															END

															--SELECT @ubicacionIdOrigen, @ubicacionIdDestino, @ubicacionBahiaHijaId, @ubicacionBahiaId, @ubicacionCodigo,@ubicacionPuertaId
							
															IF OBJECT_ID('tempdb..#despachoRuteoTemp')		IS NOT NULL DROP TABLE #despachoRuteoTemp
															CREATE TABLE #despachoRuteoTemp
																	(
																				 saldoId BIGINT
																				,saldoDetalleId BIGINT
																				,presentacionId BIGINT
																				,contenedorId BIGINT
																				,bodegaLogicaId BIGINT
																				,ubicacionId BIGINT
																				,valorProductoLoteId BIGINT
																				,cantidadManejo DECIMAL(18,4) DEFAULT 0
																				,cantidadEscalar DECIMAL(18,4) DEFAULT 0
																				,ruteoId BIGINT
																				,ruteoDetalleId BIGINT
																				,novedadId BIGINT
																				,pedidoId BIGINT
																				,pedidoDetalleId BIGINT
																				,despachoEstado BIGINT
																				,despachoId BIGINT
																				,despachoDetalleId BIGINT
																	)


									
																--INSERTO EN LA TABLA TEMPORAL LOS INFORMACION SEGUN EL CONTENEDOR
										IF EXISTS(
																SELECT		TOP 1 1
																			FROM [dbo].[SaldosDetalle] sd 	
																			INNER JOIN [dbo].[DespachosDetalle] dd ON  sd.presentacionId = dd.presentacionId
																			AND sd.ubicacionId = dd.ubicacionId AND dd.ubicacionId = @ubicacionIdOrigen AND dd.despachoEstado = 0
																			WHERE sd.saldoDetalleComprometidoManejo > 0
																			)
																					BEGIN

																						INSERT INTO #despachoRuteoTemp (
																							 saldoId 
																							,saldoDetalleId 
																							,presentacionId 
																							,contenedorId 
																							,bodegaLogicaId 
																							,ubicacionId 
																							,valorProductoLoteId 
																							,cantidadManejo 
																							,cantidadEscalar 
																							,ruteoId 
																							,ruteoDetalleId 
																							,novedadId 
																							,pedidoId 
																							,pedidoDetalleId 
																							,despachoId
																							,despachoDetalleId
																							)
																							SELECT		sd.saldoId,
																										sd.saldoDetalleId,
																										sd.presentacionId,
																										sd.contenedorId,
																										sd.bodegaLogicaId,
																										sd.ubicacionId,
																										sd.valorProductoLoteId,
																										sd.saldoDetalleComprometidoManejo,
																										sd.saldoDetalleComprometidoEscalar,
																										dd.ruteoId,
																										dd.ruteoDetalleId,
																										dd.novedadId, 
																										dd.pedidoId,
																										dd.pedidoDetalleId,
																										dd.despachoId,
																										dd.despachoDetalleId
																										FROM [dbo].[SaldosDetalle] sd 	
																										INNER JOIN [dbo].[DespachosDetalle] dd ON   sd.presentacionId = dd.presentacionId	
																																					AND sd.ubicacionId = dd.ubicacionId 
																																					AND dd.ubicacionId = @ubicacionIdOrigen 
																																					AND dd.despachoEstado = 0
																																					AND dd.despachoId = despachoId
																										WHERE sd.saldoDetalleRealManejo > 0


																					END


													ELSE
															BEGIN
																		INSERT INTO #despachoRuteoTemp (
																							 saldoId 
																							,saldoDetalleId 
																							,presentacionId 
																							,contenedorId 
																							,bodegaLogicaId 
																							,ubicacionId 
																							,valorProductoLoteId 
																							,cantidadManejo 
																							,cantidadEscalar 
																							,ruteoId 
																							,ruteoDetalleId 
																							,novedadId 
																							,pedidoId 
																							,pedidoDetalleId 
																							,despachoId
																							,despachoDetalleId
																							)
																							SELECT		sd.saldoId,
																										sd.saldoDetalleId,
																										sd.presentacionId,
																										sd.contenedorId,
																										sd.bodegaLogicaId,
																										sd.ubicacionId,
																										sd.valorProductoLoteId,
																										sd.saldoDetalleComprometidoManejo,
																										sd.saldoDetalleComprometidoEscalar,
																										dd.ruteoId,
																										dd.ruteoDetalleId,
																										dd.novedadId, 
																										dd.pedidoId,
																										dd.pedidoDetalleId,
																										dd.despachoId,
																										dd.despachoDetalleId
																										FROM [dbo].[SaldosDetalle] sd 	
																										INNER JOIN [dbo].[DespachosDetalle] dd ON   sd.presentacionId = dd.presentacionId	
																																					AND sd.ubicacionId = dd.ubicacionActualId 
																																					AND dd.ubicacionActualId = @ubicacionIdOrigen  
																																					AND dd.despachoEstado = 0
																																					AND dd.despachoId = despachoId
																										WHERE sd.saldoDetalleRealManejo > 0

															END

													SELECT TOP 1	 @ruteoId = ruteoId 
																	,@ruteoDetalleId = ruteoDetalleId
													FROM #despachoRuteoTemp										
								
								

																INSERT INTO		[dbo].[TXDespacho]
																			   (
																			   tXDespachoConcepto --1 SALIDA, 2 ENTRADA
																			  ,tXDespachoConsecutivo 
																			  ,novedadId
																			  ,presentacionId      
																			  ,contenedorId
																			  ,valorProductoLoteId
																			  ,ubicacionId
																			  ,bodegaLogicaId
																			  ,tXDespachoRealManejo 
																			  ,tXDespachoRealEscalar     
																			  ,ruteoId
																			  ,ruteoDetalleId     
																			  )

																			  SELECT 1
																			  ,@consecutivo
																			  ,@novedadId
																			  ,dr.presentacionId      
																			  ,dr.contenedorId
																			  ,dr.valorProductoLoteId
																			  ,@ubicacionIdOrigen
																			  ,dr.bodegaLogicaId
																			  ,dr.cantidadManejo 
																			  ,dr.cantidadEscalar      
																			  ,dr.ruteoId
																			  ,dr.ruteoDetalleId   
																			   FROM #despachoRuteoTemp dr																			 
	
																INSERT INTO		[dbo].[TXDespacho]
																			   (
																			   tXDespachoConcepto --1 SALIDA, 2 ENTRADA
																			  ,tXDespachoConsecutivo 
																			  ,novedadId
																			  ,presentacionId      
																			  ,contenedorId
																			  ,valorProductoLoteId
																			  ,ubicacionId
																			  ,bodegaLogicaId
																			  ,tXDespachoRealManejo 
																			  ,tXDespachoRealEscalar     
																			  ,ruteoId
																			  ,ruteoDetalleId     
																			  )

													  SELECT 2
																			  ,@consecutivo
																			  ,@novedadId
																			  ,dr.presentacionId      
																			  ,dr.contenedorId
																			  ,dr.valorProductoLoteId
																			  ,@ubicacionIdDestino
																			  ,dr.bodegaLogicaId
																			  ,dr.cantidadManejo 
																			  ,dr.cantidadEscalar      
																			  ,dr.ruteoId
																			  ,dr.ruteoDetalleId   
																			  FROM #despachoRuteoTemp dr			
												

													 EXEC [dbo].[SP_UPDATE_TxDespachoSequence] @ruteoId, @ruteoDetalleId, @ubicacionIdOrigen, @ubicacionIdDestino


													  UPDATE [dbo].[DespachosDetalle]
															 SET ubicacionActualId = @ubicacionIdDestino
															 WHERE despachoId = @despachoId 
															 AND   despachoDetalleId = @despachoDetalleId 
															 AND   ruteoId = @ruteoId 
															 AND   ruteoDetalleId = @ruteoDetalleId

															 IF(@ubicacionPuertaId IS NOT NULL OR @ubicacionPuertaId NOT LIKE '')
																	 BEGIN 
																			 UPDATE [dbo].[DespachosDetalle]
																			 SET despachoEstado = 1
																			 WHERE despachoId = @despachoId 
																			 AND despachoDetalleId = @despachoDetalleId 
																			 AND ruteoId = @ruteoId 
																			 AND ruteoDetalleId = @ruteoDetalleId

																	 END


																				-- SALDODETALLE EN LA UBICACION ORIGEN
																				UPDATE [dbo].[SaldosDetalle]
																				SET saldoDetalleComprometidoManejo = saldoDetalleComprometidoManejo - dr.cantidadManejo,
																				saldoDetalleComprometidoEscalar = saldoDetalleComprometidoEscalar - dr.cantidadEscalar,
																				saldoDetalleRealManejo = saldoDetalleRealManejo - dr.cantidadManejo,
																				saldoDetalleRealEscalar = saldoDetalleRealEscalar - dr.cantidadEscalar
																				FROM #despachoRuteoTemp dr
																				WHERE  dr.saldoId = [dbo].[SaldosDetalle].saldoId AND dr.saldoDetalleId = [dbo].[SaldosDetalle].saldoDetalleId  
																				AND [dbo].[SaldosDetalle].saldoDetalleComprometidoManejo >= dr.cantidadManejo


																				DELETE sd FROM [dbo].[SaldosDetalle] sd												
																				INNER JOIN #despachoRuteoTemp dr ON sd.saldoDetalleId = dr.saldoDetalleId AND sd.saldoId = dr.saldoId
																				WHERE  sd.saldoDetalleRealManejo = 0

																				-- INSERTO EN LA UBICACION DESTINO
																				INSERT INTO [dbo].[SaldosDetalle] ( saldoId
																												  ,presentacionId
																												  ,contenedorId
																												  ,valorProductoLoteId
																												  ,ubicacionId
																												  ,bodegaLogicaId																				  
																												  ,saldoDetalleRealManejo												 
																												  ,saldoDetalleRealEscalar
																												  ,saldoDetalleComprometidoManejo
																												  ,saldoDetalleComprometidoEscalar
																												  )
																					SELECT	dr.saldoId, 
																						dr.presentacionId, 
																						dr.contenedorId, 
																						dr.valorProductoLoteId, 
																						@ubicacionIdDestino,
																						dr.bodegaLogicaId,
																						dr.cantidadManejo,
																						dr.cantidadEscalar,
																						dr.cantidadManejo,
																						dr.cantidadEscalar	
																				FROM #despachoRuteoTemp dr	


													 SELECT @despachoId AS despachoId,  @despachoDetalleId AS despachoDetalleId ,@consecutivo AS despachoConsecutivo, ''  AS resultado
					


								COMMIT TRANSACTION despacho
															END TRY

															BEGIN CATCH
							
																			IF (XACT_STATE()) = -1  
																			BEGIN  
																				PRINT  
																					N'The transaction is in an uncommittable state.' +  
																					'Rolling back transaction.'  
																				ROLLBACK TRANSACTION despacho;  
																			END;  
  
																			-- Test whether the transaction is committable.  
																			IF (XACT_STATE()) = 1  
																			BEGIN  
																				PRINT  
																					N'The transaction is committable.' +  
																					'Committing transaction.'  
																				COMMIT TRANSACTION despacho;     
																			END;  

															END CATCH
															END

GO
/****** Object:  StoredProcedure [dbo].[SP_SET_PackingRuteo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_SET_PackingRuteo](@usuarioId AS BIGINT, @ruteoDetalleId AS BIGINT, @novedadId AS BIGINT, @novedadAccionId AS BIGINT, @codigoUbicacionBahia AS VARCHAR(50))

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION packing

			
							SET DATEFORMAT YMD


DECLARE @usuarioUser VARCHAR(50)
DECLARE @tagUbicacionIdOrigen VARCHAR(50)
DECLARE @tagContenedorPadre VARCHAR(50)
DECLARE @contenedorPadreId BIGINT 
DECLARE @ubicacionIdOrigen BIGINT
DECLARE @ubicacionBahiaId BIGINT
DECLARE @ruteoId BIGINT
DECLARE @pedidoId BIGINT
DECLARE @ubicacionBahiaHijaId BIGINT
DECLARE @despachoId BIGINT
DECLARE @documentoId BIGINT
DECLARE @packingId BIGINT
DECLARE @ubicacionDestinoId BIGINT
DECLARE @contenedorPadreAuxId BIGINT
SET @novedadId = CASE WHEN @novedadId IS NULL OR @novedadId LIKE  '' OR @novedadId = 0 THEN 1 ELSE @novedadId END
SELECT @usuarioUser = usuarioUser FROM [dbo].[Usuarios] WHERE usuarioId = @usuarioId

--SELECT @tagContenedorPadre =  RFIDTagEPC FROM [dbo].[RFIDTag] WHERE RFIDTagMaquina = @usuarioUser AND RFIDTagTipo_EPC LIKE 'Contenedor'
--SELECT @tagUbicacionIdOrigen =  RFIDTagEPC FROM [dbo].[RFIDTag] WHERE RFIDTagMaquina = @usuarioUser AND RFIDTagTipo_EPC LIKE 'Ubicacion'


SELECT TOP 1 @contenedorPadreId  = contenedorPadreId FROM [dbo].[PackingDetalle] pd 
INNER JOIN SaldosDetalle sd ON pd.ubicacionMedioId = sd.ubicacionId 
INNER JOIN Contenedores c ON sd.contenedorId = c.contenedorId
WHERE pd.ruteoDetalleId = @ruteoDetalleId 

IF (@codigoUbicacionBahia IS NOT NULL OR  @codigoUbicacionBahia NOT LIKE '')
BEGIN
	SELECT TOP 1 @ubicacionBahiaHijaId = ubicacionId FROM [dbo].[Ubicaciones] WHERE ubicacionCodigo LIKE @codigoUbicacionBahia

	 IF EXISTS( SELECT 1 FROM SaldosDetalle WHERE ubicacionId=@ubicacionBahiaHijaId AND saldoDetalleRealEscalar>0)
		BEGIN
			SELECT 'La ubicación ya tiene saldo'
			ROLLBACK TRANSACTION packing;
			RETURN
		END
END

								IF @contenedorPadreId IS NULL BEGIN 

							SELECT 'No existe el contenedor asignado al usuario'
							ROLLBACK TRANSACTION packing;
							RETURN
							END
						


							SELECT TOP(1)   @ubicacionIdOrigen = ub.ubicacionId
							FROM [dbo].[Usuarios] u
							INNER JOIN [dbo].[Ubicaciones] ub ON ub.ubicacionCodigo  LIKE  u.usuarioIdentificacion
							WHERE u.usuarioId = @usuarioId 
							IF @ubicacionIdOrigen IS NULL BEGIN 
							SELECT 'No existe la ubicacion origen capturada'
							ROLLBACK TRANSACTION packing;
							RETURN
							END

						
							--SELECT  @ubicacionBahiaId , @ubicacionBahiaHijaId, @ubicacionIdOrigen, @contenedorPadreId
							
							IF OBJECT_ID('tempdb..#packingRuteoTemp')		IS NOT NULL DROP TABLE #packingRuteoTemp
							CREATE TABLE #packingRuteoTemp
									(
												 saldoId BIGINT
												,saldoDetalleId BIGINT
												,presentacionId BIGINT
												,contenedorId BIGINT
												,bodegaLogicaId BIGINT
												,ubicacionId BIGINT
												,valorProductoLoteId BIGINT
												,cantidadManejo DECIMAL(18,4) DEFAULT 0
												,cantidadEscalar DECIMAL(18,4) DEFAULT 0
												,ruteoId BIGINT
												,ruteoDetalleId BIGINT
												,novedadId BIGINT
												,pedidoId BIGINT
												,pedidoDetalleId BIGINT
												,packingEstado BIGINT
												,packingId BIGINT
									)

								;WITH ContenedoresByParentId(contenedorId
									  ,contenedorCodigo
									  ,contenedorPadreId
									  ,tipoContenedorId
									  ,tipoContenedorDescripcion
									  ) AS (
	  
									  SELECT c.contenedorId
									  ,c.contenedorCodigo
									  ,c.contenedorPadreId
									  ,c.tipoContenedorId
									  ,tc.tipoContenedorDescripcion 
									  FROM [dbo].[Contenedores] c
									  INNER JOIN [dbo].[TiposContenedores] tc ON c.tipocontenedorId = tc.tipoContenedorId
									  WHERE contenedorPadreId = @contenedorPadreId
	  	  
									  )

								
									

								----INSERTO EN LA TABLA TEMPORAL LOS INFORMACION SEGUN EL CONTENEDOR
								INSERT INTO #packingRuteoTemp (
												 saldoId 
												,saldoDetalleId 
												,presentacionId 
												,contenedorId 
												,bodegaLogicaId 
												,ubicacionId 
												,valorProductoLoteId 
												,cantidadManejo 
												,cantidadEscalar 
												,ruteoId 
												,ruteoDetalleId 
												,novedadId 
												,pedidoId 
												,pedidoDetalleId 
												,packingId
												)
								SELECT		sd.saldoId,
											sd.saldoDetalleId,
											sd.presentacionId,
											sd.contenedorId,
											sd.bodegaLogicaId,
											sd.ubicacionId,
											sd.valorProductoLoteId,
											sd.saldoDetalleRealManejo,
											sd.saldoDetalleRealEscalar,
											pr.ruteoId,
											pr.ruteoDetalleId,
											pr.novedadId, 
											pr.pedidoId,
											pr.pedidoDetalleId,
											pr.packingId
											FROM ContenedoresByParentId cp
											INNER JOIN [dbo].[SaldosDetalle] sd ON  cp.contenedorId = sd.contenedorId AND sd.saldoDetalleRealManejo > 0	AND sd.ubicacionId = @ubicacionIdOrigen
											INNER JOIN [dbo].[RuteosDetalle] rd ON  sd.presentacionId = rd.presentacionId
																				AND sd.valorProductoLoteId = rd.valorProductoLoteId
																				AND sd.bodegaLogicaId = rd.bodegaLogicaId
																				
											INNER JOIN [dbo].[PackingDetalle] pr ON  rd.presentacionId = pr.presentacionId	
																				AND rd.ruteoDetalleId = pr.ruteoDetalleId AND rd.ruteoId = pr.ruteoId 	AND sd.ubicacionId = @ubicacionIdOrigen
																				AND pr.packingEstado = 0
										

									--SELECT * FROM 	#packingRuteoTemp
									--ROLLBACK TRANSACTION packing;
									--RETURN
										SELECT TOP 1 @ruteoId = ruteoId FROM  #packingRuteoTemp


								SELECT TOP 1  @ubicacionBahiaId=bahiaId FROM RuteosPedidos WHERE ruteoId = @ruteoId --AND pedidoId = 74
							
							--SELECT TOP(1)   @ubicacionBahiaHijaId = ub.ubicacionId
							--FROM [dbo].[Ubicaciones] ub 
							--WHERE ub.ubicacionId  =  @ubicacionBahiaHijaId
							
							IF @ubicacionBahiaHijaId IS NULL BEGIN 

							SELECT 'No existe la ubicacion destino'
							ROLLBACK TRANSACTION packing;
							RETURN
							END
							
										
												

												/****** Script for SelectTopNRows command from SSMS  ******/
						DECLARE @consecutivo INT = 0
					
					SELECT TOP 1 @packingId = packingId FROM #packingRuteoTemp

					IF(@packingId IS NULL)BEGIN 

							SELECT 'Error al capturar el packingId'
							ROLLBACK TRANSACTION packing;
							RETURN
							END
						
						SELECT @consecutivo =	packingConsecutivo FROM [dbo].[Packing] WHERE packingId = @packingId	


						INSERT INTO  [dbo].[TXPacking]
					   (tXPackingConcepto --1 SALIDA, 2 ENTRADA
					  ,tXPackingConsecutivo 
					  ,novedadId
					  ,presentacionId      
					  ,contenedorId
					  ,valorProductoLoteId
					  ,ubicacionId
					  ,bodegaLogicaId
					  ,tXPackingRealManejo 
					  ,tXPackingRealEscalar     
					  ,ruteoId
					  ,ruteoDetalleId     
					  )

					  SELECT 1
					  ,@consecutivo
					  ,@novedadId
					  ,pr.presentacionId      
					  ,pr.contenedorId
					  ,pr.valorProductoLoteId
					  ,pr.ubicacionId
					  ,pr.bodegaLogicaId
					  ,pr.cantidadManejo 
					  ,pr.cantidadEscalar      
					  ,pr.ruteoId
					  ,pr.ruteoDetalleId   
					  FROM #packingRuteoTemp pr
					  --FROM [dbo].[SaldosDetalle] sd
					  --INNER JOIN #packingRuteoTemp pr ON pr.saldoId = sd.saldoId AND pr.saldoDetalleId = sd.saldoDetalleId
	
						INSERT INTO  [dbo].[TXPacking]
					   (tXPackingConcepto --1 SALIDA, 2 ENTRADA
					  ,tXPackingConsecutivo -- por el momento quemado
					  ,presentacionId      
					  ,contenedorId
					  ,valorProductoLoteId
					  ,ubicacionId
					  ,bodegaLogicaId
					  ,tXPackingRealManejo 
					  ,tXPackingRealEscalar     
					  ,ruteoId
					  ,ruteoDetalleId
					  
					  )

					  SELECT 2
					  ,@consecutivo
					  ,pr.presentacionId      
					  ,pr.contenedorId
					  ,pr.valorProductoLoteId
					  ,@ubicacionBahiaHijaId
					  ,pr.bodegaLogicaId
					  ,pr.cantidadManejo 
					  ,pr.cantidadEscalar      
					  ,pr.ruteoId
					  ,pr.ruteoDetalleId 
					  FROM #packingRuteoTemp pr
					  --FROM [dbo].[SaldosDetalle] sd
					  --INNER JOIN #packingRuteoTemp pr ON pr.saldoId = sd.saldoId AND pr.saldoDetalleId = sd.saldoDetalleId
							

							

						
					SELECT TOP(1) 	@ruteoId = pr.ruteoid
					FROM #packingRuteoTemp pr WHERE  pr.ruteoDetalleId = @ruteoDetalleId

						SELECT TOP 1 @pedidoId = rp.pedidoId 
								
						FROM [dbo].[RuteosPedidos] rp 
						INNER JOIN [dbo].[PedidosDetalle] pd ON rp.pedidoId =  pd.pedidoId
						INNER JOIN #packingRuteoTemp  p  ON pd.presentacionId = p.presentacionId 
						WHERE rp.ruteoId = @ruteoId



						



					EXEC	[dbo].[SP_UPDATE_TxPackingSequence] @ruteoId, @ruteoDetalleId

					EXEC	[dbo].[SP_INSERT_Despacho] @usuarioId, @documentoId, @despachoId = @despachoId OUTPUT
									   				
					
					--SELECT @ruteoId, @packingId, @pedidoId

					
				
				 ;WITH DespachoItem (despachoId,despachoDetalleCantTotal,despachoDetalleCantSolicitada,
						despachoDetalleCantPreparada,despachoDetalleCantNovedad,ubicacionId,presentacionId,RuteoId,
						RuteoDetalleId,novedadId,pedidoId,pedidoDetalleId, despachoEstado)
						AS (
				  SELECT			@despachoId
								  ,rd.ruteoDetalleCantidad
								  ,rd.ruteoDetalleCantRequerida
								  ,rd.ruteoDetalleCantidad
								  ,0
								  ,@ubicacionBahiaHijaId, 
								  rd.presentacionId,
								  rd.ruteoId,
								  rd.ruteoDetalleId,
								  ISNULL(@novedadId,1),
								  rp.pedidoId,
								  pd.pedidoDetalleId,
								  0
				  FROM  #packingRuteoTemp pr 
				  INNER JOIN [dbo].[RuteosDetalle]	rd	ON	pr.ruteoDetalleId = rd.ruteoDetalleId 
															AND pr.ruteoId = rd.ruteoId
				  INNER JOIN [dbo].[RuteosPedidos]	rp	ON	rd.ruteoId = rp.ruteoId 
															AND rp.pedidoId = @pedidoId
				  LEFT JOIN [dbo].[PedidosDetalle] pd	ON	rp.pedidoId = pd.pedidoId 
															AND rd.presentacionId = pd.presentacionId
				 )

						INSERT INTO [dbo].[DespachosDetalle] (
																			   [despachoId]																			
																			  ,[despachoDetalleCantTotal]
																			  ,[despachoDetalleCantSolicitada]
																			  ,[despachoDetalleCantPreparada]
																			  ,[despachoDetalleCantNovedad]
																			  ,[ubicacionId]
																			  ,[presentacionId]
																			  ,[ruteoId]
																			  ,[ruteoDetalleId]
																			  ,[novedadId]
																			  ,[pedidoId]
																			  ,[pedidoDetalleId]
																			  ,[despachoEstado]
																			)
						
						SELECT				 despachoId
											,despachoDetalleCantTotal
											,despachoDetalleCantSolicitada
											,despachoDetalleCantPreparada
											,despachoDetalleCantNovedad
											,ubicacionId
											,presentacionId
											,RuteoId
											,RuteoDetalleId
											,novedadId
											,pedidoId
											,pedidoDetalleId
											,despachoEstado 
						FROM				despachoItem
						GROUP BY			 despachoId
											,despachoDetalleCantTotal
											,despachoDetalleCantSolicitada
											,despachoDetalleCantPreparada
											,despachoDetalleCantNovedad
											,ubicacionId
											,presentacionId
											,RuteoId
											,RuteoDetalleId
											,novedadId
											,pedidoId
											,pedidoDetalleId
											,despachoEstado

					
					
					
					
					UPDATE [dbo].[Packing]
					SET [packingEstado] = 1 --estado packing
					WHERE packingId = @packingId


					UPDATE [dbo].[PackingDetalle]
					SET [packingEstado] = 1 --estado packing
					WHERE packingId = @packingId

						--ACTUALIZO EL SALDODETALLE EN LA UBICACION ORIGEN
												UPDATE [dbo].[SaldosDetalle]
												SET saldoDetalleComprometidoManejo = saldoDetalleComprometidoManejo - pr.cantidadManejo,
												saldoDetalleComprometidoEscalar = saldoDetalleComprometidoEscalar - pr.cantidadEscalar,
												saldoDetalleRealManejo = saldoDetalleRealManejo - pr.cantidadManejo,
												saldoDetalleRealEscalar = saldoDetalleRealEscalar - pr.cantidadEscalar
												FROM #packingRuteoTemp pr
												WHERE  pr.saldoId = [dbo].[SaldosDetalle].saldoId AND pr.saldoDetalleId = [dbo].[SaldosDetalle].saldoDetalleId  
												AND [dbo].[SaldosDetalle].saldoDetalleRealManejo > 0


												DELETE sd FROM [dbo].[SaldosDetalle] sd												
												INNER JOIN #packingRuteoTemp pr ON sd.saldoDetalleId = pr.saldoDetalleId AND sd.saldoId = pr.saldoId
												WHERE  sd.saldoDetalleRealManejo = 0

												-- INSERTO EN LA UBICACION DESTINO
												INSERT INTO [dbo].[SaldosDetalle] ( saldoId
																				  ,presentacionId
																				  ,contenedorId
																				  ,valorProductoLoteId
																				  ,ubicacionId
																				  ,bodegaLogicaId																				  
																				  ,saldoDetalleRealManejo												 
																				  ,saldoDetalleRealEscalar
																				  ,saldoDetalleComprometidoManejo
																				  ,saldoDetalleComprometidoEscalar
																				  )
				
				
												SELECT	pr.saldoId, 
														pr.presentacionId, 
														pr.contenedorId, 
														pr.valorProductoLoteId, 
														@ubicacionBahiaHijaId,
														pr.bodegaLogicaId,
														pr.cantidadManejo,
														pr.cantidadEscalar,
														pr.cantidadManejo,
														pr.cantidadEscalar	
												FROM #packingRuteoTemp pr		

												


					SELECT despachoId, despachoConsecutivo FROM [dbo].[Despachos] WHERE despachoId = @despachoId


COMMIT TRANSACTION packing
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION packing;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION packing;     
											END;  

							END CATCH
							END
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_PickingRuteo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC   [dbo].[SP_SET_PickingRuteo] 1,'',  '0201041606010201',1,0,67
CREATE PROCEDURE  [dbo].[SP_SET_PickingRuteo]	(
												 @ruteoId BIGINT
												,@contenedorTag AS VARCHAR(50)
												,@ubicacionTag AS VARCHAR(50)
												,@novedadId  AS BIGINT
												,@novedadAccionId AS BIGINT
												,@usuarioId AS BIGINT
												)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT OFF
							BEGIN TRY  
							BEGIN TRANSACTION picking

			
							SET DATEFORMAT YMD

		
		DECLARE @ruteoDetalleId BIGINT
		DECLARE @contenedorPadreId BIGINT 
		DECLARE @ubicacionIdOrigen BIGINT
		DECLARE @ubicacionIdDestino BIGINT 
		DECLARE @rfIDTagUbicacion VARCHAR(50) 
		DECLARE @rfIDTagContenedor VARCHAR(50) 
		DECLARE @packingId BIGINT
		DECLARE @pickingParentId BIGINT
		DECLARE @documentoId BIGINT 
		DECLARE @pedidoId BIGINT
		DECLARE @packingExist BIGINT
		DECLARE @packingDetalleExist BIGINT
		DECLARE @ruteoIdExist BIGINT
		DECLARE @ruteoIdDetalleExist BIGINT
		DECLARE @novedadAccion VARCHAR(20)
		DECLARE @estadoRuteoDetalle INT
		
		SET @novedadId = CASE WHEN @novedadId = 0 THEN 1 ELSE @novedadId END
		SELECT @novedadAccion = na.novedadAccion FROM [dbo].[Novedades] n 
											INNER JOIN [dbo].[NovedadesAcciones] na ON n.novedadAccionId = na.novedadAccionId
											WHERE n.novedadId = @novedadId
	

							
							SELECT TOP(1)  @contenedorPadreId = c.contenedorId
							FROM  [dbo].[Contenedores] c WHERE    '%'+c.contenedorCodigo   LIKE @contenedorTag
							
								SELECT TOP(1)   @ubicacionIdDestino = ub.ubicacionId
							FROM [dbo].[Usuarios] u
							INNER JOIN [dbo].[Ubicaciones] ub ON ub.ubicacionCodigo  LIKE  u.usuarioIdentificacion
							WHERE u.usuarioId = @usuarioId 

							IF @ubicacionIdDestino IS NULL 
								BEGIN 

										SELECT 'No existe la ubicación destino'  AS resultado
										ROLLBACK TRANSACTION picking;  
										RETURN
								RETURN
							END
							ELSE
							BEGIN
							
							IF EXISTS (	SELECT 1 FROM [dbo].[saldosDetalle] WHERE ubicacionId =@ubicacionIdDestino AND saldoDetalleRealManejo > 0 )
								BEGIN

										SELECT TOP 1 @packingExist = packingId, @packingDetalleExist = packingDetalleId, @ruteoIdExist= ruteoId,@ruteoIdDetalleExist = ruteoDetalleId
										--, @ubicacionCodigoExist = u.ubicacionCodigo
										FROM [dbo].[PackingDetalle] pd
										--INNER JOIN [dbo].[Ubicaciones] u ON pd.ubicacionMedioId = u.ubicacionId
										
										WHERE ubicacionMedioId = @ubicacionIdDestino AND packingEstado = 0
										 SELECT  @packingExist AS packingId, 
										 @packingDetalleExist AS packingDetalleId, @ruteoIdExist AS ruteoId, @ruteoIdDetalleExist AS ruteoDetalleId,
										 0 as estado,
										 'El usuario ya tiene saldo asignado' AS resultado
										 
										 
										 --, @ubicacionCodigoExist AS ubicacionCodigo
										 ROLLBACK TRANSACTION picking;  
										 RETURN

								END



							END





						
							SELECT TOP(1)   @ubicacionIdOrigen = ub.ubicacionId
							FROM  [dbo].[Ubicaciones] ub WHERE  @ubicacionTag LIKE '%'+ ub.ubicacionCodigo     
							
							IF @ubicacionIdOrigen IS NULL BEGIN 
										SELECT 'No existe la ubicación origen capturada'  AS resultado
													ROLLBACK TRANSACTION picking;  
										RETURN
							END
							ELSE 
							BEGIN
											IF @novedadAccion = 'Cancelar' --Novedad ACCION Cancelar
											BEGIN												
												
												SET @estadoRuteoDetalle = 2
												SET @ubicacionIdDestino = @ubicacionIdOrigen
											END
											ELSE IF @novedadAccion = 'Reprocesar' --Novedad ACCION Reprocesar ruteo detalle
											BEGIN
												
											     SET @estadoRuteoDetalle = 2
												 SET @ubicacionIdDestino = @ubicacionIdOrigen
											END
											ELSE IF @novedadAccion = 'Informar'  --Novedad ACCION Informar
											BEGIN
												
												SET @estadoRuteoDetalle = 1
											END
											ELSE  --SIN Novedad ACCION
											BEGIN
												
												SET @estadoRuteoDetalle = 1
											END
								END


							IF OBJECT_ID('tempdb..#pickingRuteoTemp')		IS NOT NULL DROP TABLE #pickingRuteoTemp
									CREATE TABLE #pickingRuteoTemp
									(
												saldoId BIGINT,
												saldoDetalleId BIGINT,
												presentacionId BIGINT,
												contenedorId BIGINT,
												bodegaLogicaId BIGINT,
												ubicacionId BIGINT,
												valorProductoLoteId BIGINT,
												cantidadManejo DECIMAL(18,4) DEFAULT 0,
												cantidadEscalar DECIMAL(18,4) DEFAULT 0,
												ruteoId BIGINT,
												ruteoDetalleId BIGINT
									)

							IF EXISTS (SELECT		1
											FROM [dbo].[Contenedores] c
											INNER JOIN [dbo].[SaldosDetalle] sd ON  c.contenedorId = sd.contenedorId AND saldoDetalleComprometidoManejo > 0
											INNER JOIN [dbo].[RuteosDetalle] rd ON  sd.presentacionId = rd.presentacionId
																				AND sd.valorProductoLoteId = rd.valorProductoLoteId
																				AND sd.bodegaLogicaId = rd.bodegaLogicaId
																				AND sd.ubicacionId = rd.ubicacionId AND rd.ubicacionId = @ubicacionIdOrigen
																				AND rd.ruteoId = @ruteoId
											WHERE c.contenedorPadreId = @contenedorPadreId)  AND @contenedorPadreId IS NOT NULL
											BEGIN
													;WITH ContenedoresByParentId(contenedorId
														  ,contenedorCodigo
														  ,contenedorPadreId
														  ,tipoContenedorId
														  ,tipoContenedorDescripcion
														  ) AS (
	  
														  SELECT c.contenedorId
														  ,c.contenedorCodigo
														  ,c.contenedorPadreId
														  ,c.tipoContenedorId
														  ,tc.tipoContenedorDescripcion 
														  FROM [dbo].[Contenedores] c
														  INNER JOIN [dbo].[TiposContenedores] tc ON c.tipocontenedorId = tc.tipoContenedorId
														  WHERE contenedorPadreId = @contenedorPadreId
	  	  
									  )

								--INSERTO EN LA TABLA TEMPORAL LOS INFORMACION SEGUN EL CONTENEDOR
								INSERT INTO #pickingRuteoTemp (saldoId,
											saldoDetalleId,
											presentacionId,
											contenedorId,
											bodegaLogicaId,
											ubicacionId,
											valorProductoLoteId,
											cantidadManejo,
											cantidadEscalar,
											ruteoId,
											ruteoDetalleId)
								SELECT		sd.saldoId,
											sd.saldoDetalleId,
											sd.presentacionId,
											sd.contenedorId,
											sd.bodegaLogicaId,
											sd.ubicacionId,
											sd.valorProductoLoteId,
											sd.saldoDetalleComprometidoManejo,
											sd.saldoDetalleComprometidoEscalar,
											rd.ruteoId,
											rd.ruteoDetalleId
											FROM ContenedoresByParentId cp
											INNER JOIN [dbo].[SaldosDetalle] sd ON  cp.contenedorId = sd.contenedorId AND sd.saldoDetalleComprometidoManejo > 0
											INNER JOIN [dbo].[RuteosDetalle] rd ON  sd.presentacionId = rd.presentacionId
																				AND sd.valorProductoLoteId = rd.valorProductoLoteId
																				AND sd.bodegaLogicaId = rd.bodegaLogicaId
																				AND sd.ubicacionId = rd.ubicacionId AND rd.ubicacionId = @ubicacionIdOrigen
											
								END
								ELSE IF EXISTS(SELECT		1
												FROM [dbo].[SaldosDetalle] sd 
												INNER JOIN [dbo].[RuteosDetalle] rd ON  sd.presentacionId = rd.presentacionId
																					AND sd.valorProductoLoteId = rd.valorProductoLoteId
																					AND sd.bodegaLogicaId = rd.bodegaLogicaId
																					AND sd.ubicacionId = rd.ubicacionId AND rd.ubicacionId = @ubicacionIdOrigen
												WHERE sd.saldoDetalleComprometidoManejo > 0
											
											) 
											BEGIN

												--INSERTO EN LA TABLA TEMPORAL LOS INFORMACION SEGUN EL CONTENEDOR
								INSERT INTO #pickingRuteoTemp (saldoId,
											saldoDetalleId,
											presentacionId,
											contenedorId,
											bodegaLogicaId,
											ubicacionId,
											valorProductoLoteId,
											cantidadManejo,
											cantidadEscalar,
											ruteoId,
											ruteoDetalleId)
								SELECT		sd.saldoId,
											sd.saldoDetalleId,
											sd.presentacionId,
											sd.contenedorId,
											sd.bodegaLogicaId,
											sd.ubicacionId,
											sd.valorProductoLoteId,
											sd.saldoDetalleComprometidoManejo,
											sd.saldoDetalleComprometidoEscalar,
											rd.ruteoId,
											rd.ruteoDetalleId
											FROM  [dbo].[SaldosDetalle] sd 
											INNER JOIN [dbo].[RuteosDetalle] rd ON  sd.presentacionId = rd.presentacionId
																				AND sd.valorProductoLoteId = rd.valorProductoLoteId
																				AND sd.bodegaLogicaId = rd.bodegaLogicaId
																				AND sd.ubicacionId = rd.ubicacionId AND rd.ubicacionId = @ubicacionIdOrigen
																				AND rd.ruteoId = @ruteoId
											WHERE sd.saldoDetalleComprometidoManejo > 0


											END

											ELSE
											BEGIN
														-- se debe insertar novedad

														SELECT 'la ubicación origen no pertenece al ruteo seleccionado'  AS resultado
														ROLLBACK TRANSACTION picking;  
														RETURN

											END


												/****** Script for SelectTopNRows command from SSMS  ******/
						DECLARE @consecutivo INT = 0
						DECLARE @documentoAuxId BIGINT = 0
						
						SELECT				TOP 1 @documentoAuxId	=  d.documentoId 
						FROM				[dbo].[Documentos] AS d
						WHERE				d.documentoCodigo='PICK'
						
					
											--SELECT @documentoAuxId				

															--Se consulta la secuencia actual del consecutivo 														
															SELECT TOP 1 @consecutivo =  DocumentoContador + 1
															FROM [dbo].[Documentos] 
															WHERE documentoId = @documentoAuxId
																--SELECT @consecutivo	
															--Se actualiza el consecutivo 
															IF @consecutivo IS NULL OR @consecutivo = 0
															BEGIN 
																SELECT  'No se ha configurado consecutivo para este documento'  AS resultado
																ROLLBACK TRANSACTION picking;  
																RETURN
															END
															
															
															UPDATE [dbo].[Documentos]
															SET DocumentoContador = @consecutivo			
															WHERE DocumentoId = @documentoAuxId


															SELECT TOP(1) 	@ruteoId = pr.ruteoid, @ruteoDetalleId = pr.ruteoDetalleId
															FROM [dbo].[SaldosDetalle] sd
														INNER JOIN #pickingRuteoTemp pr ON pr.saldoId = sd.saldoId AND pr.saldoDetalleId = sd.saldoDetalleId

					IF @estadoRuteoDetalle = 1
							BEGIN							
											INSERT INTO  [dbo].[TXPicking]
										   (tXPickingConcepto --1 SALIDA, 2 ENTRADA
										  ,tXPickingConsecutivo 
										  ,novedadId
										  ,presentacionId      
										  ,contenedorId
										  ,valorProductoLoteId
										  ,ubicacionId
										  ,bodegaLogicaId
										  ,tXPickingRealManejo 
										  ,tXPickingRealEscalar     
										  ,ruteoId
										  ,ruteoDetalleId     
										  )

										  SELECT 1
										  ,@consecutivo
										  ,@novedadId
										  ,pr.presentacionId      
										  ,pr.contenedorId
										  ,pr.valorProductoLoteId
										  ,pr.ubicacionId
										  ,pr.bodegaLogicaId
										  ,pr.cantidadManejo 
										  ,pr.cantidadEscalar      
										  ,pr.ruteoId
										  ,pr.ruteoDetalleId   
										  FROM #pickingRuteoTemp pr
										  --FROM [dbo].[SaldosDetalle] sd
										  --INNER JOIN #pickingRuteoTemp pr ON pr.saldoId = sd.saldoId AND pr.saldoDetalleId = sd.saldoDetalleId
	
											INSERT INTO  [dbo].[TXPicking]
										   (tXPickingConcepto --1 SALIDA, 2 ENTRADA
										  ,tXPickingConsecutivo -- por el momento quemado
										  ,novedadId
										  ,presentacionId      
										  ,contenedorId
										  ,valorProductoLoteId
										  ,ubicacionId
										  ,bodegaLogicaId
										  ,tXPickingRealManejo 
										  ,tXPickingRealEscalar     
										  ,ruteoId
										  ,ruteoDetalleId
					  
										  )

										  SELECT 2
										  ,@consecutivo
										  ,@novedadId
										  ,pr.presentacionId      
										  ,pr.contenedorId
										  ,pr.valorProductoLoteId
										  ,@ubicacionIdDestino
										  ,pr.bodegaLogicaId
										  ,pr.cantidadManejo 
										  ,pr.cantidadEscalar      
										  ,pr.ruteoId
										  ,pr.ruteoDetalleId 
										  FROM #pickingRuteoTemp pr
										  --FROM [dbo].[SaldosDetalle] sd
										  --INNER JOIN #pickingRuteoTemp pr ON pr.saldoId = sd.saldoId AND pr.saldoDetalleId = sd.saldoDetalleId



										  
								EXEC	[dbo].[SP_UPDATE_TxPickingSequence] @ruteoId, @ruteoDetalleId
								


						END

					ELSE 
							BEGIN								

										 INSERT INTO  [dbo].[TXPicking]
										   (tXPickingConcepto --99 CANCELAR
										  ,tXPickingConsecutivo -- por el momento quemado
										  ,novedadId
										  ,presentacionId      
										  ,contenedorId
										  ,valorProductoLoteId
										  ,ubicacionId
										  ,bodegaLogicaId
										  ,tXPickingRealManejo 
										  ,tXPickingRealEscalar     
										  ,ruteoId
										  ,ruteoDetalleId
					  
										  )

										  SELECT 99
										  ,@consecutivo
										  ,@novedadId
										  ,pr.presentacionId      
										  ,pr.contenedorId
										  ,pr.valorProductoLoteId
										  ,@ubicacionIdOrigen
										  ,pr.bodegaLogicaId
										  ,pr.cantidadManejo 
										  ,pr.cantidadEscalar      
										  ,pr.ruteoId
										  ,pr.ruteoDetalleId 
										  FROM #pickingRuteoTemp pr





								END
						

						
					 EXEC	[dbo].[SP_INSERT_Packing] @usuarioId, @documentoId, @packingId = @packingId OUTPUT

					SELECT TOP 1 @pedidoId = rp.pedidoId 								
						FROM [dbo].[RuteosPedidos] rp 
						INNER JOIN [dbo].[PedidosDetalle] pd ON rp.pedidoId =  pd.pedidoId
						INNER JOIN #pickingRuteoTemp  p  ON pd.presentacionId = p.presentacionId 
						WHERE rp.ruteoId = @ruteoId

					 --SELECT * FROm #pickingRuteoTemp

				
				 ;WITH PackingItem (packingId,packingDetalleCantTotal,packingDetalleCantSolicitada,
						packingDetalleCantPreparada,packingDetalleCantNovedad,ubicacionMedioId,presentacionId,RuteoId,
						RuteoDetalleId,novedadId,pedidoId,
						--pedidoDetalleId,
						packingEstado)
						AS (
				  SELECT			@packingId
								  ,rd.ruteoDetalleCantidad
								  ,rd.ruteoDetalleCantRequerida
								  ,rd.ruteoDetalleCantidad
								  ,0
								  ,@ubicacionIdDestino, 
								  rd.presentacionId,
								  @ruteoId,
								  @ruteoDetalleId,
								  ISNULL(@novedadId,1),
								  @pedidoId,
								  --pd.pedidoDetalleId,
								  CASE WHEN @estadoRuteoDetalle = 1 THEN 0
								  ELSE @estadoRuteoDetalle END
				  FROM  #pickingRuteoTemp pr 
				  INNER JOIN [dbo].[RuteosDetalle]	rd	ON	pr.ruteoDetalleId = rd.ruteoDetalleId 															
				  --INNER JOIN [dbo].[RuteosPedidos]	rp	ON	 rd.ruteoId = rp.ruteoId AND rp.pedidoId  = @pedidoId
				  --LEFT JOIN [dbo].[PedidosDetalle]  pd	ON	 rd.presentacionId = pd.presentacionId
				 )


				

						INSERT INTO [dbo].[PackingDetalle] (
																				 [packingId]
																				,packingDetalleCantTotal
																				,[packingDetalleCantSolicitada]
																				,[packingDetalleCantPreparada]
																				,[packingDetalleCantNovedad]
																				,[ubicacionMedioId]
																				,[presentacionId]
																				,[RuteoId]
																				,[RuteoDetalleId]
																				,[novedadId]
																				,[pedidoId]
																				--,[pedidoDetalleId]
																				,[packingEstado]
																			)
						
						SELECT				 @packingId
											,packingDetalleCantTotal
											,packingDetalleCantSolicitada
											,packingDetalleCantPreparada
											,packingDetalleCantNovedad
											,ubicacionMedioId
											,presentacionId
											,RuteoId
											,RuteoDetalleId
											,novedadId
											,pedidoId
											--,pedidoDetalleId
											,packingEstado 
						FROM				 PackingItem
						GROUP BY			 packingId
											,packingDetalleCantTotal
											,packingDetalleCantSolicitada
											,packingDetalleCantPreparada
											,packingDetalleCantNovedad
											,ubicacionMedioId
											,presentacionId
											,RuteoId
											,RuteoDetalleId
											,novedadId
											,pedidoId
											--,pedidoDetalleId
											,packingEstado


										UPDATE [dbo].[RuteosDetalle] 											
										SET ruteoDetalleEstado = @estadoRuteoDetalle
										FROM #pickingRuteoTemp p 
										WHERE  p.ruteoId = [dbo].[RuteosDetalle].ruteoId
										AND p.ruteoDetalleId = [dbo].[RuteosDetalle].ruteoDetalleId

									
										IF @estadoRuteoDetalle = 1
												BEGIN
										--ACTUALIZO EL SALDODETALLE EN LA UBICACION ORIGEN
																UPDATE [dbo].[SaldosDetalle]
																SET saldoDetalleComprometidoManejo = saldoDetalleComprometidoManejo - cantidadManejo,
																saldoDetalleComprometidoEscalar = saldoDetalleComprometidoEscalar - cantidadEscalar,
																saldoDetalleRealManejo = saldoDetalleRealManejo - cantidadManejo,
																saldoDetalleRealEscalar = saldoDetalleRealEscalar - cantidadEscalar
																FROM #pickingRuteoTemp pr
																WHERE  pr.saldoId = [dbo].[SaldosDetalle].saldoId AND pr.saldoDetalleId = [dbo].[SaldosDetalle].saldoDetalleId  
																AND [dbo].[SaldosDetalle].saldoDetalleComprometidoManejo >= cantidadManejo

																DELETE sd FROM [dbo].[SaldosDetalle] sd												
																INNER JOIN #pickingRuteoTemp pr ON sd.saldoDetalleId = pr.saldoDetalleId AND sd.saldoId = pr.saldoId
																WHERE  sd.saldoDetalleRealManejo = 0

																---- INSERTO EN LA UBICACION DESTINO
																INSERT INTO [dbo].[SaldosDetalle] ( saldoId
																								  ,presentacionId
																								  ,contenedorId
																								  ,valorProductoLoteId
																								  ,ubicacionId
																								  ,bodegaLogicaId																				  
																								  ,saldoDetalleRealManejo												 
																								  ,saldoDetalleRealEscalar
																								  ,saldoDetalleComprometidoManejo
																								  ,saldoDetalleComprometidoEscalar
																								  )
				
				
																SELECT	pr.saldoId, 
																		pr.presentacionId, 
																		pr.contenedorId, 
																		pr.valorProductoLoteId, 
																		@ubicacionIdDestino,
																		pr.bodegaLogicaId,
																		pr.cantidadManejo,
																		pr.cantidadEscalar,
																		pr.cantidadManejo,
																		pr.cantidadEscalar	
																FROM #pickingRuteoTemp pr	



																							
									SELECT 
									p.packingId AS packingId, 
									p.packingConsecutivo AS packingConsecutivo, 
									pd.packingDetalleId AS packingDetalleId, 
									pd.ruteoId AS ruteoId,
									pd.ruteoDetalleId AS ruteoDetalleId,
									@estadoRuteoDetalle AS estado,
									'El proceso se ejecutó correctamente' AS resultado FROM [dbo].[Packing] p
									INNER JOIN [dbo].[PackingDetalle] pd ON p.packingId = pd.packingId WHERE p.packingId = @packingId
												
												END

									ELSE

													BEGIN
													

													

									IF @novedadAccion = 'Cancelar' --Novedad ACCION Cancelar
											BEGIN
											
												SELECT  @ruteoId AS ruteoId, @ruteoDetalleId AS ruteoDetalleId, @estadoRuteoDetalle  AS estado,'El ruteo detalle ha sido cancelado correctamente' AS resultado 
											


											END

											ELSE IF @novedadAccion = 'Reprocesar' --Novedad ACCION Reprocesar ruteo detalle
											BEGIN

											

											
											EXEC [dbo].[SP_SET_ReprocesarRuteoDetalle] @ruteoId, @ubicacionIdOrigen, @usuarioId
											
											SELECT  @ruteoId AS ruteoId, @ruteoDetalleId AS ruteoDetalleId, @estadoRuteoDetalle  AS estado,'El ruteo detalle ha sido reprocesado correctamente' AS resultado 
										
												



											END
											ELSE 
											BEGIN

											SELECT  @ruteoId AS ruteoId, @ruteoDetalleId AS ruteoDetalleId, @estadoRuteoDetalle  AS estado, 'El proceso se ejecutó correctamente' AS resultado --mientras se define la novedad accion informar

											END
																
									
										----DESCOMPROMETO LOS SALDOS
																UPDATE [dbo].[SaldosDetalle]
																SET saldoDetalleComprometidoManejo = saldoDetalleComprometidoManejo - cantidadManejo,
																saldoDetalleComprometidoEscalar = saldoDetalleComprometidoEscalar - cantidadEscalar,
																saldoDetalleDisponibleManejo = saldoDetalleDisponibleManejo + cantidadManejo,
																saldoDetalleDisponibleEscalar = saldoDetalleDisponibleEscalar + cantidadEscalar
																FROM #pickingRuteoTemp pr
																WHERE  pr.saldoId = [dbo].[SaldosDetalle].saldoId AND pr.saldoDetalleId = [dbo].[SaldosDetalle].saldoDetalleId  
																AND [dbo].[SaldosDetalle].saldoDetalleComprometidoManejo >= cantidadManejo




													END




													
															


	COMMIT TRANSACTION picking
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION picking;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION picking;     
											END;  

							END CATCH
							END
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_PickingRuteoPRUEBANOVEDAD]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_SET_PickingRuteoPRUEBANOVEDAD](@contenedorTag AS VARCHAR(50), @ubicacionTag AS VARCHAR(50), @novedadId  AS BIGINT, @novedadAccionId AS BIGINT,@usuarioId AS BIGINT)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION picking

			
							SET DATEFORMAT YMD

		DECLARE @ruteoId BIGINT 
		DECLARE @ruteoDetalleId BIGINT
		DECLARE @contenedorPadreId BIGINT 
		DECLARE @ubicacionIdOrigen BIGINT
		DECLARE @ubicacionIdDestino BIGINT 
		DECLARE @rfIDTagUbicacion VARCHAR(50) 
		DECLARE @rfIDTagContenedor VARCHAR(50) 
		DECLARE @packingId BIGINT
		DECLARE @pickingParentId BIGINT
		DECLARE @documentoId BIGINT 
		DECLARE @pedidoId BIGINT
		DECLARE @packingExist BIGINT
		DECLARE @packingDetalleExist BIGINT
		DECLARE @ruteoIdExist BIGINT
		DECLARE @ruteoIdDetalleExist BIGINT
		DECLARE @novedadAccion VARCHAR(20)
		DECLARE @estadoRuteoDetalle INT




		SET @novedadId = CASE WHEN @novedadId = 0 THEN 1 ELSE @novedadId END
		SELECT @novedadAccion = na.novedadAccion FROM [dbo].[Novedades] n 
											INNER JOIN [dbo].[NovedadesAcciones] na ON n.novedadAccionId = na.novedadAccionId
											WHERE n.novedadId = @novedadId
	

							-- Capturo el contenedor padre segun el tag contenedor capturado RFID
							--SELECT TOP(1)  @contenedorPadreId = c.contenedorId
							--FROM [Pdn_Contegral].[dbo].[RFIDTag] r 
							--INNER JOIN [dbo].[Contenedores] c ON   @contenedorTag LIKE '%'+c.contenedorCodigo  
							--WHERE r.RFIDTagTipo_EPC LIKE 'Contenedor' 
							SELECT TOP(1)  @contenedorPadreId = c.contenedorId
							FROM  [dbo].[Contenedores] c WHERE    '%'+c.contenedorCodigo   LIKE @contenedorTag
							
							SELECT TOP(1)   @ubicacionIdDestino = ub.ubicacionId
							FROM [dbo].[Usuarios] u
							INNER JOIN [dbo].[Ubicaciones] ub ON ub.ubicacionCodigo  LIKE  u.usuarioIdentificacion
							WHERE u.usuarioId = @usuarioId 

							IF @ubicacionIdDestino IS NULL 
								BEGIN 

										SELECT 'No existe la ubicación destino'  AS resultado
										ROLLBACK TRANSACTION picking;  
										RETURN
								RETURN
							END
							ELSE
							BEGIN
							
							IF EXISTS (	SELECT 1 FROM [dbo].[saldosDetalle] WHERE ubicacionId =@ubicacionIdDestino AND saldoDetalleRealManejo > 0 )
								BEGIN

										SELECT TOP 1 @packingExist = packingId, @packingDetalleExist = packingDetalleId, @ruteoIdExist= ruteoId,@ruteoIdDetalleExist = ruteoDetalleId
										--, @ubicacionCodigoExist = u.ubicacionCodigo
										FROM [dbo].[PackingDetalle] pd
										--INNER JOIN [dbo].[Ubicaciones] u ON pd.ubicacionMedioId = u.ubicacionId
										
										WHERE ubicacionMedioId = @ubicacionIdDestino AND packingEstado = 0
										 SELECT 'El usuario ya tiene saldo asignado' AS resultado, @packingExist AS packingId, 
										 @packingDetalleExist AS packingDetalleId, @ruteoIdExist AS ruteoId, @ruteoIdDetalleExist AS ruteoDetalleId
										 
										 
										 --, @ubicacionCodigoExist AS ubicacionCodigo
										 ROLLBACK TRANSACTION picking;  
										 RETURN

								END



							END




							SELECT TOP(1)   @ubicacionIdOrigen = ub.ubicacionId
							FROM  [dbo].[Ubicaciones] ub WHERE  @ubicacionTag LIKE '%'+ ub.ubicacionCodigo     
							
							IF @ubicacionIdOrigen IS NULL BEGIN 
										SELECT 'No existe la ubicación origen capturada'  AS resultado
													ROLLBACK TRANSACTION picking;  
										RETURN
							END
							ELSE 
							BEGIN
											IF @novedadAccion = 'Cancelar' --Novedad ACCION Cancelar
											BEGIN

												


												SET @estadoRuteoDetalle = 2
												SET @ubicacionIdDestino = @ubicacionIdOrigen


											END

											ELSE IF @novedadAccion = 'Reprocesar' --Novedad ACCION Reprocesar ruteo detalle
											BEGIN

											SELECT @novedadAccion

											     SET @estadoRuteoDetalle = 2
												 SET @ubicacionIdDestino = @ubicacionIdOrigen

												 EXEC [dbo].[SP_SET_ReprocesarRuteoDetalle] @ruteoId,@ubicacionIdOrigen, @usuarioId --busco producto con las mismas condiciones y en el orden siguiente sino donde haya




											END
											ELSE IF @novedadAccion = 'Informar'  --Novedad ACCION Informar
											BEGIN

												

													SET @estadoRuteoDetalle = 1

											END
											ELSE  --SIN Novedad ACCION
											BEGIN

												

												SET @estadoRuteoDetalle = 1

											END


SELECT @novedadAccion, @estadoRuteoDetalle

											


							END


							--ROLLBACK TRANSACTION picking;  
							--				RETURN



							SELECT @ubicacionIdDestino
						

							IF OBJECT_ID('tempdb..#pickingRuteoTemp')		IS NOT NULL DROP TABLE #pickingRuteoTemp
									CREATE TABLE #pickingRuteoTemp
									(
												saldoId BIGINT,
												saldoDetalleId BIGINT,
												presentacionId BIGINT,
												contenedorId BIGINT,
												bodegaLogicaId BIGINT,
												ubicacionId BIGINT,
												valorProductoLoteId BIGINT,
												cantidadManejo DECIMAL(18,4) DEFAULT 0,
												cantidadEscalar DECIMAL(18,4) DEFAULT 0,
												ruteoId BIGINT,
												ruteoDetalleId BIGINT
									)

IF EXISTS (SELECT		1
											FROM [dbo].[Contenedores] c
											INNER JOIN [dbo].[SaldosDetalle] sd ON  c.contenedorId = sd.contenedorId AND saldoDetalleComprometidoManejo > 0
											INNER JOIN [dbo].[RuteosDetalle] rd ON  sd.presentacionId = rd.presentacionId
																				AND sd.valorProductoLoteId = rd.valorProductoLoteId
																				AND sd.bodegaLogicaId = rd.bodegaLogicaId
																				AND sd.ubicacionId = rd.ubicacionId AND rd.ubicacionId = @ubicacionIdOrigen
											WHERE c.contenedorPadreId = @contenedorPadreId
											
											)  AND @contenedorPadreId IS NOT NULL
											BEGIN


								;WITH ContenedoresByParentId(contenedorId
									  ,contenedorCodigo
									  ,contenedorPadreId
									  ,tipoContenedorId
									  ,tipoContenedorDescripcion
									  ) AS (
	  
									  SELECT c.contenedorId
									  ,c.contenedorCodigo
									  ,c.contenedorPadreId
									  ,c.tipoContenedorId
									  ,tc.tipoContenedorDescripcion 
									  FROM [dbo].[Contenedores] c
									  INNER JOIN [dbo].[TiposContenedores] tc ON c.tipocontenedorId = tc.tipoContenedorId
									  WHERE contenedorPadreId = @contenedorPadreId
	  	  
									  )

								--INSERTO EN LA TABLA TEMPORAL LOS INFORMACION SEGUN EL CONTENEDOR
								INSERT INTO #pickingRuteoTemp (saldoId,
											saldoDetalleId,
											presentacionId,
											contenedorId,
											bodegaLogicaId,
											ubicacionId,
											valorProductoLoteId,
											cantidadManejo,
											cantidadEscalar,
											ruteoId,
											ruteoDetalleId)
								SELECT		sd.saldoId,
											sd.saldoDetalleId,
											sd.presentacionId,
											sd.contenedorId,
											sd.bodegaLogicaId,
											sd.ubicacionId,
											sd.valorProductoLoteId,
											sd.saldoDetalleComprometidoManejo,
											sd.saldoDetalleComprometidoEscalar,
											rd.ruteoId,
											rd.ruteoDetalleId
											FROM ContenedoresByParentId cp
											INNER JOIN [dbo].[SaldosDetalle] sd ON  cp.contenedorId = sd.contenedorId AND sd.saldoDetalleComprometidoManejo > 0
											INNER JOIN [dbo].[RuteosDetalle] rd ON  sd.presentacionId = rd.presentacionId
																				AND sd.valorProductoLoteId = rd.valorProductoLoteId
																				AND sd.bodegaLogicaId = rd.bodegaLogicaId
																				AND sd.ubicacionId = rd.ubicacionId AND rd.ubicacionId = @ubicacionIdOrigen
											
						END
ELSE IF EXISTS(SELECT		1
											FROM [dbo].[SaldosDetalle] sd 
											INNER JOIN [dbo].[RuteosDetalle] rd ON  sd.presentacionId = rd.presentacionId
																				AND sd.valorProductoLoteId = rd.valorProductoLoteId
																				AND sd.bodegaLogicaId = rd.bodegaLogicaId
																				AND sd.ubicacionId = rd.ubicacionId AND rd.ubicacionId = @ubicacionIdOrigen
											WHERE sd.saldoDetalleComprometidoManejo > 0
											
											) 
											BEGIN

												--INSERTO EN LA TABLA TEMPORAL LOS INFORMACION SEGUN EL CONTENEDOR
								INSERT INTO #pickingRuteoTemp (saldoId,
											saldoDetalleId,
											presentacionId,
											contenedorId,
											bodegaLogicaId,
											ubicacionId,
											valorProductoLoteId,
											cantidadManejo,
											cantidadEscalar,
											ruteoId,
											ruteoDetalleId)
								SELECT		sd.saldoId,
											sd.saldoDetalleId,
											sd.presentacionId,
											sd.contenedorId,
											sd.bodegaLogicaId,
											sd.ubicacionId,
											sd.valorProductoLoteId,
											sd.saldoDetalleComprometidoManejo,
											sd.saldoDetalleComprometidoEscalar,
											rd.ruteoId,
											rd.ruteoDetalleId
											FROM  [dbo].[SaldosDetalle] sd 
											INNER JOIN [dbo].[RuteosDetalle] rd ON  sd.presentacionId = rd.presentacionId
																				AND sd.valorProductoLoteId = rd.valorProductoLoteId
																				AND sd.bodegaLogicaId = rd.bodegaLogicaId
																				AND sd.ubicacionId = rd.ubicacionId AND rd.ubicacionId = @ubicacionIdOrigen
											WHERE sd.saldoDetalleComprometidoManejo > 0


											END

											ELSE
											BEGIN
														-- se debe insertar novedad

														SELECT 'la ubicación origen no pertenece al ruteo seleccionado'  AS resultado
														ROLLBACK TRANSACTION picking;  
														RETURN

											END


												/****** Script for SelectTopNRows command from SSMS  ******/
						DECLARE @consecutivo INT = 0
						DECLARE @documentoAuxId BIGINT = 0
						
						SELECT				TOP 1 @documentoAuxId	=  d.documentoId 
						FROM				[dbo].[Documentos] AS d
						WHERE				d.documentoCodigo='PICK'
						
					
											--SELECT @documentoAuxId				

															--Se consulta la secuencia actual del consecutivo 														
															SELECT TOP 1 @consecutivo =  DocumentoContador + 1
															FROM [dbo].[Documentos] 
															WHERE documentoId = @documentoAuxId
																--SELECT @consecutivo	
															--Se actualiza el consecutivo 
															IF @consecutivo IS NULL OR @consecutivo = 0
															BEGIN 
																SELECT  'No se ha configurado consecutivo para este documento'  AS resultado
																ROLLBACK TRANSACTION picking;  
																RETURN
															END
															
															
															
															UPDATE [dbo].[Documentos]
															SET DocumentoContador = @consecutivo			
															WHERE DocumentoId = @documentoAuxId


															SELECT TOP(1) 	@ruteoId = pr.ruteoid, @ruteoDetalleId = pr.ruteoDetalleId
															FROM [dbo].[SaldosDetalle] sd
															INNER JOIN #pickingRuteoTemp pr ON pr.saldoId = sd.saldoId AND pr.saldoDetalleId = sd.saldoDetalleId

		IF @estadoRuteoDetalle = 1
							BEGIN



											--INSERT INTO  [dbo].[TXPicking]
										 --  (tXPickingConcepto --1 SALIDA, 2 ENTRADA
										 -- ,tXPickingConsecutivo 
										 -- ,novedadId
										 -- ,presentacionId      
										 -- ,contenedorId
										 -- ,valorProductoLoteId
										 -- ,ubicacionId
										 -- ,bodegaLogicaId
										 -- ,tXPickingRealManejo 
										 -- ,tXPickingRealEscalar     
										 -- ,ruteoId
										 -- ,ruteoDetalleId     
										 -- )

										  SELECT 1
										  ,@consecutivo
										  ,@novedadId
										  ,pr.presentacionId      
										  ,pr.contenedorId
										  ,pr.valorProductoLoteId
										  ,pr.ubicacionId
										  ,pr.bodegaLogicaId
										  ,pr.cantidadManejo 
										  ,pr.cantidadEscalar      
										  ,pr.ruteoId
										  ,pr.ruteoDetalleId   
										  FROM #pickingRuteoTemp pr
										  --FROM [dbo].[SaldosDetalle] sd
										  --INNER JOIN #pickingRuteoTemp pr ON pr.saldoId = sd.saldoId AND pr.saldoDetalleId = sd.saldoDetalleId
	
											--INSERT INTO  [dbo].[TXPicking]
										 --  (tXPickingConcepto --1 SALIDA, 2 ENTRADA
										 -- ,tXPickingConsecutivo -- por el momento quemado
										 -- ,novedadId
										 -- ,presentacionId      
										 -- ,contenedorId
										 -- ,valorProductoLoteId
										 -- ,ubicacionId
										 -- ,bodegaLogicaId
										 -- ,tXPickingRealManejo 
										 -- ,tXPickingRealEscalar     
										 -- ,ruteoId
										 -- ,ruteoDetalleId
					  
										 -- )

										  SELECT 2
										  ,@consecutivo
										  ,@novedadId
										  ,pr.presentacionId      
										  ,pr.contenedorId
										  ,pr.valorProductoLoteId
										  ,@ubicacionIdDestino
										  ,pr.bodegaLogicaId
										  ,pr.cantidadManejo 
										  ,pr.cantidadEscalar      
										  ,pr.ruteoId
										  ,pr.ruteoDetalleId 
										  FROM #pickingRuteoTemp pr
										  --FROM [dbo].[SaldosDetalle] sd
										  --INNER JOIN #pickingRuteoTemp pr ON pr.saldoId = sd.saldoId AND pr.saldoDetalleId = sd.saldoDetalleId



										  
					--EXEC	[dbo].[SP_UPDATE_TxPickingSequence] @ruteoId, @ruteoDetalleId

					--EXEC	[dbo].[SP_INSERT_Packing] @usuarioId, @documentoId, @packingId = @packingId OUTPUT


								END

				ELSE 
								BEGIN

												--INSERT INTO  [dbo].[TXPicking]
										  -- (tXPickingConcepto --99 CANCELAR
										  --,tXPickingConsecutivo -- por el momento quemado
										  --,novedadId
										  --,presentacionId      
										  --,contenedorId
										  --,valorProductoLoteId
										  --,ubicacionId
										  --,bodegaLogicaId
										  --,tXPickingRealManejo 
										  --,tXPickingRealEscalar     
										  --,ruteoId
										  --,ruteoDetalleId
					  
										  --)

										  SELECT 99
										  ,@consecutivo
										  ,@novedadId
										  ,pr.presentacionId      
										  ,pr.contenedorId
										  ,pr.valorProductoLoteId
										  ,@ubicacionIdOrigen
										  ,pr.bodegaLogicaId
										  ,pr.cantidadManejo 
										  ,pr.cantidadEscalar      
										  ,pr.ruteoId
										  ,pr.ruteoDetalleId 
										  FROM #pickingRuteoTemp pr





								END
						



						
					



					SELECT TOP 1 @pedidoId = rp.pedidoId 								
						FROM [dbo].[RuteosPedidos] rp 
						INNER JOIN [dbo].[PedidosDetalle] pd ON rp.pedidoId =  pd.pedidoId
						INNER JOIN #pickingRuteoTemp  p  ON pd.presentacionId = p.presentacionId 
						WHERE rp.ruteoId = @ruteoId

					 --SELECT * FROm #pickingRuteoTemp

				
				 ;WITH PackingItem (packingId,packingDetalleCantTotal,packingDetalleCantSolicitada,
						packingDetalleCantPreparada,packingDetalleCantNovedad,ubicacionMedioId,presentacionId,RuteoId,
						RuteoDetalleId,novedadId,pedidoId,
						--pedidoDetalleId,
						packingEstado)
						AS (
				  SELECT			@packingId
								  ,rd.ruteoDetalleCantidad
								  ,rd.ruteoDetalleCantRequerida
								  ,rd.ruteoDetalleCantidad
								  ,0
								  ,@ubicacionIdDestino, 
								  rd.presentacionId,
								  @ruteoId,
								  @ruteoDetalleId,
								  ISNULL(@novedadId,1),
								  @pedidoId,
								  --pd.pedidoDetalleId,
								  0
				  FROM  #pickingRuteoTemp pr 
				  INNER JOIN [dbo].[RuteosDetalle]	rd	ON	pr.ruteoDetalleId = rd.ruteoDetalleId 															
				  --INNER JOIN [dbo].[RuteosPedidos]	rp	ON	 rd.ruteoId = rp.ruteoId AND rp.pedidoId  = @pedidoId
				  --LEFT JOIN [dbo].[PedidosDetalle]  pd	ON	 rd.presentacionId = pd.presentacionId
				 )

						--INSERT INTO [dbo].[PackingDetalle] (
						--														 [packingId]
						--														,packingDetalleCantTotal
						--														,[packingDetalleCantSolicitada]
						--														,[packingDetalleCantPreparada]
						--														,[packingDetalleCantNovedad]
						--														,[ubicacionMedioId]
						--														,[presentacionId]
						--														,[RuteoId]
						--														,[RuteoDetalleId]
						--														,[novedadId]
						--														,[pedidoId]
						--														--,[pedidoDetalleId]
						--														,[packingEstado]
						--													)
						
						SELECT				 @packingId
											,packingDetalleCantTotal
											,packingDetalleCantSolicitada
											,packingDetalleCantPreparada
											,packingDetalleCantNovedad
											,ubicacionMedioId
											,presentacionId
											,RuteoId
											,RuteoDetalleId
											,novedadId
											,pedidoId
											--,pedidoDetalleId
											,packingEstado 
						FROM				 PackingItem
						GROUP BY			 packingId
											,packingDetalleCantTotal
											,packingDetalleCantSolicitada
											,packingDetalleCantPreparada
											,packingDetalleCantNovedad
											,ubicacionMedioId
											,presentacionId
											,RuteoId
											,RuteoDetalleId
											,novedadId
											,pedidoId
											--,pedidoDetalleId
											,packingEstado


										--UPDATE [dbo].[RuteosDetalle] 											
										--SET ruteoDetalleEstado = @estadoRuteoDetalle
										--FROM #pickingRuteoTemp p 
										--WHERE  p.ruteoId = [dbo].[RuteosDetalle].ruteoId
										--AND p.ruteoDetalleId = [dbo].[RuteosDetalle].ruteoDetalleId




										IF @estadoRuteoDetalle = 1
												BEGIN
										--ACTUALIZO EL SALDODETALLE EN LA UBICACION ORIGEN
																--UPDATE [dbo].[SaldosDetalle]
																--SET saldoDetalleComprometidoManejo = saldoDetalleComprometidoManejo - cantidadManejo,
																--saldoDetalleComprometidoEscalar = saldoDetalleComprometidoEscalar - cantidadEscalar,
																--saldoDetalleRealManejo = saldoDetalleRealManejo - cantidadManejo,
																--saldoDetalleRealEscalar = saldoDetalleRealEscalar - cantidadEscalar
																--FROM #pickingRuteoTemp pr
																--WHERE  pr.saldoId = [dbo].[SaldosDetalle].saldoId AND pr.saldoDetalleId = [dbo].[SaldosDetalle].saldoDetalleId  
																--AND [dbo].[SaldosDetalle].saldoDetalleComprometidoManejo >= cantidadManejo

																--DELETE sd FROM [dbo].[SaldosDetalle] sd												
																--INNER JOIN #pickingRuteoTemp pr ON sd.saldoDetalleId = pr.saldoDetalleId AND sd.saldoId = pr.saldoId
																--WHERE  sd.saldoDetalleRealManejo = 0

																---- INSERTO EN LA UBICACION DESTINO
																--INSERT INTO [dbo].[SaldosDetalle] ( saldoId
																--								  ,presentacionId
																--								  ,contenedorId
																--								  ,valorProductoLoteId
																--								  ,ubicacionId
																--								  ,bodegaLogicaId																				  
																--								  ,saldoDetalleRealManejo												 
																--								  ,saldoDetalleRealEscalar
																--								  ,saldoDetalleComprometidoManejo
																--								  ,saldoDetalleComprometidoEscalar
																--								  )
				
				
																SELECT	pr.saldoId, 
																		pr.presentacionId, 
																		pr.contenedorId, 
																		pr.valorProductoLoteId, 
																		@ubicacionIdDestino,
																		pr.bodegaLogicaId,
																		pr.cantidadManejo,
																		pr.cantidadEscalar,
																		pr.cantidadManejo,
																		pr.cantidadEscalar	
																FROM #pickingRuteoTemp pr	



																							
									--SELECT p.packingId, p.packingConsecutivo, pd.packingDetalleId, pd.ruteoId, pd.ruteoDetalleId, '' AS resultado FROM [dbo].[Packing] p
									--INNER JOIN [dbo].[PackingDetalle] pd ON p.packingId = pd.packingId WHERE p.packingId = @packingId
												
												END

									ELSE

													BEGIN

																----DESCOMPROMETO LOS SALDOS
																--UPDATE [dbo].[SaldosDetalle]
																--SET saldoDetalleComprometidoManejo = saldoDetalleComprometidoManejo - cantidadManejo,
																--saldoDetalleComprometidoEscalar = saldoDetalleComprometidoEscalar - cantidadEscalar,
																--saldoDetalleDisponibleManejo = saldoDetalleDisponibleManejo + cantidadManejo,
																--saldoDetalleDisponibleEscalar = saldoDetalleDisponibleEscalar + cantidadEscalar
																--FROM #pickingRuteoTemp pr
																--WHERE  pr.saldoId = [dbo].[SaldosDetalle].saldoId AND pr.saldoDetalleId = [dbo].[SaldosDetalle].saldoDetalleId  
																--AND [dbo].[SaldosDetalle].saldoDetalleComprometidoManejo >= cantidadManejo



									SELECT 'El ruteo detalle ha sido cancelado correctamente' AS resultado 
																
									--SELECT p.packingId, p.packingConsecutivo, pd.packingDetalleId, pd.ruteoId, pd.ruteoDetalleId, 'El ruteo detalle ha sido cancelado correctamente' AS resultado FROM [dbo].[Packing] p
									--INNER JOIN [dbo].[PackingDetalle] pd ON p.packingId = pd.packingId WHERE p.packingId = @packingId



													END















	COMMIT TRANSACTION picking
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION picking;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION picking;     
											END;  

							END CATCH
							END
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_PreRuteo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_SET_PreRuteo] (
											  @usuarioId			BIGINT
											, @uniqueProcessId		UNIQUEIDENTIFIER
										)

	AS 

		BEGIN
							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION Preruteoprocess

			
							SET DATEFORMAT YMD

				/******							Declaración de variables INICIO							******/
				DECLARE @preRuteoId						BIGINT = 0				
				DECLARE @productoTempId					BIGINT
				DECLARE @presentacionTempId				BIGINT
				DECLARE @cantidadTemp					DECIMAL(18,4)					
				DECLARE @fechaCaducidadTemp				DATETIME
				DECLARE @descripcion					VARCHAR(MAX)
				DECLARE @ubicacionId					BIGINT = 0
				DECLARE @bodegaLogicaId					BIGINT = 0
				DECLARE @contenedorId					BIGINT = 0
				DECLARE @contenedorTempId				BIGINT = 0				
				DECLARE @cantidadDetalleAux				DECIMAL(18,4)= 0
				DECLARE @saldoComprometidoManejo		DECIMAL(18,4)= 0
				DECLARE @saldoDisponibleManejo			DECIMAL(18,4)= 0
				DECLARE @valorProductoLoteId			BIGINT = 0
				DECLARE @saldoId						BIGINT = 0
				DECLARE @presentacionCantEscalar		DECIMAL(18,4) = 0
				DECLARE @presentacionCantManejo			DECIMAL(18,4) = 0
				DECLARE @totalsaldosaffectados			BIGINT = 0	
				DECLARE @CantidadAux					DECIMAL(18,4)= 0
				DECLARE @ordenMax						INT = 0
				DECLARE @cantidadDetalleRequeridaAux	DECIMAL(18,4)= 0
				DECLARE @documentoId					BIGINT = 0
				DECLARE @fechaCaducidad					DATE
				DECLARE @novedadId						BIGINT
				DECLARE @atributoLoteIdVencimiento						BIGINT
				DECLARE @consecutivo INT = 0
				DECLARE @ID BIGINT = 0
				DECLARE @resultado VARCHAR(100)
				/******								FIN									******/

						SELECT				TOP 1 @documentoId	=  d.documentoId 
						FROM				[dbo].[Documentos] AS d
						WHERE				d.documentoCodigo='RUT'

							
							

															--Se consulta la secuencia actual del consecutivo 														
															SELECT TOP 1 @consecutivo =  DocumentoContador + 1
															FROM [dbo].[Documentos] 
															WHERE documentoId = @documentoId

															--Se actualiza el consecutivo 
															IF @consecutivo IS NULL OR @consecutivo = 0 
															BEGIN
																SELECT 'No se ha configurado consecutivo para este documento' AS resultado
																ROLLBACK TRANSACTION Preruteoprocess;  
															RETURN 
															END
															SELECT DocumentoContador + 1 FROM [dbo].[Documentos] 	WHERE				documentoCodigo='RUT'

															


				
				/******						Capturo el id del registro PreRuteo agregado				******/
						EXEC	[dbo].[SP_INSERT_PreRuteo] @usuarioId, @documentoId, @consecutivo, @preRuteoId = @preRuteoId OUTPUT					
				
				--		IF @cantidadFinal <= 0	
				--							SELECT	@cantidadFinal =	COUNT(pedidoId) - @cantidadInicial
				--							FROM	PedidosPreRuteo
				--							WHERE	[Estado] = 0 AND UserNameId = @usuarioId AND uniqueProcessId = @uniqueProcessId 

				--/******				Si no trae resultados le doy valor de uno para evitar que saque excepcion de fetch				******/
				--		IF @cantidadFinal = 0 
				--								SET @cantidadFinal = 1

			
			
				/******					Eliminar tablas temporales por si quedan en memoria					******/
						IF OBJECT_ID('tempdb..#PedidosProductosCaducidad')		IS NOT NULL DROP TABLE #PedidosProductosCaducidad
						IF OBJECT_ID('tempdb..#SaldosProductos')				IS NOT NULL DROP TABLE #SaldosProductos	
						IF OBJECT_ID('tempdb..#SaldosProductosUbicaciones')		IS NOT NULL DROP TABLE #SaldosProductosUbicaciones
						IF OBJECT_ID('tempdb..#ReglasImplicitasProductos')		IS NOT NULL DROP TABLE #ReglasImplicitasProductos	
						IF OBJECT_ID('tempdb..#ReglasImplicitasUbicaciones')	IS NOT NULL DROP TABLE #ReglasImplicitasUbicaciones
				/******						Tablas temporales INICIO							******/
								
									CREATE TABLE #PedidosProductosCaducidad (
											 pedidoId						BIGINT
											,pedidoDetalleId				BIGINT
											,productoId						BIGINT 
											,presentacionId					BIGINT NULL
											,contenedorId					BIGINT NULL
											,CantidadConsolidada			DECIMAL(18,4) DEFAULT 0 
											,caducidadValor					INT 
											,FechaCaducidad					DATE NULL
									)

									CREATE TABLE #SaldosProductos (
											 saldoId						BIGINT	
											,productoId						BIGINT		
									)

									CREATE TABLE #SaldosProductosUbicaciones (
											 ID								BIGINT PRIMARY KEY IDENTITY(1,1)
											,saldoId						BIGINT 
											,novedadId						BIGINT
											,productoId						BIGINT 
											,presentacionId					BIGINT
											,contenedorId					BIGINT NULL
											,valorProductoLoteId			BIGINT 
											,bodegaLogicaId					BIGINT
											,ubicacionId					BIGINT 
											,rutaUbicacionOrden				INT
											,CantidadDisponible				DECIMAL(18,4)
											,FechaVencimiento				DATE						
											,CantidadComprometida			DECIMAL(18,4) DEFAULT 0
											,CantidadInmovilizada			DECIMAL(18,4) DEFAULT 0
									)
									CREATE NONCLUSTERED INDEX ix_spu ON #SaldosProductosUbicaciones (ID);

									CREATE TABLE #SaldosProductosUbicacionesContenedores (
											 ID								BIGINT PRIMARY KEY IDENTITY(1,1)
											,saldoId						BIGINT 
											,productoId						BIGINT 
											,presentacionId					BIGINT
											,contenedorId					BIGINT NULL
											,valorProductoLoteId			BIGINT 
											,bodegaLogicaId					BIGINT
											,ubicacionId					BIGINT
											,rutaUbicacionOrden				INT
											,CantidadDisponible				DECIMAL(18,4)
											,FechaVencimiento				DATE						
											,CantidadComprometida			DECIMAL(18,4) DEFAULT 0
											,CantidadInmovilizada			DECIMAL(18,4) DEFAULT 0
									)
									CREATE NONCLUSTERED INDEX ix_spuc ON #SaldosProductosUbicacionesContenedores (ID);


									CREATE TABLE #ReglasImplicitasProductos (
											 documentoId					BIGINT
											,productoId						BIGINT 																			
									)

									CREATE TABLE #ReglasImplicitasUbicaciones (
											 documentoId						BIGINT
											,ubicacionId						BIGINT 		
											,rutaUbicacionOrden					INT
									)
									
									CREATE TABLE #RutasUbicaciones (
											 rutaUbicacionId					BIGINT
											,rutaId								BIGINT 		
											,ubicacionId						BIGINT
											,rutaUbicacionOrden					INT
											,ubicacionCodigo					VARCHAR(100)
											,ubicacionDescripcion				VARCHAR(50)
									)


				/******								FIN									******/					
				

				INSERT INTO #RutasUbicaciones (rutaUbicacionId, rutaId, ubicacionId, rutaUbicacionOrden, ubicacionCodigo, ubicacionDescripcion)
				SELECT ru.rutaUbicacionId,ru.rutaId,ru.UbicacionId,ru.rutaUbicacionOrden, u.ubicacionCodigo, u.ubicacionDescripcion FROM [dbo].[RutasUbicaciones] ru
				INNER JOIN Ubicaciones u on ru.ubicacionId = u.ubicacionId AND u.ubicacionDescripcion LIKE 'GENERAL'
				INNER JOIN [dbo].[DocumentosRutas] dr ON ru.rutaId = dr.rutaId AND dr.documentoId =   @documentoId
				ORDER BY ru.rutaUbicacionOrden

				/******					Consulta pedidos preruteo por usuarioId y uniqueProcessId	INICIO				******/
				;WITH  Pedidos_Pre_Ruteo (
										 pedidoId
										,usuarioId
										,estado
										) AS (
													SELECT				 pedidoId
																		,UserNameId
																		,estado
													FROM				 PedidosPreRuteo
													WHERE				 [Estado] = 0 AND UserNameId = @usuarioId AND uniqueProcessId = @uniqueProcessId
													--ORDER BY			 [pedidoId] ASC	OFFSET 	@cantidadInicial	ROWS     
													--									FETCH NEXT	@cantidadfinal 	ROWS	ONLY
										   )
				/******								FIN									******/

				/******					Consulta pedidos por producto Normal	INICIO					******/
				,Consolida_Pedido_Normal (
										 pedidoId
										,pedidoDetalleId
										,productoId
										,productoTipoId
										,presentacionId
										,pedidoDetalleCantidad
										,caducidadValor
										,FechaCaducidad
										) AS (
													SELECT				 p.pedidoId 
																		,dp.pedidoDetalleId
																		,dp.productoId 
																		,dp.productoTipoId
																		,dp.presentacionId
																		,dp.pedidoDetalleCantidad
																		,r.Caducidad
																		,DATEADD(DAY,r.Caducidad,GETDATE())
													FROM				 Pedidos_Pre_Ruteo vp
																		INNER	JOIN	[dbo].[Pedidos]			p		ON vp.pedidoId = p.pedidoId AND p.pedidoEstado= 0 
																		INNER	JOIN	[dbo].[PedidosDetalle]	dp		ON p.pedidoId = dp.pedidoId AND dp.pedidoDetalleEstado= 0 AND dp.productoTipoId = 0 --Normal
																		INNER	JOIN	[dbo].[productos]		prod	ON dp.productoId = prod.productoId AND prod.productoEstado = 1
																		LEFT	JOIN	[dbo].[ReglaCaducidad]	r		ON dp.puntoEnvioId = r.PuntoEnvioId AND dp.productoId = r.ProductoId
														
											)
				/******								FIN									******/




				/******					Consulta pedidos por producto COMBO	INICIO					******/
				,Consolida_Pedido_Combo (
										 pedidoId
										,pedidoDetalleId
										,productoId
										,productoTipoId
										,presentacionId
										,pedidoDetalleCantidad
										,caducidadValor
										,FechaCaducidad
										) AS (
													SELECT			 p.pedidoId 
																	,dp.pedidoDetalleId
																	,prod2.productoId
																	,dp.productoTipoId 
																	,pc.presentacionIdDestino
																	,(pc.productoComboCantidad * dp.pedidoDetalleCantidad)
																	,r.Caducidad
																	,DATEADD(DAY,r.Caducidad															
																	,GETDATE())
													FROM			Pedidos_Pre_Ruteo vp
																	INNER	JOIN	[dbo].[Pedidos]			p		ON vp.pedidoId = p.pedidoId AND p.pedidoEstado= 0 
																	INNER	JOIN	[dbo].[PedidosDetalle]	dp		ON p.pedidoId = dp.pedidoId AND dp.pedidoDetalleEstado = 0 AND dp.productoTipoId = 1 --Combo
																	INNER	JOIN	[dbo].[ProductosCombos] pc		ON dp.productoId = pc.productoIdCombo AND pc.productoComboEstado = 1
																	INNER	JOIN	[dbo].[productos]		prod	ON pc.productoIdCombo = prod.productoId AND prod.productoEstado = 1
																	INNER	JOIN	[dbo].[productos]		prod2	ON pc.productoIdDestino = prod2.productoId AND prod.productoEstado = 1
																	LEFT	JOIN	[dbo].[ReglaCaducidad]	r		ON dp.puntoEnvioId = r.PuntoEnvioId AND prod2.productoId = r.ProductoId																
											) 
				/******								FIN									******/

				/******					Consulta pedidos por producto KIT	INICIO					******/
				,Consolida_Pedido_Kit (
										 pedidoId
										,pedidoDetalleId
										,productoId
										,productoTipoId
										,presentacionId
										,pedidoDetalleCantidad
										,caducidadValor
										,FechaCaducidad
										) AS (
													SELECT			 p.pedidoId
																	,dp.pedidoDetalleId
																	,dp.productoId
																	,dp.productoTipoId
																	,dp.presentacionId																														
																	,dp.pedidoDetalleCantidad
																	,r.Caducidad
																	,DATEADD(DAY,r.Caducidad
																	,GETDATE())
													FROM			Pedidos_Pre_Ruteo vp
																	INNER	JOIN	[dbo].[Pedidos] p ON vp.pedidoId = p.pedidoId AND p.pedidoEstado= 0 
																	INNER	JOIN	[dbo].[PedidosDetalle] dp ON p.pedidoId = dp.pedidoId AND dp.pedidoDetalleEstado= 0 AND dp.productoTipoId = 2 --Normal
																	INNER	JOIN	[dbo].[productos] prod ON dp.productoId = prod.productoId AND prod.productoEstado = 1
																	LEFT	JOIN	[dbo].[ReglaCaducidad] r ON dp.puntoEnvioId = r.PuntoEnvioId AND dp.productoId = r.ProductoId
																
													)
				/******								FIN									******/

				/******					Consulta agrupada por pedido, pedido detalle, producto, presentación, caducidad valor, fecha caducidad 	INICIO					******/
				,Consolida_ProductosxTipo (
										 pedidoId
										,pedidoDetalleId
										,productoId
										,presentacionId
										,Cantidad
										,caducidadValor
										,FechaCaducidad
										) AS (
													SELECT			 n.pedidoId
																	,n.pedidoDetalleId
																	,n.productoId
																	,n.presentacionId
																	,SUM(n.pedidoDetalleCantidad)
																	,caducidadValor
																	,n.FechaCaducidad
													FROM			 Consolida_Pedido_Normal n
													GROUP BY		 n.pedidoId
																	,n.pedidoDetalleId
																	,n.productoId
																	,n.presentacionId
																	,n.caducidadValor
																	,n.FechaCaducidad
													UNION ALL
													SELECT			 c.pedidoId
																	,c.pedidoDetalleId
																	,c.productoId
																	,c.presentacionId
																	,SUM(c.pedidoDetalleCantidad)
																	,caducidadValor
																	,c.FechaCaducidad
													FROM			 Consolida_Pedido_Combo c 
													GROUP BY		 c.pedidoId
																	,c.pedidoDetalleId
																	,c.productoId
																	,c.presentacionId
																	,c.caducidadValor
																	,c.FechaCaducidad
													UNION ALL
													SELECT			 k.pedidoId
																	,k.pedidoDetalleId
																	,k.productoId
																	,k.presentacionId
																	,SUM(k.pedidoDetalleCantidad)
																	,caducidadValor
																	,k.FechaCaducidad
													FROM			 Consolida_Pedido_Kit k 
													GROUP BY		 k.pedidoId
																	,k.pedidoDetalleId
																	,k.productoId
																	,k.presentacionId
																	,k.caducidadValor
																	,k.FechaCaducidad
													)
				/******								FIN									******/
			
				/******				Consulta agrupada por producto, presentación, caducidad valor, fecha caducidad 	INICIO					******/
				,Consolida_Productos(
										 pedidoId	
										,pedidoDetalleId
										,productoId
										,presentacionId
										,CantidadConsolidada
										,caducidadValor
										,FechaCaducidad
										) AS (
													SELECT				 pedidoId
																		,pedidoDetalleId
																		,productoId 
																		,presentacionId
																		,SUM(Cantidad)
																		,caducidadValor
																		,FechaCaducidad
													FROM				 Consolida_ProductosxTipo 
													GROUP BY			 pedidoId
																		,pedidoDetalleId
																		,productoId
																		,presentacionId
																		,caducidadValor
																		,FechaCaducidad
														) 
				/******								FIN									******/

				/******				Inserción tabla temporal agrupada por producto, presentación, caducidad valor, fecha caducidad 	INICIO					******/	
				INSERT	INTO		#PedidosProductosCaducidad	(
												 pedidoId 
												,pedidoDetalleId 
												,productoId  
												,presentacionId 
												,CantidadConsolidada 
												,caducidadValor  
												,FechaCaducidad
											)
				SELECT							 pedidoId
												,pedidoDetalleId
												,productoId
												,presentacionId
												,CantidadConsolidada
												,caducidadValor
												,FechaCaducidad
				FROM							 Consolida_Productos
				/******								FIN									******/

				/******				Consulta agrupacion saldo por producto 	INICIO					******/	
				;WITH Saldos_Productos_Pedido(
										 saldoId
										,productoId
										) AS (
													SELECT				 s.saldoId
																		,ppc.productoId		
													FROM				 #PedidosProductosCaducidad ppc 
													INNER	JOIN		 [dbo].[Saldos] s ON ppc.productoId = s.productoId
													GROUP BY			 s.saldoId
																		,ppc.productoId		
											)
				/******								FIN									******/

				/******				Inserción tabla temporal agrupada saldo por producto 	INICIO					******/	
				INSERT INTO			#SaldosProductos  (
													 saldoId 	
													,productoId
												)	
				SELECT								 saldoId
													,productoId
				FROM								 Saldos_Productos_Pedido 
				/******								FIN									******/
				
				;WITH Reglas_Implicitas_Ruteo_Productos (
										 documentoId
										,productoId
										) AS (

													SELECT 			dpl.documentoId,pld.productoId
													FROM			Documentos AS d
													INNER JOIN		DocumentosProductosListas AS dpl ON d.documentoId=dpl.documentoId
													INNER JOIN		ProductosListas AS pl ON dpl.productoListaId=pl.productoListaId
													INNER JOIN		ProductosListasDetalle AS pld ON pl.productoListaId=pld.productoListaId
													WHERE			d.documentoCodigo='RUT'
													GROUP BY		dpl.documentoId,pld.productoId
										)

				INSERT INTO			#ReglasImplicitasProductos  (
																	 documentoId
																	,productoId
																)	
				SELECT												 documentoId
																	,productoId
				FROM												 Reglas_Implicitas_Ruteo_Productos 
				ORDER BY											 productoId

				;WITH Reglas_Implicitas_Ruteo_Ubicaciones (
										 documentoId
										,ubicacionId
										) AS (

													SELECT			dpl.documentoId,pld.ubicacionId
													FROM			Documentos AS d
													INNER JOIN		DocumentosUbicacionesListas AS dpl ON d.documentoId=dpl.documentoId
													INNER JOIN		UbicacionesListas AS pl ON dpl.ubicacionListaId=pl.ubicacionListaId
													INNER JOIN		UbicacionesListasDetalle AS pld ON pl.ubicacionListaId=pld.ubicacionListaId
													INNER JOIN		#RutasUbicaciones ru ON pld.ubicacionId = ru.ubicacionId
													WHERE			d.documentoCodigo='RUT'
													GROUP BY		dpl.documentoId,pld.ubicacionId
												
													
													
										)

				INSERT INTO											#ReglasImplicitasUbicaciones  (
																	 documentoId
																	,ubicacionId
																	,rutaUbicacionOrden
																	)	
				SELECT												 ri.documentoId
																	,ri.ubicacionId
																	,ru.rutaUbicacionOrden
				FROM												Reglas_Implicitas_Ruteo_Ubicaciones ri
				INNER JOIN											#RutasUbicaciones ru ON ri.ubicacionId = ru.ubicacionId
				ORDER BY											ru.rutaUbicacionOrden
							


					SELECT  @atributoLoteIdVencimiento = al.atributoLoteId FROM [dbo].[AtributosLotes] al 
					INNER JOIN [dbo].[TiposAtributos] ta ON al.tipoAtributoId = ta.tipoAtributoId AND ta.tipoAtributoDescripcion LIKE 'Fecha Vencimiento' 

				/******			Consulta  saldos  producto, presentación, valor producto lote, bodega logica, ubicación, fechavencimiento 	INICIO			******/
				;WITH Saldos_Productos_Ubicacion(
										 saldoId
										,productoId
										,presentacionId
										,contenedorId
										,valorProductoLoteId
										,bodegaLogicaId
										,ubicacionId
										,CantidadDisponible
										,FechaVencimiento
									
							) AS (
										SELECT			 s.saldoId
														,s.productoId
														,sd.presentacionId
														,sd.contenedorId
														,sd.valorProductoLoteId
														,sd.bodegaLogicaId
														,u.ubicacionId
														,sd.saldoDetalleRealManejo -(sd.saldoDetalleComprometidoManejo+sd.saldoDetalleInmovilizadoManejo)
														,TRY_CONVERT(DATE,MIN(vpl.valorPlantillaLoteValor))		
										FROM	  		[dbo].[saldos] s
														INNER	JOIN	#SaldosProductos sp ON s.saldoId = sp.saldoId AND s.productoId = sp.productoId
														INNER	JOIN	[dbo].[SaldosDetalle] sd ON sp.saldoId = sd.saldoId 
														INNER	JOIN	[dbo].[BodegasLogicas] b ON sd.bodegaLogicaId = b.bodegaLogicaId AND b.bodegaLogicaEstado = 1 AND b.bodegaLogicaId IN (2, 3) 
														INNER	JOIN	#RutasUbicaciones u ON sd.ubicacionId = u.ubicacionId 
														LEFT	JOIN	[dbo].[ValoresPlantillasLotes] vpl ON sd.valorProductoLoteId = vpl.valorProductoLoteId AND vpl.atributoLoteId = @atributoLoteIdVencimiento
														GROUP BY  s.saldoId
														,s.productoId
														,sd.presentacionId
														,sd.contenedorId
														,sd.valorProductoLoteId
														,sd.bodegaLogicaId
														,u.ubicacionId
														,sd.saldoDetalleRealManejo,sd.saldoDetalleComprometidoManejo,sd.saldoDetalleInmovilizadoManejo
							)
				/******								FIN									******/

				INSERT INTO				#SaldosProductosUbicacionesContenedores (
															 saldoId
															,productoId
															,presentacionId
															,contenedorId
															,valorProductoLoteId
															,bodegaLogicaId
															,ubicacionId
															,rutaUbicacionOrden
															,CantidadDisponible
															,FechaVencimiento
															)

				SELECT										 spu.saldoId
															,spu.productoId
															,spu.presentacionId
															,spu.contenedorId
															,spu.valorProductoLoteId
															,spu.bodegaLogicaId
															,spu.ubicacionId
															,rubi.rutaUbicacionOrden
															,spu.CantidadDisponible
															,spu.FechaVencimiento 
				FROM				 						 Saldos_Productos_Ubicacion spu
				INNER JOIN									 #ReglasImplicitasProductos rprod ON  spu.productoId = rprod.productoId
				INNER JOIN									 #ReglasImplicitasUbicaciones rubi ON  spu.ubicacionId = rubi.ubicacionId
				
		

				/******			Inserción tabla temporal agrupada saldos  producto, presentación, valor producto lote, bodega logica, ubicación, fechavencimiento 	INICIO			******/
				INSERT INTO				#SaldosProductosUbicaciones (
															 s.saldoId														
															,productoId
															,presentacionId															
															,valorProductoLoteId
															,bodegaLogicaId
															,ubicacionId
															,rutaUbicacionOrden
															,CantidadDisponible
															,FechaVencimiento
															)

				SELECT										 spuc.saldoId
															,spuc.productoId
															,spuc.presentacionId
															,spuc.valorProductoLoteId
															,spuc.bodegaLogicaId
															,spuc.ubicacionId
															,rubi.rutaUbicacionOrden
															,SUM(spuc.CantidadDisponible)
															,spuc.FechaVencimiento 
				FROM				 						 #SaldosProductosUbicacionesContenedores spuc
				INNER JOIN									 #ReglasImplicitasProductos rprod ON  spuc.productoId = rprod.productoId
				INNER JOIN									 #ReglasImplicitasUbicaciones rubi ON  spuc.ubicacionId = rubi.ubicacionId
				GROUP BY									 spuc.saldoId
															,spuc.productoId
															,spuc.presentacionId
															,spuc.valorProductoLoteId 
															,spuc.bodegaLogicaId
															,spuc.ubicacionId 
															,rubi.rutaUbicacionOrden
															,spuc.FechaVencimiento	
															
				/******								FIN									******/
			
				/******						Inserción PreRuteosPedidos					******/		
				INSERT INTO				[dbo].[PreRuteosPedidos](
															 preRuteoId
															,pedidoId
															)
				SELECT DISTINCT								 @preRuteoId
															,pedidoId 
				FROM										 #PedidosProductosCaducidad
					
				EXEC					[dbo].[SP_UPDATE_PedidoPreRuteoEstado]		 
															  1
															 ,@preRuteoId
															 ,@usuarioId
															 ,@uniqueProcessId
				/******								FIN									******/
				
				--UPDATE TOP(1) #PedidosProductosCaducidad
				--SET contenedorId = 18785164
				--WHERE presentacionId = 8  
				--SELECT		 *								
				--					FROM		 #SaldosProductosUbicaciones
					
				/******						Cursor Generar preruteo ubicación producto presentación contenedor lote	INICIO			******/			
				DECLARE							 PreRuteoInfo			
					CURSOR FOR 
									SELECT		 productoId
												,presentacionId
												,contenedorId
												,FechaCaducidad
												,SUM(CantidadConsolidada)								
									FROM		 #PedidosProductosCaducidad
									 --WHERE contenedorId IS NOT NULL
									GROUP BY	 productoId
												,presentacionId
												,contenedorId
												,FechaCaducidad
												ORDER BY contenedorId DESC
					OPEN						PreRuteoInfo
									FETCH NEXT 
									FROM		 PreRuteoInfo 
									INTO		 @productoTempId
												,@presentacionTempId
												,@contenedorTempId
												,@fechaCaducidad
												,@cantidadTemp						
					
									WHILE	@@fetch_status = 0
										BEGIN					  
											SET @CantidadAux = 0
											
											WHILE	(@CantidadAux < @cantidadTemp)
												BEGIN	
														
														SET		@ubicacionId = NULL
														SET		@bodegaLogicaId = NULL
														SET		@ID = 0
														SET		@cantidadDetalleAux = 0
														SET		@saldoComprometidoManejo= 0
														SET		@saldoDisponibleManejo= 0
														SET		@valorProductoLoteId = NULL
														SET		@saldoId = NULL	
														SET		@ordenMax = 0
														SET		@cantidadDetalleRequeridaAux = 0

														SELECT @ordenMax = MAX(presentacionOrden) FROM [dbo].[presentaciones] WHERE productoId =  @productoTempId
														
														IF EXISTS	(
																		SELECT		1											
																		FROM		#SaldosProductosUbicaciones		sd
																					INNER	JOIN	[dbo].[Presentaciones] p ON sd.presentacionId = p.presentacionId 
																																AND p.presentacionEstado = 1																																
																		WHERE		sd.presentacionId	= @presentacionTempId 
																					AND sd.productoId	= @productoTempId 
																					AND sd.contenedorId = @contenedorTempId
																					AND sd.FechaVencimiento >= @fechaCaducidad
																					AND sd.CantidadDisponible	-	(CantidadComprometida	+	CantidadInmovilizada)	>	0
																	)	
																BEGIN
																/******	 Se captura la información del saldo producto presentación contenedor lote INICIO	******/	
																				SELECT		TOP 1 
																							@cantidadDetalleAux				=	CantidadDisponible	-	(CantidadComprometida	+	 CantidadInmovilizada),									
																							@ubicacionId					=	sd.ubicacionId,
																							@valorProductoLoteId			=	sd.valorProductoLoteId,
																							@bodegaLogicaId					=	sd.bodegaLogicaId
																							,@ID = sd.ID
																				FROM		#SaldosProductosUbicacionesContenedores		sd
																							INNER	JOIN	[dbo].[Presentaciones] p On  sd.productoId = @productoTempId 
																																		 AND sd.presentacionId = @presentacionTempId 
																																		-- AND p.presentacionOrden = 0
																							--INNER	JOIN	[dbo].[Presentaciones] p2 On sd.productoId = p2.productoId  
																																		-- AND p2.presentacionOrden = @ordenMax																							
																				WHERE 		--sd.CantidadDisponible 			=	p2.presentacionNumUnidad
																							--AND 
																							sd.contenedorId				=	@contenedorTempId
																							AND p.presentacionEstado		=	1																							
																							AND sd.bodegaLogicaId			=	2
																							AND sd.FechaVencimiento >= @fechaCaducidad
																							AND sd.CantidadDisponible	-	(sd.CantidadComprometida	+	sd.CantidadInmovilizada)	>	0
																				ORDER BY		sd.rutaUbicacionOrden ASC ,sd.FechaVencimiento		ASC	
																			
																				
																				IF			@cantidadDetalleAux		<=	0		BREAK;

																				SET			@CantidadAux	=	@CantidadAux	+	@cantidadDetalleAux
																				SET			@saldoComprometidoManejo = @cantidadDetalleAux

																																							   																			
																				/******	 Si la cantidad supera la cantidad solicitada se valida saldo en la bodega unidades sueltas INICIO	******/
																				IF			@CantidadAux	>	@cantidadTemp 
																						BEGIN		
																						
																								SET			@saldoComprometidoManejo	=	@cantidadDetalleAux		-	(@CantidadAux	-	@cantidadTemp)	
																								
																								IF	EXISTS		(	SELECT		 1
																													FROM		 #SaldosProductosUbicacionesContenedores	sd																									
																													WHERE		 sd.presentacionId				=	@presentacionTempId 
																																 AND sd.productoId				=	@productoTempId 
																																 AND sd.contenedorId			IS NOT NULL
																																 AND sd.bodegaLogicaId			=	3
																																 AND sd.FechaVencimiento >= @fechaCaducidad
																																 AND sd.CantidadDisponible	-	(CantidadComprometida	+	 CantidadInmovilizada)	>=	 @saldoComprometidoManejo
																												 )
																									BEGIN
																														SELECT		 TOP 1 
																																	 @cantidadDetalleAux			=	CantidadDisponible	-	(CantidadComprometida	+	 CantidadInmovilizada)									
																																	,@ubicacionId					=	ubicacionId
																																	,@valorProductoLoteId			=	valorProductoLoteId	
																																	,@bodegaLogicaId				=	bodegaLogicaId
																																	,@ID = ID
																														FROM		 #SaldosProductosUbicacionesContenedores	sd																									
																														WHERE		 sd.presentacionId				=	@presentacionTempId 
																																	 AND sd.productoId				=	@productoTempId 
																																	 AND sd.contenedorId			IS NOT NULL
																																	 AND sd.bodegaLogicaId			=	3
																																	 AND sd.FechaVencimiento >= @fechaCaducidad
																																	 AND sd.CantidadDisponible	-	(CantidadComprometida	+	 CantidadInmovilizada)	>=	 @saldoComprometidoManejo
																														ORDER BY	 sd.rutaUbicacionOrden ASC
																																	,sd.FechaVencimiento			ASC
																																	,sd.CantidadDisponible			ASC	
																									END
																									/******	 FIN	******/	
																						END
																					--SELECT @contenedorTempId
																						/******	 FIN	******/	
																/****** Se actualiza el registo de la tabla temporal #SaldosProductosUbicaciones INICIO ******/
																	UPDATE			#SaldosProductosUbicacionesContenedores
																	SET				CantidadComprometida	=	CantidadComprometida + @saldoComprometidoManejo,
																					CantidadInmovilizada	=	CantidadInmovilizada + (@cantidadDetalleAux - @saldoComprometidoManejo)
																	WHERE			ID = @ID
																					--presentacionId			=	@presentacionTempId 
																					--AND productoId			=	@productoTempId 
																					--AND contenedorId		=	@contenedorTempId
																					--AND ubicacionId			=	@ubicacionId 							
																					--AND bodegaLogicaId		=	@bodegaLogicaId
																					--AND FechaVencimiento >= @fechaCaducidad


																	UPDATE			#SaldosProductosUbicaciones
																	SET				--CantidadDisponible = CantidadDisponible - @saldoComprometidoManejo
																					CantidadComprometida	=	CantidadComprometida + @saldoComprometidoManejo,
																					CantidadInmovilizada	=	CantidadInmovilizada + (@cantidadDetalleAux - @saldoComprometidoManejo)
																	WHERE			--ID = @ID
																					presentacionId			=	@presentacionTempId 
																					AND productoId			=	@productoTempId 
																					--AND contenedorId		=	@contenedorTempId
																					AND ubicacionId			=	@ubicacionId 							
																					AND bodegaLogicaId		=	@bodegaLogicaId
																					AND FechaVencimiento >= @fechaCaducidad
																/******	 FIN	******/	
																
																	/****** Se inserta el detalle asociado a un PreRuteo INICIO ******/
																	--EXEC			[dbo].[SP_INSERT_PreRuteoPedidoDetalle]		 @preRuteoId
																	--															,@presentacionTempId
																	--															,@contenedorTempId
																	--															,@bodegaLogicaId
																	--															,@ubicacionId 
																	--															,@cantidadDetalleAux
																	--															,@saldoComprometidoManejo
																	--															,@valorProductoLoteId 
																	/******		END		******/															
																	
																	/****** Se consulta y calcula el valor escalar del producto presentación  INICIO ******/
																	
																	SELECT			@presentacionCantEscalar	=	ISNULL(p.productoCantidadEscalar, 0) * ISNULL(pr.presentacionNumUnidad, 0),
																					@presentacionCantManejo		=	ISNULL(p.productoCantidadManejo, 0) * ISNULL(pr.presentacionNumUnidad, 0)
																	FROM			[dbo].[Productos]		p
																	INNER JOIN		#SaldosProductosUbicacionesContenedores		sd	ON p.productoId = sd.productoId 
																	INNER JOIN		[dbo].[Presentaciones]		pr		ON p.productoId	= @productoTempId																	
																	WHERE			pr.presentacionId = @presentacionTempId 
																	/******		END		******/			


																	SELECT			@saldoId	=	 saldoId 
																	FROM			[dbo].[saldos] 
																	WHERE			productoId	=	@productoTempId

																	IF	@saldoId	IS	 NULL	OR	@saldoId	=	0	BREAK;
																	ELSE
																			UPDATE		[dbo].[Saldos]
																			SET			saldoComprometidoManejo		=	saldoComprometidoManejo + @saldoComprometidoManejo,
																						saldoInmovilizadoManejo		=	saldoInmovilizadoManejo + 
																														(@cantidadDetalleAux - @saldoComprometidoManejo),
																						saldoDisponibleManejo		=	saldoRealManejo - ((saldoComprometidoManejo + @saldoComprometidoManejo)+ 
																														(saldoInmovilizadoManejo + 
																														(@cantidadDetalleAux - @saldoComprometidoManejo))),
																						saldoComprometidoEscalar	=	(saldoComprometidoManejo + @saldoComprometidoManejo) * @presentacionCantEscalar,
																						saldoInmovilizadoEscalar	=	(saldoInmovilizadoManejo + 
																														(@cantidadDetalleAux - @saldoComprometidoManejo)) * @presentacionCantEscalar,
																						saldoDisponibleEscalar		=	(saldoRealManejo - ((saldoComprometidoManejo + @saldoComprometidoManejo)+ 
																														(saldoInmovilizadoManejo + 
																														(@cantidadDetalleAux - @saldoComprometidoManejo)))) * @presentacionCantEscalar
																			WHERE		productoId = @productoTempId	AND		saldoId = @saldoId
																	
																END	
																/******		END		******/														
														
														/******	 Validar si existe saldo para el producto presentación contenedor lote INICIO	******/	
														ELSE IF EXISTS	(
																		SELECT		1											
																		FROM		#SaldosProductosUbicaciones		sd
																					INNER	JOIN	[dbo].[Presentaciones] p ON sd.presentacionId = p.presentacionId 
																																AND p.presentacionEstado = 1																																
																		WHERE		sd.presentacionId	= @presentacionTempId 
																					AND sd.productoId	= @productoTempId 
																					AND sd.contenedorId IS NULL
																					AND sd.FechaVencimiento >= @fechaCaducidad
																					AND sd.CantidadDisponible	-	(CantidadComprometida	+	CantidadInmovilizada)	>	0
																	)	
																BEGIN
																/******	 Se captura la información del saldo producto presentación contenedor lote INICIO	******/	
																				SELECT		TOP 1 
																							@cantidadDetalleAux				=	CantidadDisponible	-	(CantidadComprometida	+	 CantidadInmovilizada),									
																							@ubicacionId					=	sd.ubicacionId,
																							@valorProductoLoteId			=	sd.valorProductoLoteId,
																							@bodegaLogicaId					=	sd.bodegaLogicaId,
																							@ID								= ID 
																							
																				FROM		#SaldosProductosUbicaciones		sd
																							INNER	JOIN	[dbo].[Presentaciones] p On  sd.productoId = @productoTempId 
																																		 AND sd.presentacionId = @presentacionTempId 
																																		 AND p.presentacionOrden = 0
																							INNER	JOIN	[dbo].[Presentaciones] p2 On sd.productoId = p2.productoId  
																																		 AND p2.presentacionOrden = @ordenMax																							
																				WHERE 		sd.CantidadDisponible 			=	p2.presentacionNumUnidad
																							AND sd.contenedorId				IS NULL
																							AND p2.presentacionEstado		=	1																							
																							AND sd.bodegaLogicaId			=	2
																							AND sd.FechaVencimiento >= @fechaCaducidad
																							AND sd.CantidadDisponible	-	(sd.CantidadComprometida	+	sd.CantidadInmovilizada)	>	0
																				ORDER BY	sd.rutaUbicacionOrden ASC, p2.presentacionOrden		DESC,	sd.FechaVencimiento		ASC	
																			
																				
																				IF			@cantidadDetalleAux		<=	0		BREAK;

																				SET			@CantidadAux	=	@CantidadAux	+	@cantidadDetalleAux
																				SET			@saldoComprometidoManejo = @cantidadDetalleAux

																																							   																			
																				/******	 Si la cantidad supera la cantidad solicitada se valida saldo en la bodega unidades sueltas INICIO	******/
																				IF			@CantidadAux	>	@cantidadTemp 
																						BEGIN																						
																								SET			@saldoComprometidoManejo	=	@cantidadDetalleAux		-	(@CantidadAux	-	@cantidadTemp)	
																								
																								IF	EXISTS		(	SELECT		 1
																													FROM		 #SaldosProductosUbicaciones	sd																									
																													WHERE		 sd.presentacionId				=	@presentacionTempId 
																																 AND sd.productoId				=	@productoTempId 
																																 AND sd.contenedorId			IS NULL
																																 AND sd.bodegaLogicaId			=	3
																																 AND sd.FechaVencimiento >= @fechaCaducidad
																																 AND sd.CantidadDisponible	-	(CantidadComprometida	+	 CantidadInmovilizada)	>=	 @saldoComprometidoManejo
																												 )
																									BEGIN
																														SELECT		 TOP 1 
																																	 @cantidadDetalleAux			=	CantidadDisponible	-	(CantidadComprometida	+	 CantidadInmovilizada)									
																																	,@ubicacionId					=	ubicacionId
																																	,@valorProductoLoteId			=	valorProductoLoteId	
																																	,@bodegaLogicaId				=	bodegaLogicaId
																														FROM		 #SaldosProductosUbicaciones	sd																									
																														WHERE		 sd.presentacionId				=	@presentacionTempId 
																																	 AND sd.productoId				=	@productoTempId 
																																	 AND sd.contenedorId			IS NULL
																																	 AND sd.bodegaLogicaId			=	3
																																	 AND sd.FechaVencimiento >= @fechaCaducidad
																																	 AND sd.CantidadDisponible	-	(CantidadComprometida	+	 CantidadInmovilizada)	>=	 @saldoComprometidoManejo
																														ORDER BY	sd.rutaUbicacionOrden ASC
																																	,sd.FechaVencimiento			ASC
																																	,sd.CantidadDisponible			ASC	
																									END
																									/******	 FIN	******/	
																						END
																						/******	 FIN	******/	
																/****** Se actualiza el registo de la tabla temporal #SaldosProductosUbicaciones INICIO ******/
																	UPDATE			#SaldosProductosUbicaciones
																	SET				CantidadComprometida	=	@saldoComprometidoManejo,
																					CantidadInmovilizada	=	@cantidadDetalleAux		-	@saldoComprometidoManejo
																	WHERE			ID = @ID
																					--presentacionId			=	@presentacionTempId 
																					--AND productoId			=	@productoTempId 
																					--AND contenedorId		IS NULL
																					--AND ubicacionId			=	@ubicacionId 							
																					--AND bodegaLogicaId		=	@bodegaLogicaId
																					--AND FechaVencimiento >= @fechaCaducidad
																/******	 FIN	******/	

																	/****** Se inserta el detalle asociado a un PreRuteo INICIO ******/
																	--EXEC			[dbo].[SP_INSERT_PreRuteoPedidoDetalle]		 @preRuteoId
																	--															,@presentacionTempId
																	--															,@contenedorTempId
																	--															,@bodegaLogicaId
																	--															,@ubicacionId 
																	--															,@cantidadDetalleAux
																	--															,@saldoComprometidoManejo
																	--															,@valorProductoLoteId 
																	/******		END		******/															
																	
																	/****** Se consulta y calcula el valor escalar del producto presentación  INICIO ******/
																	
																	SELECT			@presentacionCantEscalar	=	ISNULL(p.productoCantidadEscalar, 0) * ISNULL(pr.presentacionNumUnidad, 0),
																					@presentacionCantManejo		=	ISNULL(p.productoCantidadManejo, 0) * ISNULL(pr.presentacionNumUnidad, 0)
																	FROM			[dbo].[Productos]		p
																	INNER JOIN		#SaldosProductosUbicaciones		sd	ON p.productoId = sd.productoId 
																	INNER JOIN		[dbo].[Presentaciones]		pr		ON p.productoId	= @productoTempId																	
																	WHERE			pr.presentacionId = @presentacionTempId 
																	/******		END		******/			


																	SELECT			@saldoId	=	 saldoId 
																	FROM			[dbo].[saldos] 
																	WHERE			productoId	=	@productoTempId

																	IF	@saldoId	IS	 NULL	OR	@saldoId	=	0	BREAK;
																	ELSE
																			UPDATE		[dbo].[Saldos]
																			SET			saldoComprometidoManejo		=	saldoComprometidoManejo + @saldoComprometidoManejo,
																						saldoInmovilizadoManejo		=	saldoInmovilizadoManejo + 
																														(@cantidadDetalleAux - @saldoComprometidoManejo),
																						saldoDisponibleManejo		=	saldoRealManejo - ((saldoComprometidoManejo + @saldoComprometidoManejo)+ 
																														(saldoInmovilizadoManejo + 
																														(@cantidadDetalleAux - @saldoComprometidoManejo))),
																						saldoComprometidoEscalar	=	(saldoComprometidoManejo + @saldoComprometidoManejo) * @presentacionCantEscalar,
																						saldoInmovilizadoEscalar	=	(saldoInmovilizadoManejo + 
																														(@cantidadDetalleAux - @saldoComprometidoManejo)) * @presentacionCantEscalar,
																						saldoDisponibleEscalar		=	(saldoRealManejo - ((saldoComprometidoManejo + @saldoComprometidoManejo)+ 
																														(saldoInmovilizadoManejo + 
																														(@cantidadDetalleAux - @saldoComprometidoManejo)))) * @presentacionCantEscalar
																			WHERE		productoId = @productoTempId	AND		saldoId = @saldoId
																	
																END	
																/******		END		******/	

														/******	 Sino existe se almacena la novedad	INICIO ******/	
														ELSE
															BEGIN
																SET @novedadId = NULL
																SET @cantidadDetalleAux = 0


																SET @cantidadDetalleAux = @cantidadTemp - @CantidadAux
																	/******		Inserción de la novedad del Preruteo INICIO	******/


																	IF NOT EXISTS(	SELECT 1	
																				FROM		#SaldosProductosUbicaciones		sd
																				INNER	JOIN	[dbo].[Productos] p ON sd.productoId = p.productoId AND p.productoEstado = 1
																				WHERE		sd.productoId	= @productoTempId 
																				)
																						BEGIN 
																								IF EXISTS(	SELECT 1	
																									FROM		#SaldosProductosUbicaciones		sd
																									INNER	JOIN	[dbo].[Productos] p ON sd.productoId = p.productoId AND p.productoEstado = 0
																									WHERE		sd.productoId	= @productoTempId 
																									)
																									BEGIN 
																								
																										SELECT @novedadId = n.novedadId FROM [dbo].[Novedades] n
																										WHERE n.novedadCodigo LIKE 'NR-014'
																									END

																								ELSE
																									BEGIN
																										SELECT @novedadId = n.novedadId FROM [dbo].[Novedades] n
																										WHERE n.novedadCodigo LIKE 'NR-015'
																									END
																								
																						END

																	ELSE IF NOT EXISTS(	SELECT 1	
																				FROM		#SaldosProductosUbicaciones		sd
																				INNER	JOIN	[dbo].[Presentaciones] p ON sd.presentacionId = p.presentacionId AND p.presentacionEstado = 1
																				WHERE		sd.productoId	= @productoTempId  AND
																							sd.presentacionId	= @presentacionTempId  
																				)																					 

																					BEGIN 
																						IF EXISTS(	SELECT 1	
																							FROM		#SaldosProductosUbicaciones		sd
																							INNER	JOIN	[dbo].[Presentaciones] p ON sd.presentacionId = p.presentacionId AND p.presentacionEstado = 0
																							WHERE	sd.productoId	= @productoTempId  AND
																									sd.presentacionId	= @presentacionTempId  
																							)
																									BEGIN 
																								
																										SELECT @novedadId = n.novedadId FROM [dbo].[Novedades] n
																										WHERE n.novedadCodigo LIKE 'NR-014' --agregar novedad presentacion inhabilitada
																									END

																								ELSE
																									BEGIN
																										SELECT @novedadId = n.novedadId FROM [dbo].[Novedades] n
																										WHERE n.novedadCodigo LIKE 'NR-011'
																									END
																						
																				END
																ELSE IF NOT EXISTS(	SELECT 1	
																				FROM		#SaldosProductosUbicaciones		sd
																				INNER	JOIN	[dbo].[Contenedores] c ON sd.contenedorId = c.contenedorId  
																				WHERE	sd.productoId	= @productoTempId  AND 	
																						sd.presentacionId	= @presentacionTempId  AND
																						sd.contenedorId = @contenedorTempId																				)
																						BEGIN 

																									SELECT @novedadId = n.novedadId FROM [dbo].[Novedades] n
																													WHERE n.novedadCodigo LIKE 'NR-010' 
																						END

																	
																	
																	
																	
																	
																	
																	
																	
																	ELSE IF NOT EXISTS(	SELECT 1	
																				FROM		#SaldosProductosUbicacionesContenedores		sd
																				INNER	JOIN	[dbo].[Presentaciones] p ON sd.presentacionId = p.presentacionId 
																				WHERE	sd.productoId	= @productoTempId  AND 	
																						sd.presentacionId	= @presentacionTempId  AND
																						sd.contenedorId IS NULL AND
																						sd.FechaVencimiento >= @fechaCaducidad 
																				)
																						BEGIN 

																						IF EXISTS(	SELECT 1	
																									FROM		#SaldosProductosUbicacionesContenedores		sd
																									INNER	JOIN	[dbo].[Presentaciones] p ON sd.presentacionId = p.presentacionId 
																									WHERE	sd.productoId	= @productoTempId  AND 	
																											sd.presentacionId	= @presentacionTempId  AND
																											sd.contenedorId IS NULL AND
																											sd.FechaVencimiento <= @fechaCaducidad 
																									)
																								BEGIN 


																										SELECT @novedadId = n.novedadId FROM [dbo].[Novedades] n
																													WHERE n.novedadCodigo LIKE 'NR-001' 

																								END
																						
																								ELSE
																										BEGIN 
																												SELECT @novedadId = n.novedadId FROM [dbo].[Novedades] n
																															WHERE n.novedadCodigo LIKE 'NR-002' --validar esta regla

																								END
																		END
																	ELSE 
																			BEGIN 

																				IF EXISTS(	SELECT 1	
																									FROM		#SaldosProductosUbicacionesContenedores		sd
																									INNER	JOIN	[dbo].[Presentaciones] p ON sd.presentacionId = p.presentacionId 
																									WHERE	sd.productoId	= @productoTempId  AND 	
																											sd.presentacionId	= @presentacionTempId  AND
																											sd.contenedorId IS NULL AND
																											sd.FechaVencimiento >= @fechaCaducidad 
																											AND sd.CantidadDisponible > 0
																									)
																									BEGIN

																														SELECT @novedadId = n.novedadId FROM [dbo].[Novedades] n
																															WHERE n.novedadCodigo LIKE 'NR-002' --validar esta regla


																									END

																									ELSE
																									BEGIN

																														SELECT @novedadId = n.novedadId FROM [dbo].[Novedades] n
																															WHERE n.novedadCodigo LIKE 'NR-013' --validar esta regla


																									END
																			END
--IF(@ubicacionId IS NULL)BREAK;
--IF NOT EXISTS (SELECT 1 FROM [dbo].[PreRuteosDetalle] WHERE  preRuteoId = @preRuteoId 																			
--																			AND presentacionId = @presentacionTempId
--																			AND contenedorId =@contenedorTempId
--																			AND bodegaLogicaId =@bodegaLogicaId
--																			AND ubicacionId =@ubicacionId) AND @ubicacionId IS NOT NULL
--																			BEGIN

																			--SELECT @novedadId

																			INSERT INTO [dbo].[PreRuteosDetalle] 
																				([preRuteoId]							  
																				,[novedadId]
																				,[preRuteoPedidoEstado]
																				,[presentacionId]
																				,[contenedorId]
																				,[bodegaLogicaId]
																				,[ubicacionId]
																				,[preRuteoDetalleCantidad]
																				,[preRuteoDetalleCantRequerida]
																				,[preRuteoDetalleEstado]																				
																				,[valorProductoLoteId]
																				,[saldoId])

																				SELECT  @preRuteoId 
																						,@novedadId
																						,0
																						,@presentacionTempId
																						,@contenedorTempId
																						,@bodegaLogicaId
																						,@ubicacionId
																						,0
																						,@cantidadDetalleAux
																						,0
																						,NULL
																						,NULL

																--END
																	/******	 END	******/	
																	BREAK;
															END
														/******	 END	******/	
											END								
											FETCH NEXT 
												FROM	 PreRuteoInfo 
												INTO	 @productoTempId
														,@presentacionTempId
														,@contenedorTempId
														,@fechaCaducidad
														,@cantidadTemp	
										END
								CLOSE		PreRuteoInfo
								DEALLOCATE	PreRuteoInfo
								/******								FIN									******/


								
								

								--SELECT * FROM #SaldosProductosUbicaciones WHERE CantidadComprometida > 0 --WHERE ubicacionId			=	1950
								--SELECT * FROM #SaldosProductosUbicacionesContenedores WHERE CantidadComprometida > 0 --WHERE ubicacionId			=	1950
								
								
								INSERT INTO [dbo].[PreRuteosDetalle] 
																				([preRuteoId]							  
																				,[novedadId]
																				,[preRuteoPedidoEstado]
																				,[presentacionId]
																				,[contenedorId]
																				,[bodegaLogicaId]
																				,[ubicacionId]
																				,[preRuteoDetalleCantidad]
																				,[preRuteoDetalleCantRequerida]
																				,[preRuteoDetalleEstado]																				
																				,[valorProductoLoteId]
																				,[saldoId])																		
															SELECT				@preRuteoId
																				,1
																				,0
																				,presentacionId
																				,contenedorId
																				,bodegaLogicaId
																				,ubicacionId																				
																				,CantidadComprometida + CantidadInmovilizada
																				,CantidadComprometida
																				,0
																				,valorProductoLoteId
																				,saldoId
															FROM				#SaldosProductosUbicaciones
															WHERE				CantidadComprometida > 0
															ORDER BY rutaUbicacionOrden ASC
								

								INSERT INTO [dbo].[PreRuteosDetalle] 
																				([preRuteoId]							  
																				,[novedadId]
																				,[preRuteoPedidoEstado]
																				,[presentacionId]
																				,[contenedorId]
																				,[bodegaLogicaId]
																				,[ubicacionId]
																				,[preRuteoDetalleCantidad]
																				,[preRuteoDetalleCantRequerida]
																				,[preRuteoDetalleEstado]																				
																				,[valorProductoLoteId]
																				,[saldoId])																	
															SELECT				@preRuteoId
																				,1
																				,0
																				,presentacionId
																				,contenedorId
																				,bodegaLogicaId
																				,ubicacionId																				
																				,CantidadComprometida + CantidadInmovilizada
																				,CantidadComprometida
																				,0
																				,valorProductoLoteId
																				,saldoId
															FROM				#SaldosProductosUbicacionesContenedores
															WHERE				CantidadComprometida > 0
															ORDER BY rutaUbicacionOrden ASC
								
								/******	Actualización cantidades saldos detalles	******/
								EXEC			 [dbo].[SP_UPDATE_Saldos] @preRuteoId 	--Se actualiza los saldos detalle							
								/******					FIN							******/
								
								/******	Resultado Preruteo	******/
								SELECT			 pr.[preRuteoId]
												,pr.[preRuteoFecha]
												,pr.[preRuteoUsuario]
												,pr.[preRuteoConsecutivo]	
												,prd.[preRuteoDetalleId]
												,prd.[novedadId]
												,n.novedadDescripcion
												,prd.[presentacionId]
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,prd.[bodegaLogicaId]
												,bl.bodegaLogicaDescripcion
												--,prd.[ubicacionId]
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,prd.[preRuteoDetalleCantidad]
												,prd.[preRuteoDetalleCantNovedad]
												,prd.[preRuteoDetalleCantRequerida]												
												,prd.[contenedorId]
												,vpl.valorPlantillaLoteValor
												,''  AS resultado
								FROM			 [dbo].[PreRuteos] pr
								INNER JOIN		 [dbo].[PreRuteosDetalle] prd ON pr.preRuteoId = prd.preRuteoId
								LEFT JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId =	p.presentacionId
								INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
								LEFT JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
								LEFT JOIN		 [dbo].[Ubicaciones] u 	ON prd.[ubicacionId] = u.ubicacionId
								LEFT JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId	AND vpl.atributoLoteId = @atributoLoteIdVencimiento
								WHERE			 pr.preRuteoId = @preRuteoId
								ORDER BY		 prd.[ubicacionId]
												
								--/******		   FIN			******/
							COMMIT TRANSACTION Preruteoprocess
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION Preruteoprocess;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION Preruteoprocess;     
											END;  

							END CATCH
							END
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_ReprocesarRuteoDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC [dbo].[SP_SET_ReprocesarRuteoDetalle]  1,4111,67


CREATE PROCEDURE  [dbo].[SP_SET_ReprocesarRuteoDetalle] @ruteoId AS BIGINT,@ubicacionIdOrigen AS BIGINT, @usuarioId AS BIGINT


AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT OFF
							BEGIN TRY  
							BEGIN TRANSACTION reprocesar			
							SET DATEFORMAT YMD


							DECLARE @valorProductoLoteId BIGINT
							DECLARE @fechaVencimientoMin DATE
							DECLARE @saldoId BIGINT
							DECLARE @presentacionId BIGINT
							DECLARE @rutaUbicacionOrden BIGINT
							DECLARE @productoId BIGINT
							DECLARE @ruteoDetalleCantRequerida	DECIMAL(18,4)
							DECLARE @grupoId	BIGINT
							

							CREATE TABLE #ReglasImplicitasProductos1 (
											 documentoId					BIGINT
											,productoId						BIGINT 																			
									)


								CREATE TABLE #ReglasImplicitasUbicaciones1 (
											 documentoId						BIGINT
											,ubicacionId						BIGINT 		
											,rutaUbicacionOrden					INT
									)
									

										CREATE TABLE #saldoDetalleItem ( 
																				 [ruteoId]						BIGINT
																				,[saldoId]						BIGINT
																				,[saldoDetalleId]				BIGINT
																				,[novedadId]					BIGINT
																				,[ruteoPedidoEstado]			INT
																				,[presentacionId]				BIGINT																				
																				,[bodegaLogicaId]				BIGINT
																				,[ubicacionId]					BIGINT
																				,[detalleDisponibleManejo]			DECIMAL(18,4)
																				,[detalleDisponibleEscalar]			DECIMAL(18,4)
																				,[ruteoDetalleCantRequerida]	DECIMAL(18,4)
																				,[ruteoDetalleEstado]			INT																			
																				,[valorProductoLoteId]			BIGINT
																				,[valorPlantillaLoteValor]		DATE
																				,grupoId						BIGINT
									)
						
							-- el contenedor padre que se desea cambiar

							SELECT		TOP 1	 @saldoId = sd.saldoId
												,@presentacionId = rd.presentacionId
												,@ruteoDetalleCantRequerida = rd.ruteoDetalleCantRequerida
												,@valorProductoLoteId = rd.valorProductoLoteId
												,@fechaVencimientoMin = TRY_CONVERT(DATE,vpl.valorPlantillaLoteValor)
												,@rutaUbicacionOrden = ru.rutaUbicacionOrden
												,@productoId = pre.productoId
												,@grupoId = rd.grupoId
							FROM				[dbo].[RuteosDetalle] rd
							INNER JOIN			[dbo].[SaldosDetalle] sd ON rd.presentacionId = sd.presentacionId 
																			AND rd.bodegaLogicaId = sd.bodegaLogicaId 
																			AND rd.ubicacionId = sd.ubicacionId
																			AND rd.valorProductoLoteId = sd.valorProductoLoteId
																			AND sd.saldoDetalleComprometidoManejo > 0 
																			AND sd.saldoDetalleRealManejo > 0
							INNER JOIN			[dbo].[Presentaciones] pre ON sd.presentacionId = pre.presentacionId 
							INNER JOIN			[dbo].[RutasUbicaciones] ru ON sd.ubicacionId = ru.ubicacionId 
							INNER JOIN			[dbo].[ValoresPlantillasLotes] vpl ON sd.valorProductoLoteId = vpl.valorProductoLoteId AND vpl.atributoLoteId = 2
							WHERE rd.ubicacionId = @ubicacionIdOrigen AND rd.ruteoId = @ruteoId

								
				INSERT INTO			#ReglasImplicitasProductos1  (
																	 documentoId
																	,productoId
																)	
				
													SELECT 		TOP 1	dpl.documentoId,pld.productoId
													FROM			Documentos AS d
													INNER JOIN		DocumentosProductosListas AS dpl ON d.documentoId=dpl.documentoId
													INNER JOIN		ProductosListas AS pl ON dpl.productoListaId=pl.productoListaId
													INNER JOIN		ProductosListasDetalle AS pld ON pl.productoListaId=pld.productoListaId AND pld.productoId = @productoId
													WHERE			d.documentoCodigo='RUT'
													GROUP BY		dpl.documentoId,pld.productoId

			

				INSERT INTO											#ReglasImplicitasUbicaciones1  (
																										 documentoId
																										,ubicacionId
																										,rutaUbicacionOrden
																										)	
													SELECT			dpl.documentoId,pld.ubicacionId,ru.rutaUbicacionOrden
													FROM			Documentos AS d
													INNER JOIN		DocumentosUbicacionesListas AS dpl ON d.documentoId=dpl.documentoId
													INNER JOIN		UbicacionesListas AS pl ON dpl.ubicacionListaId=pl.ubicacionListaId
													INNER JOIN		UbicacionesListasDetalle AS pld ON pl.ubicacionListaId=pld.ubicacionListaId
													INNER JOIN		RutasUbicaciones ru ON pld.ubicacionId = ru.ubicacionId AND ru.rutaUbicacionOrden > @rutaUbicacionOrden 
																	
													WHERE			d.documentoCodigo='RUT'
													GROUP BY		dpl.documentoId,pld.ubicacionId,ru.rutaUbicacionOrden


				;WITH ubicacion_Lote_Item(saldoId,ubicacionId, valorProductoLoteId, valorPlantillaLoteValor)
				AS
				(
				
								SELECT	TOP 1						sd.saldoId, sd.ubicacionId, sd.valorProductoLoteId,TRY_CONVERT(DATE,MIN(vpl.valorPlantillaLoteValor))
																	FROM				[dbo].[SaldosDetalle] sd 
																	INNER JOIN			#ReglasImplicitasUbicaciones1 ru ON sd.ubicacionId = ru.ubicacionId AND (ru.rutaUbicacionOrden > @rutaUbicacionOrden OR ru.rutaUbicacionOrden < @rutaUbicacionOrden)
																	INNER JOIN			#ReglasImplicitasProductos1 rp ON rp.productoId = @productoId
							
																	INNER JOIN			[dbo].[ValoresPlantillasLotes] vpl	ON	sd.valorProductoLoteId = vpl.valorProductoLoteId 
																																AND vpl.atributoLoteId = 2 
																																AND TRY_CONVERT(DATE,vpl.valorPlantillaLoteValor) >= @fechaVencimientoMin
																	WHERE				sd.valorProductoLoteId = @valorProductoLoteId 
																						AND sd.saldoId = @saldoId 
																						AND sd.presentacionId = @presentacionId
																						AND sd.saldoDetalleDisponibleManejo > 0
																						AND sd.saldoDetalleRealManejo > 0 
																	GROUP BY			sd.saldoId, sd.ubicacionId, sd.valorProductoLoteId
				)
											
											
											-- el contenedor padre que se desea tomar
											
											INSERT INTO #saldoDetalleItem (		 [ruteoId]	
																				,saldoId
																				,saldoDetalleId
																				,[novedadId]					
																				,[ruteoPedidoEstado]			
																				,[presentacionId]
																				,[bodegaLogicaId]				
																				,[ubicacionId]					
																				,detalleDisponibleManejo
																				,detalleDisponibleEscalar
																				,[ruteoDetalleCantRequerida]	
																				,[ruteoDetalleEstado]																						
																				,[valorProductoLoteId]			
																				,[valorPlantillaLoteValor]
																				,grupoId
																				)

													
															SELECT						@ruteoId
																						,sd.saldoId
																						,sd.saldoDetalleId
																						,1
																						,0
																						,sd.presentacionId
																						,sd.bodegaLogicaId
																						,sd.ubicacionId																						
																						,saldoDetalleDisponibleManejo
																						,saldoDetalleDisponibleEscalar
																						,@ruteoDetalleCantRequerida
																						,0
																						,sd.valorProductoLoteId
																						,uli.valorPlantillaLoteValor
																						,@grupoId
																						
																	FROM				[dbo].[SaldosDetalle] sd 
																	INNER JOIN			ubicacion_Lote_Item uli ON	sd.saldoId = uli.saldoId 
																													AND sd.ubicacionId = uli.ubicacionId 
																													AND sd.valorProductoLoteId = uli.valorProductoLoteId 
																	
												INSERT INTO [dbo].[RuteosDetalle] 
																				([RuteoId]							  
																				,[novedadId]
																				,[RuteoPedidoEstado]
																				,[presentacionId]																				
																				,[bodegaLogicaId]
																				,[ubicacionId]
																				,[RuteoDetalleCantidad]
																				,[RuteoDetalleCantRequerida]
																				,[RuteoDetalleEstado]																				
																				,[valorProductoLoteId]
																				,grupoId
																				)		
																				
												SELECT							 [ruteoId]											  
																				,[novedadId]					
																				,[ruteoPedidoEstado]			
																				,[presentacionId]
																				,[bodegaLogicaId]				
																				,[ubicacionId]					
																				,SUM(detalleDisponibleManejo)		
																				,[ruteoDetalleCantRequerida]	
																				,[ruteoDetalleEstado]																						
																				,[valorProductoLoteId]	
																				,grupoId
											     FROM #saldoDetalleItem

												 	GROUP BY					 [ruteoId]											  
																				,[novedadId]					
																				,[ruteoPedidoEstado]			
																				,[presentacionId]
																				,[bodegaLogicaId]				
																				,[ubicacionId]																					
																				,[ruteoDetalleCantRequerida]	
																				,[ruteoDetalleEstado]																						
																				,[valorProductoLoteId]
																				,grupoId
															





																UPDATE [dbo].[SaldosDetalle]
																SET saldoDetalleComprometidoManejo = saldoDetalleComprometidoManejo + detalleDisponibleManejo,
																saldoDetalleComprometidoEscalar = saldoDetalleComprometidoEscalar + detalleDisponibleEscalar,
																saldoDetalleDisponibleManejo = saldoDetalleDisponibleManejo - detalleDisponibleManejo,
																saldoDetalleDisponibleEscalar = saldoDetalleDisponibleEscalar - detalleDisponibleEscalar
																FROM #saldoDetalleItem sdi
																WHERE  sdi.saldoId = [dbo].[SaldosDetalle].saldoId AND sdi.saldoDetalleId = [dbo].[SaldosDetalle].saldoDetalleId  
																AND [dbo].[SaldosDetalle].saldoDetalleDisponibleManejo >= sdi.detalleDisponibleManejo



						IF OBJECT_ID('tempdb..#ReglasImplicitasProductos1')		IS NOT NULL DROP TABLE #ReglasImplicitasProductos1	
						IF OBJECT_ID('tempdb..#ReglasImplicitasUbicaciones1')	IS NOT NULL DROP TABLE #ReglasImplicitasUbicaciones1
						IF OBJECT_ID('tempdb..#saldoDetalleItem')	IS NOT NULL DROP TABLE #saldoDetalleItem
						


COMMIT TRANSACTION reprocesar
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION reprocesar;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION reprocesar;     
											END;  

							END CATCH
							END









GO
/****** Object:  StoredProcedure [dbo].[SP_SET_Ruteo]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_SET_Ruteo] (@preRuteoId BIGINT, @usuarioId BIGINT)
AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION ruteo

			
							SET DATEFORMAT YMD		

IF NOT EXISTS	(SELECT 1 FROM [dbo].[Ruteos] WHERE RuteoId = @preRuteoId)
					BEGIN
						
						



							INSERT INTO									[dbo].[Ruteos]
																	   ([RuteoId]
																	   ,[RuteoFecha]
																	   ,[RuteoUsuario]
																	   ,[RuteoConsecutivo]
																	   ,[documentoId]
																	   ,[RuteoPedidoEstado])
     
							SELECT										 preRuteoId
																		,GETUTCDATE()
																		,@usuarioId
																		,preRuteoConsecutivo
																		,documentoId
																		,0 
							FROM										[dbo].[PreRuteos]
							WHERE										preRuteoId = @preRuteoId

							/****** END	******/


							
							----- falta mandar el orden y la bahia
								/****** Se inserta los pedidos asociados al preruteo confirmado a la tabla de RuteosPedidos	******/
							INSERT INTO									 [dbo].[RuteosPedidos]		    
																		 ([RuteoId]
																		,[pedidoId]
																		,pedidoProcesado)
							SELECT										 preRuteoId
																		,PedidoId
																		,0
							FROM										[dbo].[PreRuteosPedidos]
							WHERE										preRuteoId = @preRuteoId
							--/****** END	******/


								



								------- falta balanceo grupos
							--/****** Se inserta los detalles del preruteo confirmado a la tabla de RuteosDetalle	******/
							
							INSERT INTO									[dbo].[RuteosDetalle]
																	   ([RuteoId]
																	   --,[RuteoDetalleId]
																	   ,[novedadId]
																	   ,[RuteoPedidoEstado]
																	   ,[presentacionId]
																	   ,[bodegaLogicaId]
																	   ,[ubicacionId]
																	   ,[RuteoDetalleCantidad]
																	   ,[RuteoDetalleCantNovedad]
																	   ,[RuteoDetalleCantRequerida]
																	   ,[RuteoDetalleEstado]
																	   ,[contenedorId]
																	   ,[valorProductoLoteId])


							SELECT										[preRuteoId]
																	  --,[preRuteoDetalleId]
																	  ,[novedadId]
																	  ,[preRuteoPedidoEstado]
																	  ,[presentacionId]
																	  ,[bodegaLogicaId]
																	  ,[ubicacionId]
																	  ,[preRuteoDetalleCantidad]
																	  ,[preRuteoDetalleCantNovedad]
																	  ,[preRuteoDetalleCantRequerida]
																	  ,[preRuteoDetalleEstado]
																	  ,[contenedorId]
																	  ,[valorProductoLoteId]     
							FROM									   [dbo].[PreRuteosDetalle]
							WHERE										preRuteoId = @preRuteoId 
																		AND ubicacionId IS NOT NULL AND preRuteoDetalleCantidad > 0


							UPDATE [dbo].[PreRuteosDetalle]
							SET preRuteoDetalleEstado = 1
							WHERE 	preRuteoId = @preRuteoId

							UPDATE [dbo].[PreRuteos]
							SET preRuteoPedidoEstado = 1
							WHERE 	preRuteoId = @preRuteoId

							SELECT	   [ruteoId]
										  ,[ruteoFecha]
										  ,[ruteoUsuario]
										  ,[ruteoConsecutivo]
										  ,[documentoId]
										  ,[ruteoPedidoEstado]
								FROM	   [dbo].[Ruteos]
								WHERE ruteoId = @preRuteoId

								
							
							
						END	
						COMMIT TRANSACTION ruteo
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION ruteo;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION ruteo;     
											END;  

							END CATCH
							END
							
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_RuteoDetalle]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_SET_RuteoDetalle] (@ruteoId BIGINT, @usuarioId BIGINT)
AS
BEGIN
				SET NOCOUNT ON					

IF  EXISTS	(SELECT 1 FROM [dbo].[Ruteos] WHERE RuteoId = @ruteoId)
					BEGIN
					
	

							--/****** Se inserta los detalles del preruteo confirmado a la tabla de RuteosDetalle	******/
							
							INSERT INTO									[dbo].[RuteosDetalle]
																	   ([RuteoId]
																	   ,[RuteoDetalleId]
																	   ,[novedadId]
																	   ,[RuteoPedidoEstado]
																	   ,[presentacionId]
																	   ,[bodegaLogicaId]
																	   ,[ubicacionId]
																	   ,[RuteoDetalleCantidad]
																	   ,[RuteoDetalleCantNovedad]
																	   ,[RuteoDetalleCantRequerida]
																	   ,[RuteoDetalleEstado]
																	   ,[contenedorId]
																	   ,[valorProductoLoteId])


							SELECT										[preRuteoId]
																	  ,[preRuteoDetalleId]
																	  ,[novedadId]
																	  ,[preRuteoPedidoEstado]
																	  ,[presentacionId]
																	  ,[bodegaLogicaId]
																	  ,[ubicacionId]
																	  ,[preRuteoDetalleCantidad]
																	  ,[preRuteoDetalleCantNovedad]
																	  ,[preRuteoDetalleCantRequerida]
																	  ,[preRuteoDetalleEstado]
																	  ,[contenedorId]
																	  ,[valorProductoLoteId]     
							FROM									   [dbo].[PreRuteosDetalle]
							WHERE										preRuteoId = @ruteoId


							UPDATE [dbo].[PreRuteosDetalle]
							SET preRuteoDetalleEstado = 1
							WHERE 	preRuteoId = @ruteoId


							/****** END	******/
					END


END
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_PedidoPreRuteoEstado]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_UPDATE_PedidoPreRuteoEstado](
											 @estado AS TINYINT			
											,@preRuteoId AS BIGINT	
											,@usuarioId AS BIGINT
											,@uniqueProcessId AS UNIQUEIDENTIFIER
)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION pedidospreruteo

			
							SET DATEFORMAT YMD
								
								UPDATE			[dbo].[PedidosPreRuteo] 
										SET		Estado = @estado
										FROM	[dbo].[PreRuteosPedidos] AS ppr							
										WHERE	ppr.preRuteoId = @preRuteoId 
												AND [dbo].[PedidosPreRuteo].pedidoId = ppr.pedidoId
												AND [dbo].[PedidosPreRuteo].UserNameId = @usuarioId
												AND [dbo].[PedidosPreRuteo].UniqueProcessId = @uniqueProcessId

								UPDATE			[dbo].[Pedidos] 
										SET		pedidoEstado = @estado
										FROM	[dbo].[PedidosPreRuteo] AS ppr							
										WHERE	ppr.pedidoId = [dbo].[Pedidos].pedidoId 
												AND ppr.UserNameId = @usuarioId
												AND ppr.UniqueProcessId = @uniqueProcessId
												AND [dbo].[Pedidos].pedidoEstado = 0
												


COMMIT TRANSACTION pedidospreruteo
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION pedidospreruteo;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION pedidospreruteo;     
											END;  

							END CATCH
							END


GO
/****** Object:  StoredProcedure [dbo].[SP_Update_RuteoAsignarGrupos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_Update_RuteoAsignarGrupos](
											 @ruteoId AS BIGINT	
											,@grupoId AS BIGINT
											,@rutaId AS BIGINT
											,@cantidadAsignada INT
											
)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION Asignargrupos

			
							SET DATEFORMAT YMD
			
		
			UPDATE TOP(@cantidadAsignada) [dbo].[RuteosDetalle]  
			SET grupoId = @grupoId
			WHERE ruteoId =  @ruteoId AND grupoId IS NULL

					


COMMIT TRANSACTION Asignargrupos
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION Asignargrupos;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION Asignargrupos;     
											END;  

							END CATCH
							END


GO
/****** Object:  StoredProcedure [dbo].[SP_Update_RuteoGrupos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_Update_RuteoGrupos](
											 @ruteoId AS BIGINT	
											,@grupoId AS BIGINT
											,@rutaId AS BIGINT
											,@cantidadAsiganada INT
											
)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION grupos

			
							SET DATEFORMAT YMD
			
		
			UPDATE TOP(@cantidadAsiganada) [dbo].[RuteosDetalle]  
			SET grupoId = @grupoId
			WHERE ruteoId =  @ruteoId AND grupoId IS NULL

					

									

COMMIT TRANSACTION grupos
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION grupos;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION grupos;     
											END;  

							END CATCH
							END


GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_Saldos]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_UPDATE_Saldos] (@preRuteoId BIGINT)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION saldos

			
							SET DATEFORMAT YMD
			
				UPDATE [dbo].[SaldosDetalle]
													SET		saldoDetalleComprometidoManejo			= 
																										(saldoDetalleComprometidoManejo	 +	saldoDetalleDisponibleManejo) 
															,saldoDetalleInmovilizadoManejo			=	
																										saldoDetalleInmovilizadoManejo	+ 
																										(saldoDetalleRealManejo		-	(saldoDetalleComprometidoManejo		+	saldoDetalleDisponibleManejo))	
															,saldoDetalleDisponibleManejo			=	
																										saldoDetalleRealManejo	-
																										(saldoDetalleInmovilizadoManejo		+ 
																										(saldoDetalleRealManejo		-	(saldoDetalleComprometidoManejo		+	saldoDetalleDisponibleManejo)))	-
																										(saldoDetalleComprometidoManejo	 +	saldoDetalleDisponibleManejo) 	
															,saldoDetalleComprometidoEscalar		= 
																										(saldoDetalleComprometidoEscalar	+	saldoDetalleDisponibleEscalar) 	
															,saldoDetalleInmovilizadoEscalar		=	
																										saldoDetalleInmovilizadoEscalar		+ 
																										(saldoDetalleRealEscalar	-	(saldoDetalleComprometidoEscalar	+	saldoDetalleDisponibleEscalar))	
															,saldoDetalleDisponibleEscalar			=	
																										saldoDetalleRealEscalar	-
																										(saldoDetalleInmovilizadoEscalar	+ 
																										(saldoDetalleRealEscalar	-	(saldoDetalleComprometidoEscalar	+	saldoDetalleDisponibleEscalar))) -
																										(saldoDetalleComprometidoEscalar	 +	saldoDetalleDisponibleEscalar) 	
													
													FROM [dbo].[PreRuteosDetalle] AS pd	
													INNER JOIN [dbo].[Presentaciones] pr ON pd.presentacionId = pr.presentacionId-- AND pr.Estiba IS NOT NULL
													INNER JOIN [dbo].[Productos] p ON pr.productoId = p.productoId
													WHERE	pd.preRuteoId = @preRuteoId --AND pd.presentacionId = [dbo].[SaldosDetalle].presentacionId 
															AND pd.ubicacionId = [dbo].[SaldosDetalle].ubicacionId AND saldoDetalleDisponibleManejo > 0
															AND pd.valorProductoLoteId = [dbo].[SaldosDetalle].valorProductoLoteId 
															--AND pd.contenedorId IS NOT NULL
															--AND pd.contenedorId = [dbo].[SaldosDetalle].contenedorId
															--AND pd.preRuteoDetalleCantidad = pd.preRuteoDetalleCantRequerida


			
			

		
					INSERT INTO [dbo].[SaldosUbicaciones] (
														[saldoId]
													   ,[ubicacionId]
													   ,[saldoUbicacionRealManejo]
													   ,[saldoUbicacionDisponibleManejo]
													   ,[saldoUbicacionComprometidoManejo]
													   ,[saldoUbicacionInmovilizadoManejo]
													   ,[saldoUbicacionRealEscalar]	
													     ,[saldoUbicacionDisponibleEscalar]
													   ,[saldoUbicacionComprometidoEscalar]
													   ,[saldoUbicacionInmovilizadoEscalar]
													 
													   )	
						SELECT							 pd.saldoId
														,pd.ubicacionId
														,pd.preRuteoDetalleCantidad AS RealManejo
														,pd.preRuteoDetalleCantidad - (pd.preRuteoDetalleCantRequerida + (pd.preRuteoDetalleCantidad - pd.preRuteoDetalleCantRequerida))
														,pd.preRuteoDetalleCantRequerida AS comprometidoxUbicacion														
														,pd.preRuteoDetalleCantidad - pd.preRuteoDetalleCantRequerida AS InmobilizadoxUbicacion
														,pd.preRuteoDetalleCantidad * p.presentacionNumUnidad * pr.productoCantidadEscalar
														,(pd.preRuteoDetalleCantidad - (pd.preRuteoDetalleCantRequerida + (pd.preRuteoDetalleCantidad - pd.preRuteoDetalleCantRequerida))) * p.presentacionNumUnidad * pr.productoCantidadEscalar
														
														,pd.preRuteoDetalleCantRequerida * p.presentacionNumUnidad * pr.productoCantidadEscalar
														,(pd.preRuteoDetalleCantidad - pd.preRuteoDetalleCantRequerida) * p.presentacionNumUnidad * pr.productoCantidadEscalar
														
						FROM							 [dbo].[PreRuteosDetalle] AS pd	
						INNER JOIN						 [dbo].[Presentaciones] AS p ON pd.presentacionId = p.presentacionId AND p.presentacionOrden = 0
						INNER JOIN						 [dbo].[Productos] AS pr ON p.productoId = pr.productoId
						
						WHERE							 pd.preRuteoId = @preRuteoId AND pd.contenedorId IS NULL AND pd.ubicacionId IS NOT NULL
														AND pd.preRuteoDetalleCantidad <> pd.preRuteoDetalleCantRequerida
																			
						UPDATE							[dbo].[PreRuteosDetalle]
						SET								[dbo].[PreRuteosDetalle].saldoUbicacionId = su.saldoUbicacionId
						FROM [dbo].[SaldosUbicaciones] AS su	
													
													WHERE	su.saldoId = [dbo].[PreRuteosDetalle].saldoId --AND pd.presentacionId = [dbo].[SaldosDetalle].presentacionId 
															AND su.ubicacionId = [dbo].[PreRuteosDetalle].ubicacionId 
						


COMMIT TRANSACTION saldos
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION saldos;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION saldos;     
											END;  

							END CATCH
							END


GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_TxDespachoSequence]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_UPDATE_TxDespachoSequence](											 	
											@ruteoId AS BIGINT	
											,@ruteoDetalleId AS BIGINT
											,@ubicacionIdOrigen AS BIGINT, @ubicacionIdDestino AS BIGINT
)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION despachosequence

			
							SET DATEFORMAT YMD

			;WITH TXDespachoSalidas (txDespachoId, ruteoId, ruteoDetalleId, contenedorId)
			AS (
			
						SELECT		txDespachoId
									,ruteoId
									,ruteoDetalleId
									,contenedorId 
						FROM		[dbo].[TXDespacho]
						WHERE		ruteoId = @ruteoId 
									AND ruteoDetalleId = @ruteoDetalleId
									AND ubicacionId = @ubicacionIdOrigen
									AND tXDespachoConcepto = 1
			
			)



								
										UPDATE	[dbo].[TXDespacho] 
										SET		tXDespachoParentId = txDespacho1.tXDespachoId
										FROM	TXDespachoSalidas AS txDespacho1							
										WHERE	txDespacho1.ruteoId = [dbo].[TXDespacho].ruteoId 
												AND txDespacho1.ruteoDetalleId = [dbo].[TXDespacho].ruteoDetalleId
												AND [dbo].[TXDespacho].contenedorId = txDespacho1.contenedorId
												AND  [dbo].[TXDespacho].ubicacionId = @ubicacionIdDestino
												AND [dbo].[TXDespacho].tXDespachoConcepto = 2
												
									

COMMIT TRANSACTION despachosequence
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION despachosequence;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION despachosequence;     
											END;  

							END CATCH
							END


GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_TxPackingSequence]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_UPDATE_TxPackingSequence](											 	
											@ruteoId AS BIGINT	
											,@ruteoDetalleId AS BIGINT											
)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION packingequence

			
							SET DATEFORMAT YMD

			;WITH TXPackingSalidas (txPackingId, ruteoId, ruteoDetalleId, contenedorId)
			AS (
			
						SELECT		txPackingId
									,ruteoId
									,ruteoDetalleId
									,contenedorId 
						FROM		[dbo].[TXPacking]
						WHERE		ruteoId = @ruteoId 
									AND ruteoDetalleId = @ruteoDetalleId
									AND tXPackingConcepto = 1
			
			)



								
										UPDATE	[dbo].[TXPacking] 
										SET		tXPackingParentId = txPacking1.tXPackingId
										FROM	TXPackingSalidas AS txPacking1							
										WHERE	txPacking1.ruteoId = [dbo].[TXPacking].ruteoId 
												AND txPacking1.ruteoDetalleId = [dbo].[TXPacking].ruteoDetalleId
												AND [dbo].[TXPacking].contenedorId = txPacking1.contenedorId
												AND [dbo].[TXPacking].tXPackingConcepto = 2
												
									

COMMIT TRANSACTION packingequence
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION packingequence;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION packingequence;     
											END;  

							END CATCH
							END



GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_TxPickingSequence]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_UPDATE_TxPickingSequence](											 	
											@ruteoId AS BIGINT	
											,@ruteoDetalleId AS BIGINT											
)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION pickingsequence

			
							SET DATEFORMAT YMD

			;WITH TXPickingSalidas (txPickingId, ruteoId, ruteoDetalleId, contenedorId)
			AS (
			
						SELECT		txPickingId
									,ruteoId
									,ruteoDetalleId
									,contenedorId 
						FROM		[dbo].[TXPicking]
						WHERE		ruteoId = @ruteoId 
									AND ruteoDetalleId = @ruteoDetalleId
									AND tXPickingConcepto = 1
			
			)



								
										UPDATE	[dbo].[TXPicking] 
										SET		tXPickingParentId = txPicking1.tXPickingId
										FROM	TXPickingSalidas AS txPicking1							
										WHERE	txPicking1.ruteoId = [dbo].[TXPicking].ruteoId 
												AND txPicking1.ruteoDetalleId = [dbo].[TXPicking].ruteoDetalleId
												AND [dbo].[TXPicking].contenedorId = txPicking1.contenedorId
												AND [dbo].[TXPicking].tXPickingConcepto = 2
												
									


COMMIT TRANSACTION pickingsequence
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION pickingsequence;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION pickingsequence;     
											END;  

							END CATCH
							END


GO
/****** Object:  StoredProcedure [dbo].[TEST]    Script Date: 21/11/2019 14:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE  [dbo].[TEST]
AS
BEGIN
--TEMPORALMENTE ELIMINO MIENTRAS TEST
					DELETE FROM [dbo].[PreRuteosPedidos] 
					DELETE FROM [dbo].[PreRuteosDetalle] DBCC CHECKIDENT ('[PreRuteosDetalle]', RESEED, 0)
					DELETE FROM [dbo].[PreRuteos] DBCC CHECKIDENT ('[PreRuteos]', RESEED, 0)



UPDATE PedidosPreRuteo
SET Estado = 1

UPDATE  PedidosPreRuteo
SET Estado = 0

UPDATE saldos
SET saldoDisponibleManejo = saldoRealManejo
,saldoComprometidoManejo = 0
,saldoInmovilizadoManejo = 0

UPDATE saldosDetalle
SET saldoDetalleDisponibleManejo = saldoDetalleRealManejo
,saldoDetalleComprometidoManejo = 0
,saldoDetalleInmovilizadoManejo = 0

DELETE FROM NovedadesPreRuteos

EXEC [dbo].[SP_SET_PreRuteo] 0,0


SELECT * FROM NovedadesPreRuteos

SELECT *
  FROM [dbo].[SaldosDetalle]

  SELECT *
  FROM [dbo].[Saldos]
END
GO
