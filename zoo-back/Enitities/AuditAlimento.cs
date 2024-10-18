using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditAlimento
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdAlimentos { get; set; }

    public string? Nombre { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
