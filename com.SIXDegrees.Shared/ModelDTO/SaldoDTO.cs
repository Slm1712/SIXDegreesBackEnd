using System;
using System.Collections.Generic;
using System.Text;

namespace com.SIXDegrees.Shared.ModelDTO
{
    public class SaldoDTO
    {
    }

    public class DescargaSaldoDTO
    {
        public string ubicacionCodigo { get; set; }
        public long usuarioId { get; set; }

    }

    public class SaldoReubicacionDTO
    {
        public long? saldoId { get; set; }
        public long ubicacionOrigenId { get; set; }
        public int? contenedorEstibaConsecutivo { get; set; }
        public long? productoId { get; set; }
        public long? presentacionId { get; set; }
        public DateTime? fechaSaldo { get; set; }
        public long? novedadId { get; set; }
        public long? novedadAccionId { get; set; }
        public long usuarioId { get; set; }
        public string tipoMovimientoSaldo { get; set; }

        public int? sugeridoPosicionSeleccionada { get; set; }

    }

    public class SaldoDescomprometerUbicacionDTO
    {
        public string ubicacionCodigo { get; set; }
        public long usuarioId { get; set; }
    }

    public class SaldoReubicacionParcialDTO
    {
        public int usuarioId { get; set; }
        public long contenedorId { get; set; }
        public long ubicacionId { get; set; }
        public string tipoMovimiento { get; set; }

    }

    public class ConsultarContenedoresDTO
    {
        public string contenedorCodigo { get; set; }
        public bool contenedoresHermanos { get; set; }
    }

    public class SaldoAjusteDTO
    {
        public long saldoId { get; set; }
        public long contenedorId { get; set; }
        public long ubicacionId { get; set; }
        public long bodegaLogicaId { get; set; }
        public decimal saldoDetalleRealManejo { get; set; }
        public long presentacionId { get; set; }
        public long productoId { get; set; }
        public long valorProductoLoteId { get; set; }
        public bool selected { get; set; }
        public long? usuarioId { get; set; }
    }

    public class SaldoDetalleDTO
    {
        public long? saldoDetalleId { get; set; }
        public long saldoId { get; set; }
        public long presentacionId { get; set; }
        public long? contenedorId { get; set; }
        public long valorProductoLoteId { get; set; }
        public long ubicacionId { get; set; }
        public long bodegaLogicaId { get; set; }

        public decimal? saldoDetalleRealManejo { get; set; }

        public decimal? saldoDetalleComprometidoManejo { get; set; }

        public decimal? saldoDetalleInmovilizadoManejo { get; set; }

        public decimal? saldoDetalleRealEscalar { get; set; }

        public decimal? saldoDetalleDisponibleManejo { get; set; }

        public decimal? saldoDetalleComprometidoEscalar { get; set; }

        public decimal? saldoDetalleInmovilizadoEscalar { get; set; }

        public decimal? saldoDetalleDisponibleEscalar { get; set; }
    }

    public class SaldoUbicacionContenedorDTO
    {
        public long? ubicacionId { get; set; }
        public string contenedorCodigo { get; set; }
        public bool estibaCompleta { get; set; }


    }


}
