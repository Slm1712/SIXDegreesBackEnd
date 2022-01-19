

CREATE PROCEDURE  [dbo].[SP_Update_RuteoGrupos](
											 @ruteoId AS BIGINT	
											,@grupoId AS BIGINT
											,@rutaId AS BIGINT
											,@cantidadAsiganada INT
											
)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION grupos

			
							SET DATEFORMAT YMD
			
		
			UPDATE TOP(@cantidadAsiganada) [dbo].[RuteosDetalle]  
			SET grupoId = @grupoId
			WHERE ruteoId =  @ruteoId AND grupoId IS NULL

					

									

COMMIT TRANSACTION grupos
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION grupos;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION grupos;     
											END;  

							END CATCH
							END