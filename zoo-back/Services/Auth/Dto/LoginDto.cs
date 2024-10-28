using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.Auth.Dto
{
    public class LoginDto
    {
        public int IdEmpleado { get; set; }

        public string Contraseña { get; set; }
    }
}
