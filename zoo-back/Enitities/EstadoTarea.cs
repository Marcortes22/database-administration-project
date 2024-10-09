using System;
using System.Collections.Generic;

namespace Services;

public partial class EstadoTarea
{
    public int IdEstadoTarea { get; set; }

    public string Nombre { get; set; } = null!;

    public virtual ICollection<TareasEstadosTarea> TareasEstadosTareas { get; set; } = new List<TareasEstadosTarea>();
}
