using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.AnimalService.Dto
{
    public class AnimalCreateDto
    {
        public string NombreAni { get; set; } = null!;

        public int EdadAni { get; set; } 

        public int IdDieta { get; set; }

        public int IdHabitacion { get; set; }

        public int IdEspecie { get; set; }

        public int IdEstadoSalud { get; set; }
    }
}
