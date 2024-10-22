using System;
using System.Collections.Generic;

namespace Entities;

public partial class MetodoPago
{
    public int IdMetodoPago { get; set; }

    public string Metodopago { get; set; } = null!;

    public virtual ICollection<VentaEntradum> VentaEntrada { get; set; } = new List<VentaEntradum>();
}
