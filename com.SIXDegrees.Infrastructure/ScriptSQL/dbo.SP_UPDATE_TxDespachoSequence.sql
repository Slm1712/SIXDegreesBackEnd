

CREATE PROCEDURE  [dbo].[SP_UPDATE_TxDespachoSequence](											 	
											@ruteoId AS BIGINT	
											,@ruteoDetalleId AS BIGINT
											,@ubicacionIdOrigen AS BIGINT, @ubicacionIdDestino AS BIGINT
)

AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION despachosequence

			
							SET DATEFORMAT YMD

			;WITH TXDespachoSalidas (txDespachoId, ruteoId, ruteoDetalleId, contenedorId)
			AS (
			
						SELECT		txDespachoId
									,ruteoId
									,ruteoDetalleId
									,contenedorId 
						FROM		[dbo].[TXDespacho]
						WHERE		ruteoId = @ruteoId 
									AND ruteoDetalleId = @ruteoDetalleId
									AND ubicacionId = @ubicacionIdOrigen
									AND tXDespachoConcepto = 1
			
			)



								
										UPDATE	[dbo].[TXDespacho] 
										SET		tXDespachoParentId = txDespacho1.tXDespachoId
										FROM	TXDespachoSalidas AS txDespacho1							
										WHERE	txDespacho1.ruteoId = [dbo].[TXDespacho].ruteoId 
												AND txDespacho1.ruteoDetalleId = [dbo].[TXDespacho].ruteoDetalleId
												AND [dbo].[TXDespacho].contenedorId = txDespacho1.contenedorId
												AND  [dbo].[TXDespacho].ubicacionId = @ubicacionIdDestino
												AND [dbo].[TXDespacho].tXDespachoConcepto = 2
												
									

COMMIT TRANSACTION despachosequence
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION despachosequence;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION despachosequence;     
											END;  

							END CATCH
							END