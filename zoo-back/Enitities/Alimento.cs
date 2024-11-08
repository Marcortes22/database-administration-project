using System;
using System.Collections.Generic;

namespace Entities;

public partial class Alimento
{
    public int IdAlimentos { get; set; }

    public string Nombre { get; set; } = null!;

    public int IdUnidadMedida { get; set; }

    public virtual ICollection<DietaAlimento> DietaAlimentos { get; set; } = new List<DietaAlimento>();

    public virtual UnidadMedidum IdUnidadMedidaNavigation { get; set; } = null!;
}
