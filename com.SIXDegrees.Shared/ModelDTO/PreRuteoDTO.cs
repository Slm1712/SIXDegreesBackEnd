using System;
using System.Collections.Generic;

namespace com.SIXDegrees.Shared.ModelDTO
{
    public class PreRuteoDTO
    {
        public long usuarioId { get; set; }
        public Guid uniqueProcessId { get; set; }
        public long instalacionId { get; set; }
        public int SoloEstibasCompletas { get; set; }

    }

    public class PreRuteoItemDTO
    {
        public long preRuteoId { get; set; }

    }


    public class PreRuteoAuxDTO
    {


        public long preRuteoId { get; set; }

        public DateTime preRuteoFecha { get; set; }

        public string preRuteoUsuario { get; set; }
        public long preRuteoConsecutivo { get; set; }
        public long? documentoId { get; set; }
        public byte preRuteoPedidoEstado { get; set; }


        public List<PedidoOrdenBahiaInfoDTO> pedidosOrdenBahiaInfo { get; set; }
        public List<RuteoGrupoDTO> ruteosGrupos { get; set; }

    }


    public class PreRuteoNovedadesDTO
    {
        public long preRuteoId { get; set; }
        public long preRuteoDetalleId { get; set; }
        public bool esCrossDocking { get; set; }
        public long usuarioId { get; set; }


    }

}
