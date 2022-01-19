
CREATE PROCEDURE   [dbo].[SP_GET_PedidoDetalle](@pedidoId BIGINT)

AS
BEGIN

DECLARE @result INT
	SELECT	@result =	COUNT(*) 
				FROM [dbo].[PedidosDetalle] p
INNER JOIN [dbo].[Presentaciones] pres ON p.presentacionId = pres.presentacionId
INNER JOIN [dbo].[Productos] prod ON p.productoId = prod.productoId
INNER JOIN [dbo].[PuntosEnvio] pto ON  p.puntoEnvioId = pto.puntoEnvioId
INNER JOIN [dbo].[Ciudades] ciu ON  pto.ciudadId = ciu.ciudadId
INNER JOIN [dbo].[Estados] est ON  ciu.estadoId = est.estadoId
WHERE p.pedidoId = @pedidoId
IF @result > 0
BEGIN 
SELECT			 p.pedidoId
				,p.pedidoDetalleId
				,p.pedidoDetalleVersion
				,p.productoTipoId
				,(	CASE	WHEN p.productoTipoId = 0 THEN 'NORMAL' 
							WHEN p.productoTipoId = 1 THEN 'COMBO'
							WHEN p.productoTipoId = 2 THEN 'KIT'
							ELSE '' 
					END	) AS productoTipoDescripcion
				,prod.productoId
				,prod.productoDescripcion
				,pres.presentacionId
				,pres.presentacionDescripcion
				,p.pedidoDetalleCantidad
				,pto.puntoEnvioId
				,pto.puntoEnvioCodigo
				,pto.puntoEnvioNombre
				,pto.puntoEnvioDireccion
				,pto.puntoEnvioTelefono
				,est.estadoId
				,est.estadoNombre
				,ciu.ciudadId
				,ciu.ciudadNombre 
				,'' AS resultado
FROM [dbo].[PedidosDetalle] p
INNER JOIN [dbo].[Presentaciones] pres ON p.presentacionId = pres.presentacionId
INNER JOIN [dbo].[Productos] prod ON p.productoId = prod.productoId
INNER JOIN [dbo].[PuntosEnvio] pto ON  p.puntoEnvioId = pto.puntoEnvioId
INNER JOIN [dbo].[Ciudades] ciu ON  pto.ciudadId = ciu.ciudadId
INNER JOIN [dbo].[Estados] est ON  ciu.estadoId = est.estadoId
WHERE p.pedidoId = @pedidoId
	
	END			
ELSE 
BEGIN

SELECT 'No se encuentra detalle asociado al pedidoId ' + CONVERT(varchar(10), @pedidoId) AS resultado
			END	

END