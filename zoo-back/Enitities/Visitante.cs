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

    public string Telefono { get; set; } = null!;

    public virtual ICollection<VentaEntradum> VentaEntrada { get; set; } = new List<VentaEntradum>();
}
