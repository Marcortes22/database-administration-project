using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditEstadoHabitacion
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdEstadoHabitacion { get; set; }

    public string? Estado { get; set; }

    public string? Descripcion { get; set; }

    public DateOnly? Fecha { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
