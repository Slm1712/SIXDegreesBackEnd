CREATE PROCEDURE  [dbo].[SP_GET_RuteosPedidosProductos](@ruteoId BIGINT)
AS
BEGIN 

				SELECT			 pr.productoId
								,pr.productoCodigo
								,pr.productoDescripcion
								,p.presentacionId
								,p.presentacionCodigo
								,p.presentacionDescripcion
								,rd.ruteoId
							
				FROM			[dbo].[RuteosDetalle] rd 
				INNER JOIN		[dbo].[Presentaciones] p ON rd.presentacionId = p.presentacionId
				INNER JOIN		[dbo].[Productos] pr ON p.productoId = pr.productoId
				WHERE			 rd.ruteoId = @ruteoId AND rd.ubicacionId IS NOT NULL AND rd.ruteoDetalleEstado = 0
				GROUP BY		 pr.productoId
								,pr.productoCodigo
								,pr.productoDescripcion
								,p.presentacionId
								,p.presentacionCodigo
								,p.presentacionDescripcion
								,rd.ruteoId
				ORDER BY		pr.productoDescripcion
								




END