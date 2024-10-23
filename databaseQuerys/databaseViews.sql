--VIEWS

Use ZooMA
IF OBJECT_ID('Vw_Especies', 'V') IS NOT NULL
   DROP VIEW Vw_Especies;
GO
Create View Vw_Especies
as
Select
IdEspecie,
NombreEsp
from Especie
GO

Use ZooMA
IF OBJECT_ID('Vw_EstadoSalud', 'V') IS NOT NULL
   DROP VIEW Vw_EstadoSalud;
GO
Create View Vw_EstadoSalud
as
Select
IdEstadoSalud,
estadoSalud
from EstadoSalud 
GO

Use ZooMA
IF OBJECT_ID('Vw_Dieta', 'V') IS NOT NULL
   DROP VIEW Vw_Dieta;
GO
Create View Vw_Dieta
as
Select
IdDieta,
NombreDiet
from Dieta  
GO

USE ZooMA
GO
IF OBJECT_ID('Vw_TipoHabitacion', 'V') IS NOT NULL
   DROP VIEW Vw_TipoHabitacion;
GO
Create View Vw_TipoHabitacion
as
Select
IdTipoHabitacion,
NombreTH
from TipoHabitacion  
GO




Use ZooMA
IF OBJECT_ID('Vw_Habitacion', 'V') IS NOT NULL
   DROP VIEW Vw_Habitacion;
GO
Create View Vw_Habitacion
as
Select
IdHabitacion,
NombreHab,
Direccion,
Capacidad,
IdTipoHabitacion
from Habitacion
GO

Use ZooMA
IF OBJECT_ID('Vw_Visitantes', 'V') IS NOT NULL
   DROP VIEW Vw_Visitantes;
GO
Create View Vw_Visitantes 
as
Select
IdVisitantes,
nombreVist,
apell1Vist,
apell2Vist
from Visitantes 
GO

Use ZooMA
IF OBJECT_ID('Vw_MetodoPago', 'V') IS NOT NULL
   DROP VIEW Vw_MetodoPago;
GO
Create View Vw_MetodoPago 
as
Select
IdMetodoPago,
metodopago
from MetodoPago 
GO

Use ZooMA
IF OBJECT_ID('Vw_TipoEntrada', 'V') IS NOT NULL
   DROP VIEW Vw_TipoEntrada;
GO
Create View Vw_TipoEntrada 
as
Select
IdTipoEntrada,
nombreEnt,
Precio
from TipoEntrada  
GO

Use ZooMA
IF OBJECT_ID('Vw_Animales', 'V') IS NOT NULL
   DROP VIEW Vw_Animales;
GO
Create View Vw_Animales  
as
Select
IdAnimales,
nombreAni,
EdadAni,
IdDieta,
IdHabitacion,
IdEspecie,
IdEstadoSalud,
IdZoo
from Animales   
GO

Use ZooMA
IF OBJECT_ID('Vw_Alimentos', 'V') IS NOT NULL
   DROP VIEW Vw_Alimentos;
GO
Create View Vw_Alimentos
as
Select
IdAlimentos,
Nombre
from Alimentos 
GO

Use ZooMA
IF OBJECT_ID('Vw_DietaAlimentos', 'V') IS NOT NULL
   DROP VIEW Vw_DietaAlimentos;
GO
Create View Vw_DietaAlimentos
as
Select
IdDietaAlimentos,
IdDieta,
IdAlimentos
from DietaAlimentos 
GO

Use ZooMA
IF OBJECT_ID('Vw_HistorialMovimientos', 'V') IS NOT NULL
   DROP VIEW Vw_HistorialMovimientos;
GO
Create View Vw_HistorialMovimientos
as
Select
IdHistorialMovimientos,
FechaMovimiento,
IdHabitacionAnterior,
IdHabitacionActual,
Motivo,
IdAnimales
from HistorialMovimientos 
GO

Use ZooMA
IF OBJECT_ID('Vw_EstadoHabitacion', 'V') IS NOT NULL
   DROP VIEW Vw_EstadoHabitacion;
GO
Create View Vw_EstadoHabitacion
as
Select
IdEstadoHabitacion,
estado,
descripcion,
Fecha
from EstadoHabitacion
GO

Use ZooMA
IF OBJECT_ID('Vw_MantenimientoHabitacion', 'V') IS NOT NULL
   DROP VIEW Vw_MantenimientoHabitacion;
