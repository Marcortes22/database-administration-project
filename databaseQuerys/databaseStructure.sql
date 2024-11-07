-- Parte 1: Creación de la Base de Datos
USE master
IF DB_ID('ZooMA') IS NOT NULL
BEGIN
    DROP DATABASE ZooMA;
END
GO
CREATE DATABASE ZooMA
ON PRIMARY (
    NAME = 'ZooMA_Data',
    FILENAME = 'C:\SQLData\ZooMA_Data.mdf',
    SIZE = 3400MB,
    MAXSIZE = 7GB,
    FILEGROWTH = 1020MB
) LOG ON (
    NAME = 'ZooMA_Log',
    FILENAME = 'C:\SQLData\ZooMA_Log.ldf',
    SIZE = 800MB,
    MAXSIZE = 3GB,
    FILEGROWTH = 200MB 
)
GO
--Parte 1: Fin Creación de la Base de Datos

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
    SIZE = 200MB,
    MAXSIZE = 1000MB,
    FILEGROWTH = 100MB
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
    SIZE = 700MB,
    MAXSIZE = 2GB,
    FILEGROWTH = 300MB
) TO FILEGROUP Zoo
GO

ALTER DATABASE ZooMA
ADD FILE (
    NAME = 'Empleado_Data',
    FILENAME = 'C:\SQLData\Empleado_Data.ndf',
    SIZE = 100MB,
    MAXSIZE = 350MB,
    FILEGROWTH = 50MB
) TO FILEGROUP Empleado
GO

ALTER DATABASE ZooMA
ADD FILE (
    NAME = 'Auditorias_Data',
    FILENAME = 'C:\SQLData\Auditorias_Data.ndf',
    SIZE = 1062MB,
    MAXSIZE = 4GB,
    FILEGROWTH = 319MB
) TO FILEGROUP Auditorias
GO
--Parte 2: Fin FileGroup

--Parte 3: Creación de tablas
USE ZooMA
GO
CREATE TABLE EstadoSalud (
    IdEstadoSalud INT NOT NULL IDENTITY(1,1),
    EstadoSalud VARCHAR(255) NOT NULL,
    CONSTRAINT PK_EstadoSalud_IdEstadoSalud PRIMARY KEY CLUSTERED (IdEstadoSalud)
) ON Animal
GO

USE ZooMA
GO
CREATE TABLE Especie (
    IdEspecie INT NOT NULL IDENTITY(1,1),
    NombreEsp VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Especie_IdEspecie PRIMARY KEY CLUSTERED (IdEspecie)
)  ON Animal
GO


USE ZooMA
GO
CREATE TABLE TipoHabitacion (
    IdTipoHabitacion INT NOT NULL IDENTITY(1,1),
    NombreTH VARCHAR(75) NOT NULL,
    CONSTRAINT PK_TipoHabitacion_IdTipoHabitacion PRIMARY KEY CLUSTERED (IdTipoHabitacion)
) ON Habitacion
GO


USE ZooMA
GO
CREATE TABLE ZOO (
    IdZoo INT NOT NULL IDENTITY(1,1),
    NombreZoo VARCHAR(20) NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    DescripcionZoo VARCHAR(255) NOT NULL,
    CONSTRAINT PK_ZOO_IdZoo PRIMARY KEY CLUSTERED (IdZoo)
) ON ZOO
GO


USE ZooMA
GO
CREATE TABLE EstadoHabitacion (
    IdEstadoHabitacion INT NOT NULL IDENTITY(1,1),
    Estado VARCHAR(50) NOT NULL,
    CONSTRAINT PK_EstadoHabitacion_IdEstadoHabitacion PRIMARY KEY CLUSTERED (IdEstadoHabitacion)
) ON Habitacion
GO


USE ZooMA
GO
CREATE TABLE Habitacion (
    IdHabitacion INT NOT NULL IDENTITY(1,1),
    NombreHab VARCHAR(20) NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    Capacidad INT NOT NULL,
    IdTipoHabitacion INT NOT NULL,
    IdEstadoHabitacion INT NOT NULL,
    CONSTRAINT PK_Habitacion_IdHabitacion PRIMARY KEY CLUSTERED (IdHabitacion),
    CONSTRAINT FK_Habitacion_IdTipoHabitacion FOREIGN KEY (IdTipoHabitacion) 
        REFERENCES TipoHabitacion (IdTipoHabitacion),
    CONSTRAINT FK_HabitacionEstadoHabitacion FOREIGN KEY (IdEstadoHabitacion) 
        REFERENCES EstadoHabitacion (IdEstadoHabitacion) 
)  ON Habitacion
GO

