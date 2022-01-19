

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