namespace com.SIXDegrees.Shared.ModelDTO
{
    public class DetalleProducto
    {

        public long productoId { get; set; }
        public string productoCodigo { get; set; }
        public string productoDescripcion { get; set; }
        public string ordenanteCodigo { get; set; }
        public string ordenanteDescripcion { get; set; }
        public long titularId { get; set; }
        public string titularDescripcion { get; set; }
        public long unidadEscalarId { get; set; }
        public string unidadEscalarDescripcion { get; set; }
        public decimal productoCantidadEscalar { get; set; }
        public long unidadManejoId { get; set; }
        public string unidadManejoDescripcion { get; set; }
        public decimal productoCantidadManejo { get; set; }
        public byte? productoUnidadInventario { get; set; }

        public short productoTipo { get; set; }
    }
}
