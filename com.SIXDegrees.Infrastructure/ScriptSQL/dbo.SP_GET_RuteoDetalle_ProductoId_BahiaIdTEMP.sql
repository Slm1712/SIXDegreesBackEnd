		
			
	CREATE PROCEDURE  [dbo].[SP_GET_RuteoDetalle_ProductoId_BahiaIdTEMP]
	(
	         @bahiaId AS BIGINT 
			,@productoId AS BIGINT 	
			,@ruteoId AS BIGINT
	
	
	)
	AS

	BEGIN

	IF (@bahiaId > 0 ) AND (@productoId > 0  )
	BEGIN
				SELECT					TOP 1
												 pr.[ruteoId]
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
								INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = prd.ruteoId AND prd.ruteoDetalleCantidad > 0 AND prd.ubicacionId IS NOT NULL AND prd.ruteoDetalleEstado = 0
								INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId =	p.presentacionId AND p.productoId = @productoId
								INNER JOIN		[dbo].[RuteosPedidos] rp ON prd.ruteoId = rp.ruteoId AND rp.bahiaId = @bahiaId
								INNER JOIN		[dbo].[PedidosDetalle] pd ON rp.pedidoId = pd.pedidoId AND p.presentacionId = pd.presentacionId
								INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON prd.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId	
								WHERE pr.ruteoId = @ruteoId 
								GROUP BY  pr.[ruteoId]
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
										ORDER BY prd.[ubicacionId]
			END

	ELSE IF (@bahiaId = 0  ) AND (@productoId > 0   )
				BEGIN
							SELECT			TOP 1
							
															pr.[ruteoId]
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
											INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = prd.ruteoId AND prd.ruteoDetalleCantidad > 0 AND  prd.ubicacionId IS NOT NULL AND prd.ruteoDetalleEstado = 0
											INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId = p.presentacionId	AND p.productoId = @productoId							
											INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
											INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
											INNER JOIN		 [dbo].[Ubicaciones] u 	ON prd.[ubicacionId] = u.ubicacionId
											INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId	
											WHERE pr.ruteoId = @ruteoId 
											GROUP BY  pr.[ruteoId]
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
													ORDER BY prd.[ubicacionId]
						END

			ELSE IF (@productoId = 0 ) AND (@bahiaId > 0   )
							BEGIN
							SELECT				TOP 1
																pr.[ruteoId]
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
												INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = prd.ruteoId AND prd.ruteoDetalleCantidad > 0 AND prd.ubicacionId IS NOT NULL AND prd.ruteoDetalleEstado = 0
												INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId =	p.presentacionId
												INNER JOIN		[dbo].[RuteosPedidos] rp ON prd.ruteoId = rp.ruteoId AND rp.bahiaId = @bahiaId
												INNER JOIN		[dbo].[PedidosDetalle] pd ON rp.pedidoId = pd.pedidoId AND p.presentacionId = pd.presentacionId
												INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
												INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
												INNER JOIN		 [dbo].[Ubicaciones] u 	ON prd.[ubicacionId] = u.ubicacionId
												INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId	
												WHERE pr.ruteoId = @ruteoId 
												GROUP BY  pr.[ruteoId]
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
														ORDER BY prd.[ubicacionId]

						END

						ELSE 
						BEGIN

							SELECT				TOP 1
												pr.[ruteoId]
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
								INNER JOIN		 [dbo].[ruteosDetalle] prd ON pr.ruteoId = prd.ruteoId AND prd.ruteoDetalleCantidad > 0 AND prd.ubicacionId IS NOT NULL AND prd.ruteoDetalleEstado = 0
								INNER JOIN		 [dbo].[Presentaciones] p ON prd.presentacionId =	p.presentacionId 
							
								
								INNER JOIN		 [dbo].[Novedades] n ON prd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON prd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON prd.[ubicacionId] = u.ubicacionId
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  prd.[valorProductoLoteId] = vpl.valorProductoLoteId	
								WHERE pr.ruteoId = @ruteoId 
								GROUP BY  pr.[ruteoId]
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
									


						END


						
		



END