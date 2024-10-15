--file to create database structure
----tablas proyectos 
-----------------------------------------------------------
-- Creación de la tabla EstadoSalud
--Parte 3: Creación de tablas
USE ZooMA
GO
CREATE TABLE EstadoSalud (
    IdEstadoSalud INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    estadoSalud VARCHAR(255) NOT NULL
);

USE ZooMA
GO
CREATE TABLE Especies (
    IdEspecie INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreEsp VARCHAR(20) NOT NULL
);

USE ZooMA
GO
CREATE TABLE TipoHabitacion (
    IdTipoHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreTH VARCHAR(20) NOT NULL
);

USE ZooMA
GO
CREATE TABLE ZOO (
    IdZoo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreZoo VARCHAR(20) NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    DescripcionZoo VARCHAR(255) NOT NULL
);

USE ZooMA
GO
CREATE TABLE Habitacion (
    IdHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreHab VARCHAR(20) NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    Capacidad INT NOT NULL,
    IdTipoHabitacion INT NOT NULL,
    CONSTRAINT FK_Habitacion_IdTipoHabitacion FOREIGN KEY (IdTipoHabitacion) REFERENCES TipoHabitacion (IdTipoHabitacion)
);

USE ZooMA
GO
CREATE TABLE Visitantes (
    IdVisitantes INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreVist VARCHAR(20) NOT NULL,
    Apell1Vist VARCHAR(20) NOT NULL,
    Apell2Vist VARCHAR(20) NOT NULL,
	Disponibilidad Varchar (100) NOT NULL,
	Correo VARCHAR (50) NOT NULL,
	TELEFONO INT NOT NULL
);

USE ZooMA
GO
CREATE TABLE MetodoPago (
    IdMetodoPago INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Metodopago VARCHAR(50) NOT NULL
);

USE ZooMA
GO
CREATE TABLE Animales (
    IdAnimales INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreAni VARCHAR(20) NOT NULL,
    EdadAni INT NOT NULL,
    IdDieta INT NOT NULL,
    IdHabitacion INT NOT NULL,
    IdEspecie INT NOT NULL,
    IdEstadoSalud INT NOT NULL,
    IdZoo INT NOT NULL,
    CONSTRAINT FK_Animales_IdEstadoSalud FOREIGN KEY (IdEstadoSalud) REFERENCES EstadoSalud (IdEstadoSalud),
    CONSTRAINT FK_Animales_IdZoo FOREIGN KEY (IdZoo) REFERENCES ZOO (IdZoo),
    CONSTRAINT FK_Animales_IdHabitacion FOREIGN KEY (IdHabitacion) REFERENCES Habitacion (IdHabitacion),
    CONSTRAINT FK_Animales_IdDieta FOREIGN KEY (IdDieta) REFERENCES Dieta (IdDieta),
    CONSTRAINT FK_Animales_IdEspecies FOREIGN KEY (IdEspecie) REFERENCES Especies (IdEspecie)
);

USE ZooMA
GO
CREATE TABLE HistorialMovimientos (
    IdHistorialMovimientos INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    FechaMovimiento DATE NOT NULL,
    IdHabitacionAnterior INT NOT NULL,
    IdHabitacionActual INT NOT NULL,
    Motivo VARCHAR(255) NOT NULL,
    IdAnimales INT NOT NULL,
    CONSTRAINT FK_HistorialMovimientos_IdAnimales FOREIGN KEY (IdAnimales) REFERENCES Animales (IdAnimales)
);

USE ZooMA
GO
CREATE TABLE EstadoHabitacion (
    IdEstadoHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Estado VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(255) NOT NULL,
    Fecha DATE NOT NULL
);

USE ZooMA
GO
CREATE TABLE HabitacionEstadoHabitacion (
    IdHabitacionEstadoHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdHabitacion INT NOT NULL,
    IdEstadoHabitacion INT NOT NULL,
    CONSTRAINT FK_HabitacionEstadoHabitacion_IdHabitacion FOREIGN KEY (IdHabitacion) REFERENCES Habitacion (IdHabitacion),
    CONSTRAINT FK_HabitacionEstadoHabitacion_IdEstadoHabitacion FOREIGN KEY (IdEstadoHabitacion) REFERENCES EstadoHabitacion (IdEstadoHabitacion)
);

