using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditHabitacion
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdHabitacion { get; set; }

    public string? NombreHab { get; set; }

    public string? Direccion { get; set; }

    public int? Capacidad { get; set; }

    public int? IdTipoHabitacion { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
