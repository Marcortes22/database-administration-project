using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.EmpleadoService.Dto
{
    public class EmpleadoCreateDto
    {
        public int IdEmpleado { get; set; }

        public string Nombre { get; set; } = null!;

        public string Apellido1 { get; set; } = null!;

        public string Apellido2 { get; set; } = null!;

        public string Correo { get; set; } = null!;

        public int IdPuesto { get; set; }
    }
}
