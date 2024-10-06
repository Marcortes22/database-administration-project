--Creación de la Base de Datos
USE master
GO
CREATE DATABASE ZooMA
ON PRIMARY(
Name='ZooMA_Data',
FILENAME='C:\SQLData\ZooMA_Data.mdf',
SIZE= 1300MB,
MaxSize=6gb,
FileGrowth= 390mb
) LOG ON(
Name='ZooMA_Log',
FILENAME='C:\SQLData\ZooMA_Log.ldf',
SIZE= 500MB,
MAXSIZE=2GB,
FILEGROWTH= 100MB 
)
GO
--FIN Creación de la Base de Datos

--Crear FileGroup
USE master
go
alter database ZooMA
add filegroup Animal
go

USE master
go
alter database ZooMA
add filegroup Habitacion
go

USE master
go
alter database ZooMA
add filegroup Zoo
go

USE master
go
alter database ZooMA
add filegroup Empleado
go

USE master
go
alter database ZooMA
add filegroup Auditorias
go


use master
go
alter database ZooMA
add file 
(
Name = 'Animal_Data',
filename='C:\SQLData\Animal_Data.ndf',
Size = 26MB,
MaxSize= 104MB,
Filegrowth= 8MB
)to filegroup Animal
go

use master
go
alter database ZooMA
add file 
(
Name = 'Habitacion_Data',
filename='C:\SQLData\Habitacion_Data.ndf',
Size = 26MB,
MaxSize= 104MB,
Filegrowth= 8MB
)to filegroup Habitacion
go

use master
go
alter database ZooMA
add file 
(
Name = 'Zoo_Data',
filename='C:\SQLData\Zoo_Data.ndf',
Size = 26MB,
MaxSize= 104MB,
Filegrowth= 8MB
)to filegroup Zoo
go

use master
go
alter database ZooMA
add file 
(
Name = 'Empleado_Data',
filename='C:\SQLData\Empleado_Data.ndf',
Size = 26MB,
MaxSize= 104MB,
Filegrowth= 8MB
)to filegroup Empleado
go


use master
go
alter database ZooMA
add file 
(
Name = 'Auditorias_Data',
filename='C:\SQLData\Auditorias_Data.ndf',
Size = 26MB,
MaxSize= 104MB,
Filegrowth= 8MB
)to filegroup Auditorias
go
--FIN FileGroup


-- Creación de la tabla EstadoSalud
CREATE TABLE EstadoSalud (
    IdEstadoSalud INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    estadoSalud VARCHAR(255) NOT NULL
);

-- Creación de la tabla Especies
CREATE TABLE Especies (
    IdEspecie INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreEsp VARCHAR(255) NOT NULL
);

-- Creación de la tabla Dieta
CREATE TABLE Dieta (
    IdDieta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreDiet VARCHAR(255) NOT NULL,
    DescripcionDiet VARCHAR(255) NOT NULL
);

-- Creación de la tabla TipoHabitacion
CREATE TABLE TipoHabitacion (
    IdTipoHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreTH VARCHAR(255) NOT NULL
);

-- Creación de la tabla ZOO
CREATE TABLE ZOO (
    IdZoo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreZoo VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    DescripcionZoo VARCHAR(255) NOT NULL,
    Disponibilidad BIT NOT NULL
);

-- Creación de la tabla Habitacion
CREATE TABLE Habitacion (
    IdHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreHab VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Capacidad BIT NOT NULL,
    IdTipoHabitacion INT NOT NULL,
    CONSTRAINT FK_Habitacion_IdTipoHabitacion FOREIGN KEY (IdTipoHabitacion) REFERENCES TipoHabitacion (IdTipoHabitacion)
);

-- Creación de la tabla Visitantes
CREATE TABLE Visitantes (
    IdVisitantes INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombreVist VARCHAR(255) NOT NULL,
    apell1Vist VARCHAR(255) NOT NULL,
    apell2Vist VARCHAR(255) NOT NULL,
    disponibilidad BIT NOT NULL
);

-- Creación de la tabla MetodoPago
CREATE TABLE MetodoPago (
    IdMetodoPago INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    metodopago VARCHAR(255) NOT NULL
);

