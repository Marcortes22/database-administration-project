using System;
using System.Collections.Generic;

namespace Entities;

public partial class EstadoTarea
{
    public int IdEstadoTarea { get; set; }

    public string Nombre { get; set; } = null!;

    public virtual ICollection<HistorialEstadoTarea> HistorialEstadoTareas { get; set; } = new List<HistorialEstadoTarea>();

    public virtual ICollection<Tarea> Tareas { get; set; } = new List<Tarea>();
}
