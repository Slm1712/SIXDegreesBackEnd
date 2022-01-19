CREATE PROCEDURE  [dbo].[SP_ADD_NovedadRuteo] 
(@novedadId BIGINT,
@ruteoId BIGINT,
 @ruteoDetalleId BIGINT,
  @usuarioId BIGINT)

  AS

   BEGIN

  DECLARE @novedadIdAux BIGINT


  SELECT  @novedadIdAux = novedadId From [dbo].[Novedades] WHERE novedadId = @novedadId

  IF @novedadIdAux IS NULL RETURN;


  IF EXISTS (SELECT 1 FROM [dbo].[RuteosDetalle] WHERE ruteoDetalleId = @ruteoDetalleId AND ruteoId = @ruteoId AND ruteoDetalleEstado = 0 )
			  BEGIN

						UPDATE  [dbo].[RuteosDetalle]
						SET		novedadId = @novedadId
						WHERE	ruteoDetalleId = @ruteoDetalleId 
								AND ruteoId = @ruteoId AND ruteoDetalleEstado = 0

								SELECT 'Se ha asignado la novedad al ruteo'
								RETURN	

			  END

			SELECT 'Error asignando la novedad'
			RETURN  


   END