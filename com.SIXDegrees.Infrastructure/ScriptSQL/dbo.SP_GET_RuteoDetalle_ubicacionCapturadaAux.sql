	
			
	CREATE PROCEDURE  [dbo].[SP_GET_RuteoDetalle_ubicacionCapturadaAux]
	(
	       
			@ubicacionCapturada AS VARCHAR(50)
	
	
	)
	AS

	BEGIN

	SET NOCOUNT ON
	




						SELECT TOP 1
				
												 r.ruteoId
												,r.ruteoFecha
												,r.ruteoUsuario
												,r.ruteoConsecutivo
												,r.ruteoPedidoEstado
												,rd.ruteoDetalleId
												,rd.novedadId
												,n.novedadDescripcion
												,rd.presentacionId
												,p.presentacionCodigo
												,p.presentacionDescripcion
												,rd.bodegaLogicaId
												,bl.bodegaLogicaDescripcion
												,rd.ubicacionId
												,u.ubicacionCodigo
												,u.ubicacionDescripcion
												,rd.ruteoDetalleCantidad
												,rd.ruteoDetalleCantNovedad
												,rd.ruteoDetalleCantRequerida											
												,rd.contenedorId
												,vpl.valorPlantillaLoteValor	
								FROM		[dbo].[Ruteos] r
								INNER JOIN		RuteosDetalle rd	ON r.ruteoId = rd.ruteoId 	AND rd.ruteoDetalleEstado = 0			
								INNER JOIN		 [dbo].[Presentaciones] p ON rd.presentacionId =	p.presentacionId 
								INNER JOIN		[dbo].[Productos] pro ON p.productoId = pro.productoId 
								INNER JOIN		[dbo].[UnidadesManejo] um ON pro.unidadManejoId = um.unidadManejoId
								INNER JOIN		 [dbo].[Novedades] n ON rd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON rd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON rd.[ubicacionId] = u.ubicacionId AND u.ubicacionCodigo LIKE @ubicacionCapturada
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  rd.[valorProductoLoteId] = vpl.valorProductoLoteId	 AND vpl.atributoLoteId = 2
								WHERE r.ruteoPedidoEstado = 0
									
		

END