using System;

namespace com.SIXDegrees.Shared.ModelDTO
{
    public class UbicacionDTO
    {
        public long bahiaPadreId { get; set; }

        public long usuarioId { get; set; }
    }

    public class UbicacionValidacionDTO
    {
        public string ubicacionRequerida { get; set; }

        public string ubicacionCapturada { get; set; }
    }

    public class UbicacionProductoDTO
    {
        public long productoId { get; set; }
        public long presentacionId { get; set; }
        public DateTime @FechaSaldo { get; set; }
    }
          
    public class UbicacionContingenciaDTO
    {
        public long? bahiaPadreId { get; set; }

        public bool? esDespacho { get; set; }
    }


    public class FilterBahiaDTO
    {
        public long? tipoUbicacionId { get; set; }

        public long? instalacionId { get; set; }
    }



}