USE ZooMA
GO

CREATE TABLE Visitantes (
    IdVisitantes INT NOT NULL IDENTITY(1,1),
    NombreVist VARCHAR(20) NOT NULL,
    Apell1Vist VARCHAR(20) NOT NULL,
    Apell2Vist VARCHAR(20) NOT NULL,
    CorreoElectronico VARCHAR(50) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Visitantes_IdVisitantes PRIMARY KEY CLUSTERED (IdVisitantes)
) ON ZOO
GO

USE ZooMA
GO
CREATE TABLE MetodoPago (
    IdMetodoPago INT NOT NULL IDENTITY(1,1),
    Metodopago VARCHAR(50) NOT NULL,
    CONSTRAINT PK_MetodoPago_IdMetodoPago PRIMARY KEY CLUSTERED (IdMetodoPago)
) ON ZOO
GO

USE ZooMA
GO
CREATE TABLE Dieta (
    IdDieta INT NOT NULL IDENTITY(1,1),
    NombreDiet VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Dieta_IdDieta PRIMARY KEY CLUSTERED (IdDieta)
) ON Animal
GO


USE ZooMA
GO
CREATE TABLE Animales (
    IdAnimales INT NOT NULL IDENTITY(1,1),
    NombreAni VARCHAR(20) NOT NULL,
    EdadAni INT NOT NULL,
    IdDieta INT NOT NULL,
    IdHabitacion INT NOT NULL,
    IdEspecie INT NOT NULL,
    IdEstadoSalud INT NOT NULL,
    IdZoo INT NOT NULL DEFAULT 1,
    CONSTRAINT PK_Animales PRIMARY KEY CLUSTERED (IdAnimales),
    CONSTRAINT FK_Animales_IdEstadoSalud_IdEstadoSalud FOREIGN KEY (IdEstadoSalud) 
        REFERENCES EstadoSalud (IdEstadoSalud),
    CONSTRAINT FK_Animales_IdZoo FOREIGN KEY (IdZoo) 
        REFERENCES ZOO (IdZoo),
    CONSTRAINT FK_Animales_IdHabitacion FOREIGN KEY (IdHabitacion) 
        REFERENCES Habitacion (IdHabitacion),
    CONSTRAINT FK_Animales_IdDieta FOREIGN KEY (IdDieta) 
        REFERENCES Dieta (IdDieta),
    CONSTRAINT FK_Animales_IdEspecies FOREIGN KEY (IdEspecie) 
        REFERENCES Especie (IdEspecie) 
) ON Animal
GO
USE ZooMA
GO
CREATE TABLE TipoTarea (
    IdTipoTarea INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreTT VARCHAR(20) NOT NULL
);
GO

USE ZooMA
GO
CREATE TABLE HistorialMovimientos (
    IdHistorialMovimientos INT NOT NULL IDENTITY(1,1),
    FechaMovimiento DATETIME NOT NULL,
    IdHabitacionAnterior INT NOT NULL,
    IdHabitacionActual INT NOT NULL,
    Motivo VARCHAR(255) NOT NULL,
    IdAnimales INT NOT NULL,
    realizadoPor INT NOT NULL,
    CONSTRAINT PK_HistorialMovimientos_IdHistorialMovimientos PRIMARY KEY CLUSTERED (IdHistorialMovimientos),
    CONSTRAINT FK_HistorialMovimientos_IdAnimales FOREIGN KEY (IdAnimales) 
        REFERENCES Animales (IdAnimales),
    CONSTRAINT FK_HistorialMovimientos_IdHabitacionAnterior FOREIGN KEY (IdHabitacionAnterior) 
        REFERENCES Habitacion (IdHabitacion),
    CONSTRAINT FK_HistorialMovimientos_IdHabitacionActual FOREIGN KEY (IdHabitacionActual) 
        REFERENCES Habitacion (IdHabitacion) 
) ON Habitacion

GO





USE ZooMA
GO
CREATE TABLE Puesto (
    IdPuesto INT NOT NULL IDENTITY(1,1),
    Nombre VARCHAR(20) NOT NULL,
    Salario FLOAT NOT NULL,
    CONSTRAINT PK_Puesto_IdPuesto PRIMARY KEY CLUSTERED (IdPuesto)
) ON Empleado
GO



