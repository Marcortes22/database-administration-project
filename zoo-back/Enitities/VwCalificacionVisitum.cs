using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwCalificacionVisitum
{
    public int IdCalificacionVisita { get; set; }

    public int Nota { get; set; }

    public DateOnly Fecha { get; set; }

    public int IdVisitantes { get; set; }
}
