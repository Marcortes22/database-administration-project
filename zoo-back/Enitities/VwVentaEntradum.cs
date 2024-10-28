using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwVentaEntradum
{
    public int IdVentaEntrada { get; set; }

    public DateTime Fechaventa { get; set; }

    public int IdVisitantes { get; set; }

    public int IdMetodoPago { get; set; }
}
