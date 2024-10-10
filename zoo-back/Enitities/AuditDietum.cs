using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditDietum
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdDieta { get; set; }

    public string? NombreDiet { get; set; }

    public string? DescripcionDiet { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
