using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwDistribucionAlimentosPorUnidadMedidum
{
    public string? UnidadMedida { get; set; }

    public string? Alimento { get; set; }

    public int? TotalVecesUsado { get; set; }

    public decimal? CantidadTotal { get; set; }
}
