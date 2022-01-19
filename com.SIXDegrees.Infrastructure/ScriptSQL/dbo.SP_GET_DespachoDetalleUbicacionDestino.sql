		

CREATE PROCEDURE  [dbo].[SP_GET_DespachoDetalleUbicacionDestino](@despachoDetalleId AS BIGINT)

AS
BEGIN
DECLARE @result INT
	SELECT	@result =	COUNT(*) 
				FROM [dbo].[DespachosDetalle] desp
				INNER JOIN [dbo].[Presentaciones] p ON desp.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON desp.ubicacionId = u.ubicacionId 			 
				INNER JOIN [dbo].[Ubicaciones] ubahia ON u.ubicacionPadreId = ubahia.ubicacionId
				INNER JOIN [dbo].[Ubicaciones] upuerta ON ubahia.ubicacionPadreId = upuerta.ubicacionId
				WHERE desp.despachoDetalleId = @despachoDetalleId

IF @result > 0
BEGIN 
				
				SELECT		TOP 1	 desp.despachoId
									,desp.despachoDetalleId
									,pro.productoId
									,pro.productoCodigo
									,pro.productoDescripcion
									,p.presentacionId
									,p.presentacionCodigo
									,p.presentacionDescripcion
									,desp.despachoDetalleCantTotal									
									,upuerta.ubicacionId 
									,upuerta.ubicacionCodigo
									,upuerta.ubicacionDescripcion 
									,u.ubicacionId AS ubicacionActualId
									,u.ubicacionCodigo AS ubicacionActualId
									,u.ubicacionDescripcion AS ubicacionActualId
									,'' as resultado
				FROM [dbo].[DespachosDetalle] desp
				INNER JOIN [dbo].[Presentaciones] p ON desp.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON desp.ubicacionId = u.ubicacionId 			 
				INNER JOIN [dbo].[Ubicaciones] ubahia ON u.ubicacionPadreId = ubahia.ubicacionId
				INNER JOIN [dbo].[Ubicaciones] upuerta ON ubahia.ubicacionPadreId = upuerta.ubicacionId
				WHERE desp.despachoDetalleId = @despachoDetalleId
	END			
ELSE 
BEGIN

SELECT 'No se encuentra despacho asociado al despachoDetalleId ' + CONVERT(varchar(10), @despachoDetalleId) AS resultado
			END	

END