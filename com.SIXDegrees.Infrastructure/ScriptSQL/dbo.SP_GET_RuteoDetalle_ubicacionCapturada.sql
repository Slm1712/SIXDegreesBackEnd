USE [TecnoCEDI_bd]
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_RuteoDetalle_ubicacionCapturada]    Script Date: 25/11/2019 9:06:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
			
	ALTER PROCEDURE  [dbo].[SP_GET_RuteoDetalle_ubicacionCapturada]
	(
	       
			@ubicacionRequerida AS VARCHAR(50),
			@ubicacionCapturada AS VARCHAR(50) 
	
	
	)
	AS
BEGIN

							SET XACT_ABORT ON; 							
							SET NOCOUNT ON
							BEGIN TRY  
							BEGIN TRANSACTION ubicacionCapturada

			
							SET DATEFORMAT YMD

	SET NOCOUNT ON
	DECLARE @UbicacionActualizadaId BIGINT
	DECLARE @presentacionId BIGINT
	DECLARE @bodegaLogicaId BIGINT
	DECLARE @ruteoId BIGINT
	DECLARE @ruteoDetalleId BIGINT
	DECLARE @ValorProductoLoteId BIGINT
	DECLARE @saldoId BIGINT = 0
	DECLARE @ubicacionId BIGINT
	DECLARE @ubicacionCapturadaId BIGINT
	DECLARE @ubicacionRequeridaId BIGINT
	

	SELECT TOP 1 @ubicacionCapturadaId = ubicacionId FROM [dbo].[Ubicaciones] WHERE ubicacionCodigo LIKE @ubicacionCapturada

	SELECT TOP 1 @ubicacionRequeridaId = ubicacionId FROM [dbo].[Ubicaciones] WHERE ubicacionCodigo LIKE @ubicacionRequerida
	
--	IF NOT EXISTS (SELECT 1 FROM [dbo].[RuteosDetalle] rd 
--				INNER JOIN [dbo].[Ubicaciones] u ON rd.ubicacionId = u.ubicacionId AND ubicacionCodigo LIKE @ubicacionCapturada
--				WHERE rd.ruteoDetalleEstado = 0
--				) AND @ubicacionCapturadaId > 0 AND @ubicacionRequeridaId > 0
--	BEGIN
	
