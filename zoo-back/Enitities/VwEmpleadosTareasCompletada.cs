using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwEmpleadosTareasCompletada
{
    public int? IdEmpleado { get; set; }

    public string? NombreCompleto { get; set; }

    public string? Puesto { get; set; }

    public int? TareasCompletadas { get; set; }
}
