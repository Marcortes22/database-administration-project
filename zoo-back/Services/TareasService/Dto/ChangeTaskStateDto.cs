using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.TareasService.Dto
{
    public class ChangeTaskStateDto
    {
        public int IdTarea { get; set; }
        public int IdEstadoTarea { get; set; }

    }
}
