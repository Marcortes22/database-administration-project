using System;
using System.Collections.Generic;

namespace Entities;

public partial class DietaAlimento
{
    public int IdDietaAlimentos { get; set; }

    public int IdDieta { get; set; }

    public int IdAlimentos { get; set; }

    public decimal? Cantidad { get; set; }

    public virtual Alimento IdAlimentosNavigation { get; set; } = null!;

    public virtual Dietum IdDietaNavigation { get; set; } = null!;
}
