﻿using System;
using System.Collections.Generic;

namespace Services;

public partial class Rol
{
    public int IdRol { get; set; }

    public string Nombre { get; set; } = null!;

    public virtual ICollection<RolUsario> RolUsarios { get; set; } = new List<RolUsario>();
}