interface ControlAnimal {
    idControl: number;
    nombre: string;
    idAnimales: number;
  }
  
  export interface Tarea {
    idTareas: number;
    idEmpleado: number;
    idTipoTareaNavigation: { nombreTt: string };
    idEstadoTareaNavigation: { nombre: string };
    controlAnimals: ControlAnimal[];
  }