USE ZooMA
GO
CREATE TABLE Empleado (
    IdEmpleado INT NOT NULL IDENTITY(1,1),
    Nombre VARCHAR(20) NOT NULL,
    Apellido1 VARCHAR(20) NOT NULL,
    Apellido2 VARCHAR(20) NOT NULL,
    Correo VARCHAR(50) NOT NULL,
    IdPuesto INT NOT NULL,
    IdZoo INT NOT NULL DEFAULT 1,
    CONSTRAINT PK_Empleado_IdEmpleado PRIMARY KEY CLUSTERED (IdEmpleado),
    CONSTRAINT FK_Empleado_IdZoo FOREIGN KEY (IdZoo) REFERENCES ZOO (IdZoo),
    CONSTRAINT FK_Empleado_IdPuesto FOREIGN KEY (IdPuesto) REFERENCES Puesto (IdPuesto) 
) ON Empleado
GO


USE ZooMA
GO
CREATE TABLE EstadoTarea (
    IdEstadoTarea INT NOT NULL IDENTITY(1,1),
    Nombre VARCHAR(20) NOT NULL,
    CONSTRAINT PK_EstadoTarea_IdEstadoTarea PRIMARY KEY CLUSTERED (IdEstadoTarea)
) ON Empleado
GO


USE ZooMA
GO
CREATE TABLE Tareas (
    IdTareas INT NOT NULL IDENTITY(1,1),
    IdEmpleado INT NOT NULL,
    IdTipoTarea INT NOT NULL,
    IdEstadoTarea INT NOT NULL,
    Fecha DATETIME DEFAULT GETDATE(),
    CONSTRAINT PK_Tareas_IdTareas PRIMARY KEY CLUSTERED (IdTareas),
    CONSTRAINT FK_Tareas_IdEmpleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado),
    CONSTRAINT FK_TareasEstadoTareas_IdEstadoTarea FOREIGN KEY (IdEstadoTarea) REFERENCES EstadoTarea (IdEstadoTarea)
) ON Empleado
GO

GO
USE ZooMA
GO
CREATE TABLE HistorialEstadoTarea (
    IdHistorialEstadoTarea INT PRIMARY KEY CLUSTERED IDENTITY(1,1),
    IdTarea INT NOT NULL,
    IdEstadoTarea INT NOT NULL,
    IdTipoTarea INT NOT NULL,
    IdEmpleado INT NOT NULL,	
    Fecha DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_HistorialEstadoTarea_Tarea FOREIGN KEY (IdTarea)REFERENCES Tareas (IdTareas),

    CONSTRAINT FK_HistorialEstadoTarea_EstadoTarea FOREIGN KEY (IdEstadoTarea)REFERENCES EstadoTarea (IdEstadoTarea),

    CONSTRAINT FK_HistorialEstadoTarea_TipoTarea FOREIGN KEY (IdTipoTarea)REFERENCES TipoTarea (IdTipoTarea),

    CONSTRAINT FK_HistorialEstadoTarea_Empleado FOREIGN KEY (IdEmpleado)REFERENCES Empleado (IdEmpleado)

);
GO


USE ZooMA
GO
CREATE TABLE MantenimientoHabitacion (
    IdMantenimientoHabitacion INT NOT NULL IDENTITY(1,1),
    Reporte VARCHAR(255) NULL,
    IdTareas INT NOT NULL,
    IdHabitacion INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    CONSTRAINT PK_MantenimientoHabitacion_IdMantenimientoHabitacion PRIMARY KEY CLUSTERED (IdMantenimientoHabitacion),
    CONSTRAINT FK_MantenimientoHabitacion_IdTareas FOREIGN KEY (IdTareas) REFERENCES Tareas (IdTareas),
    CONSTRAINT FK_MantenimientoHabitacion_IdHabitacion FOREIGN KEY (IdHabitacion) REFERENCES Habitacion (IdHabitacion)
) ON Habitacion
GO


