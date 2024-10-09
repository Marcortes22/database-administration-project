USE master;
GO

CREATE DATABASE ZooMA
ON PRIMARY(
    Name='ZooMA_Data',
    FILENAME='C:\SQLData\ZooMA_Data.mdf',
    SIZE=1300MB,
    MaxSize=6GB,
    FileGrowth=390MB
) 
LOG ON(
    Name='ZooMA_Log',
    FILENAME='C:\SQLData\ZooMA_Log.ldf',
    SIZE=500MB,
    MAXSIZE=2GB,
    FILEGROWTH=100MB 
);
GO

-- Creación de FileGroups
ALTER DATABASE ZooMA ADD FILEGROUP Animal;
ALTER DATABASE ZooMA ADD FILEGROUP Habitacion;
ALTER DATABASE ZooMA ADD FILEGROUP Zoo;
ALTER DATABASE ZooMA ADD FILEGROUP Empleado;
ALTER DATABASE ZooMA ADD FILEGROUP Auditorias;

-- Agregar archivos a FileGroups
ALTER DATABASE ZooMA ADD FILE 
(
    Name = 'Animal_Data',
    filename = 'C:\SQLData\Animal_Data.ndf',
    Size = 26MB,
    MaxSize = 104MB,
    Filegrowth = 8MB
) TO FILEGROUP Animal;

ALTER DATABASE ZooMA ADD FILE 
(
    Name = 'Habitacion_Data',
    filename = 'C:\SQLData\Habitacion_Data.ndf',
    Size = 26MB,
    MaxSize = 104MB,
    Filegrowth = 8MB
) TO FILEGROUP Habitacion;

ALTER DATABASE ZooMA ADD FILE 
(
    Name = 'Zoo_Data',
    filename = 'C:\SQLData\Zoo_Data.ndf',
    Size = 26MB,
    MaxSize = 104MB,
    Filegrowth = 8MB
) TO FILEGROUP Zoo;

ALTER DATABASE ZooMA ADD FILE 
(
    Name = 'Empleado_Data',
    filename = 'C:\SQLData\Empleado_Data.ndf',
    Size = 26MB,
    MaxSize = 104MB,
    Filegrowth = 8MB
) TO FILEGROUP Empleado;

ALTER DATABASE ZooMA ADD FILE 
(
    Name = 'Auditorias_Data',
    filename = 'C:\SQLData\Auditorias_Data.ndf',
    Size = 26MB,
    MaxSize = 104MB,
    Filegrowth = 8MB
) TO FILEGROUP Auditorias;
GO

USE ZooMA;

-- Creación de Tablas en orden correcto
-- ZOO
CREATE TABLE ZOO (
    IdZoo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreZoo VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    DescripcionZoo VARCHAR(255) NOT NULL,
    Disponibilidad BIT NOT NULL
);

-- EstadoSalud
CREATE TABLE EstadoSalud (
    IdEstadoSalud INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    estadoSalud VARCHAR(255) NOT NULL
);

-- Especies
CREATE TABLE Especies (
    IdEspecie INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreEsp VARCHAR(255) NOT NULL
);

-- Dieta
CREATE TABLE Dieta (
    IdDieta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreDiet VARCHAR(255) NOT NULL,
    DescripcionDiet VARCHAR(255) NOT NULL
);

-- Tipo de Habitación
CREATE TABLE TipoHabitacion (
    IdTipoHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreTH VARCHAR(255) NOT NULL
);

-- Habitación
CREATE TABLE Habitacion (
    IdHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreHab VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Capacidad BIT NOT NULL,
    IdTipoHabitacion INT NOT NULL,
    CONSTRAINT FK_Habitacion_IdTipoHabitacion FOREIGN KEY (IdTipoHabitacion) REFERENCES TipoHabitacion (IdTipoHabitacion)
);

-- Animales
CREATE TABLE Animales (
    IdAnimales INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreAni VARCHAR(255) NOT NULL,
    EdadAni INT NOT NULL,
    IdDieta INT NOT NULL,
    IdHabitacion INT NOT NULL,
    IdEspecies INT NOT NULL,
    IdEstadoSalud INT NOT NULL,
    IdZoo INT DEFAULT 1,
    CONSTRAINT FK_Animales_IdEstadoSalud FOREIGN KEY (IdEstadoSalud) REFERENCES EstadoSalud (IdEstadoSalud),
    CONSTRAINT FK_Animales_IdZoo FOREIGN KEY (IdZoo) REFERENCES ZOO (IdZoo),
    CONSTRAINT FK_Animales_IdHabitacion FOREIGN KEY (IdHabitacion) REFERENCES Habitacion (IdHabitacion),
    CONSTRAINT FK_Animales_IdDieta FOREIGN KEY (IdDieta) REFERENCES Dieta (IdDieta),
    CONSTRAINT FK_Animales_IdEspecies FOREIGN KEY (IdEspecies) REFERENCES Especies (IdEspecie)
);

-- Historial de movimientos de animales
CREATE TABLE HistorialMovimientos (
    IdHistorialMovimientos INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    FechaMovimiento DATE NOT NULL,
    IdHabitacionAnterior INT NOT NULL,
    IdHabitacionActual INT NOT NULL,
    Motivo VARCHAR(255) NOT NULL,
    IdAnimales INT NOT NULL,
    CONSTRAINT FK_HistorialMovimientos_IdAnimales FOREIGN KEY (IdAnimales) REFERENCES Animales (IdAnimales)
);

