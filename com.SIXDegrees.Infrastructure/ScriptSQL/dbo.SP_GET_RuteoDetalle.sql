CREATE PROCEDURE  [dbo].[SP_GET_RuteoDetalle] (@ruteoId AS BIGINT, @ruteoDetalleId AS BIGINT)
AS
BEGIN


IF( @ruteoDetalleId = 0)
BEGIN
SELECT											 pr.[ruteoId]
												,pr.[ruteoFecha]
												,pr.[ruteoUsuario]
												,pr.[ruteoConsecutivo]
												,pr.ruteoPedidoEstado
												,prd.[ruteoDetalleId]
												,prd.[novedadId]
												,n.novedadDescripcion
												,prd.[presentacionId]
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,prd.[bodegaLogicaId]
												,bl.bodegaLogicaDescripcion
												,prd.[ubicacionId]
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,prd.[ruteoDetalleCantidad]
												,prd.[ruteoDetalleCantNovedad]
												,prd.[ruteoDetalleCantRequerida]												
												,prd.[contenedorId]
												,vpl.valorPlantillaLoteValor	
								FROM			 [dbo].[ruteos] pr								
								
								INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = pr.ruteoId AND prd.ruteoDetalleCantidad > 0 
								INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId =	p.presentacionId
								INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON prd.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId	
								WHERE pr.ruteoId = @ruteoId 
									END		
ELSE 
BEGIN
		SELECT			 pr.[ruteoId]
												,pr.[ruteoFecha]
												,pr.[ruteoUsuario]
												,pr.[ruteoConsecutivo]
												,pr.ruteoPedidoEstado
												,prd.[ruteoDetalleId]
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
												,prd.[ruteoDetalleCantidad]
												,prd.[ruteoDetalleCantNovedad]
												,prd.[ruteoDetalleCantRequerida]												
												,prd.[contenedorId]
												,vpl.valorPlantillaLoteValor	
								FROM			 [dbo].[ruteos] pr
								INNER JOIN		 [dbo].[ruteosPedidos] rp ON pr.ruteoId = rp.ruteoId
								INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = prd.ruteoId
								INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId =	p.presentacionId
								INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON prd.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId	
								WHERE prd.ruteoId = @ruteoId AND prd.[ruteoDetalleId] = @ruteoDetalleId
			END		
		
		END