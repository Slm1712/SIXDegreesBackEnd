		--EXEC [dbo].[SP_GET_packingDetalle_ubicacionCodigo] 67

CREATE PROCEDURE  [dbo].[SP_GET_packingDetalle_ubicacionCodigo](@usuarioId BIGINT)

AS
BEGIN


DECLARE @packingId BIGINT
DECLARE @packingDetalleId BIGINT
DECLARE @ubicacionId BIGINT
DECLARE @ubicacionCodigo VARCHAR(100)
DECLARE @ruteoId BIGINT
DECLARE @ruteoDetalleId BIGINT
DECLARE @totalRow VARCHAR(20)

IF @usuarioId IS NULL 
		BEGIN 
				SELECT   @packingId AS packingId
						,@packingDetalleId AS packingDetalleId
						,@ubicacionId  AS ubicacionId
						,@ubicacionCodigo AS ubicacionCodigo
						,@ruteoId  AS ruteoId
						,@ruteoDetalleId  AS ruteoDetalleId
						,'No existe el usuario ' + CONVERT(VARCHAR(20),@usuarioId) AS resultado
				RETURN
		END

		SELECT TOP(1)	@ubicacionId = ub.ubicacionId, @ubicacionCodigo = ub.ubicacionCodigo FROM [dbo].[Usuarios] u 
						INNER JOIN [dbo].[Ubicaciones] ub ON u.usuarioIdentificacion = ub.ubicacionCodigo
						WHERE u.usuarioId = @usuarioId

IF  @ubicacionCodigo IS NULL OR @ubicacionCodigo LIKE ''
		BEGIN 

		

				SELECT   @packingId AS packingId
						,@packingDetalleId AS packingDetalleId
						,@ubicacionId  AS ubicacionId
						,@ubicacionCodigo AS ubicacionCodigo
						,@ruteoId  AS ruteoId
						,@ruteoDetalleId  AS ruteoDetalleId
						,'No existe ubicación código para el usuario '  + CONVERT(VARCHAR(20),@usuarioId) AS resultado
				RETURN
		END
ELSE

		BEGIN	
				SELECT		TOP 1	 
									 @packingId = pac.packingId 
									,@packingDetalleId = pac.packingDetalleId
									,@ruteoId = pac.ruteoId
									,@ruteoDetalleId = pac.ruteoDetalleId
									,@totalRow = CONVERT(VARCHAR(20), ROW_NUMBER() OVER(ORDER BY pac.packingId ASC)) 																		
				FROM [dbo].[PackingDetalle] pac				
				WHERE pac.ubicacionMedioId = @ubicacionId AND pac.packingEstado = 0


				SELECT   @packingId AS packingId
						,@packingDetalleId AS packingDetalleId
						,@ubicacionId  AS ubicacionId
						,@ubicacionCodigo AS ubicacionCodigo
						,@ruteoId  AS ruteoId
						,@ruteoDetalleId  AS ruteoDetalleId
						,ISNULL(@totalRow,'')  AS resultado --Si es 0 no tiene asigando packing saldo continua a bandeja picking 

		END
END