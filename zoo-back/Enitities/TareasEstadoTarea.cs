using System;
using System.Collections.Generic;

namespace Entities;

public partial class TareasEstadoTarea
{
    public int IdTareas { get; set; }

    public int IdHabitacion { get; set; }

    public int IdEstadoTarea { get; set; }

    public DateOnly Fecha { get; set; }

    public virtual Habitacion IdHabitacionNavigation { get; set; } = null!;

    public virtual Tarea IdTareasNavigation { get; set; } = null!;
}
