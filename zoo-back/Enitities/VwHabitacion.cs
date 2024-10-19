using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwHabitacion
{
    public int IdHabitacion { get; set; }

    public string NombreHab { get; set; } = null!;

    public string Direccion { get; set; } = null!;

    public int Capacidad { get; set; }

    public int IdTipoHabitacion { get; set; }
}
