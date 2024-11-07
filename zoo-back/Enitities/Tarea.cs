using System;
using System.Collections.Generic;

namespace Entities;

public partial class Tarea
{
    public int IdTareas { get; set; }

    public int IdEmpleado { get; set; }

    public int IdTipoTarea { get; set; }

    public int IdEstadoTarea { get; set; }

    public DateTime FechaCreacion { get; set; }

    public virtual ICollection<ControlAnimal> ControlAnimals { get; set; } = new List<ControlAnimal>();

    public virtual ICollection<HistorialEstadoTarea> HistorialEstadoTareas { get; set; } = new List<HistorialEstadoTarea>();

    public virtual Empleado IdEmpleadoNavigation { get; set; } = null!;

    public virtual EstadoTarea IdEstadoTareaNavigation { get; set; } = null!;

    public virtual TipoTarea IdTipoTareaNavigation { get; set; } = null!;

    public virtual ICollection<MantenimientoHabitacion> MantenimientoHabitacions { get; set; } = new List<MantenimientoHabitacion>();
}
