using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.DietaService.Dto
{
    public class DietaCreateDto
    {
        public string NombreDiet { get; set; } = null!;

        public List<AlimentoListDto> Alimentos { get; set; } = null!;
    }
}
