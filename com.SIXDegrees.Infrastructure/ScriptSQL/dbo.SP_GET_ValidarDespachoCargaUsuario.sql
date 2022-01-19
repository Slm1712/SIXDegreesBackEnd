		--EXEC  [dbo].[SP_GET_ValidarDespachoCargaUsuario] 67

CREATE PROCEDURE  [dbo].[SP_GET_ValidarDespachoCargaUsuario](@usuarioId AS BIGINT)

AS
BEGIN


DECLARE @ubicacionUsuarioId BIGINT


SELECT TOP 1 @ubicacionUsuarioId = ubicacionId
FROM [dbo].[Usuarios] u
INNER JOIn [dbo].[Ubicaciones] ub ON u.usuarioIdentificacion = ub.ubicacionCodigo
WHERE u.usuarioId = @usuarioId


DECLARE @result INT
	SELECT	@result =	COUNT(*)
				FROM [dbo].[DespachosDetalle] desp
				INNER JOIN [dbo].[Presentaciones] p ON desp.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON desp.ubicacionId = u.ubicacionId 	
				INNER JOIN [dbo].[Ubicaciones] uaux ON desp.ubicacionActualId = @ubicacionUsuarioId 
				WHERE desp.despachoEstado = 0

IF @result > 0
BEGIN 
				SELECT	TOP 1		 desp.despachoId
									,desp.despachoDetalleId
									,pro.productoId
									,pro.productoCodigo
									,pro.productoDescripcion
									,p.presentacionId
									,p.presentacionCodigo
									,p.presentacionDescripcion
									,desp.despachoDetalleCantTotal
									,u.ubicacionId
									,u.ubicacionCodigo
									,u.ubicacionDescripcion
									,uaux.ubicacionId as ubicacionIdActual
									,uaux.ubicacionCodigo as ubicacionCodigoActual
									,uaux.ubicacionDescripcion		 as ubicacionDescripcionActual	
									,'El usuario tiene saldo activo' as resultado
				FROM [dbo].[DespachosDetalle] desp
				INNER JOIN [dbo].[Presentaciones] p ON desp.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON desp.ubicacionId = u.ubicacionId 	
				INNER JOIN [dbo].[Ubicaciones] uaux ON   uaux.ubicacionId = @ubicacionUsuarioId 
				WHERE desp.despachoEstado = 0
			END		
ELSE BEGIN

SELECT '' AS resultado
END	

END