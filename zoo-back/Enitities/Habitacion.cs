using System;
using System.Collections.Generic;

namespace Entities;

public partial class Habitacion
{
    public int IdHabitacion { get; set; }

    public string NombreHab { get; set; } = null!;

    public string Direccion { get; set; } = null!;

    public int Capacidad { get; set; }

    public int IdTipoHabitacion { get; set; }

    public int IdEstadoHabitacion { get; set; }

    public virtual ICollection<Animale> Animales { get; set; } = new List<Animale>();

    public virtual ICollection<HistorialMovimiento> HistorialMovimientoIdHabitacionActualNavigations { get; set; } = new List<HistorialMovimiento>();

    public virtual ICollection<HistorialMovimiento> HistorialMovimientoIdHabitacionAnteriorNavigations { get; set; } = new List<HistorialMovimiento>();

    public virtual EstadoHabitacion IdEstadoHabitacionNavigation { get; set; } = null!;

    public virtual TipoHabitacion IdTipoHabitacionNavigation { get; set; } = null!;

    public virtual ICollection<MantenimientoHabitacion> MantenimientoHabitacions { get; set; } = new List<MantenimientoHabitacion>();
}
