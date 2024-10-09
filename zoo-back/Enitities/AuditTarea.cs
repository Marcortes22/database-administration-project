﻿using System;
using System.Collections.Generic;

namespace Services;

public partial class AuditTarea
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdTareas { get; set; }

    public string? Nombre { get; set; }

    public string? Descripcion { get; set; }

    public int? IdEmpleado { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}