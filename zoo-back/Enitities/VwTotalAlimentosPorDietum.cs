using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwTotalAlimentosPorDietum
{
    public string? Dieta { get; set; }

    public string? Alimento { get; set; }

    public string? UnidadMedida { get; set; }

    public decimal? CantidadTotal { get; set; }
}
