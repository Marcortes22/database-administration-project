using System;
using System.Collections.Generic;

namespace Services;

public partial class Dietum
{
    public int IdDieta { get; set; }

    public string NombreDiet { get; set; } = null!;

    public string DescripcionDiet { get; set; } = null!;

    public virtual ICollection<Animale> Animales { get; set; } = new List<Animale>();
}
