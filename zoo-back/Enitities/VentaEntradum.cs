using System;
using System.Collections.Generic;

namespace Entities;

public partial class VentaEntradum
{
    public int IdVentaEntrada { get; set; }

    public DateOnly Fechaventa { get; set; }

    public TimeOnly Horaventa { get; set; }

    public int IdZoo { get; set; }

    public int IdVisitantes { get; set; }

    public int IdMetodoPago { get; set; }

    public virtual MetodoPago IdMetodoPagoNavigation { get; set; } = null!;

    public virtual Visitante IdVisitantesNavigation { get; set; } = null!;

    public virtual Zoo IdZooNavigation { get; set; } = null!;
}
