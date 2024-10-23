-- Parte 1: Creación de la Base de Datos
USE master
IF DB_ID('ZooMA') IS NOT NULL
BEGIN
    DROP DATABASE ZooMA;
END;
GO
CREATE DATABASE ZooMA
ON PRIMARY (
    NAME = 'ZooMA_Data',
    FILENAME = 'C:\SQLData\ZooMA_Data.mdf',
    SIZE = 1300MB,
    MAXSIZE = 6GB,
    FILEGROWTH = 390MB
) LOG ON (
    NAME = 'ZooMA_Log',
    FILENAME = 'C:\SQLData\ZooMA_Log.ldf',
    SIZE = 500MB,
    MAXSIZE = 2GB,
    FILEGROWTH = 100MB 
)
GO
-- FIN Creación de la Base de Datos

-- Parte 2: Crear FileGroup
USE master
GO
ALTER DATABASE ZooMA
ADD FILEGROUP Animal
GO

ALTER DATABASE ZooMA
ADD FILEGROUP Habitacion
GO

ALTER DATABASE ZooMA
ADD FILEGROUP Zoo
GO

ALTER DATABASE ZooMA
ADD FILEGROUP Empleado
GO

ALTER DATABASE ZooMA
ADD FILEGROUP Auditorias
GO

-- Añadir archivos a los filegroups
USE master
GO
ALTER DATABASE ZooMA
ADD FILE (
    NAME = 'Animal_Data',
    FILENAME = 'C:\SQLData\Animal_Data.ndf',
    SIZE = 26MB,
    MAXSIZE = 104MB,
    FILEGROWTH = 8MB
) TO FILEGROUP Animal
GO

ALTER DATABASE ZooMA
ADD FILE (
    NAME = 'Habitacion_Data',
    FILENAME = 'C:\SQLData\Habitacion_Data.ndf',
    SIZE = 26MB,
    MAXSIZE = 104MB,
    FILEGROWTH = 8MB
) TO FILEGROUP Habitacion
GO

ALTER DATABASE ZooMA
ADD FILE (
    NAME = 'Zoo_Data',
    FILENAME = 'C:\SQLData\Zoo_Data.ndf',
    SIZE = 26MB,
    MAXSIZE = 104MB,
    FILEGROWTH = 8MB
) TO FILEGROUP Zoo
GO

ALTER DATABASE ZooMA
ADD FILE (
    NAME = 'Empleado_Data',
    FILENAME = 'C:\SQLData\Empleado_Data.ndf',
    SIZE = 26MB,
    MAXSIZE = 104MB,
    FILEGROWTH = 8MB
) TO FILEGROUP Empleado
GO

ALTER DATABASE ZooMA
ADD FILE (
    NAME = 'Auditorias_Data',
    FILENAME = 'C:\SQLData\Auditorias_Data.ndf',
    SIZE = 26MB,
    MAXSIZE = 104MB,
    FILEGROWTH = 8MB
) TO FILEGROUP Auditorias
GO
-- FIN FileGroup

--Parte 3: Creación de tablas
USE ZooMA
GO
CREATE TABLE EstadoSalud (
    IdEstadoSalud INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    EstadoSalud VARCHAR(255) NOT NULL
);

USE ZooMA
GO
CREATE TABLE Especie (
    IdEspecie INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreEsp VARCHAR(20) NOT NULL
);

USE ZooMA
GO
CREATE TABLE TipoHabitacion (
    IdTipoHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreTH VARCHAR(75) NOT NULL
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
    IdVisitantes INT NOT NULL PRIMARY KEY,
    NombreVist VARCHAR(20) NOT NULL,
    Apell1Vist VARCHAR(20) NOT NULL,
    Apell2Vist VARCHAR(20) NOT NULL,
	CorreoElectronico VARCHAR (50) NOT NULL,
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
CREATE TABLE Dieta (
    IdDieta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreDiet VARCHAR(20) NOT NULL
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
    IdZoo INT NOT NULL DEFAULT 1,
    CONSTRAINT FK_Animales_IdEstadoSalud FOREIGN KEY (IdEstadoSalud) REFERENCES EstadoSalud (IdEstadoSalud),
    CONSTRAINT FK_Animales_IdZoo FOREIGN KEY (IdZoo) REFERENCES ZOO (IdZoo),
    CONSTRAINT FK_Animales_IdHabitacion FOREIGN KEY (IdHabitacion) REFERENCES Habitacion (IdHabitacion),
    CONSTRAINT FK_Animales_IdDieta FOREIGN KEY (IdDieta) REFERENCES Dieta (IdDieta),
    CONSTRAINT FK_Animales_IdEspecies FOREIGN KEY (IdEspecie) REFERENCES Especie (IdEspecie)
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
);

USE ZooMA
GO
CREATE TABLE Empleado (
    IdEmpleado INT NOT NULL PRIMARY KEY,
    Nombre VARCHAR(20) NOT NULL,
    Apellido1 VARCHAR(20) NOT NULL,
    Apellido2 VARCHAR(20) NOT NULL,
	Correo VARCHAR (50) NOT NULL,
    IdPuesto INT NOT NULL,
    IdZoo INT NOT NULL DEFAULT 1, 
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
    Nombre VARCHAR(20) NOT NULL,
);

USE ZooMA
GO
CREATE TABLE TareasEstadoTareas (
    IdTareas INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdEstadoTarea INT NOT NULL,
	Fecha DATE NOT NULL,
    CONSTRAINT FK_TareasEstadoTareas_IdTareas FOREIGN KEY (IdTareas) REFERENCES Tareas (IdTareas),
    CONSTRAINT FK_TareasEstadoTareas_IdEstadoTarea FOREIGN KEY (IdEstadoTarea) REFERENCES EstadoTarea (IdEstadoTarea)
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
    IdUsuario INT NOT NULL PRIMARY KEY,
    Contraseña VARCHAR(20) NOT NULL,
    Estado BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_Usuario_IdEmpleado FOREIGN KEY (IdUsuario) REFERENCES Empleado (IdEmpleado)
);

USE ZooMA
GO
CREATE TABLE Rol (
    IdRol INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(20) NOT NULL
);

USE ZooMA
GO
CREATE TABLE RolUsuario (
    IdRolUsario INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdRol INT NOT NULL,
    IdUsuario INT NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NULL,
    CONSTRAINT FK_RolUsario_IdUsuario  FOREIGN KEY (IdUsuario ) REFERENCES Usuario (IdUsuario ),
    CONSTRAINT FK_RolUsario_IdRol FOREIGN KEY (IdRol) REFERENCES Rol (IdRol)
);

USE ZooMA
GO
CREATE TABLE VentaEntrada (
    IdVentaEntrada INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Fechaventa DATETIME NOT NULL,
    IdVisitantes INT NOT NULL,
    IdMetodoPago INT NOT NULL,
    IdEmpleado INT NOT NULL,
    CONSTRAINT FK_VentaEntrada_IdEmpleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado),
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
    fechaVencimiento DATE NOT NULL,
    descuento INT NOT NULL,
    IdTipoEntrada INT NOT NULL,
    CONSTRAINT FK_Entrada_IdTipoEntrada FOREIGN KEY (IdTipoEntrada) REFERENCES TipoEntrada (IdTipoEntrada) 
);

