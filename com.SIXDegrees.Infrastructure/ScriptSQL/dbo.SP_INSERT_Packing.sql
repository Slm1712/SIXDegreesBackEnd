

CREATE PROCEDURE  [dbo].[SP_INSERT_Packing](
									@usuarioId AS BIGINT,
									@documentoId AS BIGINT, 
									@packingId AS BIGINT OUTPUT
									)
AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION packingItem

			
							SET DATEFORMAT YMD

			
			DECLARE @consecutivo INT = 0
						DECLARE @documentoAuxId BIGINT = 0
						
						SELECT				TOP 1 @documentoAuxId	=  d.documentoId 
						FROM				[dbo].[Documentos] AS d
						WHERE				d.documentoCodigo='PACK'
						
						
															

															--Se consulta la secuencia actual del consecutivo 														
															SELECT TOP 1 @consecutivo =  DocumentoContador + 1
															FROM [dbo].[Documentos] 
															WHERE documentoId = @documentoAuxId

															--Se actualiza el consecutivo 
															IF @consecutivo IS NULL OR @consecutivo = 0
															BEGIN 
																SELECT 'No se ha configurado consecutivo para este documento'
																ROLLBACK TRANSACTION packingItem;
																RETURN
															END
															
															UPDATE [dbo].[Documentos]
															SET DocumentoContador = @consecutivo			
															WHERE DocumentoId = @documentoAuxId
								INSERT INTO [dbo].[Packing] (
									   UsuarioId
									  ,packingConsecutivo
									  ,packingEstado
									  ,documentoId
								)
								VALUES (											
											 @usuarioId
											,@consecutivo
											,0
											,@documentoId
											
								)

			SELECT @packingId = SCOPE_IDENTITY() 


COMMIT TRANSACTION packingItem
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION packingItem;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION packingItem;     
											END;  

							END CATCH
							END