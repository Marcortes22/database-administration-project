using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwVentasPorEntradaYtipo
{
    public string? TipoEntrada { get; set; }

    public int? Cantidad { get; set; }

    public decimal? MontoTotal { get; set; }
}
