using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwEmpleadosTareasPendiente
{
    public int? IdEmpleado { get; set; }

    public string? NombreCompleto { get; set; }

    public int? TareasPendientes { get; set; }
}
