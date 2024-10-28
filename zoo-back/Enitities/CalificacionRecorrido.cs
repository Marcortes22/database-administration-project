using System;
using System.Collections.Generic;

namespace Entities;

public partial class CalificacionRecorrido
{
    public int IdCalificacionRecorrido { get; set; }

    public int Nota { get; set; }

    public string? SugerenciaMejora { get; set; }

    public virtual ICollection<CalificacionVisitum> CalificacionVisita { get; set; } = new List<CalificacionVisitum>();
}
