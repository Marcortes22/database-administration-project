using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwTopDiasConMasVenta
{
    public DateOnly? Fecha { get; set; }

    public int? TotalVentas { get; set; }

    public decimal? MontoTotalVentas { get; set; }
}
