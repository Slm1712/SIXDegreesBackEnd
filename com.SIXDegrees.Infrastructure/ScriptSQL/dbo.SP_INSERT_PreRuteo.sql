

CREATE PROCEDURE  [dbo].[SP_INSERT_PreRuteo](
									@usuarioId AS BIGINT,
									@documentoId AS BIGINT,
									@consecutivo AS INT,
									@preRuteoId AS BIGINT OUTPUT
									)
AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION Preruteo

			
							SET DATEFORMAT YMD
						
						
						
						/****** Se inserta el preruteo confirmado a la tabla de ruteos	******/
						
														
								INSERT INTO [dbo].[PreRuteos] (
									 preRuteoFecha
									,preRuteoUsuario
									,preRuteoConsecutivo
									,documentoId
									,preRuteoPedidoEstado
								)
								VALUES (
											 GETDATE() 
											,@usuarioId
											,@consecutivo
											,@documentoId
											,0
								)


								UPDATE [dbo].[Documentos]
															SET DocumentoContador = @consecutivo			
															WHERE DocumentoId = @documentoId

			SELECT @preRuteoId = SCOPE_IDENTITY() 
	COMMIT TRANSACTION Preruteo
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION Preruteo;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION Preruteo;     
											END;  

							END CATCH
							END