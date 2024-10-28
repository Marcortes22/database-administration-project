using System;
using System.Collections.Generic;

namespace Entities;

public partial class Rol
{
    public int IdRol { get; set; }

    public string Nombre { get; set; } = null!;

    public virtual ICollection<RolUsuario> RolUsuarios { get; set; } = new List<RolUsuario>();
}
