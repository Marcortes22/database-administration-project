﻿using System;
using System.Collections.Generic;

namespace Services;

public partial class HistorialMovimiento
{
    public int IdHistorialMovimientos { get; set; }

    public DateOnly FechaMovimiento { get; set; }

    public int IdHabitacionAnterior { get; set; }

    public int IdHabitacionActual { get; set; }

    public string Motivo { get; set; } = null!;

    public int IdAnimales { get; set; }

    public virtual Animale IdAnimalesNavigation { get; set; } = null!;
}