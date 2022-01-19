CREATE PROCEDURE  [dbo].[SP_GET_RutasRuteoxGrupoId] (@preRuteoId BIGINT, @grupoId BIGINT)

AS
BEGIN

								SELECT ru.rutaId, rg.grupoId, 0
								
														FROM RuteosDetalle rd
														 INNER JOIN RutasUbicaciones ru ON rd.ubicacionId = ru.ubicacionId 
														 INNER JOIN DocumentosRutas dr ON ru.rutaId = dr.rutaId
														 INNER JOIN Documentos d ON dr.documentoId = d.documentoId AND documentoCodigo LIKE  'RUT'
														 INNER JOIN RutasGrupos rg ON ru.rutaId = rg.rutaId
														WHERE  rd.ruteoId = @preRuteoId AND  rg.grupoId = @grupoId

								GROUP BY ru.rutaId, rg.grupoId
								HAVING COUNT(rd.ruteoDetalleId) > 0


								END