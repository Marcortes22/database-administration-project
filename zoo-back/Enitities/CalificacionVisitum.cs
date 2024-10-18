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

    public int IdCalificacionServicioAlCliente { get; set; }

    public int IdCalificacionRecorrido { get; set; }

    public virtual CalificacionRecorrido IdCalificacionRecorridoNavigation { get; set; } = null!;

    public virtual CalificacionServicioAlCliente IdCalificacionServicioAlClienteNavigation { get; set; } = null!;

    public virtual Visitante IdVisitantesNavigation { get; set; } = null!;
}
