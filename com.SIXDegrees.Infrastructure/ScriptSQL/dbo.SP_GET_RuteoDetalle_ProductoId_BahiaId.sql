USE [TecnoCEDI_bd]
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_RuteoDetalle_ProductoId_BahiaId]    Script Date: 21/11/2019 15:54:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		--EXEC  [dbo].[SP_GET_RuteoDetalle_ProductoId_BahiaId] 0,0,1
			
	ALTER PROCEDURE  [dbo].[SP_GET_RuteoDetalle_ProductoId_BahiaId]
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
														,@cantidadRequeridaAux
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


							IF OBJECT_ID('tempdb..#RuteoPedidosDetalleTemp') IS NOT NULL DROP TABLE #RuteoPedidosDetalleTemp		
						IF OBJECT_ID('tempdb..#RuteosDetalleTemp') IS NOT NULL DROP TABLE #RuteosDetalleTemp
						IF OBJECT_ID('tempdb..#AsignacionRuteoDetallePedidoTemp') IS NOT NULL DROP TABLE #AsignacionRuteoDetallePedidoTemp
						IF OBJECT_ID('tempdb..#packingProcesadoTemp')  IS NOT NULL DROP TABLE #packingProcesadoTemp

		

			
									

END
