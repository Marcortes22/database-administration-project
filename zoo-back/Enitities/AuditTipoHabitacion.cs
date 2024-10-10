using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditTipoHabitacion
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdTipoHabitacion { get; set; }

    public string? NombreTh { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
