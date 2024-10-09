using System;
using System.Collections.Generic;

namespace Services;

public partial class TipoHabitacion
{
    public int IdTipoHabitacion { get; set; }

    public string NombreTh { get; set; } = null!;

    public virtual ICollection<Habitacion> Habitacions { get; set; } = new List<Habitacion>();
}