USE ZooMA
GO
CREATE TABLE DetalleVenta (
    IdDetalleVenta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdEntrada INT NOT NULL,
    IdVentaEntrada INT NOT NULL,
    Cantidad INT NOT NULL,
    Precio MONEY NOT NULL,
    CONSTRAINT FK_DetalleVenta_IdVentaEntrada FOREIGN KEY (IdVentaEntrada) REFERENCES VentaEntrada (IdVentaEntrada),
	CONSTRAINT FK_DetalleVenta_IdEntrada FOREIGN KEY (IdEntrada) REFERENCES Entrada (IdEntrada),
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

--FIN Creación de tablas



--Parte 4: Tablas de Auditorias
USE ZooMA
GO
CREATE TABLE Audit_EstadoSalud (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdEstadoSalud INT,
    EstadoSalud VARCHAR(255),
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_Especie (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdEspecie INT,
    NombreEsp VARCHAR(20),
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_Dieta (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdDieta INT,
    NombreDiet VARCHAR(20),
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_TipoHabitacion (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdTipoHabitacion INT,
    NombreTH VARCHAR(75),
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_Visitantes (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdVisitantes INT,
    NombreVist VARCHAR(20),
    Apell1Vist VARCHAR(20),
	Apell2Vist VARCHAR(20),
	CorreoElectronico VARCHAR (50),
	Telefono INT,
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_TipoEntrada (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdTipoEntrada INT,
    NombreEnt VARCHAR(20),
    Precio MONEY,
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_EstadoHabitacion (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdEstadoHabitacion INT,
    Estado VARCHAR(255),
    Descripcion VARCHAR(255),
    Fecha DATE,
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_Empleado (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdEmpleado INT,
    Nombre VARCHAR(20),
    Apellido1 VARCHAR(20),
    Apellido2 VARCHAR(20),
	Correo VARCHAR (50),
    IdPuesto INT,
    IdZoo INT,
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_Puesto (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdPuesto INT,
    Nombre VARCHAR(20),
    Salario FLOAT,
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_Tareas (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdTareas INT,
    Nombre VARCHAR(20),
    IdTipoTarea INT,
    IdEmpleado INT,
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_EstadoTarea (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20), 
    Operacion VARCHAR(10),
    IdEstadoTarea INT,
    Nombre VARCHAR(20),
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_VentaEntrada (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdVentaEntrada INT,
    Fechaventa DATE,
    Horaventa TIME,
    IdVisitante INT,
    IdMetodoPago INT,
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_MetodoPago (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdMetodoPago INT,
    MetodoPago VARCHAR(255),
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_CalificacionVisita (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdCalificacionVisita INT,
    Nota FLOAT,
    SugerenciaMejora VARCHAR(255),
    Fecha DATE,
    IdVisitantes INT,
	IdCalificacionRecorrido INT,
	IdRecorrido INT,
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_Rol (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdRol INT,
    Nombre VARCHAR(20),
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_Usuario (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdUsuario INT,
    Contraseña VARCHAR(20),
    Estado BIT,
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_Habitacion (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdHabitacion INT,
    NombreHab VARCHAR(20),
    Direccion VARCHAR(100),
    Capacidad INT,
    IdTipoHabitacion INT,
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_ZOO (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdZoo INT,
    NombreZoo VARCHAR(20),
    Direccion VARCHAR(100),
    DescripcionZoo VARCHAR(255),
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_Animales (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdAnimales INT,
    NombreAni VARCHAR(20),
    EdadAni INT,
    IdDieta INT,
    IdHabitacion INT,
    IdEspecie INT,
    IdEstadoSalud INT,
    IdZoo INT,
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);


USE ZooMA
GO
CREATE TABLE Audit_Alimentos (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdAlimentos INT,
    Nombre VARCHAR(20),
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_CalificacionServicioAlCliente (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdCalificacionServicioAlCliente INT,
    Nota VARCHAR(20),
	SugerenciaMejora VARCHAR (255),
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_CalificacionRecorrido (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdCalificacionRecorrido INT,
    Nota VARCHAR(20),
	SugerenciaMejora VARCHAR (255),
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);
--FIN Tablas Auditorias