export interface RegistarEmpleado {
  idEmpleado: string;
  nombre: string;
  apellido1: string;
  apellido2: string;
  correo: string;
  idPuesto: number;
  contraseña: string;
  idRol: number;
  rolFechaInicio: string;
  rolFechaFin: string;
}

export interface Empleado {
  idEmpleado: string;
  nombre: string;
  apellido1: string;
  apellido2: string;
  puesto: string;
  roles: string
}