GO
Create View Vw_MantenimientoHabitacion 
as
Select
IdMantenimientoHabitacion,
reporte,
IdTareas,
IdHabitacion
from MantenimientoHabitacion 
GO

Use ZooMA
IF OBJECT_ID('Vw_ControlAnimal', 'V') IS NOT NULL
   DROP VIEW Vw_ControlAnimal;
GO
Create View Vw_ControlAnimal 
as
Select
IdControl,
reporte,
IdTareas,
IdAnimales
from ControlAnimal
GO

Use ZooMA
IF OBJECT_ID('Vw_EstadoTarea', 'V') IS NOT NULL
   DROP VIEW Vw_EstadoTarea;
GO
Create View Vw_EstadoTarea 
as
Select
IdEstadoTarea,
Nombre
from EstadoTarea
GO

Use ZooMA
IF OBJECT_ID('Vw_Puesto', 'V') IS NOT NULL
   DROP VIEW Vw_Puesto;
GO
Create View Vw_Puesto
as
Select
IdPuesto,
Nombre,
Salario
from Puesto
GO

Use ZooMA
IF OBJECT_ID('Vw_Empleado', 'V') IS NOT NULL
   DROP VIEW Vw_Empleado;
GO
Create View Vw_Empleado
as
SELECT 
	E.IdEmpleado,
    E.Nombre, 
	E.Apellido1, 
	E.Apellido2, 
    P.Nombre AS 'Puesto', 
    STRING_AGG(R.Nombre, ', ') AS Roles 
FROM 
    Empleado E 
INNER JOIN
	Puesto P ON P.IdPuesto = E.IdPuesto
INNER JOIN 
    Usuario U ON E.IdEmpleado = U.IdUsuario 
INNER JOIN 
    RolUsuario RS ON U.IdUsuario = RS.IdUsuario 
INNER JOIN 
    Rol R ON R.IdRol = RS.IdRol 
GROUP BY 
   E.IdEmpleado, E.Nombre, E.Apellido1,  E.Apellido2, E.Nombre,  P.Nombre
GO

Use ZooMA
IF OBJECT_ID('Vw_Tareas', 'V') IS NOT NULL
   DROP VIEW Vw_Tareas;
GO
Create View Vw_Tareas 
as
Select
IdTareas,
Nombre,
IdEmpleado
from Tareas 
GO

Use ZooMA
IF OBJECT_ID('Vw_VentaEntrada', 'V') IS NOT NULL
   DROP VIEW Vw_VentaEntrada;
GO
Create View Vw_VentaEntrada 
as
Select
IdVentaEntrada,
fechaventa,
IdVisitantes,
IdMetodoPago
from VentaEntrada 
GO

Use ZooMA
IF OBJECT_ID('Vw_DetalleVenta', 'V') IS NOT NULL
   DROP VIEW Vw_DetalleVenta;
GO
Create View Vw_DetalleVenta 
as
Select
IdDetalleVenta,
IdVentaEntrada,
Cantidad
from DetalleVenta 
GO

Use ZooMA
IF OBJECT_ID('Vw_CalificacionVisita', 'V') IS NOT NULL
   DROP VIEW Vw_CalificacionVisita;
GO
Create View Vw_CalificacionVisita 
as
Select
IdCalificacionVisita,
Nota,
fecha,
IdVisitantes
from CalificacionVisita
GO

Use ZooMA
IF OBJECT_ID('Vw_Roles', 'V') IS NOT NULL
   DROP VIEW Vw_Roles;
GO
Create View Vw_Roles 
as
Select
IdRol,
Nombre
from Rol
GO

Use ZooMA
IF OBJECT_ID('Vw_Empleado_Login', 'V') IS NOT NULL
   DROP VIEW Vw_Empleado_Login;
GO
Create View Vw_Empleado_Login 
as
   SELECT IdEmpleado, Nombre, Apellido1, Apellido2, Correo FROM Empleado 
GO

Use ZooMA
IF OBJECT_ID('Vw_Empleado_Roles_Activos', 'V') IS NOT NULL
   DROP VIEW Vw_Empleado_Roles_Activos;
GO
Create View Vw_Empleado_Roles_Activos 
as
   SELECT  US.IdUsuario, R.nombre FROM RolUsuario US INNER JOIN Rol R ON US.IdRol = R.IdRol WHERE US.FechaFin > GETDATE() OR US.FechaFin IS NULL
GO




--FIN VIEWS--
