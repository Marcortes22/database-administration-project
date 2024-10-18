﻿using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditEspecie
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdEspecie { get; set; }

    public string? NombreEsp { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}