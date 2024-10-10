--Parte 1: Creación de la Base de Datos
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

--Parte 2: Crear FileGroup
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
CREATE TABLE Dieta (
    IdDieta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreDiet VARCHAR(20) NOT NULL,
    DescripcionDiet VARCHAR(255) NOT NULL
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
    nombreVist VARCHAR(20) NOT NULL,
    apell1Vist VARCHAR(20) NOT NULL,
    apell2Vist VARCHAR(20) NOT NULL,
);

USE ZooMA
GO
CREATE TABLE MetodoPago (
    IdMetodoPago INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    metodopago VARCHAR(50) NOT NULL
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
    estado VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
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
CREATE TABLE MantenimientoHabitacion (
    IdMantenimientoHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    reporte VARCHAR(255) NOT NULL,
    IdTareas INT NOT NULL,
    IdHabitacion INT NOT NULL,
    CONSTRAINT FK_MantenimientoHabitacion_IdHabitacion FOREIGN KEY (IdHabitacion) REFERENCES Habitacion (IdHabitacion)
);

USE ZooMA
GO
CREATE TABLE ControlAnimal (
    IdControl INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Reporte VARCHAR(255) NOT NULL,
    IdTareas INT NOT NULL,
    IdAnimales INT NOT NULL,
    CONSTRAINT FK_ControlAnimal_IdAnimales FOREIGN KEY (IdAnimales) REFERENCES Animales (IdAnimales)
);

USE ZooMA
GO
CREATE TABLE EstadoTarea (
    IdEstadoTarea INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(20) NOT NULL
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
    Descripcion VARCHAR(255) NOT NULL,
    IdEmpleado INT NOT NULL,
    CONSTRAINT FK_Tareas_IdEmpleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado)
);

USE ZooMA
GO
CREATE TABLE TareasEstadosTareas (
    IdTareasEstadosTareas INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdTareas INT NOT NULL,
    IdEstadoTarea INT NOT NULL,
    CONSTRAINT FK_TareasEstadosTareas_IdTareas FOREIGN KEY (IdTareas) REFERENCES Tareas (IdTareas),
    CONSTRAINT FK_TareasEstadosTareas_IdEstadoTarea FOREIGN KEY (IdEstadoTarea) REFERENCES EstadoTarea (IdEstadoTarea)
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
    fechaventa DATE NOT NULL,
    horaventa TIME NOT NULL,
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
    Cantidad INT NOT NULL,
    CONSTRAINT FK_DetalleVenta_IdEntrada FOREIGN KEY (IdEntrada) REFERENCES Entrada (IdEntrada)--Hay algo que me está dando conficto ahí y no se que es!!
);


USE ZooMA
GO
CREATE TABLE CalificacionVisita (
    IdCalificacionVisita INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nota INT NOT NULL,
    SugerenciaMejora VARCHAR(255) NOT NULL,
    fecha DATE NOT NULL,
    IdVisitantes INT NOT NULL,
    CONSTRAINT FK_CalificacionVisita_IdVisitantes FOREIGN KEY (IdVisitantes) REFERENCES Visitantes (IdVisitantes)
);



--Parte 4: Tablas de Auditorias
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
CREATE TABLE Audit_Animales (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdAnimales INT,
    NombreAni VARCHAR(20),
    EdadAni INT,
    IdDieta INT,
    IdHabitacion INT,
    IdEspecies INT,
    IdEstadoSalud INT,
    IdZoo INT,
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE TABLE Audit_Especies (
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
CREATE TABLE Audit_Dieta (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(20),
    Operacion VARCHAR(10),
    IdDieta INT,
    NombreDiet VARCHAR(20),
    DescripcionDiet VARCHAR(255),
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
    NombreTH VARCHAR(20),
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
    DescripcionTareas VARCHAR(255),
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
    Descripcion VARCHAR(255),
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
    fechaventa DATE,
    horaventa TIME,
    IdEmpleado INT,
    IdVisitantes INT,
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
    fecha DATE,
    IdVisitantes INT,
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
    IdEmpleado INT,
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

--FIN Tablas Auditorias