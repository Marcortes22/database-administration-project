using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditMetodoPago
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdMetodoPago { get; set; }

    public string? MetodoPago { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
