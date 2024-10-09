using System;
using System.Collections.Generic;

namespace Services;

public partial class AuditDietaAlimento
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdDietaAlimentos { get; set; }

    public int? IdDieta { get; set; }

    public int? IdAlimentos { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
