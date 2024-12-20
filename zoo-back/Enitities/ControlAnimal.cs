﻿using System;
using System.Collections.Generic;

namespace Entities;

public partial class ControlAnimal
{
    public int IdControl { get; set; }

    public string? Reporte { get; set; }

    public int IdTareas { get; set; }

    public string Nombre { get; set; } = null!;

    public int IdAnimales { get; set; }

    public virtual Animale IdAnimalesNavigation { get; set; } = null!;

    public virtual Tarea IdTareasNavigation { get; set; } = null!;
}
