﻿using System;
using System.Collections.Generic;

namespace Services;

public partial class AuditCalificacionVisitum
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public long? IdCalificacionVisita { get; set; }

    public double? Nota { get; set; }

    public string? SugerenciaMejora { get; set; }

    public DateOnly? Fecha { get; set; }

    public int? IdVisitantes { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
