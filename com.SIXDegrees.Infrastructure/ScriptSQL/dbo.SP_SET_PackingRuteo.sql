USE [TecnoCEDI_bd]
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_PackingRuteo]    Script Date: 21/11/2019 16:33:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE  [dbo].[SP_SET_PackingRuteo](@usuarioId AS BIGINT, @ruteoDetalleId AS BIGINT, @novedadId AS BIGINT, @novedadAccionId AS BIGINT, @codigoUbicacionBahia AS VARCHAR(50))

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

										IF NOT EXISTS(SELECT 1 FROM [dbo].[RuteosDetalle]  where ruteoId =  @ruteoId AND ruteoDetalleEstado = 0)	
										BEGIN 
													--IF NOT EXISTS(SELECT 1 FROM [dbo].[PackingDetalle]  where ruteoId =  @ruteoId AND packingEstado = 0)	
													--BEGIN 
																UPDATE TOP(1) [dbo].[Ruteos] 
																SET ruteoPedidoEstado = 1
																WHERE ruteoId = @ruteoId	
													--END
												
										END


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
