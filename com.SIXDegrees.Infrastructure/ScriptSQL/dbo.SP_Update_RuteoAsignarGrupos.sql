

CREATE PROCEDURE  [dbo].[SP_Update_RuteoAsignarGrupos](
											 @ruteoId AS BIGINT	
											,@grupoId AS BIGINT
											,@rutaId AS BIGINT
											,@cantidadAsignada INT
											
)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION Asignargrupos

			
							SET DATEFORMAT YMD
			
		
			UPDATE TOP(@cantidadAsignada) [dbo].[RuteosDetalle]  
			SET grupoId = @grupoId
			WHERE ruteoId =  @ruteoId AND grupoId IS NULL

					


COMMIT TRANSACTION Asignargrupos
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION Asignargrupos;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION Asignargrupos;     
											END;  

							END CATCH
							END