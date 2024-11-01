using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditCalificacionVisitum
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdCalificacionVisita { get; set; }

    public string? SugerenciaMejora { get; set; }

    public DateOnly? Fecha { get; set; }

    public int? IdVentaEntrada { get; set; }

    public int? IdCalificacionRecorrido { get; set; }

    public int? IdRecorrido { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
