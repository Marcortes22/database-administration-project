using System;
using System.Collections.Generic;

namespace Entities;

public partial class EstadoSalud
{
    public int IdEstadoSalud { get; set; }

    public string EstadoSalud1 { get; set; } = null!;

    public virtual ICollection<Animale> Animales { get; set; } = new List<Animale>();
}
