using System;
using System.Collections.Generic;

namespace Entities;

public partial class Usuario
{
    public int IdUsuario { get; set; }

    public string Contraseña { get; set; } = null!;

    public bool Estado { get; set; }

    public virtual Empleado IdUsuarioNavigation { get; set; } = null!;

    public virtual ICollection<RolUsuario> RolUsuarios { get; set; } = new List<RolUsuario>();
}
