using System;
using System.Collections.Generic;

namespace Services;

public partial class Zoo
{
    public int IdZoo { get; set; }

    public string NombreZoo { get; set; } = null!;

    public string Direccion { get; set; } = null!;

    public string DescripcionZoo { get; set; } = null!;

    public virtual ICollection<Animale> Animales { get; set; } = new List<Animale>();

    public virtual ICollection<Empleado> Empleados { get; set; } = new List<Empleado>();
}
