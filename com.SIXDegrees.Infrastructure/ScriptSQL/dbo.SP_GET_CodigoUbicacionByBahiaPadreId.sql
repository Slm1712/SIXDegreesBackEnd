CREATE PROCEDURE  [dbo].[SP_GET_CodigoUbicacionByBahiaPadreId] (@bahiaPadreId AS BIGINT, @usuarioId AS BIGINT)
AS
BEGIN

DECLARE @rFIDTagEPC VARCHAR(50)

SELECT TOP 1 @rFIDTagEPC = REPLACE(r.RFIDTagEPC, '00000092', '') FROM [dbo].[Usuarios] u
INNER JOIN [RFIDTag] r ON u.usuarioUser = r.RFIDTagMaquina AND RFIDTagTipo_EPC LIKE 'Ubicacion'
WHERE u.usuarioId = @usuarioId


SELECT u.ubicacionCodigo AS RFIDTagEPC, 
(CASE WHEN (u.ubicacionCodigo IS NULL OR u.ubicacionCodigo LIKE '')  THEN 'No se encuentra ubicación asociada al usuario ' + CONVERT(varchar(10), @usuarioId)
ELSE '' END) AS resultado FROM [dbo].[Ubicaciones] u 
WHERE ubicacionPadreId = @bahiaPadreId AND u.ubicacionCodigo = @rFIDTagEPC 



END