
Create PROCEDURE  [dbo].[SP_GET_Preruteos]

AS
BEGIN
SET DATEFORMAT DMY
SELECT		
       [preRuteoId] 
	  ,CONVERT(VARCHAR(10),[preRuteoFecha], 103) AS [preRuteoFecha]
      ,[preRuteoUsuario]
      ,[preRuteoConsecutivo]
      ,[documentoId]
      ,[preRuteoPedidoEstado]

 FROM [dbo].[Preruteos] p


WHERE p.preRuteoPedidoEstado = 0
END