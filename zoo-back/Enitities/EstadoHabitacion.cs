using System;
using System.Collections.Generic;

namespace Entities;

public partial class EstadoHabitacion
{
    public int IdEstadoHabitacion { get; set; }

    public string Estado { get; set; } = null!;

    public virtual ICollection<Habitacion> Habitacions { get; set; } = new List<Habitacion>();
}