-- Creación de la tabla TipoEntrada
CREATE TABLE TipoEntrada (
    IdTipoEntrada INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombreEnt VARCHAR(255) NOT NULL,
    decripcionEnt VARCHAR(255) NOT NULL,
    Precio MONEY NOT NULL
);

-- Creación de la tabla Animales
CREATE TABLE Animales (
    IdAnimales INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreAni VARCHAR(255) NOT NULL,
    EdadAni INT NOT NULL,
    IdDieta INT NOT NULL,
    IdHabitacion INT NOT NULL,
    IdEspecies INT NOT NULL,
    IdEstadoSalud INT NOT NULL,
    IdZoo INT NOT NULL,
    CONSTRAINT FK_Animales_IdEstadoSalud FOREIGN KEY (IdEstadoSalud) REFERENCES EstadoSalud (IdEstadoSalud),
    CONSTRAINT FK_Animales_IdZoo FOREIGN KEY (IdZoo) REFERENCES ZOO (IdZoo),
    CONSTRAINT FK_Animales_IdHabitacion FOREIGN KEY (IdHabitacion) REFERENCES Habitacion (IdHabitacion),
    CONSTRAINT FK_Animales_IdDieta FOREIGN KEY (IdDieta) REFERENCES Dieta (IdDieta),
    CONSTRAINT FK_Animales_IdEspecies FOREIGN KEY (IdEspecies) REFERENCES Especies (IdEspecie)
);

-- Creación de la tabla Alimentos
CREATE TABLE Alimentos (
    IdAlimentos INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreAli VARCHAR(255) NOT NULL
);
-- Creación de la tabla DietaAlimentos
CREATE TABLE DietaAlimentos (
    IdDietaAlimentos INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdDieta INT NOT NULL,
    IdAlimentos INT NOT NULL,
    CONSTRAINT FK_DietaAlimentos_IdDieta FOREIGN KEY (IdDieta) REFERENCES Dieta (IdDieta),
    CONSTRAINT FK_DietaAlimentos_IdAlimentos FOREIGN KEY (IdAlimentos) REFERENCES Alimentos (IdAlimentos)
);

-- Creación de la tabla HistorialMovimientos
CREATE TABLE HistorialMovimientos (
    IdHistorialMovimientos INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    FechaMovimiento DATE NOT NULL,
    IdHabitacionAnterior INT NOT NULL,
    IdHabitacionActual INT NOT NULL,
    Motivo VARCHAR(255) NOT NULL,
    IdAnimales INT NOT NULL,
    CONSTRAINT FK_HistorialMovimientos_IdAnimales FOREIGN KEY (IdAnimales) REFERENCES Animales (IdAnimales)
);

-- Creación de la tabla EstadoHabitacion
CREATE TABLE EstadoHabitacion (
    IdEstadoHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    estado VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    Fecha DATE NOT NULL
);

-- Creación de la tabla HabitacionEstadoHabitacion
CREATE TABLE HabitacionEstadoHabitacion (
    IdHabitacionEstadoHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdHabitacion INT NOT NULL,
    IdEstadoHabitacion INT NOT NULL,
    CONSTRAINT FK_HabitacionEstadoHabitacion_IdHabitacion FOREIGN KEY (IdHabitacion) REFERENCES Habitacion (IdHabitacion),
    CONSTRAINT FK_HabitacionEstadoHabitacion_IdEstadoHabitacion FOREIGN KEY (IdEstadoHabitacion) REFERENCES EstadoHabitación (IdEstadoHabitación)
);

-- Creación de la tabla MantenimientoHabitacion
CREATE TABLE MantenimientoHabitacion (
    IdMantenimientoHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    reporte VARCHAR(255) NOT NULL,
    IdTareas INT NOT NULL,
    IdHabitacion INT NOT NULL,
    CONSTRAINT FK_MantenimientoHabitacion_IdHabitacion FOREIGN KEY (IdHabitacion) REFERENCES Habitacion (IdHabitacion)
);

-- Creación de la tabla ControlAnimal
CREATE TABLE ControlAnimal (
    IdControl INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Reporte VARCHAR(255) NOT NULL,
    IdTareas INT NOT NULL,
    IdAnimales INT NOT NULL,
    CONSTRAINT FK_ControlAnimal_IdAnimales FOREIGN KEY (IdAnimales) REFERENCES Animales (IdAnimales)
);


