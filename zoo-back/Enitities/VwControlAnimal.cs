﻿using System;
using System.Collections.Generic;

namespace Entities;

public partial class VwControlAnimal
{
    public int IdControl { get; set; }

    public string Reporte { get; set; } = null!;

    public int IdTareas { get; set; }

    public int IdAnimales { get; set; }
}