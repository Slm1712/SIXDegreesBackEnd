CREATE PROCEDURE  [dbo].[SP_GET_PreruteoDetalle] (@preRuteoId AS BIGINT)
AS
BEGIN

DECLARE @documentoId BIGINT = 0



IF OBJECT_ID('tempdb..#RutasUbicaciones')	IS NOT NULL DROP TABLE #RutasUbicaciones

		CREATE TABLE #RutasUbicaciones (
											 rutaUbicacionId					BIGINT
											,rutaId								BIGINT 		
											,ubicacionId						BIGINT
											,rutaUbicacionOrden					INT
											,ubicacionCodigo					VARCHAR(100)
											,ubicacionDescripcion				VARCHAR(50)
									)


				/******								FIN									******/					
				
				
SELECT				TOP 1 @documentoId	=  d.documentoId 
						FROM				[dbo].[Documentos] AS d
						WHERE				d.documentoCodigo='RUT'



				INSERT INTO #RutasUbicaciones (rutaUbicacionId, rutaId, ubicacionId, rutaUbicacionOrden, ubicacionCodigo, ubicacionDescripcion)
				SELECT ru.rutaUbicacionId,ru.rutaId,ru.UbicacionId,ru.rutaUbicacionOrden, u.ubicacionCodigo, u.ubicacionDescripcion FROM [dbo].[RutasUbicaciones] ru
				INNER JOIN     Ubicaciones u on ru.ubicacionId = u.ubicacionId AND u.ubicacionDescripcion LIKE 'GENERAL'
				
				ORDER BY ru.rutaUbicacionOrden

				DECLARE @result INT
	SELECT	@result =	COUNT(*) 
				FROM			 [dbo].[PreRuteos] pr
								INNER JOIN		 [dbo].[PreRuteosDetalle] prd ON pr.preRuteoId = prd.preRuteoId
								INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId =	p.presentacionId
								INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 #RutasUbicaciones u 	ON prd.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId AND vpl.atributoLoteId = 2  	
								WHERE prd.preRuteoId = @preRuteoId AND prd.preRuteoDetalleEstado = 0 AND pr.preRuteoPedidoEstado = 0
								

IF @result > 0
BEGIN 


SELECT			 pr.[preRuteoId]
												,pr.[preRuteoFecha]
												,pr.[preRuteoUsuario]
												,pr.[preRuteoConsecutivo]	
												,prd.[preRuteoDetalleId]
												,prd.[novedadId]
												,n.novedadDescripcion
												,prd.[presentacionId]
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,prd.[bodegaLogicaId]
												,bl.bodegaLogicaDescripcion
												--,prd.[ubicacionId]
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,prd.[preRuteoDetalleCantidad]
												,prd.[preRuteoDetalleCantNovedad]
												,prd.[preRuteoDetalleCantRequerida]												
												,prd.[contenedorId]
												,vpl.valorPlantillaLoteValor
												, '' AS resultado
								FROM			 [dbo].[PreRuteos] pr
								INNER JOIN		 [dbo].[PreRuteosDetalle] prd ON pr.preRuteoId = prd.preRuteoId
								INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId =	p.presentacionId
								INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 #RutasUbicaciones u 	ON prd.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId AND vpl.atributoLoteId = 2  	
								WHERE prd.preRuteoId = @preRuteoId AND prd.preRuteoDetalleEstado = 0 AND pr.preRuteoPedidoEstado = 0
								ORDER BY u.rutaUbicacionOrden
	END			
ELSE 
BEGIN

SELECT 'No se encuentra pre ruteo asociado al preruteoId ' + CONVERT(varchar(10), @preRuteoId) AS resultado
			END	

END