using System;
using System.Collections.Generic;

namespace Entities;

public partial class Tarea
{
    public int IdTareas { get; set; }

    public string Nombre { get; set; } = null!;

    public int IdEmpleado { get; set; }

    public int IdTipoTarea { get; set; }

    public virtual ICollection<ControlAnimal> ControlAnimals { get; set; } = new List<ControlAnimal>();

    public virtual Empleado IdEmpleadoNavigation { get; set; } = null!;

    public virtual TipoTarea IdTipoTareaNavigation { get; set; } = null!;

    public virtual ICollection<MantenimientoHabitacion> MantenimientoHabitacions { get; set; } = new List<MantenimientoHabitacion>();

    public virtual TareasEstadoTarea? TareasEstadoTarea { get; set; }
}
