using System;
using System.Collections.Generic;

namespace Services;

public partial class AuditEstadoTarea
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdEstadoTarea { get; set; }

    public string? Nombre { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
