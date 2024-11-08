using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwCantidadAlimentosPorTipoDietum
{
    public string? TipoDieta { get; set; }

    public string? Alimento { get; set; }

    public decimal? CantidadTotal { get; set; }
}
