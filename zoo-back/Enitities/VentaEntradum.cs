﻿using System;
using System.Collections.Generic;

namespace Entities;

public partial class VentaEntradum
{
    public int IdVentaEntrada { get; set; }

    public DateOnly Fechaventa { get; set; }

    public int IdVisitantes { get; set; }

    public int IdMetodoPago { get; set; }

    public virtual ICollection<DetalleVentum> DetalleVenta { get; set; } = new List<DetalleVentum>();

    public virtual MetodoPago IdMetodoPagoNavigation { get; set; } = null!;

    public virtual Visitante IdVisitantesNavigation { get; set; } = null!;
}
