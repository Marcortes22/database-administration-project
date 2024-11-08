using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwResumenTareasPorEstado
{
    public int IdEstadoTarea { get; set; }

    public string? EstadoTarea { get; set; }

    public int? TotalTareas { get; set; }
}
