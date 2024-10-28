using System;
using System.Collections.Generic;

namespace Entities;

public partial class TareasEstadoTarea
{
    public int IdTareas { get; set; }

    public int IdEstadoTarea { get; set; }

    public DateTime Fecha { get; set; }

    public virtual EstadoTarea IdEstadoTareaNavigation { get; set; } = null!;

    public virtual Tarea IdTareasNavigation { get; set; } = null!;
}
