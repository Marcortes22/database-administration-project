using System;
using System.Collections.Generic;

namespace Services;

public partial class Empleado
{
    public int IdEmpleado { get; set; }

    public string Nombre { get; set; } = null!;

    public string Apellido1 { get; set; } = null!;

    public string Apellido2 { get; set; } = null!;

    public int IdPuesto { get; set; }

    public int? IdZoo { get; set; }

    public virtual Puesto IdPuestoNavigation { get; set; } = null!;

    public virtual Zoo? IdZooNavigation { get; set; }

    public virtual ICollection<RolUsario> RolUsarios { get; set; } = new List<RolUsario>();

    public virtual ICollection<Tarea> Tareas { get; set; } = new List<Tarea>();

    public virtual ICollection<Usuario> Usuarios { get; set; } = new List<Usuario>();
}
