using System;
using System.Collections.Generic;

namespace Entities;

public partial class AuditAnimale
{
    public int IdAudit { get; set; }

    public string? NombreTabla { get; set; }

    public string? Operacion { get; set; }

    public int? IdAnimales { get; set; }

    public string? NombreAni { get; set; }

    public int? EdadAni { get; set; }

    public int? IdDieta { get; set; }

    public int? IdHabitacion { get; set; }

    public int? IdEspecies { get; set; }

    public int? IdEstadoSalud { get; set; }

    public int? IdZoo { get; set; }

    public string? RealizadoPor { get; set; }

    public DateTime? FechaDeEjecucion { get; set; }
}
