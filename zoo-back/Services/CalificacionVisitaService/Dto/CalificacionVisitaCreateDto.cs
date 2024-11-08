using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.CalificacionVisitaService.Dto
{
    public class CalificacionVisitaCreateDto
    {
        public int IdVentaEntrada { get; set; }
        public int NotaRecorrido { get; set; }
        public string SugerenciaMejoraRecorrido { get; set; }

        public int NotaServicioAlCliente { get; set; }

        public string SugerenciaMejoraServicioAlCliente { get; set; }
    }
}
