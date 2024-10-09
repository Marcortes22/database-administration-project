using System;
using System.Collections.Generic;

namespace Services;

public partial class Venta
{
    public int IdVenta { get; set; }

    public DateOnly Fecha { get; set; }

    public double Total { get; set; }

    public int IdVisitante { get; set; }

    public virtual ICollection<DetalleVentum> DetalleVenta { get; set; } = new List<DetalleVentum>();

    public virtual Visitante IdVisitanteNavigation { get; set; } = null!;
}