USE ZooMA
GO
CREATE TABLE TipoTarea (
    IdTipoTarea INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreTT VARCHAR(20) NOT NULL
);

USE ZooMA
GO
CREATE TABLE Puesto (
    IdPuesto INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(20) NOT NULL,
    Salario FLOAT NOT NULL,
    DescripcionTareas VARCHAR(255) NOT NULL
);

USE ZooMA
GO
CREATE TABLE Empleado (
    IdEmpleado INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(20) NOT NULL,
    Apellido1 VARCHAR(20) NOT NULL,
    Apellido2 VARCHAR(20) NOT NULL,
	Correo VARCHAR (50) NOT NULL,
    IdPuesto INT NOT NULL,
    IdZoo INT NOT NULL,
    CONSTRAINT FK_Empleado_IdZoo FOREIGN KEY (IdZoo) REFERENCES ZOO (IdZoo),
    CONSTRAINT FK_Empleado_IdPuesto FOREIGN KEY (IdPuesto) REFERENCES Puesto (IdPuesto)
);

USE ZooMA
GO
CREATE TABLE Tareas (
    IdTareas INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(20) NOT NULL,
    IdEmpleado INT NOT NULL,
    IdTipoTarea INT NOT NULL,
	CONSTRAINT FK_Tareas_IdEmpleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado),
    CONSTRAINT FK_Tareas_IdTipoTarea FOREIGN KEY (IdTipoTarea) REFERENCES TipoTarea (IdTipoTarea)
);

USE ZooMA
GO
CREATE TABLE EstadoTarea (
    IdEstadoTarea INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(20) NOT NULL
);

USE ZooMA
GO
CREATE TABLE TareasEstadoTareas (
    IdTareas INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdHabitacion INT NOT NULL,
    IdEstadoTarea INT NOT NULL,
	Fecha DATE NOT NULL,
    CONSTRAINT FK_TareasEstadoTareas_IdTareas FOREIGN KEY (IdTareas) REFERENCES Tareas (IdTareas),
    CONSTRAINT FK_TareasEstadoTareas_IdHabitacion FOREIGN KEY (IdHabitacion) REFERENCES Habitacion (IdHabitacion)
);

USE ZooMA
GO
CREATE TABLE MantenimientoHabitacion (
    IdMantenimientoHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Reporte VARCHAR(255) NOT NULL,
    IdTareas INT NOT NULL,
    IdHabitacion INT NOT NULL,
	CONSTRAINT FK_MantenimientoHabitacion_IdTareas FOREIGN KEY (IdTareas) REFERENCES Tareas (IdTareas),
    CONSTRAINT FK_MantenimientoHabitacion_IdHabitacion FOREIGN KEY (IdHabitacion) REFERENCES Habitacion (IdHabitacion)
);

USE ZooMA
GO
CREATE TABLE ControlAnimal (
    IdControl INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Reporte VARCHAR(255) NOT NULL,
    IdTareas INT NOT NULL,
    IdAnimales INT NOT NULL,
	CONSTRAINT FK_ControlAnimal_IdTareas FOREIGN KEY (IdTareas) REFERENCES Tareas (IdTareas),
    CONSTRAINT FK_ControlAnimal_IdAnimales FOREIGN KEY (IdAnimales) REFERENCES Animales (IdAnimales)
);

USE ZooMA
GO
CREATE TABLE Usuario (
    IdUsuario INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Contraseña VARCHAR(20) NOT NULL,
    IdEmpleado INT NOT NULL,
    CONSTRAINT FK_Usuario_IdEmpleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado)
);

USE ZooMA
GO
CREATE TABLE Rol (
    IdRol INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(20) NOT NULL
);

USE ZooMA
GO
CREATE TABLE RolUsario (
    IdRolUsario INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdRol INT NOT NULL,
    IdUsuario INT NOT NULL,
    CONSTRAINT FK_RolUsario_IdUsuario  FOREIGN KEY (IdUsuario ) REFERENCES Usuario (IdUsuario ),
    CONSTRAINT FK_RolUsario_IdRol FOREIGN KEY (IdRol) REFERENCES Rol (IdRol)
);

