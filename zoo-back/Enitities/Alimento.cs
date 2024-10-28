using System;
using System.Collections.Generic;

namespace Entities;

public partial class Alimento
{
    public int IdAlimentos { get; set; }

    public string Nombre { get; set; } = null!;

    public virtual ICollection<DietaAlimento> DietaAlimentos { get; set; } = new List<DietaAlimento>();
}
