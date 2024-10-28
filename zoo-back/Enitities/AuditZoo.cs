using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditZoo
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdZoo { get; set; }

    public string? NombreZoo { get; set; }

    public string? Direccion { get; set; }

    public string? DescripcionZoo { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