--							;WITH ruteoDetalleUbicacionCapturada( presentacionId
--																,productoId
--																,bodegaLogicaId
--																,ubicacionId
--																,valorProductoLoteId
--																,valorPlantillaLoteValor
--																,ruteoDetalleCantidad
--																,ruteoDetalleCantRequerida
--																,ruteoId
--																,ruteoDetalleId)
--																AS
--																(
--									SELECT 
--												 rd.presentacionId
--												,pro.productoId
--												,rd.bodegaLogicaId
--												,rd.ubicacionId
--												,vpl.valorProductoLoteId
--												,vpl.valorPlantillaLoteValor
--												,rd.ruteoDetalleCantidad
--												,rd.ruteoDetalleCantRequerida
--												,rd.ruteoId
--												,rd.ruteoDetalleId 
--									FROM		[dbo].[RuteosDetalle] rd
--									INNER JOIN  [dbo].[Ubicaciones] u ON rd.ubicacionId = u.ubicacionId AND u.ubicacionId = @ubicacionRequeridaId									
--									INNER JOIN  [dbo].[ValoresPlantillasLotes] vpl ON rd.valorProductoLoteId = vpl.valorProductoLoteId AND vpl.atributoLoteId = 2
--									INNER JOIN	[dbo].[Presentaciones] p ON rd.presentacionId = p.presentacionId AND presentacionEstado = 1
--									INNER JOIN	[dbo].[Productos] pro ON pro.productoId = p.productoId AND pro.productoEstado = 1
--									WHERE		rd.ruteoDetalleEstado = 0
--									GROUP BY	rd.presentacionId
--												,pro.productoId
--												,rd.bodegaLogicaId
--												,rd.ubicacionId
--												,vpl.valorProductoLoteId
--												,vpl.valorPlantillaLoteValor
--												,rd.ruteoDetalleCantidad
--												,rd.ruteoDetalleCantRequerida
--												,rd.ruteoId
--												,rd.ruteoDetalleId 
--												),
--												 saldoDetalleUbicacionActual(	
--																		 presentacionId
--																		,productoId
--																		,bodegaLogicaId
--																		,ubicacionId
--																		,valorProductoLoteId
--																		,valorPlantillaLoteValor
--																		,saldoDetalleCantidad									
--																		,saldoId
--																		)
--																		AS
--																		(
--									SELECT 
--												 sd.presentacionId
--												,s.productoId
--												,sd.bodegaLogicaId
--												,sd.ubicacionId
--												,vpl.valorProductoLoteId
--												,vpl.valorPlantillaLoteValor
--												,SUM(sd.saldoDetalleDisponibleManejo)			
--												,s.saldoId

			 
--									FROM		[dbo].[Saldos] s
--									INNER JOIN [dbo].[SaldosDetalle] sd ON s.saldoId = sd.saldoId AND sd.saldoDetalleDisponibleManejo > 0
--									INNER JOIN  [dbo].[Ubicaciones] u ON sd.ubicacionId = u.ubicacionId AND u.ubicacionId = @ubicacionCapturadaId -- codigo codigocapturado
--									INNER JOIN  [dbo].[RutasUbicaciones] ru ON u.ubicacionId = ru.ubicacionId
--									INNER JOIN  [dbo].[ValoresPlantillasLotes] vpl ON sd.valorProductoLoteId = vpl.valorProductoLoteId AND vpl.atributoLoteId = 2
--									INNER JOIN	[dbo].[Presentaciones] p ON sd.presentacionId = p.presentacionId AND presentacionEstado = 1

--									GROUP BY	sd.presentacionId
--												,s.productoId
--												,sd.bodegaLogicaId
--												,sd.ubicacionId
--												,vpl.valorProductoLoteId
--												,vpl.valorPlantillaLoteValor						
--												,s.saldoId
		



--												)


--												SELECT TOP 1 
--												 @presentacionId = sd.presentacionId
--												--,sd.productoId
--												,@bodegaLogicaId =sd.bodegaLogicaId
--												,@UbicacionActualizadaId = sd.ubicacionId
--												,@valorProductoLoteId =sd.valorProductoLoteId
--												--,sd.valorPlantillaLoteValor
--												--,sd.saldoDetalleCantidad
--												,@saldoId = sd.saldoId
--												,@ruteoDetalleId = rd.ruteoDetalleId
--												,@ruteoId =  rd.ruteoId
--												FROM saldoDetalleUbicacionActual sd
--												INNER JOIN ruteoDetalleUbicacionCapturada rd ON sd.presentacionId = rd.presentacionId 
--																								AND sd.bodegaLogicaId = rd.bodegaLogicaId
--																								AND sd.productoId = rd.productoId
--																								AND sd.ubicacionId != rd.ubicacionId
--																								AND sd.valorPlantillaLoteValor >=  rd.valorPlantillaLoteValor
--																								AND sd.saldoDetalleCantidad  >= rd.ruteoDetalleCantRequerida 


--												--SELECT TOP 1 
--												--  sd.presentacionId
--												----,sd.productoId
--												--,sd.bodegaLogicaId
--												--, sd.ubicacionId
--												--,sd.valorProductoLoteId
--												----,sd.valorPlantillaLoteValor
--												----,sd.saldoDetalleCantidad
--												--, sd.saldoId
--												--, rd.ruteoDetalleId
--												--,  rd.ruteoId
--												--FROM saldoDetalleUbicacionActual sd
--												--INNER JOIN ruteoDetalleUbicacionCapturada rd ON sd.presentacionId = rd.presentacionId 
--												--												AND sd.bodegaLogicaId = rd.bodegaLogicaId
--												--												AND sd.productoId = rd.productoId
--												--												AND sd.ubicacionId != rd.ubicacionId
--												--												AND sd.valorPlantillaLoteValor >=  rd.valorPlantillaLoteValor
--												--												AND sd.saldoDetalleCantidad >= rd.ruteoDetalleCantRequerida

