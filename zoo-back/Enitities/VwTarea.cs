using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwTarea
{
    public int IdTareas { get; set; }

    public string Nombre { get; set; } = null!;

    public int IdEmpleado { get; set; }
}
