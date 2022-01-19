
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