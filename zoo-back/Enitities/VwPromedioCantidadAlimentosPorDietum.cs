using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwPromedioCantidadAlimentosPorDietum
{
    public string? Alimento { get; set; }

    public string? UnidadMedida { get; set; }

    public decimal? PromedioCantidad { get; set; }
}
