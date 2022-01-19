		

CREATE PROCEDURE  [dbo].[SP_GET_packingDetalle](@packingId BIGINT, @packingDetalleId BIGINT)

AS
BEGIN
DECLARE @result INT
	SELECT	@result =	COUNT(*) 
				FROM [dbo].[PackingDetalle] pac
				INNER JOIN [dbo].[Presentaciones] p ON pac.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON pac.ubicacionMedioId = u.ubicacionId
				INNER JOIN [dbo].[RuteosPedidos] rp ON pac.pedidoId = rp.pedidoId
				INNER JOIN [dbo].[Ubicaciones] ubahia ON rp.bahiaId = ubahia.ubicacionId
				WHERE pac.packingId = @packingId AND pac.packingDetalleId = @packingDetalleId

IF @result > 0
BEGIN 
		
				SELECT		TOP 1		 pac.packingId
									,pac.packingDetalleId
									,pro.productoId
									,pro.productoCodigo
									,pro.productoDescripcion
									,p.presentacionId
									,p.presentacionCodigo
									,p.presentacionDescripcion
									,pac.packingDetalleCantTotal
									,u.ubicacionId
									,u.ubicacionCodigo
									,u.ubicacionDescripcion
									,ubahia.ubicacionId AS  bahiaId
									,ubahia.ubicacionCodigo AS  bahiaCodigo
									,ubahia.ubicacionDescripcion  AS  bahiaDescripcion	
									,'' as resultado
				FROM [dbo].[PackingDetalle] pac
				INNER JOIN [dbo].[Presentaciones] p ON pac.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON pac.ubicacionMedioId = u.ubicacionId
				INNER JOIN [dbo].[RuteosPedidos] rp ON pac.pedidoId = rp.pedidoId
				INNER JOIN [dbo].[Ubicaciones] ubahia ON rp.bahiaId = ubahia.ubicacionId
				WHERE pac.packingId = @packingId AND pac.packingDetalleId = @packingDetalleId

	END			
ELSE 
BEGIN

SELECT 'No se encuentra packing asociado al pakingDetalleId ' + CONVERT(varchar(10), @packingDetalleId) AS resultado
			END	

END