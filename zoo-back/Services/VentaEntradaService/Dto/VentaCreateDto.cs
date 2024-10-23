using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.VentaEntradaService.Dto
{
    public class VentaCreateDto
    {
        public int IdVisitantes { get; set; }

        public int IdMetodoPago { get; set; }

        public List<detalleDto> Detalles { get; set; }
    }
}
