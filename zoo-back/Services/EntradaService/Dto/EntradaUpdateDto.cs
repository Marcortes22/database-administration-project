using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.EntradaService.Dto
{
    public class EntradaUpdateDto
    {
        public int? IdTipoEntrada { get; set; }

        public DateTime? FechaVencimiento { get; set; }

        public int? Descuento { get; set; }
    }
}
