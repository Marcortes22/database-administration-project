using System;
using System.Collections.Generic;

namespace Entities;

public partial class UnidadMedidum
{
    public int IdUnidadMedida { get; set; }

    public string? Nombre { get; set; }

    public virtual ICollection<Alimento> Alimentos { get; set; } = new List<Alimento>();
}
