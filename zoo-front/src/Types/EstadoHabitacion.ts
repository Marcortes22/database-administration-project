export interface EstadoHabitacion {
    idEstadoHabitacion: number;
    estado: string;
  }
  
  export interface EstadoHabitacionResponse {
    success: boolean;
    message: string;
    data: EstadoHabitacion[];
  }
  