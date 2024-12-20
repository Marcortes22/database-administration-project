﻿using System;
using System.Collections.Generic;

namespace Entities;

public partial class Dietum
{
    public int IdDieta { get; set; }

    public string NombreDiet { get; set; } = null!;

    public virtual ICollection<Animale> Animales { get; set; } = new List<Animale>();

    public virtual ICollection<DietaAlimento> DietaAlimentos { get; set; } = new List<DietaAlimento>();
}
