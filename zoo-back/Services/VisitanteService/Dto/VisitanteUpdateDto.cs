using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.VisitanteService.Dto
{
    public class VisitanteUpdateDto
    {

        public string? NombreVist { get; set; } = null!;

        public string? Apell1Vist { get; set; } = null!;

        public string? Apell2Vist { get; set; } = null!;

        public string? CorreoElectronico { get; set; } = null!;

        public int? Telefono { get; set; }
    }
}
