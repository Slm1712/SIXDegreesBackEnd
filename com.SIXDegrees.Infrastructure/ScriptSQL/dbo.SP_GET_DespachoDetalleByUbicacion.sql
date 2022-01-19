		

CREATE PROCEDURE  [dbo].[SP_GET_DespachoDetalleByUbicacion](@ubicacionCodigo AS VARCHAR(50))

AS
BEGIN

DECLARE @result INT
	SELECT	@result =	COUNT(*) FROM [dbo].[DespachosDetalle] desp
				INNER JOIN [dbo].[Presentaciones] p ON desp.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON desp.ubicacionId = u.ubicacionId AND 	 @ubicacionCodigo LIKE  '%' +u.ubicacionCodigo		
				LEFT JOIN [dbo].[Ubicaciones] uaux ON desp.ubicacionActualId = uaux.ubicacionId 
				WHERE desp.despachoEstado = 0

IF @result > 0
BEGIN 
				SELECT		TOP 1	 desp.despachoId
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
									,'' as resultado
				FROM [dbo].[DespachosDetalle] desp
				INNER JOIN [dbo].[Presentaciones] p ON desp.presentacionId = p.presentacionId 
				INNER JOIN [dbo].[Productos] pro ON p.productoId = pro.productoId				
				INNER JOIN [dbo].[Ubicaciones] u ON desp.ubicacionId = u.ubicacionId AND 	 @ubicacionCodigo LIKE  '%' +u.ubicacionCodigo		
				LEFT JOIN [dbo].[Ubicaciones] uaux ON desp.ubicacionActualId = uaux.ubicacionId 
				WHERE desp.despachoEstado = 0
			END		
ELSE BEGIN

SELECT 'No se encuentra despacho asociado a la ubicación capturada' AS resultado
			END	

END