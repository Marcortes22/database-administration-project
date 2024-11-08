using System;
using System.Collections.Generic;

namespace Entities;

public partial class HistorialEstadoTarea
{
    public int IdHistorialEstadoTarea { get; set; }

    public int IdTarea { get; set; }

    public int IdEstadoTarea { get; set; }

    public int IdTipoTarea { get; set; }

    public int IdEmpleado { get; set; }

    public DateTime? Fecha { get; set; }

    public virtual Empleado IdEmpleadoNavigation { get; set; } = null!;

    public virtual EstadoTarea IdEstadoTareaNavigation { get; set; } = null!;

    public virtual Tarea IdTareaNavigation { get; set; } = null!;

    public virtual TipoTarea IdTipoTareaNavigation { get; set; } = null!;
}
