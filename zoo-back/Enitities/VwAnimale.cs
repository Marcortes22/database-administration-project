using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwAnimale
{
    public int IdAnimales { get; set; }

    public string NombreAni { get; set; } = null!;

    public int EdadAni { get; set; }

    public int IdDieta { get; set; }

    public int IdHabitacion { get; set; }

    public int IdEspecie { get; set; }

    public int IdEstadoSalud { get; set; }

    public int IdZoo { get; set; }
}
