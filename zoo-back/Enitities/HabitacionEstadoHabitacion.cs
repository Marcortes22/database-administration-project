using System;
using System.Collections.Generic;

namespace Services;

public partial class HabitacionEstadoHabitacion
{
    public int IdHabitacionEstadoHabitacion { get; set; }

    public int IdHabitacion { get; set; }

    public int IdEstadoHabitacion { get; set; }

    public virtual EstadoHabitacion IdEstadoHabitacionNavigation { get; set; } = null!;

    public virtual Habitacion IdHabitacionNavigation { get; set; } = null!;
}
