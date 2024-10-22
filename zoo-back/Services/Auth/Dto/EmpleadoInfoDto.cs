using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
using Services.RolService.Dto;

namespace Services.Auth.Dto
{
    public class EmpleadoInfoDto
    {
        public int IdEmpleado { get; set; }
        public string Nombre { get; set; }
        public string Apellido1 { get; set; }
        public string Apellido2 { get; set; }
        public string Correo { get; set; }
        public List<VwEmpleadoRolesActivo> Roles { get; set; }
    }
}
