

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