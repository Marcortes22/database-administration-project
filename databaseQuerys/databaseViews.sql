--VIEWS
Use ZooMA
GO
Create View Vw_Especies
as
Select
IdEspecie  as 'Codigo de Especie',
NombreEsp as 'Nombre del Especie'
from Especies
GO

Use ZooMA
GO
Create View Vw_EstadoSalud
as
Select
IdEstadoSalud  as 'Codigo de EstadoSalud',
estadoSalud  as 'Estado'
from EstadoSalud 
GO

Use ZooMA
GO
Create View Vw_Dieta
as
Select
IdDieta   as 'Codigo de Dieta',
NombreDiet  as 'Nombre de Dieta',
DescripcionDiet as 'Descripcon de Dieta'
from Dieta  
GO

USE ZooMA
GO
-- Verifica si la vista existe y la elimina
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


select * from Vw_TipoHabitacion

Use ZooMA
GO
Create View Vw_Habitacion
as
Select
IdHabitacion as 'Codigo de Habitacion',
NombreHab as 'Nombre de la Habitacion',
Direccion,
Capacidad,
IdTipoHabitacion as 'Codigo del tipo de habitacion'
from Habitacion
GO

Use ZooMA
GO
Create View Vw_Visitantes 
as
Select
IdVisitantes  as 'Codigo de Visitante',
nombreVist  as 'Nombre del visitante',
apell1Vist as 'Primer Apellido',
apell2Vist as 'Segundo Apellido'
from Visitantes 
GO

Use ZooMA
GO
Create View Vw_MetodoPago 
as
Select
IdMetodoPago as 'Codigo de metodo de pago',
metodopago  as 'Metodo de pago'
from MetodoPago 
GO

Use ZooMA
GO
Create View Vw_TipoEntrada 
as
Select
IdTipoEntrada  as 'Codigo de Visitante',
nombreEnt  as 'Nombre del tipo de entra',
decripcionEnt as 'Descripcion del Tipo de Entrada',
Precio
from TipoEntrada  
GO

Use ZooMA
GO
Create View Vw_Animales  
as
Select
IdAnimales  as 'Codigo del animal',
nombreAni  as 'Nombre del animal',
EdadAni as 'Edad del animal',
IdDieta as 'Codigo de la Dieta',
IdHabitacion as 'Codigo de la Habitacion',
IdEspecies as 'Codigo de la Especie',
IdEstadoSalud as 'Codigo del estado de salud',
IdZoo as 'Codigo del Zoologico'
from Animales   
GO

Use ZooMA
GO
Create View Vw_Alimentos
as
Select
IdAlimentos as 'Codigo del alimento',
NombreAli  as 'Nombre del alimento'
from Alimentos 
GO

Use ZooMA
GO
Create View Vw_DietaAlimentos
as
Select
IdDietaAlimentos as 'Codigo de la Dieta de los alimentos',
IdDieta as 'Codigo de la Dieta',
IdAlimentos as 'Codigo de los alimentos'
from DietaAlimentos 
GO

Use ZooMA
GO
Create View Vw_HistorialMovimientos
as
Select
IdHistorialMovimientos as 'Codigo de los movimientos',
FechaMovimiento as 'Fecha del movimiento',
IdHabitacionAnterior as 'Codigo de la habitacion anterior',
IdHabitacionActual as 'Codigo de la habitacion actual',
Motivo as 'Motivo del movimiento',
IdAnimales as 'Codigo del animal'
from HistorialMovimientos 
GO

Use ZooMA
GO
Create View Vw_EstadoHabitacion
as
Select
IdEstadoHabitacion as 'Codigo del estado Hab',
estado,
descripcion,
Fecha
from EstadoHabitacion
GO

Use ZooMA
GO
Create View Vw_MantenimientoHabitacion 
as
Select
IdMantenimientoHabitacion  as 'Codigo de Mante Hab',
reporte,
IdTareas as 'Codigo de la Tarea',
IdHabitacion as 'Codigo de la habitacion actual'
from MantenimientoHabitacion 
GO

Use ZooMA
GO
Create View Vw_ControlAnimal 
as
Select
IdControl as 'Codigo del Control Animal',
reporte,
IdTareas as 'Codigo de la Tarea',
IdAnimales as 'Codigo del Animal'
from ControlAnimal
GO

Use ZooMA
GO
Create View Vw_EstadoTarea 
as
Select
IdEstadoTarea as 'Codigo del Estado',
Nombre as 'Nombre'
from EstadoTarea
GO

Use ZooMA
GO
Create View Vw_Puesto
as
Select
IdPuesto as 'Codigo del Estado',
Nombre as 'Nombre del Puesto',
Salario,
DescripcionTareas as 'Descripcion Tareas'
from Puesto
GO

Use ZooMA
GO
Create View Vw_Empleado
as
Select
IdEmpleado as 'Codigo del Empleado',
Nombre as 'Nombre del Empleado',
Apellido1 as 'Primer Apellido',
Apellido2 as 'Segundo Apellido',
IdPuesto as 'Codigo del puesto',
IdZoo as 'Codigo del Zoologico'
from Empleado
GO

Use ZooMA
GO
Create View Vw_Tareas 
as
Select
IdTareas as 'Codigo de las Tareas',
Nombre as 'Nombre de las Tareas',
Descripcion,
IdEmpleado as 'Codigo del Empleado'
from Tareas 
GO

Use ZooMA
GO
Create View Vw_VentaEntrada 
as
Select
IdVentaEntrada as 'Codigo de Venta Entrada',
fechaventa as 'Fecha de la Venta',
horaventa as 'Hora de la venta',
IdZoo as 'Codigo del Zoologico',
IdVisitantes as 'Codigo del Visitante',
IdMetodoPago as 'Codigo del Metodo de Pago'
from VentaEntrada 
GO

Use ZooMA
GO
Create View Vw_DetalleVenta 
as
Select
IdDetalleVenta as 'Codigo del Detalle de Venta',
IdVentaEntrada as 'Codigo de la entrada vendida',
IdTipoEntrada as 'Codigo del tipo de entrada vendida',
Cantidad
from DetalleVenta 
GO

Use ZooMA
GO
Create View Vw_CalificacionVisita 
as
Select
IdCalificacionVisita as 'Codigo de la calificacion',
Nota,
SugerenciaMejora as 'Sugerencia de Mejora',
fecha,
IdVisitantes as 'Codigo del Visitante'
from CalificacionVisita
GO

--FIN VIEWS--
