CREATE PROCEDURE  [dbo].[SP_CANCEL_PreRuteo]
		(
		@preRuteoId AS BIGINT
		)
		AS
			BEGIN
			
			IF OBJECT_ID('tempdb..#PreRuteoContenedorUbicacionTemp') IS NOT NULL DROP TABLE #PreRuteoContenedorUbicacionTemp
			IF OBJECT_ID('tempdb..#CantidadConsolidadaSaldo') IS NOT NULL DROP TABLE #CantidadConsolidadaSaldo
			
					CREATE TABLE #PreRuteoContenedorUbicacionTemp 
															(
																saldoId BIGINT, 
																saldoUbicacionId BIGINT,
																saldoDetalleId BIGINT, 
																ubicacionId BIGINT, 
																presentacionId BIGINT, 
																contenedorId BIGINT, 
																valorProductoLote BIGINT,
																CantidadComprometidoManejo DECIMAL(18,4), 
																CantidadInmovilizadoManejo DECIMAL(18,4),
																CantidadComprometidoEscalar DECIMAL(18,4),
																CantidadInmovilizadoEscalar DECIMAL(18,4)
															)



					CREATE TABLE #CantidadConsolidadaSaldo 
															(
																 saldoId BIGINT
																,CantidadComprometidoManejo DECIMAL(18,4) 
																,CantidadInmovilizadoManejo DECIMAL(18,4)
																,CantidadComprometidoEscalar DECIMAL(18,4)
																,CantidadInmovilizadoEscalar DECIMAL(18,4)
															)

				;WITH preRuteoData 
				(
							 preRuteoId
							,presentacionId
							,bodegaLogicaId
							,ubicacionId
							,valorProductoLoteId
							,preRuteoDetalleCantidad
							,saldoId
							,saldoUbicacionId
				) AS (

							SELECT 
										 pd.preRuteoId
										,pd.presentacionId
										,pd.bodegaLogicaId
										,pd.ubicacionId
										,pd.valorProductoLoteId
										,pd.preRuteoDetalleCantidad
										,pd.saldoId
										,pd.saldoUbicacionId
							FROM		[dbo].[PreRuteosDetalle] AS pd													
							WHERE		 pd.preRuteoId = @preRuteoId 		
										AND pd.preRuteoDetalleEstado = 0
															
					),	PreRuteoContenedorUbicacion(
															 saldoId
															,saldoUbicacionId
															,saldoDetalleId
															,ubicacionId
															,presentacionId
															,contenedorId
															,valorProductoLote
															,CantidadComprometidoManejo 
															,CantidadInmovilizadoManejo
															,CantidadComprometidoEscalar
															,CantidadInmovilizadoEscalar
													) AS (
													SELECT   sd.saldoId
															,pd.saldoUbicacionId
															,sd.saldoDetalleId
															,sd.ubicacionId
															,sd.presentacionId
															,sd.contenedorId
															,sd.valorProductoLoteId
															,sd.saldoDetalleComprometidoManejo
															,sd.saldoDetalleInmovilizadoManejo
															,sd.saldoDetalleComprometidoEscalar
															,saldoDetalleInmovilizadoEscalar
													FROM	[dbo].[SaldosDetalle] sd 
															INNER JOIN preRuteoData pd ON sd.ubicacionId = pd.ubicacionId 
																						  AND sd.saldoId = pd.saldoId 
														)

				INSERT INTO #PreRuteoContenedorUbicacionTemp 
														(
																 saldoId 
																,saldoUbicacionId
																,saldoDetalleId
																,ubicacionId 
																,presentacionId
																,contenedorId 
																,valorProductoLote
																,CantidadComprometidoManejo 
																,CantidadInmovilizadoManejo
																,CantidadComprometidoEscalar
																,CantidadInmovilizadoEscalar 
														)				
													SELECT		 saldoId
																,saldoUbicacionId
																,saldoDetalleId
																,ubicacionId
																,presentacionId
																,contenedorId
																,valorProductoLote
																,CantidadComprometidoManejo 
																,CantidadInmovilizadoManejo
																,CantidadComprometidoEscalar
																,CantidadInmovilizadoEscalar 
													FROM		 PreRuteoContenedorUbicacion 

				;WITH saldosPreruteoConsolidado				
				(
						saldoId
						,CantidadComprometidoManejo
						,CantidadInmovilizadoManejo
						,CantidadComprometidoEscalar
						,CantidadInmovilizadoEscalar
				) AS (
						SELECT		 pd.saldoId
									,SUM(CantidadComprometidoManejo)  
									,SUM(CantidadInmovilizadoManejo) 
									,SUM(CantidadComprometidoEscalar) 
									,SUM(CantidadInmovilizadoEscalar) 
						FROM		#PreRuteoContenedorUbicacionTemp AS pd	
						INNER JOIN	SaldosUbicaciones su ON pd.saldoId = su.saldoId
						GROUP BY	pd.saldoId
								), saldosUbicacionesPreruteoConsolidado
									(
												 saldoId
												,CantidadComprometidoManejo
												,CantidadInmovilizadoManejo
												,CantidadComprometidoEscalar
												,CantidadInmovilizadoEscalar
									) AS (
												SELECT		 su.saldoId
															,su.saldoUbicacionComprometidoManejo + spc. CantidadComprometidoManejo 
															,su.saldoUbicacionInmovilizadoManejo + spc.CantidadInmovilizadoManejo 
															,su.saldoUbicacionComprometidoEscalar + spc.CantidadComprometidoEscalar 
															,su.saldoUbicacionInmovilizadoEscalar + spc.CantidadInmovilizadoEscalar
												FROM		 SaldosUbicaciones AS su	
												INNER JOIN   saldosPreruteoConsolidado spc ON su.saldoId = spc.saldoId  

				)
				INSERT INTO #CantidadConsolidadaSaldo 
				(
								 saldoId
								,CantidadComprometidoManejo
								,CantidadInmovilizadoManejo
								,CantidadComprometidoEscalar
								,CantidadInmovilizadoEscalar
				)
								SELECT		 saldoId
											,CantidadComprometidoManejo
											,CantidadInmovilizadoManejo
											,CantidadComprometidoEscalar
											,CantidadInmovilizadoEscalar 
								FROM		 saldosUbicacionesPreruteoConsolidado													

				UPDATE		[dbo].[SaldosDetalle] 
				SET			 saldoDetalleComprometidoManejo		= 	(saldoDetalleComprometidoManejo		-	pd.CantidadComprometidoManejo) 
							,saldoDetalleInmovilizadoManejo		=	(saldoDetalleInmovilizadoManejo		-	pd.CantidadInmovilizadoManejo)		
							,saldoDetalleDisponibleManejo		=	(pd.CantidadComprometidoManejo		+	pd.CantidadInmovilizadoManejo)															
							,saldoDetalleComprometidoEscalar	=   (saldoDetalleComprometidoEscalar	-	pd.CantidadComprometidoEscalar)
							,saldoDetalleInmovilizadoEscalar	=	(saldoDetalleInmovilizadoEscalar	-	pd.CantidadInmovilizadoEscalar)
							,saldoDetalleDisponibleEscalar		=	(pd.CantidadComprometidoEscalar		+	pd.CantidadInmovilizadoEscalar)	
				FROM		 #PreRuteoContenedorUbicacionTemp AS pd													
				WHERE		 pd.saldoDetalleId = [dbo].[SaldosDetalle].saldoDetalleId 
							 AND pd.ubicacionId = [dbo].[SaldosDetalle].ubicacionId
							 AND ([dbo].[SaldosDetalle].saldoDetalleComprometidoManejo > 0 AND [dbo].[SaldosDetalle].saldoDetalleInmovilizadoManejo >= 0)
							 AND pd.contenedorId = [dbo].[SaldosDetalle].contenedorId 
							 AND pd.presentacionId  = [dbo].[SaldosDetalle].presentacionId
							 AND pd.saldoId = [dbo].[SaldosDetalle].saldoid
							 AND pd.saldoUbicacionId IS NULL

				UPDATE		 [dbo].[SaldosUbicaciones] 
				SET			 saldoUbicacionComprometidoManejo	= 	0 
							,saldoUbicacionInmovilizadoManejo	=	0		
							,saldoUbicacionDisponibleManejo		=	0															
							,saldoUbicacionComprometidoEscalar	=   0
							,saldoUbicacionInmovilizadoEscalar	=	0
							,saldoUbicacionDisponibleEscalar	=	0		
				FROM		#PreRuteoContenedorUbicacionTemp AS pd													
				WHERE		pd.saldoUbicacionId	=	[dbo].[SaldosUbicaciones].saldoUbicacionId 
							AND pd.ubicacionId	=	[dbo].[SaldosUbicaciones].ubicacionId
							AND ([dbo].[SaldosUbicaciones].saldoUbicacionComprometidoManejo > 0 
							AND [dbo].[SaldosUbicaciones].saldoUbicacionInmovilizadoManejo >= 0)															
							AND pd.saldoId = [dbo].[SaldosUbicaciones].saldoid
							AND pd.saldoUbicacionId IS NOT NULL
														
				DELETE		su 
				FROM		[dbo].[SaldosUbicaciones] su
				INNER JOIN #PreRuteoContenedorUbicacionTemp pr ON	su.saldoId = pr.saldoId 
																	AND su.ubicacionId = pr.ubicacionId
				WHERE		su.saldoUbicacionComprometidoManejo = 0		
							AND su.saldoUbicacionInmovilizadoManejo = 0				
				
				UPDATE		 [dbo].[Saldos] 
				SET			 saldoComprometidoManejo	= 	saldoComprometidoManejo - pd.CantidadComprometidoManejo
							,saldoInmovilizadoManejo	=	saldoInmovilizadoManejo - pd.CantidadInmovilizadoManejo 	
							,saldoDisponibleManejo		=	saldoDisponibleManejo	+ saldoComprometidoManejo + saldoInmovilizadoManejo
							,saldoComprometidoEscalar	=   saldoComprometidoEscalar	- pd.CantidadComprometidoEscalar
							,saldoInmovilizadoEscalar	=	saldoInmovilizadoEscalar	-  pd.CantidadInmovilizadoEscalar
							,saldoDisponibleEscalar		=	saldoDisponibleEscalar		+ saldoComprometidoEscalar + saldoInmovilizadoEscalar
				FROM		#CantidadConsolidadaSaldo AS pd													
				WHERE		pd.saldoId = [dbo].[Saldos].saldoId 															
							AND ([dbo].[Saldos].saldoComprometidoManejo > 0 
							AND [dbo].[Saldos].saldoInmovilizadoManejo >= 0)
							AND  pd.CantidadComprometidoManejo > 0																			

				UPDATE		[dbo].[Pedidos] 
				SET			pedidoEstado = 0
				FROM		[dbo].[PreRuteosPedidos] prp
				WHERE		prp.pedidoId = [dbo].[Pedidos].pedidoId 
							AND  [dbo].[Pedidos].pedidoEstado = 1
							AND prp.preRuteoId = @preRuteoId

				DELETE		ppr 
				FROM		[dbo].[PedidosPreRuteo] ppr
				INNER JOIN	[dbo].[PreRuteosPedidos] prp ON ppr.pedidoId = prp.pedidoId 
															AND ppr.Estado = 1

				UPDATE		[dbo].[PreRuteosDetalle] 
				SET			 preRuteoPedidoEstado = 4 ---validar codigos estado 4 cancelado
							,preRuteoDetalleEstado = 4 ---validar codigos estado 4 cancelado
				WHERE		 preRuteoId = @preRuteoId


				UPDATE		[dbo].[PreRuteos] 
				SET			preRuteoPedidoEstado = 4  ---validar codigos estado 4 cancelado
				WHERE		preRuteoId = @preRuteoId

END