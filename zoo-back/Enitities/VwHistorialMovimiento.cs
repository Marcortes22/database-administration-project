using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwHistorialMovimiento
{
    public int IdHistorialMovimientos { get; set; }

    public DateOnly FechaMovimiento { get; set; }

    public int IdHabitacionAnterior { get; set; }

    public int IdHabitacionActual { get; set; }

    public string Motivo { get; set; } = null!;

    public int IdAnimales { get; set; }
}