USE ZooMA
GO
CREATE TABLE VentaEntrada (
    IdVentaEntrada INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Fechaventa DATE NOT NULL,
    Horaventa TIME NOT NULL,
    IdZoo INT NOT NULL,
    IdVisitantes INT NOT NULL,
    IdMetodoPago INT NOT NULL,
    CONSTRAINT FK_VentaEntrada_IdZoo FOREIGN KEY (IdZoo) REFERENCES ZOO (IdZoo),
    CONSTRAINT FK_VentaEntrada_IdMetodoPago FOREIGN KEY (IdMetodoPago) REFERENCES MetodoPago (IdMetodoPago),
    CONSTRAINT FK_VentaEntrada_IdVisitantes FOREIGN KEY (IdVisitantes) REFERENCES Visitantes (IdVisitantes)
);

USE ZooMA
GO
CREATE TABLE TipoEntrada (
    IdTipoEntrada INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreEnt VARCHAR(20) NOT NULL,
    Precio MONEY NOT NULL
);

USE ZooMA
GO
CREATE TABLE Entrada (
    IdEntrada INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Descripcion VARCHAR(255) NOT NULL,
    IdTipoEntrada INT NOT NULL,
    CONSTRAINT FK_Entrada_IdTipoEntrada FOREIGN KEY (IdTipoEntrada) REFERENCES TipoEntrada (IdTipoEntrada) --Hay algo que me está dando conficto ahí y no se que es!!
);

USE ZooMA
GO
CREATE TABLE DetalleVenta (
    IdDetalleVenta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdEntrada INT NOT NULL,
	IdTipoEntrada INT NOT NULL,
    Cantidad INT NOT NULL,
	CONSTRAINT FK_DetalleVenta_IdEntrada FOREIGN KEY (IdEntrada) REFERENCES Entrada (IdEntrada),
    CONSTRAINT FK_DetalleVenta_IdTipoEntrada FOREIGN KEY (IdTipoEntrada) REFERENCES TipoEntrada (IdTipoEntrada)
);


USE ZooMA
GO
CREATE TABLE CalificacionRecorrido (
    IdCalificacionRecorrido INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nota INT NOT NULL,
	SugerenciaMejora VARCHAR (255) NULL
);

USE ZooMA
GO
CREATE TABLE CalificacionServicioAlCliente (
    IdCalificacionServicioAlCliente INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nota INT NOT NULL,
	SugerenciaMejora VARCHAR (255) NULL
);

USE ZooMA
GO
CREATE TABLE CalificacionVisita (
    IdCalificacionVisita INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nota INT NOT NULL,
    SugerenciaMejora VARCHAR(255) NOT NULL,
    Fecha DATE NOT NULL,
    IdVisitantes INT NOT NULL,
	IdCalificacionServicioAlCliente INT NOT NULL,
	IdCalificacionRecorrido INT NOT NULL,
	CONSTRAINT FK_CalificacionVisita_IdCalificacionServicioAlCliente FOREIGN KEY (IdCalificacionServicioAlCliente) REFERENCES CalificacionServicioAlCliente (IdCalificacionServicioAlCliente),
	CONSTRAINT FK_CalificacionVisita_IdCalificacionRecorrido FOREIGN KEY (IdCalificacionRecorrido) REFERENCES CalificacionRecorrido (IdCalificacionRecorrido),
    CONSTRAINT FK_CalificacionVisita_IdVisitantes FOREIGN KEY (IdVisitantes) REFERENCES Visitantes (IdVisitantes)
);

USE ZooMA
GO
CREATE TABLE Dieta (
    IdDieta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreDiet VARCHAR(20) NOT NULL
);

USE ZooMA
GO
CREATE TABLE Alimentos (
    IdAlimentos INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR (20) NOT NULL
);

USE ZooMA
GO
CREATE TABLE DietaAlimentos (
    IdDietaAlimentos INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdDieta INT NOT NULL,
    IdAlimentos  INT NOT NULL,
    CONSTRAINT FK_DietaAlimentos_IdDieta FOREIGN KEY (IdDieta) REFERENCES Dieta (IdDieta),
    CONSTRAINT FK_DietaAlimentos_IdAlimentos FOREIGN KEY (IdAlimentos) REFERENCES Alimentos (IdAlimentos)
);

--Fin tablas
