using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.Auth.Dto
{
    public class RegisterDto
    {
        public string IdEmpleado { get; set; } 
        public string Nombre { get; set; }     
        public string Apellido1 { get; set; }  
        public string Apellido2 { get; set; }  
        public string Correo { get; set; }     
        public int IdPuesto { get; set; }     
        public string Contraseña { get; set; } 
        public int IdRol { get; set; }        
        public DateTime RolFechaInicio { get; set; } 
        public DateTime RolFechaFin { get; set; }   
        
    }
}
