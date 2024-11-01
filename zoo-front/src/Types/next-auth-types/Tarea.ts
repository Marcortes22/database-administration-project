interface ControlAnimal {
  idControl: number;
  nombre: string;
  idAnimales: number;
}

interface MantenimientoHabitacion {
  idMantenimientoHabitacion: number;
  nombre: string;
  idHabitacion: number;
}

export interface Tarea {
  idTareas: number;
  idTipoTareaNavigation: { nombreTt: string };
  idEstadoTareaNavigation: { nombre: string };
  controlAnimals: ControlAnimal[];
  mantenimientoHabitacions: MantenimientoHabitacion[];
}
