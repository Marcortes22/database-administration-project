using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.HabitacionService.Dto
{
    public class HabitacionCreateDto
    {
        public string NombreHab { get; set; } = null!;

        public string Direccion { get; set; } = null!;

        public int Capacidad { get; set; }

        public int IdTipoHabitacion { get; set; }

        public int IdEstadoHabitacion { get; set; }
    }
}
