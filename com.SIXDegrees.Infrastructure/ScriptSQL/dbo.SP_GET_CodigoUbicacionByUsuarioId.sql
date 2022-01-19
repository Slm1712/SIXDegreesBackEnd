--EXEC [dbo].[SP_GET_CodigoUbicacionByUsuarioId]  67
CREATE PROCEDURE  [dbo].[SP_GET_CodigoUbicacionByUsuarioId] (@usuarioId AS BIGINT)
AS
BEGIN

DECLARE @ubicacionCapturadaId BIGINT
DECLARE @usuarioIdentificacion VARCHAR(50)
DECLARE @tipoUbicacion VARCHAR(50)
DECLARE @resultadoUsuario VARCHAR(50)
DECLARE @resultadoUbicacion VARCHAR(50)

DECLARE @ubicacionDescripcion VARCHAR(50)
DECLARE @RFIDTagEPC VARCHAR(100)

SELECT TOP 1 @RFIDTagEPC= REPLACE(r.RFIDTagEPC, '00000092', '') , @usuarioIdentificacion = u.usuarioIdentificacion
FROM [dbo].[Usuarios] u
INNER JOIN RFIDTag r ON u.usuarioUser = r.RFIDTagMaquina AND RFIDTagTipo_EPC LIKE 'Ubicacion'
WHERE u.usuarioId = @usuarioId





SELECT TOP 1 @ubicacionCapturadaId = ubicacionId, @ubicacionDescripcion = ubicacionDescripcion,  @tipoUbicacion = tipoUbicacionId FROM [dbo].[Ubicaciones] WHERE ubicacionCodigo = @RFIDTagEPC


IF @tipoUbicacion = 2 OR @tipoUbicacion = 4
						BEGIN

						

								SELECT  TOP 1 @resultadoUbicacion = 'La bahía ' + @ubicacionDescripcion + ' tiene saldo activo'    FROM [dbo].[SaldosDetalle]  sd
								INNER JOIN [dbo].[Ubicaciones]  u ON sd.ubicacionId =u.ubicacionId AND u.tipoUbicacionId = @tipoUbicacion AND u.ubicacionCodigo LIKE @RFIDTagEPC
								WHERE  sd.saldoDetalleRealManejo > 0 AND sd.saldoDetalleComprometidoManejo > 0
								
						END
ELSE IF @tipoUbicacion = 1 OR @tipoUbicacion = 3
						BEGIN 

						

								SELECT  TOP 1 @resultadoUsuario = 'El usuario tiene saldo activo'      FROM [dbo].[SaldosDetalle]  sd
								INNER JOIN [dbo].[Ubicaciones]  u ON sd.ubicacionId = u.ubicacionId AND u.tipoUbicacionId = @tipoUbicacion AND u.ubicacionCodigo LIKE @usuarioIdentificacion
								WHERE  sd.saldoDetalleRealManejo > 0 AND sd.saldoDetalleComprometidoManejo > 0
								 

						END


ELSE
BEGIN
SET @resultadoUbicacion = ''
SET @resultadoUsuario = ''
END


SELECT @RFIDTagEPC AS RFIDTagEPC, ISNULL(@resultadoUsuario,'') AS resultadoUsuario, ISNULL(@resultadoUbicacion,'') AS resultadoUbicacion 







END