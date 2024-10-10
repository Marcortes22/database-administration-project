using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditVisitante
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdVisitantes { get; set; }

    public string? NombreVist { get; set; }

    public string? Apell1Vist { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
