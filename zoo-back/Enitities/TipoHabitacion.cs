using System;
using System.Collections.Generic;

namespace Entities;

public partial class TipoHabitacion
{
    public int IdTipoHabitacion { get; set; }

    public string? NombreTh { get; set; }

    public virtual ICollection<Habitacion> Habitacions { get; set; } = new List<Habitacion>();
}
