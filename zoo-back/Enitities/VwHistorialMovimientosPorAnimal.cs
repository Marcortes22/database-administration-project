using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwHistorialMovimientosPorAnimal
{
    public string? NombreAnimal { get; set; }

    public string? Fecha { get; set; }

    public string? HabitacionAnterior { get; set; }

    public string? HabitacionActual { get; set; }

    public string? Motivo { get; set; }
}
