

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