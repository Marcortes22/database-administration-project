using System;
using System.Collections.Generic;

namespace Entities;

public partial class VistaVentaSinCalificacione
{
    public int IdVentaEntrada { get; set; }

    public DateTime Fechaventa { get; set; }

    public string Nombre { get; set; } = null!;
}
