
			
			
CREATE PROCEDURE SP_GET_BahiasPuertas
AS BEGIN		
				
				CREATE TABLE #puertaBahiaInfoTemp
								(
									 ubicacionIdBahia					BIGINT
									,ubicacionCodigoBahia				VARCHAR(100)
									,ubicacionDescripcionBahia			VARCHAR(100)
									,tipoUbicacionIdBahia				BIGINT
									
									,ubicacionIdPuerta					BIGINT										
									,ubicacionCodigoPuerta				VARCHAR(100)
									,ubicacionDescripcionPuerta			VARCHAR(100)
								)


								INSERT INTO #puertaBahiaInfoTemp
												(
																ubicacionIdBahia					
															,ubicacionCodigoBahia				
															,ubicacionDescripcionBahia			
															,tipoUbicacionIdBahia				
																		
															,ubicacionIdPuerta															
															,ubicacionCodigoPuerta				
															,ubicacionDescripcionPuerta	
												)
								SELECT				 u.ubicacionId
													,u.ubicacionCodigo
													,u.ubicacionDescripcion
													,u.tipoUbicacionId															
													,upuerta.ubicacionId								
													,upuerta.ubicacionCodigo
													,upuerta.ubicacionDescripcion
								FROM				[dbo].[Ubicaciones] u 
								INNER JOIN			[dbo].[TiposUbicaciones] t ON u.tipoUbicacionId = t.tipoUbicacionId
								INNER JOIN			[dbo].[Ubicaciones] upuerta ON u.ubicacionPadreId = upuerta.ubicacionId	
								WHERE				u.tipoUbicacionId = 2 --hace referencia a la bahia padre
								GROUP BY			 u.ubicacionId
													,u.ubicacionCodigo
													,u.ubicacionDescripcion
													,u.tipoUbicacionId															
													,upuerta.ubicacionId
													,upuerta.tipoUbicacionId
													,upuerta.ubicacionCodigo
													,upuerta.ubicacionDescripcion
								ORDER BY			u.ubicacionDescripcion
								SELECT						 ubicacionIdBahia					
															,ubicacionCodigoBahia				
															,ubicacionDescripcionBahia			
															,tipoUbicacionIdBahia																		
															,ubicacionIdPuerta															
															,ubicacionCodigoPuerta				
															,ubicacionDescripcionPuerta	 
								FROM						 #puertaBahiaInfoTemp
															   								 							  							  							 						   
								IF OBJECT_ID('tempdb..#puertaBahiaInfoTemp')		IS NOT NULL DROP TABLE #puertaBahiaInfoTemp

END