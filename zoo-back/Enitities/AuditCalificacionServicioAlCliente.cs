using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditCalificacionServicioAlCliente
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdCalificacionServicioAlCliente { get; set; }

    public string? Nota { get; set; }

    public string? SugerenciaMejora { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
