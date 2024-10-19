using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwEstadoHabitacion
{
    public int IdEstadoHabitacion { get; set; }

    public string Estado { get; set; } = null!;

    public string Descripcion { get; set; } = null!;

    public DateOnly Fecha { get; set; }
}
