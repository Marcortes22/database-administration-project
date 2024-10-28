using System;
using System.Collections.Generic;

namespace Entities;

public partial class HabitacionEstadoHabitacion
{
    public int IdHabitacionEstadoHabitacion { get; set; }

    public int IdHabitacion { get; set; }

    public int IdEstadoHabitacion { get; set; }

    public string Descripcion { get; set; } = null!;

    public DateOnly Fecha { get; set; }

    public virtual EstadoHabitacion IdEstadoHabitacionNavigation { get; set; } = null!;

    public virtual Habitacion IdHabitacionNavigation { get; set; } = null!;
}