-- Creación de la tabla EstadoTarea
CREATE TABLE EstadoTarea (
    IdEstadoTarea INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL
);


-- Creación de la tabla Puesto
CREATE TABLE Puesto (
    IdPuesto INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Salario FLOAT NOT NULL,
    DescripcionTareas VARCHAR(255) NOT NULL
);

-- Creación de la tabla Empleado
CREATE TABLE Empleado (
    IdEmpleado INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Apellido1 VARCHAR(255) NOT NULL,
    Apellido2 VARCHAR(255) NOT NULL,
    IdPuesto INT NOT NULL,
    IdZoo INT NOT NULL,
    CONSTRAINT FK_Empleado_IdZoo FOREIGN KEY (IdZoo) REFERENCES ZOO (IdZoo),
    CONSTRAINT FK_Empleado_IdPuesto FOREIGN KEY (IdPuesto) REFERENCES Puesto (IdPuesto)
);

CREATE TABLE Tareas (
    IdTareas INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Descripcion VARCHAR(255) NOT NULL,
    IdEmpleado INT NOT NULL,
    CONSTRAINT FK_Tareas_IdEmpleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado)
);

-- Creación de la tabla TareasEstadosTareas
CREATE TABLE TareasEstadosTareas (
    IdTareasEstadosTareas INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdTareas INT NOT NULL,
    IdEstadoTarea INT NOT NULL,
    CONSTRAINT FK_TareasEstadosTareas_IdTareas FOREIGN KEY (IdTareas) REFERENCES Tareas (IdTareas),
    CONSTRAINT FK_TareasEstadosTareas_IdEstadoTarea FOREIGN KEY (IdEstadoTarea) REFERENCES EstadoTarea (IdEstadoTarea)
);

-- Creación de la tabla Usuario
CREATE TABLE Usuario (
    IdUsuario INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Contraseña VARCHAR(255) NOT NULL,
    IdEmpleado INT NOT NULL,
    CONSTRAINT FK_Usuario_IdEmpleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado)
);

-- Creación de la tabla Rol
CREATE TABLE Rol (
    IdRol INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(255) NOT NULL
);

-- Creación de la tabla RolUsario
CREATE TABLE RolUsario (
    IdRolUsario INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdRol INT NOT NULL,
    IdEmpleado INT NOT NULL,
    CONSTRAINT FK_RolUsario_IdEmpleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado),
    CONSTRAINT FK_RolUsario_IdRol FOREIGN KEY (IdRol) REFERENCES Rol (IdRol)
);



-- Creación de la tabla VentaEntrada
CREATE TABLE VentaEntrada (
    IdVentaEntrada INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    fechaventa DATE NOT NULL,
    horaventa TIME NOT NULL,
    IdZoo INT NOT NULL,
    IdVisitantes INT NOT NULL,
    IdMetodoPago INT NOT NULL,
    CONSTRAINT FK_VentaEntrada_IdZoo FOREIGN KEY (IdZoo) REFERENCES ZOO (IdZoo),
    CONSTRAINT FK_VentaEntrada_IdMetodoPago FOREIGN KEY (IdMetodoPago) REFERENCES MetodoPago (IdMetodoPago),
    CONSTRAINT FK_VentaEntrada_IdVisitantes FOREIGN KEY (IdVisitantes) REFERENCES Visitantes (IdVisitantes)
);

-- Creación de la tabla DetalleVenta
CREATE TABLE DetalleVenta (
    IdDetalleVenta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdVentaEntrada INT NOT NULL,
    IdTipoEntrada INT NOT NULL,
    Cantidad INT NOT NULL,
    CONSTRAINT FK_DetalleVenta_IdVentaEntrada FOREIGN KEY (IdVentaEntrada) REFERENCES VentaEntrada (IdVentaEntrada),
    CONSTRAINT FK_DetalleVenta_IdTipoEntrada FOREIGN KEY (IdTipoEntrada) REFERENCES TipoEntrada (IdTipoEntrada)
);

