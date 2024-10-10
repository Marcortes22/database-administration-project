using System;
using System.Collections.Generic;

namespace Entities;

public partial class CalificacionVisitum
{
    public int IdCalificacionVisita { get; set; }

    public int Nota { get; set; }

    public string SugerenciaMejora { get; set; } = null!;

    public DateOnly Fecha { get; set; }

    public int IdVisitantes { get; set; }

    public virtual Visitante IdVisitantesNavigation { get; set; } = null!;
}
