using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.AnimalService.Dto
{
    public class AnimalUpdateDto
    {
        public string? NombreAni { get; set; }

        public int? EdadAni { get; set; }

        public int? IdDieta { get; set; }

        public int? IdEspecie { get; set; }

        public int? IdEstadoSalud { get; set; }
    }
}
