
CREATE PROCEDURE   [dbo].[SP_GET_Pedidos]

AS
BEGIN
SET DATEFORMAT DMY
SELECT				[pedidoId]
				  ,[sucursalId]
				  ,[pedidoConsecutivo]
				 ,CONVERT(VARCHAR(10),[pedidoFecha], 103) AS [pedidoFecha]
				  ,CONVERT(VARCHAR(10),[pedidoFechaEntrega], 103)  AS [pedidoFechaEntrega]
				  ,CONVERT(VARCHAR(10),[pedidoFechaCarga], 103)  AS [pedidoFechaCarga]
				  ,CONVERT(VARCHAR(10),[pedidoFechaMalla], 103)  AS [pedidoFechaMalla]
				  ,[pedidoObservacion]
				  ,[pedidoDocumentoERP]
				  ,[pedidoConsecutivoERP]
				  ,[pedidoVersion]
				  ,[pedidoEstado]
				  ,[pedidoFuente]
				  ,[puntoOperacionId] 
FROM [dbo].[Pedidos] p


WHERE p.pedidoEstado = 0  
END