--															--GROUP BY							 sd.presentacionId
--															--									--,sd.productoId
--															--									,sd.bodegaLogicaId
--															--									--,sd.ubicacionId
--															--									,sd.valorProductoLoteId
--															--									--,sd.valorPlantillaLoteValor
--															--									--,sd.saldoDetalleCantidad
--															--									--,sd.saldoId
--															--									,rd.ruteoDetalleId
--															--									,rd.ruteoId
			
--												IF (@saldoId > 0)
--												BEGIN
						
--															UPDATE [dbo].[RuteosDetalle]
--															SET		ubicacionId = @UbicacionActualizadaId
--																	,valorProductoLoteId = @ValorProductoLoteId
																	

--															WHERE	ruteoId = @ruteoId AND @ruteoId > 0
--																	AND ubicacionId =  @ubicacionRequeridaId
--																	AND ruteoDetalleId = @ruteoDetalleId AND @ruteoDetalleId > 0
--																	AND presentacionId = @presentacionId AND @presentacionId > 0
--																	AND bodegaLogicaId = @bodegaLogicaId AND @bodegaLogicaId > 0
								

--															UPDATE [dbo].[saldosDetalle]															
--															SET		saldoDetalleComprometidoManejo			= 
--																										(saldoDetalleComprometidoManejo	 +	saldoDetalleDisponibleManejo) 
--																	,saldoDetalleInmovilizadoManejo			=	
--																										saldoDetalleInmovilizadoManejo	+ 
--																										(saldoDetalleRealManejo		-	(saldoDetalleComprometidoManejo		+	saldoDetalleDisponibleManejo))	
--																	,saldoDetalleDisponibleManejo			=	
--																										saldoDetalleRealManejo	-
--																										(saldoDetalleInmovilizadoManejo		+ 
--																										(saldoDetalleRealManejo		-	(saldoDetalleComprometidoManejo		+	saldoDetalleDisponibleManejo)))	-
--																										(saldoDetalleComprometidoManejo	 +	saldoDetalleDisponibleManejo) 	
--																	,saldoDetalleComprometidoEscalar		= 
--																										(saldoDetalleComprometidoEscalar	+	saldoDetalleDisponibleEscalar) 	
--																	,saldoDetalleInmovilizadoEscalar		=	
--																										saldoDetalleInmovilizadoEscalar		+ 
--																										(saldoDetalleRealEscalar	-	(saldoDetalleComprometidoEscalar	+	saldoDetalleDisponibleEscalar))	
--																	,saldoDetalleDisponibleEscalar			=	
--																										saldoDetalleRealEscalar	-
--																										(saldoDetalleInmovilizadoEscalar	+ 
--																										(saldoDetalleRealEscalar	-	(saldoDetalleComprometidoEscalar	+	saldoDetalleDisponibleEscalar))) -
--																										(saldoDetalleComprometidoEscalar	 +	saldoDetalleDisponibleEscalar) 	

--															WHERE	saldoId = @saldoId 
--																	AND valorProductoLoteId = @ValorProductoLoteId AND @ValorProductoLoteId > 0
--																	AND ubicacionId = @UbicacionActualizadaId  AND @UbicacionActualizadaId > 0
--																	AND presentacionId = @presentacionId  AND @presentacionId > 0
--																	AND bodegaLogicaId = @bodegaLogicaId  AND @bodegaLogicaId > 0
--																	AND saldoDetalleDisponibleManejo > 0 AND saldoDetalleRealManejo > 0


