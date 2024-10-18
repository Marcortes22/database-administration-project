using System;
using System.Collections.Generic;

namespace Entities;

public partial class TipoEntradum
{
    public int IdTipoEntrada { get; set; }

    public string NombreEnt { get; set; } = null!;

    public decimal Precio { get; set; }

    public virtual ICollection<DetalleVentum> DetalleVenta { get; set; } = new List<DetalleVentum>();

    public virtual ICollection<Entradum> Entrada { get; set; } = new List<Entradum>();
}
