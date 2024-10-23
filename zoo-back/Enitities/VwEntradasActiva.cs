using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwEntradasActiva
{
    public int IdEntrada { get; set; }

    public DateOnly? FechaVencimiento { get; set; }

    public int? Descuento { get; set; }

    public string TipoEntrada { get; set; } = null!;

    public decimal PrecioTipoEntrada { get; set; }

    public decimal? PrecioTotal { get; set; }
}