--															UPDATE [dbo].[saldosDetalle]															
--															SET		saldoDetalleComprometidoManejo			= (saldoDetalleComprometidoManejo	 -	saldoDetalleRealManejo) 
--																	,saldoDetalleInmovilizadoManejo			=	0	
--																	,saldoDetalleDisponibleManejo			=	saldoDetalleDisponibleManejo + saldoDetalleRealManejo																									 
--																	,saldoDetalleComprometidoEscalar		=  (saldoDetalleComprometidoEscalar	-	saldoDetalleDisponibleEscalar) 	
--																	,saldoDetalleInmovilizadoEscalar		=	0																									
--																	,saldoDetalleDisponibleEscalar			=	saldoDetalleDisponibleEscalar + saldoDetalleComprometidoEscalar	
--															WHERE	saldoId = @saldoId 
--																	AND valorProductoLoteId = @ValorProductoLoteId AND @ValorProductoLoteId > 0
--																	AND ubicacionId = @UbicacionRequeridaId  AND @UbicacionActualizadaId > 0
--																	AND presentacionId = @presentacionId  AND @presentacionId > 0
--																	AND bodegaLogicaId = @bodegaLogicaId  AND @bodegaLogicaId > 0
--																	AND saldoDetalleComprometidoManejo > 0 AND saldoDetalleRealManejo > 0




								
--												END

--END
												IF(@UbicacionActualizadaId > 0) SET @ubicacionId = @UbicacionActualizadaId
												ELSE  SET @ubicacionId = @ubicacionCapturadaId


DECLARE @result INT
	SELECT	@result =	COUNT(*) 
					FROM		[dbo].[Ruteos] r
								INNER JOIN		RuteosDetalle rd	ON r.ruteoId = rd.ruteoId 	AND rd.ruteoDetalleEstado = 0			
								INNER JOIN		 [dbo].[Presentaciones] p ON rd.presentacionId =	p.presentacionId 
								INNER JOIN		[dbo].[Productos] pro ON p.productoId = pro.productoId 
								INNER JOIN		[dbo].[UnidadesManejo] um ON pro.unidadManejoId = um.unidadManejoId
								INNER JOIN		 [dbo].[Novedades] n ON rd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON rd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON rd.[ubicacionId] = u.ubicacionId 
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  rd.[valorProductoLoteId] = vpl.valorProductoLoteId	 AND vpl.atributoLoteId = 2
								WHERE   u.ubicacionId = @UbicacionId

IF @result > 0
BEGIN 


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
												,'' as resultado
								FROM		[dbo].[Ruteos] r
								INNER JOIN		RuteosDetalle rd	ON r.ruteoId = rd.ruteoId 	AND rd.ruteoDetalleEstado = 0			
								INNER JOIN		 [dbo].[Presentaciones] p ON rd.presentacionId =	p.presentacionId 
								INNER JOIN		[dbo].[Productos] pro ON p.productoId = pro.productoId 
								INNER JOIN		[dbo].[UnidadesManejo] um ON pro.unidadManejoId = um.unidadManejoId
								INNER JOIN		 [dbo].[Novedades] n ON rd.novedadId =	n.[novedadId]
								INNER JOIN		 [dbo].[BodegasLogicas] bl ON rd.bodegaLogicaId = bl.bodegaLogicaId
								INNER JOIN		 [dbo].[Ubicaciones] u 	ON rd.[ubicacionId] = u.ubicacionId 
								INNER JOIN		 [dbo].[ValoresPlantillasLotes] vpl ON  rd.[valorProductoLoteId] = vpl.valorProductoLoteId	 AND vpl.atributoLoteId = 2
								WHERE   u.ubicacionId = @UbicacionId
									
			END			
ELSE 
BEGIN

SELECT 'No se encuentra  registro asociado a la ubicación capturada' AS resultado
			END	


COMMIT TRANSACTION ubicacionCapturada
							END TRY

							BEGIN CATCH
							
											IF (XACT_STATE()) = -1  
											BEGIN  
												PRINT  
													N'The transaction is in an uncommittable state.' +  
													'Rolling back transaction.'  
												ROLLBACK TRANSACTION ubicacionCapturada;  
											END;  
  
											-- Test whether the transaction is committable.  
											IF (XACT_STATE()) = 1  
											BEGIN  
												PRINT  
													N'The transaction is committable.' +  
													'Committing transaction.'  
												COMMIT TRANSACTION ubicacionCapturada;     
											END;  

							END CATCH
							END
