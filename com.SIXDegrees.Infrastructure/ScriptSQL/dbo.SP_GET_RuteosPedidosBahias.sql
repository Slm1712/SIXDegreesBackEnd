CREATE PROCEDURE  [dbo].[SP_GET_RuteosPedidosBahias](@ruteoId BIGINT)
AS
BEGIN 

				SELECT				 u.ubicacionId
									,u.ubicacionCodigo
									,u.ubicacionDescripcion
									,u.tipoUbicacionId
									,rp.ruteoId
				FROM				[dbo].[RuteosPedidos] rp 
				INNER JOIN			[dbo].[Ubicaciones] u ON rp.bahiaId = u.ubicacionId
				INNER JOIN			[dbo].[TiposUbicaciones] t ON u.tipoUbicacionId = t.tipoUbicacionId
				WHERE				rp.ruteoId = @ruteoId
				GROUP BY			 u.ubicacionId
									,u.ubicacionCodigo
									,u.ubicacionDescripcion
									,u.tipoUbicacionId
									,rp.ruteoId
				ORDER BY			u.ubicacionDescripcion




END