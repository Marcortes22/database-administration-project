using System;
using System.Collections.Generic;

namespace Services;

public partial class AuditPuesto
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdPuesto { get; set; }

    public string? Nombre { get; set; }

    public double? Salario { get; set; }

    public string? DescripcionTareas { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
