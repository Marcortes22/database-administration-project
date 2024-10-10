using System;
using System.Collections.Generic;

namespace Entities;

public partial class RolUsario
{
    public int IdRolUsario { get; set; }

    public int IdRol { get; set; }

    public int IdUsuario { get; set; }

    public virtual Rol IdRolNavigation { get; set; } = null!;

    public virtual Usuario IdUsuarioNavigation { get; set; } = null!;
}
