using System;

namespace com.SIXDegrees.Shared.ModelDTO
{
    public class PackingDTO
    {
        public long packingId { get; set; }
        public long packingDetalleId { get; set; }
        public long usuarioId { get; set; }
        public long ruteoId { get; set; }
        public long ruteoDetalleId { get; set; }
        public long? novedadId { get; set; }
        public long? novedadAccionId { get; set; }

        public string codigoUbicacionBahia { get; set; }
        public bool? continuidadActivada { get; set; }

}


    public class PackingDetalleDTO
    {
        public long packingId { get; set; }
        public long packingDetalleId { get; set; }

        public Guid packingDetalleGlobalId { get; set; }

        public long ubicacionbahiaId { get; set; }
    }
}
