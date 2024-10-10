using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditEstadoSalud
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdEstadoSalud { get; set; }

    public string? EstadoSalud { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
