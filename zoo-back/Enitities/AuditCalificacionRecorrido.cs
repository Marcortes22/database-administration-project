using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditCalificacionRecorrido
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdCalificacionRecorrido { get; set; }

    public string? Nota { get; set; }

    public string? SugerenciaMejora { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
