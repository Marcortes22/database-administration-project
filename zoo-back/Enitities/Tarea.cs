using System;
using System.Collections.Generic;

namespace Entities;
public partial class Tarea
{
    public int IdTareas { get; set; }

    public string Nombre { get; set; } = null!;

    public string Descripcion { get; set; } = null!;

    public int IdEmpleado { get; set; }

    public virtual Empleado IdEmpleadoNavigation { get; set; } = null!;

    public virtual ICollection<TareasEstadosTarea> TareasEstadosTareas { get; set; } = new List<TareasEstadosTarea>();
}
