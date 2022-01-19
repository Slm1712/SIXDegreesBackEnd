using System;
using System.Collections.Generic;
using System.Text;

namespace com.SIXDegrees.Shared.ModelDTO
{
   public class OrdenEmpaqueDTO
    {

        public long? ubicacionId { get; set; }
        public string ubicacionCodigo { get; set; }
        public string estadoEstibaUbicacion { get; set; }
        public long? contenedorId { get; set; }
        public string contenedorCodigo { get; set; }
        public string proceso { get; set; }

        public long? usuarioId { get; set; }

        public long? estacionId { get; set; }

        public long? ordenEmpaqueId { get; set; }

        public long? presentacionId { get; set; }


    }

    public class generarOrdenEmpaqueDTO
    {

        public long usuarioId { get; set; }
        public long productoId { get; set; }
        public string tipoEvalacion { get; set; }
        public string fechaFinalizacion { get; set; }
        public long? NUnidades { get; set; }
        public long? estacionId { get; set; }

    }

    public class cambioFechaLoteOrdenEmpaqueDTO
    {

        public long ordenEmpaqueId { get; set; }
        public string fecha { get; set; }

    }

    public class cambioEstadioEstacionLoteDTO
    {
        public long estacionId { get; set; }
        public Boolean valor { get; set; }

    }
}
