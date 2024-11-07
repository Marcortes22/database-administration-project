using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwPorcentajeTareasCompletadasPorTipo
{
    public int IdTipoTarea { get; set; }

    public string? TipoTarea { get; set; }

    public decimal? PorcentajeCompletado { get; set; }
}
