using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditPuesto
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdPuesto { get; set; }

    public string Nombre { get; set; } = null!;

    public double? Salario { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