USE ZooMA
GO
CREATE TABLE ControlAnimal (
    IdControl INT NOT NULL IDENTITY(1,1),
    Reporte VARCHAR(255) NULL,
    IdTareas INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    IdAnimales INT NOT NULL,
    CONSTRAINT PK_ControlAnimal_IdControl PRIMARY KEY CLUSTERED (IdControl),
    CONSTRAINT FK_ControlAnimal_IdTareas FOREIGN KEY (IdTareas) REFERENCES Tareas (IdTareas),
    CONSTRAINT FK_ControlAnimal_IdAnimales FOREIGN KEY (IdAnimales) REFERENCES Animales (IdAnimales)
) ON Animal
GO


USE ZooMA
GO

CREATE TABLE Usuario (
    IdUsuario INT NOT NULL IDENTITY(1,1),
    Contraseña VARCHAR(20) NOT NULL,
    Estado BIT NOT NULL DEFAULT 1,
    CONSTRAINT PK_Usuario_IdUsuario PRIMARY KEY CLUSTERED (IdUsuario),
    CONSTRAINT FK_Usuario_IdEmpleado FOREIGN KEY (IdUsuario) REFERENCES Empleado (IdEmpleado)
) ON Empleado
GO

USE ZooMA
GO
CREATE TABLE Rol (
    IdRol INT NOT NULL IDENTITY(1,1),
    nombre VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Rol_IdRol PRIMARY KEY CLUSTERED (IdRol)
) ON Empleado
GO


USE ZooMA
GO

CREATE TABLE RolUsuario (
    IdRolUsuario INT NOT NULL IDENTITY(1,1),
    IdRol INT NOT NULL,
    IdUsuario INT NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NULL,
    CONSTRAINT PK_RolUsuario_IdRolUsuario PRIMARY KEY CLUSTERED (IdRolUsuario),
    CONSTRAINT FK_RolUsuario_IdUsuario FOREIGN KEY (IdUsuario) REFERENCES Usuario (IdUsuario),
    CONSTRAINT FK_RolUsuario_IdRol FOREIGN KEY (IdRol) REFERENCES Rol (IdRol) 
) ON Empleado
GO


USE ZooMA
GO
CREATE TABLE VentaEntrada (
    IdVentaEntrada INT NOT NULL IDENTITY(1,1),
    Fechaventa DATETIME NOT NULL,
    IdVisitantes INT NOT NULL,
    IdMetodoPago INT NOT NULL,
    IdEmpleado INT NOT NULL,
    IVA MONEY DEFAULT 0.13,
    CONSTRAINT PK_VentaEntrada_IdVentaEntrada PRIMARY KEY CLUSTERED (IdVentaEntrada),
    CONSTRAINT FK_VentaEntrada_IdEmpleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado),
    CONSTRAINT FK_VentaEntrada_IdMetodoPago FOREIGN KEY (IdMetodoPago) REFERENCES MetodoPago (IdMetodoPago),
    CONSTRAINT FK_VentaEntrada_IdVisitantes FOREIGN KEY (IdVisitantes) REFERENCES Visitantes (IdVisitantes) 
) ON ZOO
GO


USE ZooMA
GO
CREATE TABLE TipoEntrada (
    IdTipoEntrada INT NOT NULL IDENTITY(1,1),
    NombreEnt VARCHAR(20) NOT NULL,
    Precio MONEY NOT NULL,
    CONSTRAINT PK_TipoEntrada_IdTipoEntrada PRIMARY KEY CLUSTERED (IdTipoEntrada)
) ON ZOO
GO


USE ZooMA
GO
CREATE TABLE Entrada (
    IdEntrada INT NOT NULL IDENTITY(1,1),
    fechaVencimiento DATE NOT NULL,
    descuento INT NOT NULL,
    IdTipoEntrada INT NOT NULL,
    CONSTRAINT PK_Entrada_IdEntrada PRIMARY KEY CLUSTERED (IdEntrada),
    CONSTRAINT FK_Entrada_IdTipoEntrada FOREIGN KEY (IdTipoEntrada) 
        REFERENCES TipoEntrada (IdTipoEntrada)
) ON ZOO
GO


USE ZooMA
GO

CREATE TABLE DetalleVenta (
    IdDetalleVenta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdEntrada INT NOT NULL,
    IdVentaEntrada INT NOT NULL,
    Cantidad INT NOT NULL,
    Precio MONEY NOT NULL,
    CONSTRAINT FK_DetalleVenta_IdVentaEntrada FOREIGN KEY (IdVentaEntrada) 
        REFERENCES VentaEntrada (IdVentaEntrada),
    CONSTRAINT FK_DetalleVenta_IdEntrada FOREIGN KEY (IdEntrada) 
        REFERENCES Entrada (IdEntrada)
) ON ZOO
GO


