using System;
using System.Collections.Generic;

namespace Services;

public partial class Habitacion
{
    public int IdHabitacion { get; set; }

    public string NombreHab { get; set; } = null!;

    public string Direccion { get; set; } = null!;

    public bool Capacidad { get; set; }

    public int IdTipoHabitacion { get; set; }

    public virtual ICollection<Animale> Animales { get; set; } = new List<Animale>();

    public virtual ICollection<HabitacionEstadoHabitacion> HabitacionEstadoHabitacions { get; set; } = new List<HabitacionEstadoHabitacion>();

    public virtual TipoHabitacion IdTipoHabitacionNavigation { get; set; } = null!;

    public virtual ICollection<MantenimientoHabitacion> MantenimientoHabitacions { get; set; } = new List<MantenimientoHabitacion>();
}
