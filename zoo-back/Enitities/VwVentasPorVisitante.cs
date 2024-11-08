using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwVentasPorVisitante
{
    public string? Visitante { get; set; }

    public int? TotalCompras { get; set; }

    public decimal? GastoTotal { get; set; }
}
