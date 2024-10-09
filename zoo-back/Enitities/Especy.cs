using System;
using System.Collections.Generic;

namespace Services;

public partial class Especy
{
    public int IdEspecie { get; set; }

    public string NombreEsp { get; set; } = null!;

    public virtual ICollection<Animale> Animales { get; set; } = new List<Animale>();
}
