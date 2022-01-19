

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