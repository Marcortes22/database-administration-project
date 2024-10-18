using System;
using System.Collections.Generic;

namespace Entities;

public partial class Visitante
{
    public int IdVisitantes { get; set; }

    public string NombreVist { get; set; } = null!;

    public string Apell1Vist { get; set; } = null!;

    public string Apell2Vist { get; set; } = null!;

    public string CorreoElectronico { get; set; } = null!;

    public int Telefono { get; set; }

    public virtual ICollection<CalificacionVisitum> CalificacionVisita { get; set; } = new List<CalificacionVisitum>();

    public virtual ICollection<VentaEntradum> VentaEntrada { get; set; } = new List<VentaEntradum>();
}
