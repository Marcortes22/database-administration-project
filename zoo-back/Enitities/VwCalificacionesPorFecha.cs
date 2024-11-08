using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwCalificacionesPorFecha
{
    public DateOnly? Fecha { get; set; }

    public int? PromedioNotaRecorrido { get; set; }

    public int? PromedioNotaServicioCliente { get; set; }

    public decimal? PromedioNotaFinal { get; set; }
}
