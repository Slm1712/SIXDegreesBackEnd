using System;
using System.Collections.Generic;
using System.Text;

namespace com.SIXDegrees.Shared.ModelDTO
{
   public class ContenedorDTO
    {
        public long? contenedorId { get; set; }
        public string contenedorCodigo { get; set; }
        public string proceso { get; set; }

        public long? usuarioId { get; set; }
    }
    public class ContenedorUbicacionParcialDTO
    {
        public string contenedorCodigo { get; set; }

        public string ubicacionCodigo { get; set; }

        public long? ubicacionId { get; set; }

        public long? presentacionId { get; set; }
    }

}
