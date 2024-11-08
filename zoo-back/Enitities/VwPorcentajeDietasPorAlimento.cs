using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwPorcentajeDietasPorAlimento
{
    public string? Alimento { get; set; }

    public int? NumeroDietasConAlimento { get; set; }

    public decimal? PorcentajeDietas { get; set; }
}
