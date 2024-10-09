using System;
using System.Collections.Generic;

namespace Services;

public partial class DetalleVentum
{
    public int IdDetalleVenta { get; set; }

    public int IdVenta { get; set; }

    public int IdAnimales { get; set; }

    public double Precio { get; set; }

    public virtual Animale IdAnimalesNavigation { get; set; } = null!;

    public virtual Venta IdVentaNavigation { get; set; } = null!;
}
