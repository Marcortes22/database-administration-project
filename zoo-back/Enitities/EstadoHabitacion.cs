using System;
using System.Collections.Generic;

namespace Services;

public partial class EstadoHabitacion
{
    public int IdEstadoHabitacion { get; set; }

    public string Estado { get; set; } = null!;

    public string Descripcion { get; set; } = null!;

    public DateOnly Fecha { get; set; }

    public virtual ICollection<HabitacionEstadoHabitacion> HabitacionEstadoHabitacions { get; set; } = new List<HabitacionEstadoHabitacion>();
}
