using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwTipoEntradum
{
    public int IdTipoEntrada { get; set; }

    public string NombreEnt { get; set; } = null!;

    public decimal Precio { get; set; }
}
