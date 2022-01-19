
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


																--EXEC pdn.Contegral..[Picking_Integracion_EliminarSaldo] @ubicacionIdOrigen


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