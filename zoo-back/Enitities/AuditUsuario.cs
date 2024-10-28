using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditUsuario
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdUsuario { get; set; }

    public string? Contraseña { get; set; }

    public bool? Estado { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
