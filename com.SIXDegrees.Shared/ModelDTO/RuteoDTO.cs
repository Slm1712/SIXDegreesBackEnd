using System;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace com.SIXDegrees.Shared.ModelDTO
{
    public class RuteoDTO
    {
        [JsonProperty("preRuteoId")]
        public long preRuteoId { get; set; }

        [JsonProperty("usuarioId")]
        public long usuarioId { get; set; }

        [JsonProperty("pedidosOrdenBahiaInfo")]
        public List<PedidoOrdenBahiaInfoDTO> pedidosOrdenBahiaInfo { get; set; }

        [JsonProperty("ruteosGrupos")]
        public List<RuteoGrupoDTO> ruteosGrupos { get; set; }


        public RuteoDTO()
        {
            pedidosOrdenBahiaInfo = new List<PedidoOrdenBahiaInfoDTO>();
            ruteosGrupos = new List<RuteoGrupoDTO>();
        }
    }

    public class PedidoOrdenBahiaInfoDTO
    {
        [JsonProperty("pedidoId")]
        public long pedidoId { get; set; }

        [JsonProperty("pedidoOrden")]
        public int pedidoOrden { get; set; }

        [JsonProperty("pedidoUbicacionBahiaId")]
        public long pedidoUbicacionBahiaId { get; set; }
    }

    public class RuteoGrupoDTO
    {
        [JsonProperty("grupoId")]
        public long grupoId { get; set; }

        [JsonProperty("grupoCantidad")]
        public int grupoCantidad { get; set; }

        [JsonProperty("rutaId")]
        public long rutaId { get; set; }
    }

    public class NovedadRuteoDTO
    {
        [JsonProperty("novedadId")]
        public long novedadId { get; set; }

        [JsonProperty("ruteoId")]
        public long ruteoId { get; set; }

        [JsonProperty("ruteoDetalleId")]
        public long ruteoDetalleId { get; set; }

        [JsonProperty("usuarioId")]
        public long usuarioId { get; set; }
    }

    public class RuteoDetalleDTO
    {

        [JsonProperty("ruteoId")]
        public long ruteoId { get; set; }

        [JsonProperty("ruteoDetalleId")]
        public long? ruteoDetalleId { get; set; }

        [JsonProperty("productoId")]
        public long? productoId { get; set; }

        [JsonProperty("bahiaId")]
        public long? bahiaId { get; set; }
        [JsonProperty("usuarioId")]
        public long? usuarioId { get; set; }
        [JsonProperty("bodegaLogicaId")]
        public long? bodegaLogicaId { get; set; }


    }




    public class RuteoAuxDTO
    {


        public long ruteoId { get; set; }
        public DateTime ruteoFecha { get; set; }
        public string ruteoUsuario { get; set; }
        public long ruteoConsecutivo { get; set; }
        public long? documentoId { get; set; }
        public byte ruteoPedidoEstado { get; set; }
        public List<PedidoOrdenBahiaInfoDTO> pedidosOrdenBahiaInfo { get; set; }
        public List<RuteoGrupoDTO> ruteosGrupos { get; set; }

    }


    public class RuteoBahiaProductoFilterDTO
    {

        [JsonProperty("ruteoId")]
        public long ruteoId { get; set; }


        [JsonProperty("bahiaId")]
        public long? bahiaId { get; set; }

        [JsonProperty("productoId")]
        public long? productoId { get; set; }

      

    }

}