-- Creación de la tabla CalificacionVisita
CREATE TABLE CalificacionVisita (
    IdCalificacionVisita BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nota FLOAT NOT NULL,
    SugerenciaMejora VARCHAR(255) NOT NULL,
    fecha DATE NOT NULL,
    IdVisitantes INT NOT NULL,
    CONSTRAINT FK_CalificacionVisita_IdVisitantes FOREIGN KEY (IdVisitantes) REFERENCES Visitantes (IdVisitantes)
);

--Tablas de Auditorias
CREATE TABLE Audit_ZOO (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(100),
    Operacion VARCHAR(10),
    IdZoo INT,
    NombreZoo VARCHAR(255),
    Direccion VARCHAR(255),
    DescripcionZoo VARCHAR(255),
    Disponibilidad BIT,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);


CREATE TABLE Audit_Habitacion (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdHabitacion INT,
    NombreHab VARCHAR(255),
    Direccion VARCHAR(255),
    Capacidad BIT,
    IdTipoHabitacion INT,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Audit_Animales (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(100),
    Operacion VARCHAR(10),
    IdAnimales INT,
    NombreAni VARCHAR(255),
    EdadAni INT,
    IdDieta INT,
    IdHabitacion INT,
    IdEspecies INT,
    IdEstadoSalud INT,
    IdZoo INT,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Audit_Especies (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(100),
    Operacion VARCHAR(10),
    IdEspecie INT,
    NombreEsp VARCHAR(255),
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Audit_EstadoSalud (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdEstadoSalud INT,
    EstadoSalud VARCHAR(255),
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Audit_Dieta (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdDieta INT,
    NombreDiet VARCHAR(255),
    DescripcionDiet VARCHAR(255),
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Audit_TipoHabitacion (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdTipoHabitacion INT,
    NombreTH VARCHAR(255),
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Audit_Alimentos (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdAlimentos INT,
    NombreAli VARCHAR(255),
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Audit_DietaAlimentos (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdDietaAlimentos INT,
    IdDieta INT,
    IdAlimentos INT,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Audit_Visitantes (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdVisitantes INT,
    NombreVist VARCHAR(255),
    Apell1Vist VARCHAR(255),
    Apell2Vist VARCHAR(255),
    Disponibilidad BIT,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Audit_TipoEntrada (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdTipoEntrada INT,
    NombreEnt VARCHAR(255),
    DescripcionEnt VARCHAR(255),
    Precio MONEY,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Audit_EstadoHabitacion (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdEstadoHabitacion INT,
    Estado VARCHAR(255),
    Descripcion VARCHAR(255),
    Fecha DATE,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Audit_Empleado (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdEmpleado INT,
    Nombre VARCHAR(255),
    Apellido1 VARCHAR(255),
    Apellido2 VARCHAR(255),
    IdPuesto INT,
    IdZoo INT,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Audit_Puesto (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdPuesto INT,
    Nombre VARCHAR(255),
    Salario FLOAT,
    DescripcionTareas VARCHAR(255),
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);


CREATE TABLE Audit_Tareas (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdTareas INT,
    Nombre VARCHAR(255),
    Descripcion VARCHAR(255),
    IdEmpleado INT,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Audit_EstadoTarea (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100), 
    Operacion NVARCHAR(10),
    IdEstadoTarea INT,
    Nombre VARCHAR(255),
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);


CREATE TABLE Audit_VentaEntrada (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdVentaEntrada INT,
    fechaventa DATE,
    horaventa TIME,
    IdZoo INT,
    IdVisitantes INT,
    IdMetodoPago INT,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

CREATE TABLE Audit_MetodoPago (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdMetodoPago INT,
    MetodoPago VARCHAR(255),
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);


CREATE TABLE Audit_CalificacionVisita (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdCalificacionVisita BIGINT,
    Nota FLOAT,
    SugerenciaMejora VARCHAR(255),
    fecha DATE,
    IdVisitantes INT,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);


CREATE TABLE Audit_Rol (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdRol INT,
    Nombre VARCHAR(255),
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);


CREATE TABLE Audit_Usuario (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdUsuario INT,
    Contraseña VARCHAR(255),
    IdEmpleado INT,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

--FIN Tablas Auditorias
