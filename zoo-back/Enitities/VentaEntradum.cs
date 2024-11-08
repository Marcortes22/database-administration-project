using System;
using System.Collections.Generic;

namespace Entities;

public partial class VentaEntradum
{
    public int IdVentaEntrada { get; set; }

    public DateTime Fechaventa { get; set; }

    public int IdVisitantes { get; set; }

    public int IdMetodoPago { get; set; }

    public int IdEmpleado { get; set; }

    public decimal? Iva { get; set; }

    public virtual ICollection<CalificacionVisitum> CalificacionVisita { get; set; } = new List<CalificacionVisitum>();

    public virtual ICollection<DetalleVentum> DetalleVenta { get; set; } = new List<DetalleVentum>();

    public virtual Empleado IdEmpleadoNavigation { get; set; } = null!;

    public virtual MetodoPago IdMetodoPagoNavigation { get; set; } = null!;

    public virtual Visitante IdVisitantesNavigation { get; set; } = null!;
}
