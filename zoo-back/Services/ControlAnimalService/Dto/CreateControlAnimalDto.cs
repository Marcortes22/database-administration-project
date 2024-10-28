using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.ControlAnimalService.Dto
{
    public class CreateControlAnimalDto
    {
        public int IdAnimales { get; set; }

        public int IdEmpleado{ get; set; }
        public string NombreTarea{ get; set; }

    }
}
