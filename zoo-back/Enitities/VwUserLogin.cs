using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwUserLogin
{
    public int IdEmpleado { get; set; }

    public string Nombre { get; set; } = null!;

    public string Apellido1 { get; set; } = null!;

    public string Apellido2 { get; set; } = null!;

    public string Correo { get; set; } = null!;
}
