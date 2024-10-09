using System;
using System.Collections.Generic;

namespace Services;

public partial class RolUsario
{
    public int IdRolUsario { get; set; }

    public int IdRol { get; set; }

    public int IdEmpleado { get; set; }

    public virtual Empleado IdEmpleadoNavigation { get; set; } = null!;

    public virtual Rol IdRolNavigation { get; set; } = null!;
}
