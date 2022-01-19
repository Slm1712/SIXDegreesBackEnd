

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