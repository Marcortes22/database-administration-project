using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.PuestoService.Dto
{
    public class PuestoCreateDto
    {
        public string Nombre { get; set; } = null!;

        public double Salario { get; set; }
    }
}
