using System;
using System.Collections.Generic;

namespace Services;

public partial class TareasEstadosTarea
{
    public int IdTareasEstadosTareas { get; set; }

    public int IdTareas { get; set; }

    public int IdEstadoTarea { get; set; }

    public virtual EstadoTarea IdEstadoTareaNavigation { get; set; } = null!;

    public virtual Tarea IdTareasNavigation { get; set; } = null!;
}
