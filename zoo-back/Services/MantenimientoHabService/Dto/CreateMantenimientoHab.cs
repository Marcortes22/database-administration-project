using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.MantenimientoHabService.Dto
{
    public class CreateMantenimientoHab
    {

        public int IdHabitacion { get; set; }

        public int IdEmpleado { get; set; }
        public string NombreTarea { get; set; }
    }
}
