using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwPuesto
{
    public int IdPuesto { get; set; }

    public string Nombre { get; set; } = null!;

    public double Salario { get; set; }
}
