

CREATE PROCEDURE  [dbo].[SP_INSERT_Despacho](
									@usuarioId AS BIGINT,
									@documentoId AS BIGINT, 									
									@despachoId AS BIGINT OUTPUT
									)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION despachoItem

			
							SET DATEFORMAT YMD
			DECLARE @consecutivo INT = 0
						DECLARE @documentoAuxId BIGINT = 0
						
						SELECT				TOP 1 @documentoAuxId	=  d.documentoId 
						FROM				[dbo].[Documentos] AS d
						WHERE				d.documentoCodigo='DESP'
						
						
															

															--Se consulta la secuencia actual del consecutivo 														
															SELECT TOP 1 @consecutivo =  DocumentoContador + 1
															FROM [dbo].[Documentos] 
															WHERE documentoId = @documentoAuxId

															--Se actualiza el consecutivo 
															IF @consecutivo IS NULL OR @consecutivo = 0
															BEGIN
															SELECT 'No se ha configurado consecutivo para este documento'  AS resultado
															COMMIT TRANSACTION despachoItem;  
															RETURN
															END
															UPDATE [dbo].[Documentos]
															SET DocumentoContador = @consecutivo			
															WHERE DocumentoId = @documentoAuxId
			
								INSERT INTO [dbo].[Despachos] (
									   UsuarioId
									  ,despachoConsecutivo
									  ,despachoEstado
									  ,documentoId
								)
								VALUES (											
											 @usuarioId
											,@consecutivo
											,0
											,@documentoId
											
								)

			SELECT @despachoId = SCOPE_IDENTITY() 


COMMIT TRANSACTION despachoItem
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION despachoItem;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION despachoItem;     
											END;  

							END CATCH
							END