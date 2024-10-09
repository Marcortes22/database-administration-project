using System;
using System.Collections.Generic;

namespace Services;

public partial class AuditVisitante
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdVisitantes { get; set; }

    public string? NombreVist { get; set; }

    public string? Apell1Vist { get; set; }

    public string? Apell2Vist { get; set; }

    public bool? Disponibilidad { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
