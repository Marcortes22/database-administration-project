using System;
using System.Collections.Generic;

namespace Entities;

public partial class MantenimientoHabitacion
{
    public int IdMantenimientoHabitacion { get; set; }

    public string Reporte { get; set; } = null!;

    public int IdTareas { get; set; }

    public int IdHabitacion { get; set; }

    public virtual Habitacion IdHabitacionNavigation { get; set; } = null!;

    public virtual Tarea IdTareasNavigation { get; set; } = null!;
}
