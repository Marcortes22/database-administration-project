using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwAlimentosMasUtilizado
{
    public string? Alimento { get; set; }

    public string? UnidadMedida { get; set; }

    public decimal? CantidadTotal { get; set; }

    public int? NumeroDietas { get; set; }
}
