using System;
using System.Collections.Generic;

namespace Entities;

public partial class Animale
{
    public int IdAnimales { get; set; }

    public string NombreAni { get; set; } = null!;

    public int EdadAni { get; set; }

    public int IdDieta { get; set; }

    public int IdHabitacion { get; set; }

    public int IdEspecie { get; set; }

    public int IdEstadoSalud { get; set; }

    public int IdZoo { get; set; }

    public virtual ICollection<ControlAnimal> ControlAnimals { get; set; } = new List<ControlAnimal>();

    public virtual ICollection<HistorialMovimiento> HistorialMovimientos { get; set; } = new List<HistorialMovimiento>();

    public virtual Dietum IdDietaNavigation { get; set; } = null!;

    public virtual Especy IdEspecieNavigation { get; set; } = null!;

    public virtual EstadoSalud IdEstadoSaludNavigation { get; set; } = null!;

    public virtual Habitacion IdHabitacionNavigation { get; set; } = null!;

    public virtual Zoo IdZooNavigation { get; set; } = null!;
}
