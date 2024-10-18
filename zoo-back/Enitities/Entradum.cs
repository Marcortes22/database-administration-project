﻿using System;
using System.Collections.Generic;

namespace Entities;

public partial class Entradum
{
    public int IdEntrada { get; set; }

    public string Descripcion { get; set; } = null!;

    public int IdTipoEntrada { get; set; }

    public virtual ICollection<DetalleVentum> DetalleVenta { get; set; } = new List<DetalleVentum>();

    public virtual TipoEntradum IdTipoEntradaNavigation { get; set; } = null!;
}
