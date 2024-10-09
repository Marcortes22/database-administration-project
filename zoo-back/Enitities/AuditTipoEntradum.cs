using System;
using System.Collections.Generic;

namespace Services;

public partial class AuditTipoEntradum
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdTipoEntrada { get; set; }

    public string? NombreEnt { get; set; }

    public string? DescripcionEnt { get; set; }

    public decimal? Precio { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
