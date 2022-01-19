

CREATE PROCEDURE  [dbo].[SP_UPDATE_TxPackingSequence](											 	
											@ruteoId AS BIGINT	
											,@ruteoDetalleId AS BIGINT											
)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION packingequence

			
							SET DATEFORMAT YMD

			;WITH TXPackingSalidas (txPackingId, ruteoId, ruteoDetalleId, contenedorId)
			AS (
			
						SELECT		txPackingId
									,ruteoId
									,ruteoDetalleId
									,contenedorId 
						FROM		[dbo].[TXPacking]
						WHERE		ruteoId = @ruteoId 
									AND ruteoDetalleId = @ruteoDetalleId
									AND tXPackingConcepto = 1
			
			)



								
										UPDATE	[dbo].[TXPacking] 
										SET		tXPackingParentId = txPacking1.tXPackingId
										FROM	TXPackingSalidas AS txPacking1							
										WHERE	txPacking1.ruteoId = [dbo].[TXPacking].ruteoId 
												AND txPacking1.ruteoDetalleId = [dbo].[TXPacking].ruteoDetalleId
												AND [dbo].[TXPacking].contenedorId = txPacking1.contenedorId
												AND [dbo].[TXPacking].tXPackingConcepto = 2
												
									

COMMIT TRANSACTION packingequence
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION packingequence;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION packingequence;     
											END;  

							END CATCH
							END