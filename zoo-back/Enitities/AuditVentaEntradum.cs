using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditVentaEntradum
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdVentaEntrada { get; set; }

    public DateOnly? Fechaventa { get; set; }

    public TimeOnly? Horaventa { get; set; }

    public int? IdEmpleado { get; set; }

    public int? IdVisitantes { get; set; }

    public int? IdMetodoPago { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
