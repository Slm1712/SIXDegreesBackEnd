using System;
using System.Collections.Generic;
using System.Text;

namespace com.SIXDegrees.Shared.ModelDTO
{
    public class MaquinaDTO
    {

        public long maquinaId { get; set; }
        public string maquinaIP { get; set; }
        public string maquinaCodigo { get; set; }
        public byte? maquinaEstado { get; set; }
        public long? usuarioId { get; set; }

    }
}

