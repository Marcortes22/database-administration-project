﻿using System;
using System.Collections.Generic;

namespace Entities;

public partial class TipoTarea
{
    public int IdTipoTarea { get; set; }

    public string NombreTt { get; set; } = null!;

    public virtual ICollection<Tarea> Tareas { get; set; } = new List<Tarea>();
}
