USE [TecnoCEDI_bd]
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_PreRuteo]    Script Date: 21/11/2019 15:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE  [dbo].[SP_SET_PreRuteo] (
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
								
				/******					Eliminar tablas temporales por si quedan en memoria					******/
						IF OBJECT_ID('tempdb..#PedidosProductosCaducidad')		IS NOT NULL DROP TABLE #PedidosProductosCaducidad
						IF OBJECT_ID('tempdb..#SaldosProductos')				IS NOT NULL DROP TABLE #SaldosProductos	
						IF OBJECT_ID('tempdb..#SaldosProductosUbicaciones')		IS NOT NULL DROP TABLE #SaldosProductosUbicaciones
						IF OBJECT_ID('tempdb..#ReglasImplicitasProductos')		IS NOT NULL DROP TABLE #ReglasImplicitasProductos	
						IF OBJECT_ID('tempdb..#ReglasImplicitasUbicaciones')	IS NOT NULL DROP TABLE #ReglasImplicitasUbicaciones
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
