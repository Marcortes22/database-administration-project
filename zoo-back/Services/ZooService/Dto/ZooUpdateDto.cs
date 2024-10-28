using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.ZooService.Dto
{
    public class ZooUpdateDto
    {

        public string? NombreZoo { get; set; } = null!;

        public string? Direccion { get; set; } = null!;

        public string? DescripcionZoo { get; set; } = null!;
    }
}
