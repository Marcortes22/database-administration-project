using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwVentasPorEmpleado
{
    public string? Empleado { get; set; }

    public int? TotalVentas { get; set; }

    public decimal? MontoTotalVentas { get; set; }
}
