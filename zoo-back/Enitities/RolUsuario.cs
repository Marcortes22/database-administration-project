using System;
using System.Collections.Generic;

namespace Entities;

public partial class RolUsuario
{
    public int IdRolUsario { get; set; }

    public int IdRol { get; set; }

    public int IdUsuario { get; set; }

    public DateOnly FechaInicio { get; set; }

    public DateOnly? FechaFin { get; set; }

    public virtual Rol IdRolNavigation { get; set; } = null!;

    public virtual Usuario IdUsuarioNavigation { get; set; } = null!;
}
