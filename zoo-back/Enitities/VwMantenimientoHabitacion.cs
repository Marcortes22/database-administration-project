using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwMantenimientoHabitacion
{
    public int IdMantenimientoHabitacion { get; set; }

    public string? Reporte { get; set; }

    public int IdTareas { get; set; }

    public int IdHabitacion { get; set; }
}
