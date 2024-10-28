using System;
using System.Collections.Generic;

namespace Entities;

public partial class DetalleVentum
{
    public int IdDetalleVenta { get; set; }

    public int IdEntrada { get; set; }

    public int IdVentaEntrada { get; set; }

    public int Cantidad { get; set; }

    public decimal Precio { get; set; }

    public virtual Entradum IdEntradaNavigation { get; set; } = null!;

    public virtual VentaEntradum IdVentaEntradaNavigation { get; set; } = null!;
}
