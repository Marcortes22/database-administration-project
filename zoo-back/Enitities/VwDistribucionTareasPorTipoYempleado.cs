using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwDistribucionTareasPorTipoYempleado
{
    public int? IdEmpleado { get; set; }

    public string? NombreCompleto { get; set; }

    public string? TipoTarea { get; set; }

    public int? TotalTareas { get; set; }
}
