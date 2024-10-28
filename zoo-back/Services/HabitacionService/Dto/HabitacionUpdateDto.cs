using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.HabitacionService.Dto
{
    public class HabitacionUpdateDto
    {
        public string? NombreHab { get; set; }

        public string? Direccion { get; set; } 

        public int? Capacidad { get; set; }

        public int? IdTipoHabitacion { get; set; }

        public int? IdEstadoHabitacion { get; set; }
    }
}