-- Estado de las habitaciones
CREATE TABLE EstadoHabitacion (
    IdEstadoHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    estado VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    Fecha DATE NOT NULL
);

-- Relación entre Habitaciones y su Estado
CREATE TABLE HabitacionEstadoHabitacion (
    IdHabitacionEstadoHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdHabitacion INT NOT NULL,
    IdEstadoHabitacion INT NOT NULL,
    CONSTRAINT FK_HabitacionEstadoHabitacion_IdHabitacion FOREIGN KEY (IdHabitacion) REFERENCES Habitacion (IdHabitacion),
    CONSTRAINT FK_HabitacionEstadoHabitacion_IdEstadoHabitacion FOREIGN KEY (IdEstadoHabitacion) REFERENCES EstadoHabitacion (IdEstadoHabitacion)
);

-- Mantenimiento de Habitaciones
CREATE TABLE MantenimientoHabitacion (
    IdMantenimientoHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    reporte VARCHAR(255) NOT NULL,
    IdTareas INT NOT NULL,
    IdHabitacion INT NOT NULL,
    CONSTRAINT FK_MantenimientoHabitacion_IdHabitacion FOREIGN KEY (IdHabitacion) REFERENCES Habitacion (IdHabitacion)
);

-- Puesto de Empleados
CREATE TABLE Puesto (
    IdPuesto INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Salario FLOAT NOT NULL,
    DescripcionTareas VARCHAR(255) NOT NULL
);

-- Empleados
CREATE TABLE Empleado (
    IdEmpleado INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Apellido1 VARCHAR(255) NOT NULL,
    Apellido2 VARCHAR(255) NOT NULL,
    IdPuesto INT NOT NULL,
    IdZoo INT DEFAULT 1,
    CONSTRAINT FK_Empleado_IdZoo FOREIGN KEY (IdZoo) REFERENCES ZOO (IdZoo),
    CONSTRAINT FK_Empleado_IdPuesto FOREIGN KEY (IdPuesto) REFERENCES Puesto (IdPuesto)
);

-- Tareas
CREATE TABLE Tareas (
    IdTareas INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Descripcion VARCHAR(255) NOT NULL,
    IdEmpleado INT NOT NULL,
    CONSTRAINT FK_Tareas_IdEmpleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado)
);

-- Estado de las Tareas
CREATE TABLE EstadoTarea (
    IdEstadoTarea INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL
);

-- Relación entre Tareas y Estado
CREATE TABLE TareasEstadosTareas (
    IdTareasEstadosTareas INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdTareas INT NOT NULL,
    IdEstadoTarea INT NOT NULL,
    CONSTRAINT FK_TareasEstadosTareas_IdTareas FOREIGN KEY (IdTareas) REFERENCES Tareas (IdTareas),
    CONSTRAINT FK_TareasEstadosTareas_IdEstadoTarea FOREIGN KEY (IdEstadoTarea) REFERENCES EstadoTarea (IdEstadoTarea)
);

-- Usuarios
CREATE TABLE Usuario (
    IdUsuario INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Contraseña VARCHAR(255) NOT NULL,
    IdEmpleado INT NOT NULL,
    CONSTRAINT FK_Usuario_IdEmpleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado)
);

-- Roles
CREATE TABLE Rol (
    IdRol INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(255) NOT NULL
);

-- Relación entre Usuarios y Roles
CREATE TABLE RolUsario (
    IdRolUsario INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdRol INT NOT NULL,
    IdEmpleado INT NOT NULL,
    CONSTRAINT FK_RolUsario_IdEmpleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado),
    CONSTRAINT FK_RolUsario_IdRol FOREIGN KEY (IdRol) REFERENCES Rol (IdRol)
);

-- Visitantes
CREATE TABLE Visitante (
    IdVisitante INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Apellido1 VARCHAR(255) NOT NULL,
    Apellido2 VARCHAR(255) NOT NULL,
    Tipo VARCHAR(255) NOT NULL
);

-- Ventas
CREATE TABLE Ventas (
    IdVenta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Fecha DATE NOT NULL,
    Total FLOAT NOT NULL,
    IdVisitante INT NOT NULL,
    CONSTRAINT FK_Ventas_IdVisitante FOREIGN KEY (IdVisitante) REFERENCES Visitante (IdVisitante)
);

-- Detalle de Ventas
CREATE TABLE DetalleVenta (
    IdDetalleVenta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdVenta INT NOT NULL,
    IdAnimales INT NOT NULL,
    Precio FLOAT NOT NULL,
    CONSTRAINT FK_DetalleVenta_IdVenta FOREIGN KEY (IdVenta) REFERENCES Ventas (IdVenta),
    CONSTRAINT FK_DetalleVenta_IdAnimales FOREIGN KEY (IdAnimales) REFERENCES Animales (IdAnimales)
);


--Tablas de Auditorias
CREATE TABLE Audit_ZOO (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(100),
    Operacion VARCHAR(10),
    IdZoo INT DEFAULT 1,
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
    IdZoo INT DEFAULT 1,
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
    IdZoo INT DEFAULT 1,
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
    IdEmpleado INT,
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
