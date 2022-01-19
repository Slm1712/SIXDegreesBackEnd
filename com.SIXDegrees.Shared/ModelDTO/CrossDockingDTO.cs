using System;
using System.Collections.Generic;
using System.Text;

namespace com.SIXDegrees.Shared.ModelDTO
{
    public class CrossDockingDTO
    {
        public long ruteoId { get; set; }
        public string contenedorTag { get; set; }
        public string ubicacionTag { get; set; }
        public long? novedadId { get; set; }
        public long? novedadAccionId { get; set; }
        public long usuarioId { get; set; }
        public long? bahiaIdDestino { get; set; }
        public long? pedidoId { get; set; }
        public bool? continuidadActivada { get; set; }


    }



    public class FiltroBahiasProductosCrossDockingDTO
    {

        public long ruteoId { get; set; }
        public long bahiaId { get; set; }
        public long productoId { get; set; }

        public long usuarioId { get; set; }
    }

    public class SaldoDetalleRuteoCrossDockingDTO
    {

        public long ruteoId { get; set; }
        public long ubicacionId { get; set; }
     
    }
    public class UbicacionCrossDockingDTO
    {

        public long usuarioId { get; set; }
        public long ruteoId { get; set; }

        public string ubicacionContinuidad { get; set; }

    }


}
