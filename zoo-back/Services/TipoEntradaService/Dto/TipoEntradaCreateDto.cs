using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.TipoEntradaService.Dto
{
    public class TipoEntradaCreateDto
    {
        public string NombreEnt { get; set; } = null!;

        public decimal Precio { get; set; }
    }
}