USE ZooMA
GO
CREATE TABLE CalificacionRecorrido (
    IdCalificacionRecorrido INT NOT NULL IDENTITY(1,1),
    Nota INT NOT NULL,
    SugerenciaMejora VARCHAR(255) NULL,
    CONSTRAINT PK_CalificacionRecorrido_IdCalificacionRecorrido PRIMARY KEY CLUSTERED (IdCalificacionRecorrido)
) ON ZOO
GO


USE ZooMA
GO
CREATE TABLE CalificacionServicioAlCliente (
    IdCalificacionServicioAlCliente INT NOT NULL IDENTITY(1,1),
    Nota INT NOT NULL,
    SugerenciaMejora VARCHAR(255) NULL,
    CONSTRAINT PK_CalificacionServicioAlCliente_IdCalificacionServicioAlCliente PRIMARY KEY CLUSTERED (IdCalificacionServicioAlCliente)
) ON ZOO
GO


USE ZooMA
GO
CREATE TABLE CalificacionVisita (
    IdCalificacionVisita INT NOT NULL IDENTITY(1,1),
    Nota INT NOT NULL,
    Fecha DATE NOT NULL,
    IdVentaEntrada INT NOT NULL,
    IdCalificacionServicioAlCliente INT NOT NULL,
    IdCalificacionRecorrido INT NOT NULL,
    CONSTRAINT PK_CalificacionVisita_IdCalificacionVisita PRIMARY KEY CLUSTERED (IdCalificacionVisita),
    CONSTRAINT FK_CalificacionVisita_IdCalificacionServicioAlCliente 
        FOREIGN KEY (IdCalificacionServicioAlCliente) 
        REFERENCES CalificacionServicioAlCliente (IdCalificacionServicioAlCliente),
    CONSTRAINT FK_CalificacionVisita_IdCalificacionRecorrido 
        FOREIGN KEY (IdCalificacionRecorrido) 
        REFERENCES CalificacionRecorrido (IdCalificacionRecorrido),
    CONSTRAINT FK_CalificacionVisita_VentaEntrada 
        FOREIGN KEY (IdVentaEntrada) 
        REFERENCES VentaEntrada (IdVentaEntrada)
) ON ZOO
GO


USE ZooMA
GO
CREATE TABLE Alimentos (
    IdAlimentos INT NOT NULL IDENTITY(1,1),
    Nombre VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Alimentos_IdAlimentos PRIMARY KEY CLUSTERED (IdAlimentos)
) ON Animal
GO


USE ZooMA
GO
CREATE TABLE DietaAlimentos (
    IdDietaAlimentos INT NOT NULL IDENTITY(1,1),
    IdDieta INT NOT NULL,
    IdAlimentos INT NOT NULL,
    Cantidad DECIMAL(10, 2) ,
    CONSTRAINT PK_DietaAlimentos_IdDietaAlimentos PRIMARY KEY CLUSTERED (IdDietaAlimentos),
    CONSTRAINT FK_DietaAlimentos_IdDieta FOREIGN KEY (IdDieta) REFERENCES Dieta (IdDieta),
    CONSTRAINT FK_DietaAlimentos_IdAlimentos FOREIGN KEY (IdAlimentos) REFERENCES Alimentos (IdAlimentos)
) ON Animal
GO


--Parte 3: Fin Creación de tablas

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
) ON Auditorias
GO

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
) ON Auditorias
GO

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
) ON Auditorias
GO

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
)ON Auditorias
GO


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
) ON Auditorias
GO

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
)ON Auditorias
GO

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
)ON Auditorias
GO

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
)ON Auditorias
GO

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
)ON Auditorias
GO

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
    IdEstadoTarea INT NOT NULL,
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
)ON Auditorias
GO

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
)ON Auditorias
GO

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
)ON Auditorias
GO

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
)ON Auditorias
GO

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
)ON Auditorias
GO

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
)ON Auditorias
GO

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
)ON Auditorias
GO

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
    IdEstadoHabitacion INT,
    RealizadoPor VARCHAR(100),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
)ON Auditorias
GO

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
)ON Auditorias
GO

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
) ON Auditorias
GO


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
) ON Auditorias
GO

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
) ON Auditorias
GO

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
) ON Auditorias
GO

--Parte 4: Fin Tablas Auditorias
