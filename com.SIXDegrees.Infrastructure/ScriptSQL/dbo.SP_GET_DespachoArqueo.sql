

CREATE PROCEDURE  [dbo].[SP_GET_DespachoArqueo](@ubicacionPuertaId BIGINT)
AS BEGIN 

SELECT CONVERT(varchar(max), productoId) as number , * FROM Productos
--SELECT * FROM [dbo].[DespachosDetalle]

END