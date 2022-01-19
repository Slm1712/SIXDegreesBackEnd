using System;
using System.Collections.Generic;
using System.Text;

namespace com.SIXDegrees.Shared.ModelDTO
{
    public class ProcesoDevolucionDTO
    {
        public Guid? devolucionProcesoId { get; set; }
        public long ubicacionId { get; set; }
        public long contenedorId { get; set; }
        public int estibaConsecutivo { get; set; }
        public long novedadId { get; set; }
        public long usuarioId { get; set; }
        public long pedidoId { get; set; }
        public string proceso { get; set; }

    }


    public class SaldoDevolucionDTO
    {
        public long devolucionId { get; set; }
        public long usuarioId { get; set; }
    }


    public class DevolucionUbicacionPedidosDTO
    {

        public long puertaId { get; set; }
        public long usuarioId { get; set; }

    }

    public class DevolucionContenedoDTO
    {

        public string contenedorCodigo { get; set; }
        public long ubicacionId { get; set; }

    }

    public class DevolucionTransaccionDTO
    {       
        public long ruteoId { get; set; }      
        public long contenedorId { get; set; }
        public long ubicacionIdOrigen { get; set; }
        public long? pedidoId { get; set; }
        public string puertaId { get; set; }
        public long usuarioId { get; set; }

    }




}
