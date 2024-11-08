using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwVentasPorMetodoPago
{
    public string? MetodoPago { get; set; }

    public int? TotalVentas { get; set; }

    public decimal? MontoTotalVentas { get; set; }
}
