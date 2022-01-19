

CREATE PROCEDURE  [dbo].[SP_UPDATE_TxPickingSequence](											 	
											@ruteoId AS BIGINT	
											,@ruteoDetalleId AS BIGINT											
)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION pickingsequence

			
							SET DATEFORMAT YMD

			;WITH TXPickingSalidas (txPickingId, ruteoId, ruteoDetalleId, contenedorId)
			AS (
			
						SELECT		txPickingId
									,ruteoId
									,ruteoDetalleId
									,contenedorId 
						FROM		[dbo].[TXPicking]
						WHERE		ruteoId = @ruteoId 
									AND ruteoDetalleId = @ruteoDetalleId
									AND tXPickingConcepto = 1
			
			)



								
										UPDATE	[dbo].[TXPicking] 
										SET		tXPickingParentId = txPicking1.tXPickingId
										FROM	TXPickingSalidas AS txPicking1							
										WHERE	txPicking1.ruteoId = [dbo].[TXPicking].ruteoId 
												AND txPicking1.ruteoDetalleId = [dbo].[TXPicking].ruteoDetalleId
												AND [dbo].[TXPicking].contenedorId = txPicking1.contenedorId
												AND [dbo].[TXPicking].tXPickingConcepto = 2
												
									


COMMIT TRANSACTION pickingsequence
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION pickingsequence;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION pickingsequence;     
											END;  

							END CATCH
							END