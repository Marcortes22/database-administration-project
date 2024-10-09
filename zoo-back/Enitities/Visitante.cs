using System;
using System.Collections.Generic;

namespace Services;

public partial class Visitante
{
    public int IdVisitante { get; set; }

    public string Nombre { get; set; } = null!;

    public string Apellido1 { get; set; } = null!;

    public string Apellido2 { get; set; } = null!;

    public string Tipo { get; set; } = null!;

    public virtual ICollection<Venta> Venta { get; set; } = new List<Venta>();
}
