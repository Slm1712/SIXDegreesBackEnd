using System;

namespace com.SIXDegrees.Shared.ModelDTO
{
    public class PickingDTO
    {
        public long ruteoId { get; set; }
        public long ruteoDetalleId { get; set; }
        public string contenedorTag { get; set; }
        public string ubicacionTag { get; set; }
        public long? novedadId { get; set; }
        public long? novedadAccionId { get; set; }
        public long usuarioId { get; set; }

        public long? bahiaIdDestino { get; set; }
        public long? pedidoId { get; set; }
        public long? ruteoIdAux { get; set; }
        public long? ruteoDetalleIdAux { get; set; }
        public long? valorProductoLoteIdAux { get; set; }
        public long? ubicacionIdAux { get; set; }

        public bool? continuidadActivada { get; set; }
        //public long? productoId { get; set; }
    }

    public class PickingPackingDTO
    {
        public long ruteoId { get; set; }
        public long ruteoDetalleId { get; set; }
        public long contenedorId { get; set; }
        public long usuarioId { get; set; }
        public Guid? uniqueProcessId { get; set; }
        public string ubicacionTag { get; set; }
        public long novedadAccionId { get; set; }
        public long bahiaIdDestino { get; set; }
        public long pedidoId { get; set; }
        public long ubicacionIdAux { get; set; }
        public long ruteoIdAUX { get; set; }
        public long ruteoDetalleIdAUX { get; set; }
        public bool estado { get; set; }
    }

    public class PickingPackingNovedadDTO
    {
        public long ruteoId { get; set; }
        public long ruteoDetalleId { get; set; }
        public string ubicacionIdOrigen { get; set; }
        public long usuarioId { get; set; }
        public long ruteoDetalleCantRequerida { get; set; }
    }
}
