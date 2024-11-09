using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwTareasMantenimiento
{
    public int IdTareas { get; set; }

    public string NombreTarea { get; set; } = null!;

    public string NombreEmpleado { get; set; } = null!;

    public int IdEmpleado { get; set; }

    public string Estado { get; set; } = null!;

    public string NombreHab { get; set; } = null!;
}
