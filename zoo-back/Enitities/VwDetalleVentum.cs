using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwDetalleVentum
{
    public int IdDetalleVenta { get; set; }

    public int IdVentaEntrada { get; set; }

    public int Cantidad { get; set; }
}
