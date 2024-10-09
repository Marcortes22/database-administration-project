using System;
using System.Collections.Generic;

namespace Services;

public partial class Usuario
{
    public int IdUsuario { get; set; }

    public string Contraseña { get; set; } = null!;

    public int IdEmpleado { get; set; }

    public virtual Empleado IdEmpleadoNavigation { get; set; } = null!;
}
