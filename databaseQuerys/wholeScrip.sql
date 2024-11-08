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
    IdVisitantes INT NOT NULL,
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
    IdEmpleado INT NOT NULL,
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
    IdUsuario INT NOT NULL,
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


CREATE TABLE UnidadMedida(
    IdUnidadMedida INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50)
)

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
    IdVentaEntrada INT,
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
--table type para la tabla DetalleVenta (permite pasar una tabla como parametro)
USE ZooMA;
GO
IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DetalleVentaTableType')
  DROP TYPE DetalleVentaTableType;
GO
CREATE TYPE DetalleVentaTableType AS TABLE
(
    IdEntrada INT NOT NULL,
    Cantidad INT NOT NULL

);

GO

--table type para la tabla DetalleVenta (permite pasar una tabla como parametro)
 DROP TYPE if exists AlimentosDeDietaTableType
 GO
CREATE TYPE AlimentosDeDietaTableType AS TABLE
(
    IdAlimentos INT NOT NULL,
    Cantidad DECIMAL(10, 2) 
);

go


USE ZooMA
go
DROP function IF EXISTS CalcularPrecioEntrada
go
CREATE FUNCTION dbo.CalcularPrecioEntrada(@IdEntrada INT, @Cantidad INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Precio DECIMAL(10, 2);
    
    -- Obtener el precio y el descuento de la entrada
    SET @Precio = (SELECT  (TP.Precio - (TP.Precio * (ISNULL(E.descuento, 0)/100.0)))* @Cantidad  FROM Entrada E 
    INNER JOIN TipoEntrada TP ON E.IdTipoEntrada = TP.IdTipoEntrada WHERE E.IdEntrada = @IdEntrada);
    RETURN @Precio;
END

go


--Parte 7: SP Insert
use ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_HABITACION', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_HABITACION;
GO
CREATE PROCEDURE SP_INGRESAR_HABITACION(
    @NombreHab VARCHAR(20),
    @Direccion VARCHAR(255),
    @Capacidad INT,
    @IdTipoHabitacion INT,
    @IdEstadoHabitacion INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;
    
    BEGIN TRY

        IF (@NombreHab = '' OR @Direccion = '' OR @Capacidad = '' OR   @IdEstadoHabitacion IS NULL OR @IdTipoHabitacion IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        IF NOT EXISTS (SELECT 1 FROM TipoHabitacion WHERE IdTipoHabitacion = @IdTipoHabitacion)
        BEGIN
            RAISERROR ('El tipo de habitación no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM EstadoHabitacion WHERE IdEstadoHabitacion = @IdEstadoHabitacion)
        BEGIN
            RAISERROR ('El estado de habitación no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        INSERT INTO Habitacion (NombreHab, Direccion, Capacidad, IdTipoHabitacion, IdEstadoHabitacion)
        VALUES (@NombreHab, @Direccion, @Capacidad, @IdTipoHabitacion, @IdEstadoHabitacion);
        
        COMMIT TRANSACTION;
        SELECT 'Habitación registrada correctamente: ' + @NombreHab AS 'Mensaje de Confirmación';
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO



use ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_EMPLEADO', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_EMPLEADO;
GO
CREATE PROCEDURE SP_INGRESAR_EMPLEADO(
    @IdEmpleado VARCHAR(20),
    @Nombre VARCHAR(20),
    @Apellido1 VARCHAR(20),
    @Apellido2 VARCHAR(20),
    @IdPuesto INT,
	@Cedula VARCHAR(20)
)
AS
BEGIN
	
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Nombre = '' OR @Apellido1 = '' OR @Apellido2 = '' OR @IdPuesto IS NULL OR @IdEmpleado IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM ZOO WHERE IdZoo = 1)
        BEGIN
			RAISERROR ('El zoológico no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        IF NOT EXISTS (SELECT 1 FROM Puesto WHERE IdPuesto = @IdPuesto)
        BEGIN
			RAISERROR ('El puesto no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END


        IF EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @IdEmpleado)
        BEGIN
			RAISERROR ('El empleado ya existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Empleado (IdEmpleado,Nombre, Apellido1, Apellido2, IdPuesto)
        VALUES (@IdEmpleado, @Nombre, @Apellido1, @Apellido2, @IdPuesto);
        
        COMMIT TRANSACTION;
        SELECT 'Empleado registrado correctamente: ' + @Nombre + ' ' + @Apellido1 + ' ' + @Apellido2 AS 'Mensaje de Confirmación';
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END

GO

USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_ANIMAL', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_ANIMAL;
GO
CREATE PROCEDURE SP_INGRESAR_ANIMAL(
    @NombreAni VARCHAR(20),
    @EdadAni INT,
    @IdDieta INT,
    @IdHabitacion INT,
    @IdEspecie INT,
    @IdEstadoSalud INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRY
  DECLARE @CantidadActual INT;

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

        IF (@NombreAni = '' OR @EdadAni IS NULL OR @IdDieta IS NULL OR @IdHabitacion IS NULL OR @IdEspecie IS NULL OR @IdEstadoSalud IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            
            RETURN;
        END


        IF NOT EXISTS (SELECT 1 FROM ZOO WHERE IdZoo = 1)
        BEGIN
			RAISERROR ('El Zoológico no existe', 16, 1);
            
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM Dieta WHERE IdDieta = @IdDieta)
        BEGIN
			RAISERROR ('La Dieta no existe', 16, 1);
            
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM Habitacion WHERE IdHabitacion = @IdHabitacion)
        BEGIN
			RAISERROR ('La Habitación no existe', 16, 1);
         
            RETURN;
        END

		SET @CantidadActual = (SELECT COUNT(*) FROM Animales WHERE IdHabitacion = @IdHabitacion)

		IF(@CantidadActual >= (SELECT Capacidad from Habitacion where IdHabitacion = @IdHabitacion))
			BEGIN
			RAISERROR ('La Habitación está llena', 16, 1);
         
            RETURN;
			END

        IF NOT EXISTS (SELECT 1 FROM Especie WHERE IdEspecie = @IdEspecie)
        BEGIN
			RAISERROR ('La Especie no existe', 16, 1);
          
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM EstadoSalud WHERE IdEstadoSalud = @IdEstadoSalud)
        BEGIN
			RAISERROR ('El Estado de Salud no existe', 16, 1);
            RETURN;
        END

        INSERT INTO Animales (NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud)
        VALUES (@NombreAni, @EdadAni, @IdDieta, @IdHabitacion, @IdEspecie, @IdEstadoSalud);

        
        SELECT 'Animal registrado correctamente: ' + @NombreAni AS 'Mensaje de Confirmación';
        
    END TRY
    BEGIN CATCH

        
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END

GO

USE ZooMA;
GO

use ZooMA
go

use ZooMA
go
IF OBJECT_ID('SP_ACTUALIZAR_ANIMAL', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_ANIMAL;
GO

CREATE PROCEDURE SP_ACTUALIZAR_ANIMAL(
    @IdAnimal INT,
    @NombreAni VARCHAR(20) = NULL,
    @EdadAni INT = NULL,
    @IdDieta INT = NULL,
    @IdEspecie INT = NULL,
    @IdEstadoSalud INT = NULL,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Cedula = '' OR @IdAnimal IS NULL)
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

        IF NOT EXISTS (SELECT 1 FROM Animales WHERE IdAnimales = @IdAnimal)
        BEGIN
			RAISERROR ('El animal no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS  (SELECT 1 FROM Dieta WHERE IdDieta = @IdDieta)
        BEGIN
			RAISERROR ('La Dieta especificada no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END


        IF  NOT EXISTS (SELECT 1 FROM Especie WHERE IdEspecie = @IdEspecie)
        BEGIN
			RAISERROR ('La Especie especificada no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF  NOT EXISTS (SELECT 1 FROM EstadoSalud WHERE IdEstadoSalud = @IdEstadoSalud)
        BEGIN
			RAISERROR ('El Estado de Salud especificado no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE Animales
        SET 
            NombreAni = COALESCE(@NombreAni, NombreAni),
            EdadAni = COALESCE(@EdadAni, EdadAni),
            IdDieta = COALESCE(@IdDieta, IdDieta),
            IdEspecie = COALESCE(@IdEspecie, IdEspecie),
            IdEstadoSalud = COALESCE(@IdEstadoSalud, IdEstadoSalud)
        WHERE IdAnimales = @IdAnimal;

        COMMIT TRANSACTION;
        SELECT 'Animal actualizado correctamente: '  AS 'Mensaje de Confirmación';
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;


GO



USE ZooMA
GO
IF OBJECT_ID('SP_MOVER_ANIMAL', 'P') IS NOT NULL
   DROP PROCEDURE SP_MOVER_ANIMAL;
GO
CREATE PROCEDURE SP_MOVER_ANIMAL(
	@IdAnimal INT,
    @IdHabitacion INT,
	@Motivo VARCHAR(100),
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRY
	BEGIN TRANSACTION

  DECLARE @CantidadActual INT;
  DECLARE @IdHabitacionAterior INT;

        IF (@IdHabitacion  IS NULL OR @Motivo = '' OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            
            RETURN;
        END

		 IF NOT EXISTS (SELECT 1 FROM Animales WHERE IdAnimales = @IdAnimal)
        BEGIN
			RAISERROR ('El animal no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Habitacion WHERE IdHabitacion = @IdHabitacion)
        BEGIN
			RAISERROR ('La Habitación a la que desea mover el animal no existe', 16, 1);
            RETURN;
        END

		SET @CantidadActual = (SELECT COUNT(*) FROM Animales WHERE IdHabitacion = @IdHabitacion)
		SET @IdHabitacionAterior = (SELECT IdHabitacion FROM Animales WHERE IdAnimales = @IdAnimal)

		IF(@IdHabitacionAterior = @IdHabitacion)
		BEGIN
			RAISERROR ('El animal ya se encuentra en la habitacion seleccionada', 16, 1);
            RETURN;
			END

		IF(@CantidadActual >= (SELECT Capacidad from Habitacion where IdHabitacion = @IdHabitacion))
			BEGIN
			RAISERROR ('La Habitación está llena', 16, 1);
            RETURN;
			END

			UPDATE Animales
			SET IdHabitacion = @IdHabitacion
			WHERE IdAnimales = @IdAnimal

        INSERT INTO HistorialMovimientos(FechaMovimiento, IdHabitacionAnterior, IdHabitacionActual, Motivo, IdAnimales, realizadoPor)
        VALUES (GETDATE(), @IdHabitacionAterior, @IdHabitacion, @Motivo, @IdAnimal,@Cedula);

		COMMIT TRANSACTION
        
        SELECT 'Animal movido correctamente: 'AS 'Mensaje de Confirmación';
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END

GO


USE ZooMA
GO
GO
IF OBJECT_ID('SP_INGRESAR_ESTADO_SALUD', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_ESTADO_SALUD;
GO
CREATE PROCEDURE SP_INGRESAR_ESTADO_SALUD(
    @estadoSalud VARCHAR(255),
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@estadoSalud = '' OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        IF EXISTS (SELECT 1 FROM EstadoSalud WHERE estadoSalud = @estadoSalud)
        BEGIN
			RAISERROR ('El estado de salud ya existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO EstadoSalud (estadoSalud)
        VALUES (@estadoSalud);

        COMMIT TRANSACTION;
        SELECT 'Estado de salud registrado correctamente: ' + @estadoSalud AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_ESPECIE', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_ESPECIE;
GO
CREATE PROCEDURE SP_INGRESAR_ESPECIE(
    @NombreEsp VARCHAR(20),
    @Cedula VARCHAR(20)
)
AS
BEGIN

    BEGIN TRY

        IF (@NombreEsp = '' OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            
            RETURN;
        END
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

        IF EXISTS (SELECT 1 FROM Especie WHERE NombreEsp = @NombreEsp)
        BEGIN
			RAISERROR ('La especie ya existe', 16, 1);
            RETURN;
        END

        INSERT INTO Especie (NombreEsp)
        VALUES (@NombreEsp);

        SELECT 'Especie registrada correctamente: ' + @NombreEsp AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH

       
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_VISITANTE', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_VISITANTE;
GO
CREATE PROCEDURE SP_INGRESAR_VISITANTE(
	@IdVisitantes int,
    @NombreVist VARCHAR(20),
    @Apell1Vist VARCHAR(20),
    @Apell2Vist VARCHAR(20),
    @Correo VARCHAR(50),
    @TELEFONO INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreVist = '' OR @Apell1Vist = '' OR @Apell2Vist = '' OR @Correo = '' OR @TELEFONO IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

        IF EXISTS (SELECT 1 FROM Visitantes WHERE IdVisitantes = @IdVisitantes)
        BEGIN
            RAISERROR ('El visitante ya existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END


        INSERT INTO Visitantes (IdVisitantes, nombreVist, apell1Vist, apell2Vist, CorreoElectronico, TELEFONO)
        VALUES (@IdVisitantes, @NombreVist, @Apell1Vist, @Apell2Vist, @Correo, @TELEFONO);

        COMMIT TRANSACTION;
        SELECT 'Visitante registrado correctamente: ' + @NombreVist + ' ' + @Apell1Vist + ' ' + @Apell2Vist AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_ESTADOHABITACION', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_ESTADOHABITACION;
GO
CREATE PROCEDURE SP_INGRESAR_ESTADOHABITACION(
    @Estado VARCHAR(50),
    @Cedula VARCHAR(20)
)
AS
BEGIN
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Estado = '' OR  @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
  
        
        INSERT INTO EstadoHabitacion (estado)
        VALUES (@Estado);

        COMMIT TRANSACTION;
        SELECT 'Estado de habitación registrado correctamente: ' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
END
GO

USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_PUESTO', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_PUESTO;
GO
CREATE PROCEDURE SP_INGRESAR_PUESTO(
    @Nombre VARCHAR(20),
    @Salario FLOAT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Nombre = '' OR @Salario IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF (@Salario < 0)
        BEGIN
			RAISERROR ('El salario no puede ser negativo', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM Puesto WHERE Nombre = @Nombre)
        BEGIN
            RAISERROR ('El puesto ya existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

        INSERT INTO Puesto (Nombre, Salario)
        VALUES (@Nombre, @Salario);

        COMMIT TRANSACTION;
        SELECT 'Puesto registrado correctamente: ' + @Nombre + ', Salario: ' + CAST(@Salario AS VARCHAR) + ', Descripción: ';

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

use ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_TIPOHABITACION', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_TIPOHABITACION;
GO
go
CREATE PROCEDURE SP_INGRESAR_TIPOHABITACION(
    @NombreTH VARCHAR(75),
	@Cedula VARCHAR(20)
)
AS
BEGIN
EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;
    BEGIN TRY

	

        IF (@NombreTH = '' OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

		IF (@Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM TipoHabitacion WHERE NombreTH = @NombreTH)
        BEGIN
            RAISERROR ('El tipo de habitación ya existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO TipoHabitacion (NombreTH)
        VALUES (@NombreTH);

        
        COMMIT TRANSACTION;
        SELECT 'Tipo de Habitación registrado correctamente: ' + @NombreTH AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO
USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_ZOO', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_ZOO;
GO
CREATE PROCEDURE SP_INGRESAR_ZOO(
    @NombreZoo VARCHAR(20),
    @Direccion VARCHAR(100),
    @DescripcionZoo VARCHAR(255),
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreZoo = '' OR @Direccion = '' OR @DescripcionZoo = '' OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM ZOO WHERE NombreZoo = @NombreZoo)
        BEGIN
            RAISERROR ('El zoológico ya existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        INSERT INTO ZOO (NombreZoo, Direccion, DescripcionZoo)
        VALUES (@NombreZoo, @Direccion, @DescripcionZoo);

        COMMIT TRANSACTION;
        SELECT 'Zoológico registrado correctamente: ' + @NombreZoo AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO


GO

USE ZooMA
GO
DROP PROC IF EXISTS SP_CREAR_CALIFICACION_VISITA
GO
CREATE PROC SP_CREAR_CALIFICACION_VISITA 
@NotaRecorrido INT,
@IdVentaEntrada INT,
@SugerenciaMejoraRecorrido VARCHAR(200),
@NotaServicioAlCliente INT,
@SugerenciaMejoraServicioAlCliente VARCHAR(200),
@Cedula VARCHAR(25)
AS

BEGIN
BEGIN TRANSACTION
BEGIN TRY
EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
	IF(@NotaRecorrido IS NULL OR @NotaServicioAlCliente IS NULL OR @IdVentaEntrada IS NULL OR @SugerenciaMejoraRecorrido = '' OR @SugerenciaMejoraServicioAlCliente = '')
        BEGIN
        RAISERROR('No se permiten campos en blanco',16,1)
        END


        IF NOT EXISTS(SELECT 1 FROM VentaEntrada WHERE IdVentaEntrada = @IdVentaEntrada)
        BEGIN
        RAISERROR('La venta no existe',16,1)
		RETURN
        END

        IF EXISTS(SELECT 1 FROM CalificacionVisita WHERE IdVentaEntrada = @IdVentaEntrada)
        BEGIN
        RAISERROR('La calificacion asociada a esta venta ya existe',16,1)
		RETURN
        END
		
        DECLARE @IdCalificacionRecorrido INT, @IdCalificacionServicio INT

        INSERT INTO CalificacionRecorrido(Nota, SugerenciaMejora)
        VALUES(@NotaRecorrido, @SugerenciaMejoraRecorrido)

        SET @IdCalificacionRecorrido = SCOPE_IDENTITY()

        INSERT INTO CalificacionServicioAlCliente(Nota, SugerenciaMejora)
        VALUES(@NotaServicioAlCliente, @SugerenciaMejoraServicioAlCliente)

        SET @IdCalificacionServicio = SCOPE_IDENTITY()



        INSERT INTO CalificacionVisita(Fecha, IdVentaEntrada,IdCalificacionServicioAlCliente, IdCalificacionRecorrido)
        VALUES(GETDATE(),@IdVentaEntrada,@IdCalificacionServicio, @IdCalificacionRecorrido)

COMMIT TRANSACTION
PRINT('Calificación creada exitosamente')

END TRY


BEGIN CATCH

ROLLBACK TRANSACTION
DECLARE @ERROR VARCHAR(100)
SET @ERROR = ERROR_MESSAGE()
RAISERROR(@ERROR,16,1)

END CATCH
END

GO

USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_TIPO_ENTRADA', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_TIPO_ENTRADA;
GO
CREATE PROCEDURE SP_INGRESAR_TIPO_ENTRADA(
    @NombreEnt VARCHAR(20),
    @Precio MONEY,
    @Cedula VARCHAR(20)
)
AS
BEGIN
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreEnt = '' OR @Precio IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM TipoEntrada WHERE nombreEnt = @NombreEnt)
        BEGIN
            RAISERROR ('El tipo de entrada ya existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO TipoEntrada (nombreEnt, Precio)
        VALUES (@NombreEnt, @Precio);

        COMMIT TRANSACTION;
        SELECT 'Tipo de entrada registrado correctamente. Nombre: ' + @NombreEnt
              + ', Precio: ' + CAST(@Precio AS VARCHAR) AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_ROL', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_ROL;
GO
CREATE PROCEDURE SP_INGRESAR_ROL(
    @nombre VARCHAR(20),
    @Cedula VARCHAR(20)
)
AS
BEGIN
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@nombre = '' OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM Rol WHERE nombre = @nombre)
        BEGIN
            RAISERROR ('El rol ya existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Rol (nombre)
        VALUES (@nombre);
        COMMIT TRANSACTION;
        SELECT 'Rol registrado correctamente: ' + @nombre AS 'Mensaje de Confirmación';
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_USUARIO_ROL', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_USUARIO_ROL;
GO
CREATE PROCEDURE SP_INGRESAR_USUARIO_ROL(
	@IdUsuario INT,
    @Contraseña VARCHAR(255),
    @IdRol INT,
	@Estado BIT = 1,
    @Cedula VARCHAR(20)
)
AS
BEGIN

EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Contraseña = ''  OR @IdRol IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @IdUsuario)
        BEGIN
            RAISERROR ('El empleado no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Rol WHERE IdRol = @IdRol)
        BEGIN
            RAISERROR ('El rol no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

		IF EXISTS (SELECT 1 FROM RolUsario WHERE IdUsuario = @IdUsuario AND IdRol = @IdRol)
        BEGIN
            RAISERROR ('El usuario ya tiene este rol asignado', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Usuario (IdUsuario, Contraseña, Estado)
        VALUES (@IdUsuario, @Contraseña, @Estado);

     
       

        INSERT INTO RolUsario (IdUsuario, IdRol)
        VALUES (@IdUsuario, @IdRol);
        
        COMMIT TRANSACTION;
        SELECT 'Usuario registrado y rol asignado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END
GO

USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_VENTA_ENTRADA', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_VENTA_ENTRADA;
GO
CREATE PROCEDURE SP_INGRESAR_VENTA_ENTRADA (
    @fechaventa DATE,
    @IdVisitantes INT,
    @IdMetodoPago INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@fechaventa IS NULL OR @IdVisitantes IS NULL OR @IdMetodoPago IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM ZOO WHERE IdZoo = 1)
        BEGIN
            RAISERROR ('El zoológico no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Visitantes WHERE IdVisitantes = @IdVisitantes)
        BEGIN
            RAISERROR ('El visitante no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM MetodoPago WHERE IdMetodoPago = @IdMetodoPago)
        BEGIN
            RAISERROR ('El método de pago no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO VentaEntrada (fechaventa, IdVisitantes, IdMetodoPago)
        VALUES (@fechaventa, @IdVisitantes, @IdMetodoPago);
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
         SELECT 'Venta de entrada registrada correctamente para la fecha ' + CONVERT(VARCHAR(10), @fechaventa);
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO



USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_ENTRADA', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_ENTRADA;
GO
CREATE PROCEDURE SP_INGRESAR_ENTRADA (
    @fechaVencimiento DATE,
    @descuento INT,
    @IdTipoEntrada INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@fechaVencimiento IS NULL OR @descuento IS NULL OR @IdTipoEntrada IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM TipoEntrada WHERE IdTipoEntrada = @idTipoEntrada)
        BEGIN
            RAISERROR ('El tipo entrada no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF  (@fechaVencimiento < GETDATE())
        BEGIN
            RAISERROR ('La de vencimiento no puede ser en el pasado', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        

        INSERT INTO Entrada (fechaVencimiento, descuento, IdTipoEntrada)
        VALUES (@fechaVencimiento, @descuento, @IdTipoEntrada);
        COMMIT TRANSACTION;
         SELECT 'Entrada registrada correctamente para la fecha ';
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(100);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

IF OBJECT_ID('SP_ACTUALIZAR_HABITACION', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_HABITACION;
GO

CREATE PROCEDURE SP_ACTUALIZAR_HABITACION(
    @IdHabitacion INT,
    @NombreHab VARCHAR(20),
    @Direccion VARCHAR(255),
    @Capacidad INT,
    @IdTipoHabitacion INT,
    @IdEstadoHabitacion INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;
    
    BEGIN TRY
        -- Validación de campos vacíos
        IF (@NombreHab = '' AND @Direccion = '' AND @Capacidad = '' AND @IdTipoHabitacion IS NULL AND @IdEstadoHabitacion IS NULL)
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF ( @Cedula = '' OR @IdHabitacion IS NULL)
        BEGIN
            RAISERROR ('Se necesita el id de la habitacion a editar y el de la persona editora', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        -- Verificación de que la habitación exista
        IF NOT EXISTS (SELECT 1 FROM Habitacion WHERE IdHabitacion = @IdHabitacion)
        BEGIN
            RAISERROR ('La habitación no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM EstadoHabitacion WHERE IdEstadoHabitacion = @IdEstadoHabitacion)
        BEGIN
            RAISERROR ('El estado de habitación no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        -- Verificación de que el tipo de habitación exista
        IF NOT EXISTS (SELECT 1 FROM TipoHabitacion WHERE IdTipoHabitacion = @IdTipoHabitacion)
        BEGIN
            RAISERROR ('El tipo de habitación no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        -- Actualización de los datos de la habitación
        UPDATE Habitacion
        SET NombreHab = ISNULL(@NombreHab, NombreHab),
            Direccion = ISNULL(@Direccion, Direccion),              
            Capacidad = ISNULL(@Capacidad, Capacidad),
            IdEstadoHabitacion = ISNULL(@IdEstadoHabitacion,IdEstadoHabitacion),
            IdTipoHabitacion = ISNULL(@IdTipoHabitacion,IdTipoHabitacion)
        WHERE IdHabitacion = @IdHabitacion;
        
        COMMIT TRANSACTION;
        SELECT 'Habitación actualizada correctamente: ' + @NombreHab AS 'Mensaje de Confirmación';
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_ENTRADA', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_ENTRADA;
GO
CREATE PROCEDURE SP_ACTUALIZAR_ENTRADA (
    @IdEntrada INT,
    @fechaVencimiento DATE,
    @descuento INT,
    @IdTipoEntrada INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@fechaVencimiento IS NULL AND @descuento IS NULL AND @IdTipoEntrada IS NULL OR @Cedula = '' OR @IdEntrada IS NULL)
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF (@IdTipoEntrada IS NOT NULL AND NOT EXISTS (SELECT 1 FROM TipoEntrada WHERE IdTipoEntrada = @IdTipoEntrada))
        BEGIN
            RAISERROR ('El tipo entrada no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
       
       IF(@fechaVencimiento IS NOT NULL AND @fechaVencimiento < GETDATE())
        BEGIN
            RAISERROR ('La fecha de vencimiento no puede ser en el pasado', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
         

        UPDATE Entrada 
        SET fechaVencimiento = ISNULL(@fechaVencimiento, fechaVencimiento),
            descuento = ISNULL(@descuento, descuento),
            IdTipoEntrada = ISNULL(@IdTipoEntrada, IdTipoEntrada)
        WHERE IdEntrada = @IdEntrada;
        COMMIT TRANSACTION;
         SELECT 'Entrada editada correctamente ';
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(100);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO





USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_ESTADO_TAREA', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_ESTADO_TAREA;
GO
CREATE PROCEDURE SP_INGRESAR_ESTADO_TAREA (
    @Nombre VARCHAR(20),
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Nombre IS NULL OR @Nombre = '' OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO EstadoTarea (Nombre)
        VALUES (@Nombre);
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Estado de tarea registrado correctamente: ' + @Nombre AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO





USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_METODO_PAGO', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_METODO_PAGO;
GO
CREATE PROCEDURE SP_INGRESAR_METODO_PAGO (
    @Metodopago VARCHAR(20),
    @Cedula VARCHAR(20)
)
AS
BEGIN
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Metodopago IS NULL OR @Metodopago = '' OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO MetodoPago (Metodopago)
        VALUES (@Metodopago);
        COMMIT TRANSACTION;
        SELECT 'Metodo pago registrado correctamente: ';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(100);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO



USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_TIPO_TAREA', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_TIPO_TAREA;
GO
CREATE PROCEDURE SP_INGRESAR_TIPO_TAREA (
    @NombreTT VARCHAR(20),
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        IF (@NombreTT IS NULL OR @NombreTT = '' OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO TipoTarea (NombreTT)
        VALUES (@NombreTT);
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Tipo de tarea registrada correctamente: ' + @NombreTT AS 'Mensaje de Confirmación';
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_ALIMENTOS', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_ALIMENTOS;
GO
CREATE PROCEDURE SP_INGRESAR_ALIMENTOS (
    @Nombre VARCHAR(20),
    @IdUnidadMedida INT,
    @Cedula VARCHAR(20)

)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Nombre IS NULL OR @Nombre = '' OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS(SELECT 1 FROM UnidadMedida WHERE IdUnidadMedida = @IdUnidadMedida)
            BEGIN
            RAISERROR ('No existe la unidad de medida', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
            END

        INSERT INTO Alimentos (Nombre)
        VALUES (@Nombre);
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Alimento registrado correctamente: ' + @Nombre AS 'Mensaje de Confirmación';
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_CALIFICACION_SERVICIO', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_CALIFICACION_SERVICIO;
GO
CREATE PROCEDURE SP_INGRESAR_CALIFICACION_SERVICIO (
    @Nota INT,
    @SugerenciaMejora VARCHAR(255) = NULL,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

     IF ( @Cedula = '')
        BEGIN
            RAISERROR ('No se permiten espacios vacios', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF (@Nota IS NULL OR @Nota < 1 OR @Nota > 10)
        BEGIN
            RAISERROR ('La nota debe ser un valor entre 1 y 10', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO CalificacionServicioAlCliente (Nota, SugerenciaMejora)
        VALUES (@Nota, @SugerenciaMejora);
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Calificación registrada correctamente con una nota de ' + CONVERT(VARCHAR(10), @Nota) AS 'Mensaje de Confirmación';
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

USE ZooMA
GO
IF OBJECT_ID('SP_INGRESAR_CALIFICACION_RECORRIDO', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_CALIFICACION_RECORRIDO;
GO
CREATE PROCEDURE SP_INGRESAR_CALIFICACION_RECORRIDO (
    @Nota INT,
    @SugerenciaMejora VARCHAR(255) = NULL,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

    IF ( @Cedula = '')
        BEGIN
            RAISERROR ('No se permiten espacios vacios', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF (@Nota IS NULL OR @Nota < 1 OR @Nota > 10)
        BEGIN
            RAISERROR ('La nota debe ser un valor entre 1 y 10', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO CalificacionRecorrido (Nota, SugerenciaMejora)
        VALUES (@Nota, @SugerenciaMejora);
        
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Calificación de recorrido registrada correctamente con una nota de ' + CONVERT(VARCHAR(10), @Nota) AS 'Mensaje de Confirmación';
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO
--FIN SP Insert--

--Parte 8: SP Consultar tablas
--Buscar todas las habitaciones
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_HABITACIONES', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_HABITACIONES;
GO
CREATE PROCEDURE SP_BUSCAR_HABITACIONES
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        
        IF NOT EXISTS (SELECT 1 FROM Habitacion)
        BEGIN
            RAISERROR ('No hay habitaciones registradas', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT * FROM Habitacion;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Buscar Habitacion por Id
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_HABITACION_POR_ID', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_HABITACION_POR_ID;
GO
CREATE PROCEDURE SP_BUSCAR_HABITACION_POR_ID (
    @IdHabitacion INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdHabitacion IS NULL OR @IdHabitacion <= 0)
        BEGIN
            RAISERROR ('El ID de la habitación debe ser un valor positivo y no nulo', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Habitacion WHERE IdHabitacion = @IdHabitacion)
        BEGIN
            RAISERROR ('La habitación con el Id especificado no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT * FROM Habitacion WHERE IdHabitacion = @IdHabitacion;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Buscar El tipoHabitacion por Nombre
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_TIPOS_HABITACION_POR_NOMBRE', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_TIPOS_HABITACION_POR_NOMBRE;
GO
CREATE PROCEDURE SP_BUSCAR_TIPOS_HABITACION_POR_NOMBRE (
    @NombreTH VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreTH IS NULL OR @NombreTH = '')
        BEGIN
            RAISERROR ('El nombre de la habitación no puede ser nulo o vacío', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT 
			NombreTH 
		FROM 
			TipoHabitacion 
		WHERE 
			NombreTH LIKE '%' + @NombreTH + '%';

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO


--Buscar El tipoHabitacion por ID
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_TIPOS_HABITACION_POR_ID', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_TIPOS_HABITACION_POR_ID;
GO
CREATE PROCEDURE SP_BUSCAR_TIPOS_HABITACION_POR_ID (
    @idTipoHabitacion INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@idTipoHabitacion IS NULL)
        BEGIN
            RAISERROR ('El id de la habitación no puede ser nulo o vacío', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT 
			idTipoHabitacion, NombreTH 
		FROM 
			TipoHabitacion 
		WHERE 
			idTipoHabitacion = @idTipoHabitacion;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;

GO
--Buscar Dieta por nombre
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_DIETAS_POR_NOMBRE', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_DIETAS_POR_NOMBRE;
GO
CREATE PROCEDURE SP_BUSCAR_DIETAS_POR_NOMBRE (
    @NombreDiet VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreDiet IS NULL OR @NombreDiet = '')
        BEGIN
            RAISERROR ('El nombre de la dieta no puede ser nulo o vacío', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT  
            NombreDiet
        FROM 
            Dieta 
        WHERE 
            NombreDiet LIKE '%' + @NombreDiet + '%';

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO


--Buscar visitante por Id o nombre

USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_VISITANTES_POR_ID_O_NOMBRE', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_VISITANTES_POR_ID_O_NOMBRE;
GO
CREATE PROCEDURE SP_BUSCAR_VISITANTES_POR_ID_O_NOMBRE (
    @IdVisitantes INT = NULL,
    @NombreVist VARCHAR(20) = NULL,
    @Apellido1Vist VARCHAR(20) = NULL,
    @Apellido2Vist VARCHAR(20) = NULL,
    @Correo VARCHAR(50) = NULL,
    @Telefono INT = NULL
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdVisitantes IS NULL AND 
            (@NombreVist IS NULL OR @NombreVist = '') AND 
            (@Apellido1Vist IS NULL OR @Apellido1Vist = '') AND 
            (@Apellido2Vist IS NULL OR @Apellido2Vist = '') AND 
            (@Correo IS NULL OR @Correo = '') AND
            (@Telefono IS NULL)
        )
        BEGIN
            RAISERROR ('Debes proporcionar un ID de visitante o al menos un nombre, apellidos, correo o teléfono', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT 
            IdVisitantes , 
            NombreVist ,
            Apell1Vist ,
            Apell2Vist ,
            CorreoElectronico,
            TELEFONO
        FROM 
            Visitantes 
        WHERE 
            (@IdVisitantes IS NULL OR IdVisitantes = @IdVisitantes) AND
            (@NombreVist IS NULL OR NombreVist LIKE '%' + @NombreVist + '%') AND
            (@Apellido1Vist IS NULL OR Apell1Vist LIKE '%' + @Apellido1Vist + '%') AND
            (@Apellido2Vist IS NULL OR Apell2Vist LIKE '%' + @Apellido2Vist + '%') AND
            (@Correo IS NULL OR @Correo LIKE '%' + @Correo + '%') AND
            (@Telefono IS NULL OR TELEFONO = @Telefono)

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Buscar especie por Nombre
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_ESPECIES_POR_NOMBRE', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_ESPECIES_POR_NOMBRE;
GO
CREATE PROCEDURE SP_BUSCAR_ESPECIES_POR_NOMBRE (
    @NombreEsp VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreEsp IS NULL OR @NombreEsp = '')
        BEGIN
            RAISERROR ('El nombre de la especie no puede ser nulo o vacío', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT 
            NombreEsp 
        FROM 
            Especies 
        WHERE 
            NombreEsp LIKE '%' + @NombreEsp + '%';

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Buscar Animal por Nombre, Especie, Habitación o estado salud
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_ANIMALES_POR_NOMBRE', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_ANIMALES_POR_NOMBRE;
GO
CREATE PROCEDURE SP_BUSCAR_ANIMALES_POR_NOMBRE (
    @NombreAnimal VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreAnimal IS NULL OR LTRIM(RTRIM(@NombreAnimal)) = '')
        BEGIN
            RAISERROR ('El nombre del animal no puede estar vacío o nulo', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Animales WHERE NombreAni = @NombreAnimal)
        BEGIN
            RAISERROR ('No existe ningún animal con el nombre especificado', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT 
            A.NombreAni, 
            E.NombreEsp, 
            H.NombreHab , 
            ES.estadoSalud 
        FROM Animales A
        INNER JOIN Especies E ON A.IdEspecie = E.IdEspecie
        INNER JOIN Habitacion H ON A.IdHabitacion = H.IdHabitacion
        INNER JOIN EstadoSalud ES ON A.IdEstadoSalud = ES.IdEstadoSalud
        WHERE A.NombreAni = @NombreAnimal;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Buscar todos los animales


USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_ANIMALES', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_ANIMALES;
GO
CREATE PROCEDURE SP_BUSCAR_ANIMALES
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF NOT EXISTS (SELECT 1 FROM Animales)
        BEGIN
            RAISERROR ('No hay animales registrados', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT * FROM Animales;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Buscar Zoo por Nombre o Id
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_ZOO_POR_ID', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_ZOO_POR_ID;
GO
CREATE PROCEDURE SP_BUSCAR_ZOO_POR_ID (
    @IdZoo INT = NULL
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdZoo IS NULL)
        BEGIN
            RAISERROR ('Debes proporcionar un ID de zoológico', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT 
            IdZoo, 
            NombreZoo,
			Direccion,
			DescripcionZoo
        FROM 
            ZOO
        WHERE 
            (@IdZoo IS NULL OR IdZoo = @IdZoo)

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;

GO
--Buscar EstadoHabitación por Id
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_ESTADO_HABITACION_POR_ID', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_ESTADO_HABITACION_POR_ID;
GO
CREATE PROCEDURE SP_BUSCAR_ESTADO_HABITACION_POR_ID (
    @IdEstadoHabitacion INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdEstadoHabitacion IS NULL OR @IdEstadoHabitacion <= 0)
        BEGIN
            RAISERROR ('El ID del estado de habitación debe ser un valor positivo y no nulo', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM EstadoHabitacion WHERE IdEstadoHabitacion = @IdEstadoHabitacion)
        BEGIN
            RAISERROR ('El estado de habitación con el Id especificado no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT * FROM EstadoHabitacion WHERE IdEstadoHabitacion = @IdEstadoHabitacion;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Buscar puesto por nombre
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_PUESTO_POR_NOMBRE', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_PUESTO_POR_NOMBRE;
GO
CREATE PROCEDURE SP_BUSCAR_PUESTO_POR_NOMBRE (
    @NombrePuesto VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombrePuesto IS NULL OR LTRIM(RTRIM(@NombrePuesto)) = '')
        BEGIN
            RAISERROR ('El nombre del puesto no puede ser nulo o vacío', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT 
            IdPuesto,
            Nombre,
            Salario
        FROM 
            Puesto 
        WHERE 
            Nombre LIKE '%' + @NombrePuesto + '%';

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;

GO
--Buscar puesto por id
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_PUESTO_POR_ID', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_PUESTO_POR_ID;
GO
CREATE PROCEDURE SP_BUSCAR_PUESTO_POR_ID (
    @IdPuesto INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdPuesto IS NULL OR @IdPuesto <= 0)
        BEGIN
            RAISERROR ('El ID del puesto tiene que ser positivo', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT 
            IdPuesto,
            Nombre,
            Salario
        FROM 
            Puesto 
        WHERE 
            IdPuesto = @IdPuesto;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;

GO
--Buscar especie por ID
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_ESPECIE_POR_ID', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_ESPECIE_POR_ID;
GO
CREATE PROCEDURE SP_BUSCAR_ESPECIE_POR_ID (
    @IdEspecie INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdEspecie IS NULL OR @IdEspecie <= 0)
        BEGIN
            RAISERROR ('El ID de la especie debe ser un valor positivo y no nulo', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Especies WHERE IdEspecie = @IdEspecie)
        BEGIN
            RAISERROR ('La especie con el Id especificado no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT * FROM Especies WHERE IdEspecie = @IdEspecie;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Buscar TipoEntrada por ID
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_TIPOENTRADA_POR_ID', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_TIPOENTRADA_POR_ID;
GO
CREATE PROCEDURE SP_BUSCAR_TIPOENTRADA_POR_ID (
    @IdTipoEntrada INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdTipoEntrada IS NULL OR @IdTipoEntrada <= 0)
        BEGIN
            RAISERROR ('El ID del tipo de entrada debe ser un valor positivo y no nulo', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM TipoEntrada WHERE IdTipoEntrada = @IdTipoEntrada)
        BEGIN
            RAISERROR ('El tipo de entrada con el Id especificado no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT * FROM TipoEntrada WHERE IdTipoEntrada = @IdTipoEntrada;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Buscar Alimentos por Id o Nombre
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_ALIMENTOS_POR_ID_O_NOMBRE', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_ALIMENTOS_POR_ID_O_NOMBRE;
GO
CREATE PROCEDURE SP_BUSCAR_ALIMENTOS_POR_ID_O_NOMBRE (
    @IdAlimentos INT = NULL,
    @Nombre VARCHAR(20) = NULL
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdAlimentos IS NULL AND 
            (@Nombre IS NULL OR @Nombre = ''))
        BEGIN
            RAISERROR ('Debes proporcionar un ID de alimento o al menos un nombre', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT 
            IdAlimentos, 
            Nombre
        FROM 
            Alimentos 
        WHERE 
            (@IdAlimentos IS NULL OR IdAlimentos = @IdAlimentos) AND
            (@Nombre IS NULL OR Nombre LIKE '%' + @Nombre + '%')

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Buscar Tarea por Id o Nombre
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_TAREAS', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_TAREAS;
GO
CREATE PROCEDURE SP_BUSCAR_TAREAS (
    @IdTareas INT = NULL,
    @Nombre VARCHAR(20) = NULL,
    @IdEmpleado INT = NULL,
    @IdTipoTarea INT = NULL
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdTareas IS NULL AND 
            (@Nombre IS NULL OR @Nombre = '') AND 
            @IdEmpleado IS NULL AND 
            @IdTipoTarea IS NULL)
        BEGIN
            RAISERROR ('Debes proporcionar un ID de tarea, un nombre, un ID de empleado o un ID de tipo de tarea', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT 
            IdTareas, 
            IdEmpleado,
            IdTipoTarea
        FROM 
            Tareas 
        WHERE 
            (@IdTareas IS NULL OR IdTareas = @IdTareas) AND
            (@IdEmpleado IS NULL OR IdEmpleado = @IdEmpleado) AND
            (@IdTipoTarea IS NULL OR IdTipoTarea = @IdTipoTarea)

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Buscar Clificaión del recorrido por Id
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_CALIFICACION_RECORRIDO_POR_ID', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_CALIFICACION_RECORRIDO_POR_ID;
GO
CREATE PROCEDURE SP_BUSCAR_CALIFICACION_RECORRIDO_POR_ID (
    @IdCalificacionRecorrido INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdCalificacionRecorrido IS NULL OR @IdCalificacionRecorrido <= 0)
        BEGIN
            RAISERROR ('El ID de la calificación de recorrido debe ser un valor positivo y no nulo', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM CalificacionRecorrido WHERE IdCalificacionRecorrido = @IdCalificacionRecorrido)
        BEGIN
            RAISERROR ('La calificación de recorrido con el ID especificado no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT * FROM CalificacionRecorrido WHERE IdCalificacionRecorrido = @IdCalificacionRecorrido;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Buscar Calificacion del servicio al cliente por Id
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_CALIFICACION_SERVICIO_AL_CLIENTE_POR_ID', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_CALIFICACION_SERVICIO_AL_CLIENTE_POR_ID;
GO
CREATE PROCEDURE SP_BUSCAR_CALIFICACION_SERVICIO_AL_CLIENTE_POR_ID (
    @IdCalificacionServicioAlCliente INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdCalificacionServicioAlCliente IS NULL OR @IdCalificacionServicioAlCliente <= 0)
        BEGIN
            RAISERROR ('El ID de la calificación de servicio al cliente debe ser un valor positivo y no nulo', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM CalificacionServicioAlCliente WHERE IdCalificacionServicioAlCliente = @IdCalificacionServicioAlCliente)
        BEGIN
            RAISERROR ('La calificación de servicio al cliente con el ID especificado no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT * FROM CalificacionServicioAlCliente WHERE IdCalificacionServicioAlCliente = @IdCalificacionServicioAlCliente;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Buscar Calificacion de la visita por Id
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_CALIFICACION_VISITA_POR_ID', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_CALIFICACION_VISITA_POR_ID;
GO
CREATE PROCEDURE SP_BUSCAR_CALIFICACION_VISITA_POR_ID (
    @IdCalificacionVisita INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdCalificacionVisita IS NULL OR @IdCalificacionVisita <= 0)
        BEGIN
            RAISERROR ('El ID de la calificación de visita debe ser un valor positivo y no nulo', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM CalificacionVisita WHERE IdCalificacionVisita = @IdCalificacionVisita)
        BEGIN
            RAISERROR ('La calificación de visita con el ID especificado no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT * FROM CalificacionVisita WHERE IdCalificacionVisita = @IdCalificacionVisita;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--FIN SP Consultar tablas--

--parte 9: SP Actualizar
USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_EstadoSalud', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_EstadoSalud;
GO
CREATE PROCEDURE SP_ACTUALIZAR_EstadoSalud (
    @IdEstadoSalud INT,
    @EstadoSalud VARCHAR(255),
    @Cedula VARCHAR(20)

)
AS
BEGIN
    IF(@IdEstadoSalud IS NULL OR @IdEstadoSalud = 0 OR @EstadoSalud = '' OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM EstadoSalud WHERE IdEstadoSalud = @IdEstadoSalud)
    BEGIN
        RAISERROR ('El estado de salud no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE EstadoSalud
        SET estadoSalud = @EstadoSalud
        WHERE IdEstadoSalud = @IdEstadoSalud;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del estado de salud actualizado correctamente'  AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO


USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_EstadoHabitacion', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_EstadoHabitacion;
GO
CREATE PROCEDURE SP_ACTUALIZAR_EstadoHabitacion (
    @IdEstadoHabitacion INT,
    @Estado VARCHAR(255),
    @Cedula VARCHAR(20)

)
AS
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
BEGIN
    IF(@IdEstadoHabitacion IS NULL OR @IdEstadoHabitacion = 0 OR @Estado = '' OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM EstadoHabitacion WHERE IdEstadoHabitacion = @IdEstadoHabitacion)
    BEGIN
        RAISERROR ('El estado de habitacion no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE EstadoHabitacion
        SET Estado = @Estado
        WHERE IdEstadoHabitacion = @IdEstadoHabitacion;
        COMMIT TRANSACTION;

        SELECT 'Registro del estado de salud actualizado correctamente'  AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO


--parte 9: SP Actualizar
USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_METODO_PAGO', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_METODO_PAGO;
GO
CREATE PROCEDURE SP_ACTUALIZAR_METODO_PAGO (
    @IdMetodoPago INT,
    @Metodopago VARCHAR(50),
    @Cedula VARCHAR(20)

)
AS
BEGIN
    IF(@IdMetodoPago IS NULL OR @IdMetodoPago = 0 OR @metodoPago = '' OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM MetodoPago WHERE IdMetodoPago = @IdMetodoPago)
    BEGIN
        RAISERROR ('El metodo de pago no existe', 16, 1);
        RETURN;
    END

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE MetodoPago
        SET Metodopago = @Metodopago
        WHERE IdMetodoPago = @IdMetodoPago;
        COMMIT TRANSACTION;

        SELECT 'Registro de metodo de pago actualizado correctamente'  AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(100) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_Especie', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_Especie;
GO
CREATE PROCEDURE SP_ACTUALIZAR_Especie (
    @IdEspecie INT,
    @NombreEsp VARCHAR(20),
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF(@IdEspecie IS NULL OR @IdEspecie = 0 OR @NombreEsp = '' OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Especies WHERE IdEspecie = @IdEspecie)
    BEGIN
        RAISERROR ('La especie no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE Especies
        SET NombreEsp = @NombreEsp
        WHERE IdEspecie = @IdEspecie;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro de la especie actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_Dieta', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_Dieta;
GO
CREATE PROCEDURE SP_ACTUALIZAR_Dieta (
    @IdDieta INT,
    @NombreDiet VARCHAR(20),
    @Cedula VARCHAR(20)
)
AS
BEGIN
    IF(@IdDieta IS NULL OR @IdDieta = 0 OR @NombreDiet = '' )
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Dieta WHERE IdDieta = @IdDieta OR @Cedula = '')
    BEGIN
        RAISERROR ('La dieta no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE Dieta
        SET NombreDiet = @NombreDiet
        WHERE IdDieta = @IdDieta;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro de la dieta actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;
GO


use ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_TIPOHABITACION', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_TIPOHABITACION;
GO
CREATE PROCEDURE SP_ACTUALIZAR_TIPOHABITACION (
    @IdTipoHabitacion INT,
    @NombreTH VARCHAR(20),
	@Cedula VARCHAR(20)
)
AS
BEGIN
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
	

    IF (@IdTipoHabitacion IS NULL OR @IdTipoHabitacion = 0 OR @NombreTH = '' OR @NombreTH = '' OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM TipoHabitacion WHERE IdTipoHabitacion = @IdTipoHabitacion)
    BEGIN
        RAISERROR ('El tipo de habitación no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE TipoHabitacion
        SET NombreTH = @NombreTH
        WHERE IdTipoHabitacion = @IdTipoHabitacion;
        COMMIT TRANSACTION;

        SELECT 'Registro del tipo de habitación actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;

GO

USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_Zoo', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_Zoo;
GO
CREATE PROCEDURE SP_ACTUALIZAR_Zoo (
    @IdZoo INT,
    @NombreZoo VARCHAR(20),
    @Direccion VARCHAR(100),
    @DescripcionZoo VARCHAR(255),
    @Cedula VARCHAR(20)
)
AS
BEGIN

 IF(@IdZoo IS NULL  OR @Cedula = '')
    BEGIN
        RAISERROR ('Se mecesita el id del zoo a editar y la cedula de la persona que realiza la acción', 16, 1);
        RETURN;
    END

    IF( @NombreZoo = '' AND @Direccion = '' AND @DescripcionZoo = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM ZOO WHERE IdZoo = @IdZoo)
    BEGIN
        RAISERROR ('El zoo no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        UPDATE ZOO
        SET NombreZoo = ISNULL(@NombreZoo, NombreZoo),
            Direccion = ISNULL(@Direccion, Direccion),
            DescripcionZoo = ISNULL(@DescripcionZoo, DescripcionZoo)
        WHERE IdZoo = @IdZoo;
        COMMIT TRANSACTION;

        SELECT 'Registro del zoo actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_Zoo', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_Zoo;
GO
CREATE PROCEDURE SP_ACTUALIZAR_Zoo (
    @IdZoo INT,
    @NombreZoo VARCHAR(20),
    @Direccion VARCHAR(100),
    @DescripcionZoo VARCHAR(255),
    @Cedula VARCHAR(20)
)
AS
BEGIN

 IF(@IdZoo IS NULL OR  @Cedula = '')
    BEGIN
        RAISERROR ('Se mecesita el id del zoo a editar y la cedula de la persona que realiza la acción', 16, 1);
        RETURN;
    END

    IF( @NombreZoo = '' AND @Direccion = '' AND @DescripcionZoo = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM ZOO WHERE IdZoo = @IdZoo)
    BEGIN
        RAISERROR ('El zoo no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE ZOO
        SET NombreZoo = ISNULL(@NombreZoo, NombreZoo),
            Direccion = ISNULL(@Direccion, Direccion),
            DescripcionZoo = ISNULL(@DescripcionZoo, DescripcionZoo)
        WHERE IdZoo = @IdZoo;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del zoo actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;
GO

USE ZooMA
GO

IF OBJECT_ID('SP_ACTUALIZAR_Visitante', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_Visitante;
GO

CREATE PROCEDURE SP_ACTUALIZAR_Visitante (
    @IdVisitantes INT,
    @NombreVist VARCHAR(20),
    @Apell1Vist VARCHAR(20),
    @Apell2Vist VARCHAR(20),
    @Correo VARCHAR(50),
    @Telefono INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF(@IdVisitantes IS NULL OR @IdVisitantes = 0 OR @NombreVist = '' OR @Apell1Vist = '' OR @Apell2Vist = ''  OR @Correo = '' OR @Telefono IS NULL OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco o valores nulos', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Visitantes WHERE IdVisitantes = @IdVisitantes)
    BEGIN
        RAISERROR ('El visitante no existe', 16, 1);
        RETURN;
    END

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Visitantes
        SET NombreVist = @NombreVist,
            Apell1Vist = @Apell1Vist,
            Apell2Vist = @Apell2Vist,
            CorreoElectronico = @Correo,
            TELEFONO = @Telefono
        WHERE IdVisitantes = @IdVisitantes;
        COMMIT TRANSACTION;

        SELECT 'Registro del visitante actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);

    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_EDITAR_Animales', 'P') IS NOT NULL
   DROP PROCEDURE SP_EDITAR_Animales;
GO
CREATE PROCEDURE SP_EDITAR_Animales (
    @IdAnimal INT,
    @NombreAni VARCHAR(20),
    @EdadAni INT,
    @IdDieta INT,
    @IdHabitacion INT,
    @IdEspecie INT,
    @IdEstadoSalud INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF(@IdAnimal IS NULL OR @NombreAni = '' OR @EdadAni IS NULL OR @IdDieta IS NULL OR 
           @IdHabitacion IS NULL OR @IdEspecie IS NULL OR @IdEstadoSalud IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Animales WHERE IdAnimales = @IdAnimal)
        BEGIN
            RAISERROR ('El animal no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE Animales
        SET NombreAni = @NombreAni,
            EdadAni = @EdadAni,
            IdDieta = @IdDieta,
            IdHabitacion = @IdHabitacion,
            IdEspecie = @IdEspecie,
            IdEstadoSalud = @IdEstadoSalud
        WHERE IdAnimales = @IdAnimal;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Datos del animal actualizados correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_EDITAR_ESTADOHABITACION', 'P') IS NOT NULL
   DROP PROCEDURE SP_EDITAR_ESTADOHABITACION;
GO
CREATE PROCEDURE SP_EDITAR_ESTADOHABITACION (
    @IdEstadoHabitacion INT,
    @Estado VARCHAR(50),
    @Descripcion VARCHAR(255),
    @Fecha DATE,
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF (@IdEstadoHabitacion IS NULL OR @IdEstadoHabitacion = 0 OR @Estado = '' OR @Descripcion = '' OR @Fecha IS NULL OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM EstadoHabitacion WHERE IdEstadoHabitacion = @IdEstadoHabitacion)
    BEGIN
        RAISERROR ('El estado de habitación no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE EstadoHabitacion
        SET estado = @Estado
        WHERE IdEstadoHabitacion = @IdEstadoHabitacion;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del estado de la habitación actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_PUESTO', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_PUESTO;
GO
CREATE PROCEDURE SP_ACTUALIZAR_PUESTO (
    @IdPuesto INT,
    @Nombre VARCHAR(20),
    @Salario FLOAT,
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF ( @Nombre = '' AND @Salario IS NULL)
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF (@IdPuesto IS NULL OR @IdPuesto = 0 OR @Cedula = '')
    BEGIN
        RAISERROR ('Se necesita el id del puesto y de la persona editora', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Puesto WHERE IdPuesto = @IdPuesto)
    BEGIN
        RAISERROR ('El puesto no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

        UPDATE Puesto
        SET Nombre = ISNULL(@Nombre, Nombre),
            Salario = ISNULL(@Salario, Salario)
        WHERE IdPuesto = @IdPuesto;
        COMMIT TRANSACTION;

        SELECT 'Registro del puesto actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
		
        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_Empleado', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_Empleado;
GO
CREATE PROCEDURE SP_ACTUALIZAR_Empleado (
    @IdEmpleado INT,
    @Nombre VARCHAR(20),
    @Apellido1 VARCHAR(20),
    @Apellido2 VARCHAR(20),
	@Correo VARCHAR (50),
    @IdPuesto INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    IF(@IdEmpleado IS NULL OR @IdEmpleado = 0 OR @Nombre = '' OR @Apellido1 = '' OR @Apellido2 = '' OR @Correo = '' OR @IdPuesto IS NULL OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @IdEmpleado)
    BEGIN
        RAISERROR ('El empleado no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE Empleado
        SET Nombre = @Nombre,
            Apellido1 = @Apellido1,
            Apellido2 = @Apellido2,
			Correo = @Correo,
            IdPuesto = @IdPuesto
        WHERE IdEmpleado = @IdEmpleado;

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del empleado actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_Tareas', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_Tareas;
GO
CREATE PROCEDURE SP_ACTUALIZAR_Tareas (
    @IdTareas INT,
    @Nombre VARCHAR(20),
    @IdEmpleado INT,
    @IdTipoTarea INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    IF (@IdTareas IS NULL OR @IdTareas = 0 OR @Nombre = '' OR @IdEmpleado IS NULL OR @IdTipoTarea IS NULL OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Tareas WHERE IdTareas = @IdTareas)
    BEGIN
        RAISERROR ('La tarea no existe', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @IdEmpleado)
    BEGIN
        RAISERROR ('El empleado no existe', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM TipoTarea WHERE IdTipoTarea = @IdTipoTarea)
    BEGIN
        RAISERROR ('El tipo de tarea no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Tareas
        SET 
            IdEmpleado = @IdEmpleado,
            IdTipoTarea = @IdTipoTarea
        WHERE IdTareas = @IdTareas;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro de la tarea actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_Usuario', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_Usuario;
GO
CREATE PROCEDURE SP_ACTUALIZAR_Usuario (
    @IdUsuario INT,
    @Contraseña VARCHAR(20),
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF(@IdUsuario IS NULL OR @IdUsuario = 0 OR @Contraseña = ''  OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE IdUsuario = @IdUsuario)
    BEGIN
        RAISERROR ('El usuario no existe', 16, 1);
        RETURN;
    END
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Usuario
        SET Contraseña = @Contraseña
        WHERE IdUsuario = @IdUsuario;
        COMMIT TRANSACTION;

        SELECT 'Registro del usuario actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;
GO


USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_Rol', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_Rol;
GO
CREATE PROCEDURE SP_ACTUALIZAR_Rol (
    @IdRol INT,
    @nombre VARCHAR(20),
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF(@IdRol IS NULL OR @IdRol = 0 OR @nombre = '' OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Rol WHERE IdRol = @IdRol)
    BEGIN
        RAISERROR ('El rol no existe', 16, 1);
        RETURN;
    END

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Rol
        SET nombre = @nombre
        WHERE IdRol = @IdRol;
        COMMIT TRANSACTION;

        SELECT 'Registro del rol actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_TipoEntrada', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_TipoEntrada;
GO
CREATE PROCEDURE SP_ACTUALIZAR_TipoEntrada (
    @IdTipoEntrada INT,
    @nombreEnt VARCHAR(20),
    @Precio MONEY,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    IF(@IdTipoEntrada IS NULL OR @IdTipoEntrada = 0 OR @nombreEnt = ''  OR @Precio IS NULL OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM TipoEntrada WHERE IdTipoEntrada = @IdTipoEntrada)
    BEGIN
        RAISERROR ('El tipo de entrada no existe', 16, 1);
        RETURN;
    END
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE TipoEntrada
        SET nombreEnt = @nombreEnt,
            Precio = @Precio
        WHERE IdTipoEntrada = @IdTipoEntrada;
        COMMIT TRANSACTION;

        SELECT 'Registro del tipo de entrada actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(100) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_Alimentos', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_Alimentos;
GO
CREATE PROCEDURE SP_ACTUALIZAR_Alimentos (
    @IdAlimentos INT,
    @Nombre VARCHAR(20),
    @Cedula VARCHAR(20)
)
AS
BEGIN
    IF(@IdAlimentos IS NULL OR @IdAlimentos = 0 OR @Nombre = '' OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Alimentos WHERE IdAlimentos = @IdAlimentos)
    BEGIN
        RAISERROR ('El alimento no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Alimentos
        SET Nombre = @Nombre
        WHERE IdAlimentos = @IdAlimentos;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del alimento actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_EstadoTarea', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_EstadoTarea;
GO
CREATE PROCEDURE SP_ACTUALIZAR_EstadoTarea (
    @IdEstadoTarea INT,
    @Nombre VARCHAR(20),
    @Cedula VARCHAR(20)
)
AS
BEGIN
    IF(@IdEstadoTarea IS NULL OR @IdEstadoTarea = 0 OR @Nombre = '' OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM EstadoTarea WHERE IdEstadoTarea = @IdEstadoTarea)
    BEGIN
        RAISERROR ('El estado de tarea no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE EstadoTarea
        SET Nombre = @Nombre
        WHERE IdEstadoTarea = @IdEstadoTarea;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del estado de tarea actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_TipoTarea', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_TipoTarea;
GO
CREATE PROCEDURE SP_ACTUALIZAR_TipoTarea (
    @IdTipoTarea INT,
    @NombreTT VARCHAR(20),
    @Cedula VARCHAR(20)
)
AS
BEGIN
    IF(@IdTipoTarea IS NULL OR @IdTipoTarea = 0 OR @NombreTT = '' OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM TipoTarea WHERE IdTipoTarea = @IdTipoTarea)
    BEGIN
        RAISERROR ('El tipo de tarea no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE TipoTarea
        SET NombreTT = @NombreTT
        WHERE IdTipoTarea = @IdTipoTarea;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del tipo de tarea actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Parte 10: SP Eliminar
USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_EstadoSalud', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_EstadoSalud;
GO
CREATE PROCEDURE SP_ELIMINAR_EstadoSalud (
    @IdEstadoSalud INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF(@IdEstadoSalud IS NULL OR @IdEstadoSalud = 0)
    BEGIN
        RAISERROR ('El ID del estado de salud no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM EstadoSalud WHERE IdEstadoSalud = @IdEstadoSalud)
    BEGIN
        RAISERROR ('El estado de salud no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM EstadoSalud
        WHERE IdEstadoSalud = @IdEstadoSalud;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del estado de salud eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;

go

USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_ALIMENTO', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_ALIMENTO;
GO
CREATE PROCEDURE SP_ELIMINAR_ALIMENTO (
    @IdAlimentos INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF(@IdAlimentos IS NULL OR @IdAlimentos = 0)
    BEGIN
        RAISERROR ('El ID del alimento no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Alimentos WHERE IdAlimentos = @IdAlimentos)
    BEGIN
        RAISERROR ('El alimento no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

    BEGIN TRY

        DELETE FROM Alimentos
        WHERE IdAlimentos = @IdAlimentos;
        COMMIT TRANSACTION;

        SELECT 'Registro de alimento eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;


go

USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_Entrada', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_Entrada;
GO
CREATE PROCEDURE SP_ELIMINAR_Entrada (
    @IdEntrada INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
BEGIN TRY
 BEGIN TRANSACTION;
    IF(@IdEntrada IS NULL OR @IdEntrada = 0)
    BEGIN
        RAISERROR ('El ID del estado de salud no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Entrada WHERE IdEntrada = @IdEntrada)
    BEGIN
        RAISERROR ('La entrada no existe', 16, 1);
        RETURN;
    END

    IF EXISTS(SELECT 1 FROM DetalleVenta WHERE IdEntrada = @IdEntrada)

    BEGIN
        RAISERROR ('No se puede eliminar la entrada porque tiene ventas asociadas', 16, 1);
        RETURN;
    END    

        DELETE FROM Entrada
        WHERE IdEntrada = @IdEntrada;
        COMMIT TRANSACTION;

        SELECT 'Registro del estado de salud eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(100) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;



go



--Parte 10: SP Eliminar
USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_METODO_PAGO', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_METODO_PAGO;
GO
CREATE PROCEDURE SP_ELIMINAR_METODO_PAGO (
    @IdMetodoPago INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF(@IdMetodoPago IS NULL OR @IdMetodoPago = 0)
    BEGIN
        RAISERROR ('El ID de metodo de pago no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM MetodoPago WHERE IdMetodoPago = @IdMetodoPago)
    BEGIN
        RAISERROR ('El estado de salud no existe', 16, 1);
        RETURN;
    END

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM MetodoPago
        WHERE IdMetodoPago = @IdMetodoPago;
        COMMIT TRANSACTION;

        SELECT 'Registro de metodo de pago eliminado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(100) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;



GO

USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_Especie', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_Especie;
GO
CREATE PROCEDURE SP_ELIMINAR_Especie (
    @IdEspecie INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF(@IdEspecie IS NULL OR @IdEspecie = 0)
    BEGIN
        RAISERROR ('El ID de la especie no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Especies WHERE IdEspecie = @IdEspecie)
    BEGIN
        RAISERROR ('La especie no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM Especies
        WHERE IdEspecie = @IdEspecie;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro de la especie eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_Dieta', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_Dieta;
GO
CREATE PROCEDURE SP_ELIMINAR_Dieta (
    @IdDieta INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    IF(@IdDieta IS NULL OR @IdDieta = 0)
    BEGIN
        RAISERROR ('El ID de la dieta no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Dieta WHERE IdDieta = @IdDieta)
    BEGIN
        RAISERROR ('La dieta no existe', 16, 1);
        RETURN;
    END

    IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM Dieta
        WHERE IdDieta = @IdDieta;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro de la dieta eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_TIPOHABITACION', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_TIPOHABITACION;
GO
CREATE PROCEDURE SP_ELIMINAR_TIPOHABITACION (
    @IdTipoHabitacion INT,
	@Cedula VARCHAR(255)
)
AS
BEGIN

	IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

    IF (@IdTipoHabitacion IS NULL OR @IdTipoHabitacion = 0)
    BEGIN
        RAISERROR ('El ID del tipo de habitación no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM TipoHabitacion WHERE IdTipoHabitacion = @IdTipoHabitacion)
    BEGIN
        RAISERROR ('El tipo de habitación no existe', 16, 1);
        RETURN;
    END
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM TipoHabitacion
        WHERE IdTipoHabitacion = @IdTipoHabitacion;
        COMMIT TRANSACTION;

        SELECT 'Registro del tipo de habitación eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;

GO
USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_ZOO', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_ZOO;
GO
CREATE PROCEDURE SP_ELIMINAR_ZOO (
    @IdZoo INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF (@IdZoo IS NULL OR @IdZoo = 0)
    BEGIN
        RAISERROR ('El ID del zoo no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM ZOO WHERE IdZoo = @IdZoo)
    BEGIN
        RAISERROR ('El zoo no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

        DELETE FROM ZOO
        WHERE IdZoo = @IdZoo;
        COMMIT TRANSACTION;

        SELECT 'Registro del zoo eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_Habitacion', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_Habitacion;
GO
CREATE PROCEDURE SP_ELIMINAR_Habitacion (
    @IdHabitacion INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF(@IdHabitacion IS NULL OR @IdHabitacion = 0)
    BEGIN
        RAISERROR ('El ID de la habitación no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Habitacion WHERE IdHabitacion = @IdHabitacion)
    BEGIN
        RAISERROR ('La habitación no existe', 16, 1);
        RETURN;
    END

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM Habitacion
        WHERE IdHabitacion = @IdHabitacion;
        COMMIT TRANSACTION;

        SELECT 'Registro de la habitación eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar la habitación: ' + @ErrorMessage;

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_Visitante', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_Visitante;
GO
CREATE PROCEDURE SP_ELIMINAR_Visitante (
    @IdVisitantes INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    IF(@IdVisitantes IS NULL OR @IdVisitantes = 0)
    BEGIN
        RAISERROR ('El ID del visitante no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM VentaEntrada WHERE IdVisitantes = @IdVisitantes)
    BEGIN
        RAISERROR ('No se puede eliminar el cliente, ya que está asociado a registros de ventas', 16, 1);
        RETURN;
    END

   

    IF NOT EXISTS (SELECT 1 FROM Visitantes WHERE IdVisitantes = @IdVisitantes)
    BEGIN
        RAISERROR ('El visitante no existe', 16, 1);
        RETURN;
    END

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM Visitantes
        WHERE IdVisitantes = @IdVisitantes;
        COMMIT TRANSACTION;

        SELECT 'Registro del visitante eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(100) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar el visitante: ' + @ErrorMessage;

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_Animales', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_Animales;
GO
CREATE PROCEDURE SP_ELIMINAR_Animales (
    @IdAnimal INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF(@IdAnimal IS NULL OR @IdAnimal = 0)
        BEGIN
            RAISERROR ('El ID del animal no puede ser un campo vacío o ser cero', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

        IF NOT EXISTS (SELECT 1 FROM Animales WHERE IdAnimales = @IdAnimal)
        BEGIN
            RAISERROR ('El animal no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        DELETE FROM Animales
        WHERE IdAnimales = @IdAnimal;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

        COMMIT TRANSACTION;
        SELECT 'El registro del animal ha sido eliminado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_ESTADOHABITACION', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_ESTADOHABITACION;
GO
CREATE PROCEDURE SP_ELIMINAR_ESTADOHABITACION (
    @IdEstadoHabitacion INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdEstadoHabitacion IS NULL OR @IdEstadoHabitacion = 0)
        BEGIN
            RAISERROR ('El ID del estado de la habitación no puede ser un campo vacío o ser cero', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM EstadoHabitacion WHERE IdEstadoHabitacion = @IdEstadoHabitacion)
        BEGIN
            RAISERROR ('El estado de habitación no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        DELETE FROM EstadoHabitacion
        WHERE IdEstadoHabitacion = @IdEstadoHabitacion;

        COMMIT TRANSACTION;
        SELECT 'El registro del estado de la habitación ha sido eliminado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO


USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_TIPO_TAREA', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_TIPO_TAREA;
GO
CREATE PROCEDURE SP_ELIMINAR_TIPO_TAREA (
    @IdTipoTarea INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

        IF (@IdTipoTarea IS NULL OR @IdTipoTarea = 0)
        BEGIN
            RAISERROR ('El ID del tipo tarea  no puede ser un campo vacío o ser cero', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM TipoTarea WHERE IdTipoTarea = @IdTipoTarea)
        BEGIN
            RAISERROR ('El tipo tarea no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END
        DELETE FROM TipoTarea
        WHERE IdTipoTarea = @IdTipoTarea;

        COMMIT TRANSACTION;
        SELECT 'El registro de tipo tarea ha sido eliminado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO


IF OBJECT_ID('SP_ELIMINAR_PUESTO', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_PUESTO;
GO
CREATE PROCEDURE SP_ELIMINAR_PUESTO (
    @IdPuesto INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdPuesto IS NULL OR @IdPuesto = 0)
        BEGIN
            RAISERROR ('El ID del puesto no puede ser un campo vacío o ser cero', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Puesto WHERE IdPuesto = @IdPuesto)
        BEGIN
            RAISERROR ('El puesto no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        DELETE FROM Puesto
        WHERE IdPuesto = @IdPuesto;
        COMMIT TRANSACTION;
        SELECT 'El registro del puesto ha sido eliminado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_Empleado', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_Empleado;
GO
CREATE PROCEDURE SP_ELIMINAR_Empleado (
    @IdEmpleado INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF(@IdEmpleado IS NULL OR @IdEmpleado = 0)
    BEGIN
        RAISERROR ('El ID del empleado no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @IdEmpleado)
    BEGIN
        RAISERROR ('El empleado no existe', 16, 1);
        RETURN;
    END
    IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM Empleado
        WHERE IdEmpleado = @IdEmpleado;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del empleado eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_Tareas', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_Tareas;
GO
CREATE PROCEDURE SP_ELIMINAR_Tareas (
    @IdTareas INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdTareas IS NULL OR @IdTareas = 0)
        BEGIN
            RAISERROR ('El ID de la tarea no puede ser un campo vacío o ser cero', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Tareas WHERE IdTareas = @IdTareas)
        BEGIN
            RAISERROR ('La tarea no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

        DELETE FROM Tareas
        WHERE IdTareas = @IdTareas;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'El registro de la tarea ha sido eliminado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_Usuario', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_Usuario;
GO
CREATE PROCEDURE SP_ELIMINAR_Usuario (
    @IdUsuario INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF(@IdUsuario IS NULL OR @IdUsuario = 0)
        BEGIN
            RAISERROR ('El ID del usuario no puede ser un campo vacío o ser cero', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Usuario WHERE IdUsuario = @IdUsuario)
        BEGIN
            RAISERROR ('El usuario no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

        DELETE FROM Usuario
        WHERE IdUsuario = @IdUsuario;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'El registro del usuario ha sido eliminado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_Rol', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_Rol;
GO
CREATE PROCEDURE SP_ELIMINAR_Rol (
    @IdRol INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;
    BEGIN TRY

        IF(@IdRol IS NULL OR @IdRol = 0)
        BEGIN
            RAISERROR ('El ID del rol no puede ser un campo vacío o ser cero', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Rol WHERE IdRol = @IdRol)
        BEGIN
            RAISERROR ('El rol no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

        DELETE FROM Rol
        WHERE IdRol = @IdRol;
        COMMIT TRANSACTION;
        SELECT 'El registro del rol ha sido eliminado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(200);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_TipoEntrada', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_TipoEntrada;
GO
CREATE PROCEDURE SP_ELIMINAR_TipoEntrada (
    @IdTipoEntrada INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    IF(@IdTipoEntrada IS NULL OR @IdTipoEntrada = 0)
    BEGIN
        RAISERROR ('El ID del tipo de entrada no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM TipoEntrada WHERE IdTipoEntrada = @IdTipoEntrada)
    BEGIN
        RAISERROR ('El tipo de entrada no existe', 16, 1);
        RETURN;
    END

    IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        DELETE FROM TipoEntrada
        WHERE IdTipoEntrada = @IdTipoEntrada;
        COMMIT TRANSACTION;

        SELECT 'Registro del tipo de entrada eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;
GO


USE ZooMA
GO
IF OBJECT_ID('SP_ELIMINAR_EstadoTarea', 'P') IS NOT NULL
   DROP PROCEDURE SP_ELIMINAR_EstadoTarea;
GO
CREATE PROCEDURE SP_ELIMINAR_EstadoTarea (
    @IdEstadoTarea INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

    IF(@IdEstadoTarea IS NULL OR @IdEstadoTarea = 0)
    BEGIN
        RAISERROR ('El ID del estado de tarea no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF(@Cedula = '')
    BEGIN
        RAISERROR ('Las se necesitan las credenciales de la persona a realizar la accion', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM EstadoTarea WHERE IdEstadoTarea = @IdEstadoTarea)
    BEGIN
        RAISERROR ('El estado de tarea no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM EstadoTarea
        WHERE IdEstadoTarea = @IdEstadoTarea;
        COMMIT TRANSACTION;

        SELECT 'Registro del estado de tarea eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(200) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;
--FIN SP Eliminar


go

--Parte 5: Trigger
USE ZooMA
GO
IF OBJECT_ID('trg_Audit_ZOO', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_ZOO;
GO
CREATE TRIGGER trg_Audit_ZOO
ON ZOO
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'ZOO';
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdZoo, NombreZoo, Direccion, DescripcionZoo FROM inserted)
       AND NOT EXISTS (SELECT IdZoo, NombreZoo, Direccion, DescripcionZoo FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_ZOO (NombreTabla, Operacion, IdZoo, NombreZoo, Direccion, DescripcionZoo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdZoo, NombreZoo, Direccion, DescripcionZoo, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdZoo, NombreZoo, Direccion, DescripcionZoo FROM inserted)
       AND EXISTS (SELECT IdZoo, NombreZoo, Direccion, DescripcionZoo FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_ZOO (NombreTabla, Operacion, IdZoo, NombreZoo, Direccion, DescripcionZoo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdZoo, NombreZoo, Direccion, DescripcionZoo, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdZoo, NombreZoo, Direccion, DescripcionZoo FROM deleted)
       AND NOT EXISTS (SELECT IdZoo, NombreZoo, Direccion, DescripcionZoo FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_ZOO (NombreTabla, Operacion, IdZoo, NombreZoo, Direccion, DescripcionZoo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdZoo, NombreZoo, Direccion, DescripcionZoo, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO
IF OBJECT_ID('trg_Audit_Habitacion', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_Habitacion;
GO
CREATE TRIGGER trg_Audit_Habitacion
ON Habitacion
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'Habitacion';
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion FROM inserted)
       AND NOT EXISTS (SELECT IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Habitacion (NombreTabla, Operacion, IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion,IdEstadoHabitacion, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion, IdEstadoHabitacion,@Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion FROM inserted)
       AND EXISTS (SELECT IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Habitacion (NombreTabla, Operacion, IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion,IdEstadoHabitacion, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion,IdEstadoHabitacion, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion FROM deleted)
       AND NOT EXISTS (SELECT IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Habitacion (NombreTabla, Operacion, IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion,IdEstadoHabitacion, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion, IdEstadoHabitacion, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO
IF OBJECT_ID('trg_Audit_Animales', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_Animales;
GO
CREATE TRIGGER trg_Audit_Animales
ON Animales
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'Animales';
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud, IdZoo FROM inserted)
       AND NOT EXISTS (SELECT IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud, IdZoo FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Animales (NombreTabla, Operacion, IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud, IdZoo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud, IdZoo, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud, IdZoo FROM inserted)
       AND EXISTS (SELECT IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud, IdZoo FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Animales (NombreTabla, Operacion, IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud, IdZoo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud, IdZoo, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud, IdZoo FROM deleted)
       AND NOT EXISTS (SELECT IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud, IdZoo FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Animales (NombreTabla, Operacion, IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud, IdZoo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud, IdZoo, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO
IF OBJECT_ID('trg_Audit_Especies', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_Especies;
GO
CREATE TRIGGER trg_Audit_Especies
ON Especie
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'Especies';
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));
    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdEspecie, NombreEsp FROM inserted)
       AND NOT EXISTS (SELECT IdEspecie, NombreEsp FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Especie (NombreTabla, Operacion, IdEspecie, NombreEsp, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEspecie, NombreEsp, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdEspecie, NombreEsp FROM inserted)
       AND EXISTS (SELECT IdEspecie, NombreEsp FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Especies (NombreTabla, Operacion, IdEspecie, NombreEsp, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEspecie, NombreEsp, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdEspecie, NombreEsp FROM deleted)
       AND NOT EXISTS (SELECT IdEspecie, NombreEsp FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Especies (NombreTabla, Operacion, IdEspecie, NombreEsp, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEspecie, NombreEsp, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO
IF OBJECT_ID('trg_Audit_EstadoSalud', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_EstadoSalud;
GO
CREATE TRIGGER trg_Audit_EstadoSalud
ON EstadoSalud
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'EstadoSalud';
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));
    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdEstadoSalud, estadoSalud FROM inserted)
       AND NOT EXISTS (SELECT IdEstadoSalud, estadoSalud FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_EstadoSalud (NombreTabla, Operacion, IdEstadoSalud, EstadoSalud, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoSalud, estadoSalud, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdEstadoSalud, estadoSalud FROM inserted)
       AND EXISTS (SELECT IdEstadoSalud, estadoSalud FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_EstadoSalud (NombreTabla, Operacion, IdEstadoSalud, EstadoSalud, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoSalud, estadoSalud, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdEstadoSalud, estadoSalud FROM deleted)
       AND NOT EXISTS (SELECT IdEstadoSalud, estadoSalud FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_EstadoSalud (NombreTabla, Operacion, IdEstadoSalud, EstadoSalud, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoSalud, estadoSalud, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO
IF OBJECT_ID('trg_Audit_Dieta', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_Dieta;
GO
CREATE TRIGGER trg_Audit_Dieta
ON Dieta
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'Dieta';
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));
    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdDieta, NombreDiet FROM inserted)
       AND NOT EXISTS (SELECT IdDieta, NombreDiet FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Dieta (NombreTabla, Operacion, IdDieta, NombreDiet, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdDieta, NombreDiet, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdDieta, NombreDiet FROM inserted)
       AND EXISTS (SELECT IdDieta, NombreDiet FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Dieta (NombreTabla, Operacion, IdDieta, NombreDiet, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdDieta, NombreDiet, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdDieta, NombreDiet FROM deleted)
       AND NOT EXISTS (SELECT IdDieta, NombreDiet FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Dieta (NombreTabla, Operacion, IdDieta, NombreDiet, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdDieta, NombreDiet, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO
IF OBJECT_ID('trg_Audit_TipoHabitacion', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_TipoHabitacion;
GO
CREATE TRIGGER trg_Audit_TipoHabitacion
ON TipoHabitacion
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'TipoHabitacion';
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdTipoHabitacion, NombreTH FROM inserted)
       AND NOT EXISTS (SELECT IdTipoHabitacion, NombreTH FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_TipoHabitacion (NombreTabla, Operacion, IdTipoHabitacion, NombreTH, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTipoHabitacion, NombreTH, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdTipoHabitacion, NombreTH FROM inserted)
       AND EXISTS (SELECT IdTipoHabitacion, NombreTH FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_TipoHabitacion (NombreTabla, Operacion, IdTipoHabitacion, NombreTH, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTipoHabitacion, NombreTH, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdTipoHabitacion, NombreTH FROM deleted)
       AND NOT EXISTS (SELECT IdTipoHabitacion, NombreTH FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_TipoHabitacion (NombreTabla, Operacion, IdTipoHabitacion, NombreTH, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTipoHabitacion, NombreTH, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO






USE ZooMA
GO
IF OBJECT_ID('trg_Audit_Visitantes', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_Visitantes;
GO
CREATE TRIGGER trg_Audit_Visitantes
ON Visitantes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));
    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'Visitantes';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdVisitantes, nombreVist, apell1Vist, apell2Vist, CorreoElectronico, Telefono FROM inserted)
       AND NOT EXISTS (SELECT IdVisitantes, nombreVist, apell1Vist, apell2Vist , CorreoElectronico, Telefono FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Visitantes (NombreTabla, Operacion, IdVisitantes, NombreVist, Apell1Vist, apell2Vist, CorreoElectronico, Telefono, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdVisitantes, nombreVist, apell1Vist, apell2Vist, CorreoElectronico, Telefono, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdVisitantes, nombreVist, apell1Vist, apell2Vist, CorreoElectronico, Telefono FROM inserted)
       AND EXISTS (SELECT IdVisitantes, nombreVist, apell1Vist, apell2Vist, CorreoElectronico, Telefono FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Visitantes (NombreTabla, Operacion, IdVisitantes, NombreVist, Apell1Vist, apell2Vist, CorreoElectronico, Telefono, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdVisitantes, nombreVist, apell1Vist, apell2Vist, CorreoElectronico, Telefono, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdVisitantes, nombreVist, apell1Vist, apell2Vist, CorreoElectronico, Telefono FROM deleted)
       AND NOT EXISTS (SELECT IdVisitantes, nombreVist, apell1Vist, apell2Vist, CorreoElectronico, Telefono FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Visitantes (NombreTabla, Operacion, IdVisitantes, NombreVist, Apell1Vist, Apell2Vist, CorreoElectronico, Telefono, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdVisitantes, nombreVist, apell1Vist, apell2Vist, CorreoElectronico, Telefono, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO
IF OBJECT_ID('trg_Audit_TipoEntrada', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_TipoEntrada;
GO
CREATE TRIGGER trg_Audit_TipoEntrada
ON TipoEntrada
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'TipoEntrada';
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));
    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdTipoEntrada, nombreEnt, Precio FROM inserted)
       AND NOT EXISTS (SELECT IdTipoEntrada, nombreEnt, Precio FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_TipoEntrada (NombreTabla, Operacion, IdTipoEntrada, NombreEnt, Precio, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTipoEntrada, nombreEnt, Precio, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdTipoEntrada, nombreEnt, Precio FROM inserted)
       AND EXISTS (SELECT IdTipoEntrada, nombreEnt, Precio FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_TipoEntrada (NombreTabla, Operacion, IdTipoEntrada, NombreEnt, Precio, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTipoEntrada, nombreEnt, Precio, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdTipoEntrada, nombreEnt,Precio FROM deleted)
       AND NOT EXISTS (SELECT IdTipoEntrada, nombreEnt, Precio FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_TipoEntrada (NombreTabla, Operacion, IdTipoEntrada, NombreEnt, Precio, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTipoEntrada, nombreEnt, Precio, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO

USE ZooMA
GO
IF OBJECT_ID('trg_Audit_EstadoHabitacion', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_EstadoHabitacion;
GO
CREATE TRIGGER trg_Audit_EstadoHabitacion
ON EstadoHabitacion
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));
    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'EstadoHabitacion';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdEstadoHabitacion FROM inserted)
       AND NOT EXISTS (SELECT IdEstadoHabitacion, estado FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_EstadoHabitacion (NombreTabla, Operacion, IdEstadoHabitacion, Estado,  RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoHabitacion, estado, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdEstadoHabitacion FROM inserted)
       AND EXISTS (SELECT IdEstadoHabitacion FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_EstadoHabitacion (NombreTabla, Operacion, IdEstadoHabitacion, Estado, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoHabitacion, estado, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdEstadoHabitacion, estado FROM deleted)
       AND NOT EXISTS (SELECT IdEstadoHabitacion, estado FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_EstadoHabitacion (NombreTabla, Operacion, IdEstadoHabitacion, Estado, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoHabitacion, estado, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO

USE ZooMA
GO
IF OBJECT_ID('trg_Audit_Empleado', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_Empleado;
GO
CREATE TRIGGER trg_Audit_Empleado
ON Empleado
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));
    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'Empleado';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdEmpleado, Nombre, Apellido1, Apellido2, IdPuesto, Correo, IdZoo FROM inserted)
       AND NOT EXISTS (SELECT IdEmpleado, Nombre, Apellido1, Apellido2, Correo, IdPuesto, IdZoo FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Empleado (NombreTabla, Operacion, IdEmpleado, Nombre, Apellido1, Apellido2,Correo, IdPuesto, IdZoo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEmpleado, Nombre, Apellido1, Apellido2,Correo, IdPuesto, IdZoo, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdEmpleado, Nombre, Apellido1, Apellido2,Correo, IdPuesto, IdZoo FROM inserted)
       AND EXISTS (SELECT IdEmpleado, Nombre, Apellido1, Apellido2,Correo, IdPuesto, IdZoo FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Empleado (NombreTabla, Operacion, IdEmpleado, Nombre, Apellido1, Apellido2,Correo, IdPuesto, IdZoo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEmpleado, Nombre, Apellido1, Apellido2,Correo, IdPuesto, IdZoo, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdEmpleado, Nombre, Apellido1, Apellido2,Correo, IdPuesto, IdZoo FROM deleted)
    AND NOT EXISTS (SELECT IdEmpleado, Nombre, Apellido1, Apellido2,Correo, IdPuesto, IdZoo FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Empleado (NombreTabla, Operacion, IdEmpleado, Nombre, Apellido1, Apellido2,Correo, IdPuesto, IdZoo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEmpleado, Nombre, Apellido1, Apellido2,Correo, IdPuesto, IdZoo, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO

USE ZooMA
GO
IF OBJECT_ID('trg_Audit_Puesto', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_Puesto;
GO
CREATE TRIGGER trg_Audit_Puesto
ON Puesto
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));
    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'Puesto';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdPuesto, Nombre, Salario FROM inserted)
       AND NOT EXISTS (SELECT IdPuesto, Nombre, Salario FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Puesto (NombreTabla, Operacion, IdPuesto, Nombre, Salario, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdPuesto, Nombre, Salario, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdPuesto, Nombre, Salario FROM inserted)
       AND EXISTS (SELECT IdPuesto, Nombre, Salario FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Puesto (NombreTabla, Operacion, IdPuesto, Nombre, Salario, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdPuesto, Nombre, Salario, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdPuesto, Nombre, Salario FROM deleted)
       AND NOT EXISTS (SELECT IdPuesto, Nombre, Salario FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Puesto (NombreTabla, Operacion, IdPuesto, Nombre, Salario, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdPuesto, Nombre, Salario, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO
IF OBJECT_ID('trg_Audit_Tareas', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_Tareas;
GO
CREATE TRIGGER trg_Audit_Tareas
ON Tareas
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'Tareas';
	
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));
    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdTareas, IdEmpleado FROM inserted)
       AND NOT EXISTS (SELECT IdTareas, IdEmpleado FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Tareas (NombreTabla, Operacion, IdTareas, IdEmpleado,IdEstadoTarea, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTareas, IdEmpleado,IdEstadoTarea, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdTareas, IdEmpleado FROM inserted)
       AND EXISTS (SELECT IdTareas, IdEmpleado FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Tareas (NombreTabla, Operacion, IdTareas, IdEmpleado,IdEstadoTarea, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTareas, IdEmpleado,IdEstadoTarea, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdTareas, IdEmpleado FROM deleted)
       AND NOT EXISTS (SELECT IdTareas, IdEmpleado FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Tareas (NombreTabla, Operacion, IdTareas, IdEmpleado,IdEstadoTarea, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTareas, IdEmpleado,IdEstadoTarea, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO

USE ZooMA
GO
IF OBJECT_ID('trg_Audit_EstadoTarea', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_EstadoTarea;
GO

CREATE TRIGGER trg_Audit_EstadoTarea
ON EstadoTarea
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'EstadoTarea';
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));
    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdEstadoTarea, Nombre FROM inserted)
       AND NOT EXISTS (SELECT IdEstadoTarea, Nombre FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_EstadoTarea (NombreTabla, Operacion, IdEstadoTarea, Nombre, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoTarea, Nombre, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdEstadoTarea, Nombre FROM inserted)
       AND EXISTS (SELECT IdEstadoTarea, Nombre FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_EstadoTarea (NombreTabla, Operacion, IdEstadoTarea, Nombre, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoTarea, Nombre, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdEstadoTarea, Nombre FROM deleted)
       AND NOT EXISTS (SELECT IdEstadoTarea, Nombre FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_EstadoTarea (NombreTabla, Operacion, IdEstadoTarea, Nombre, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoTarea, Nombre, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO
IF OBJECT_ID('trg_Audit_VentaEntrada', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_VentaEntrada;
GO
CREATE TRIGGER trg_Audit_VentaEntrada
ON VentaEntrada
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));
    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128) = SYSTEM_USER;
    DECLARE @TableName VARCHAR(100) = 'VentaEntrada';

    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';
    END
    ELSE IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @Operacion = 'INSERT';
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'DELETE';
    END

    IF @Operacion IN ('INSERT', 'UPDATE')
    BEGIN
        INSERT INTO Audit_VentaEntrada (NombreTabla, Operacion, IdVentaEntrada, fechaventa, IdVisitante, IdMetodoPago, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdVentaEntrada, fechaventa, IdVisitantes, IdMetodoPago, @Cedula, GETDATE()
        FROM inserted;
    END

    IF @Operacion = 'DELETE'
    BEGIN
        INSERT INTO Audit_VentaEntrada (NombreTabla, Operacion, IdVentaEntrada, fechaventa, IdVisitante, IdMetodoPago, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdVentaEntrada, fechaventa, IdVisitantes, IdMetodoPago, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO
IF OBJECT_ID('trg_Audit_MetodoPago', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_MetodoPago;
GO

CREATE TRIGGER trg_Audit_MetodoPago
ON MetodoPago
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));
    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'MetodoPago';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdMetodoPago, MetodoPago FROM inserted)
       AND NOT EXISTS (SELECT IdMetodoPago, MetodoPago FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_MetodoPago (NombreTabla, Operacion, IdMetodoPago, MetodoPago, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdMetodoPago, MetodoPago, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdMetodoPago, MetodoPago FROM inserted)
       AND EXISTS (SELECT IdMetodoPago, MetodoPago FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_MetodoPago (NombreTabla, Operacion, IdMetodoPago, MetodoPago, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdMetodoPago, MetodoPago, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdMetodoPago, MetodoPago FROM deleted)
       AND NOT EXISTS (SELECT IdMetodoPago, MetodoPago FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_MetodoPago (NombreTabla, Operacion, IdMetodoPago, MetodoPago, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdMetodoPago, MetodoPago, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO
IF OBJECT_ID('trg_Audit_CalificacionVisita', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_CalificacionVisita;
GO
CREATE TRIGGER trg_Audit_CalificacionVisita
ON CalificacionVisita
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'CalificacionVisita';
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));
    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdCalificacionVisita, fecha, IdVentaEntrada FROM inserted)
       AND NOT EXISTS (SELECT IdCalificacionVisita, fecha, IdVentaEntrada FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_CalificacionVisita (NombreTabla, Operacion, IdCalificacionVisita, fecha, IdVentaEntrada, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdCalificacionVisita, fecha, IdVentaEntrada, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdCalificacionVisita, fecha, IdVentaEntrada FROM inserted)
       AND EXISTS (SELECT IdCalificacionVisita, fecha, IdVentaEntrada FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_CalificacionVisita (NombreTabla, Operacion, IdCalificacionVisita, fecha, IdVentaEntrada, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdCalificacionVisita, fecha, IdVentaEntrada, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdCalificacionVisita, fecha, IdVentaEntrada FROM deleted)
       AND NOT EXISTS (SELECT IdCalificacionVisita, fecha, IdVentaEntrada FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_CalificacionVisita (NombreTabla, Operacion, IdCalificacionVisita, fecha, IdVentaEntrada, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdCalificacionVisita, fecha, IdVentaEntrada, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO
IF OBJECT_ID('trg_Audit_Rol', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_Rol;
GO

CREATE TRIGGER trg_Audit_Rol
ON Rol
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));
    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'Rol';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdRol, Nombre FROM inserted)
       AND NOT EXISTS (SELECT IdRol, Nombre FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Rol (NombreTabla, Operacion, IdRol, Nombre, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdRol, Nombre, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdRol, Nombre FROM inserted)
       AND EXISTS (SELECT IdRol, Nombre FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Rol (NombreTabla, Operacion, IdRol, Nombre, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdRol, Nombre, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdRol, Nombre FROM deleted)
       AND NOT EXISTS (SELECT IdRol, Nombre FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Rol (NombreTabla, Operacion, IdRol, Nombre, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdRol, Nombre, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO
IF OBJECT_ID('trg_Audit_Usuario', 'TR') IS NOT NULL
   DROP TRIGGER trg_Audit_Usuario;
GO

CREATE TRIGGER trg_Audit_Usuario
ON Usuario
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion VARCHAR(10);
    DECLARE @User VARCHAR(128);
    DECLARE @TableName VARCHAR(100) = 'Usuario';
	DECLARE @Cedula VARCHAR(20) = CONVERT(VARCHAR(20), SESSION_CONTEXT(N'CedulaUsuario'));
    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdUsuario, Contraseña, Estado FROM inserted)
       AND NOT EXISTS (SELECT IdUsuario, Contraseña, Estado FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Usuario (NombreTabla, Operacion, IdUsuario, Contraseña, Estado, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdUsuario, Contraseña, Estado, @Cedula, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdUsuario, Contraseña, Estado FROM inserted)
       AND EXISTS (SELECT IdUsuario, Contraseña, Estado FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Usuario (NombreTabla, Operacion, IdUsuario, Contraseña, Estado, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdUsuario, Contraseña, Estado, @Cedula, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdUsuario, Contraseña, Estado FROM deleted)
       AND NOT EXISTS (SELECT IdUsuario, Contraseña, Estado FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Usuario (NombreTabla, Operacion, IdUsuario, Contraseña, Estado, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdUsuario, Contraseña, Estado, @Cedula, GETDATE()
        FROM deleted;
    END
END
GO
--FIN Trigger


go

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
estado
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
fecha,
IdVentaEntrada
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
IF OBJECT_ID('Vw_TipoTarea', 'V') IS NOT NULL
   DROP VIEW Vw_TipoTarea;
GO
Create View Vw_TipoTarea 
as
Select
IdTipoTarea,
NombreTT
from TipoTarea
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

Use ZooMA
IF OBJECT_ID('Vw_Entradas_Activas', 'V') IS NOT NULL
   DROP VIEW Vw_Entradas_Activas;
GO
Create View Vw_Entradas_Activas 
as
    SELECT  E.IdEntrada, E.fechaVencimiento, E.descuento, TP.nombreEnt as 'Tipo entrada', TP.Precio as 'Precio tipo entrada', 
    (dbo.CalcularPrecioEntrada(E.IdEntrada, 1)) as 'Precio total' FROM Entrada E 
   INNER JOIN TipoEntrada TP ON E.IdTipoEntrada = TP.IdTipoEntrada WHERE E.fechaVencimiento > GETDATE()
GO




--FIN VIEWS--
USE ZooMA
GO
IF OBJECT_ID('SP_REGISTER','P') IS NOT NULL
    DROP PROCEDURE SP_REGISTER;
GO
CREATE PROCEDURE SP_REGISTER(
    @IdEmpleado VARCHAR(20),
    @Nombre VARCHAR(20),
    @Apellido1 VARCHAR(20),
    @Apellido2 VARCHAR(20),
    @Correo VARCHAR(50),
    @IdPuesto INT,
    @Contraseña VARCHAR(20),
    @IdRol INT,
    @RolFechaInicio DATE,
    @RolFechaFin DATE,
    @Cedula VARCHAR(20),
    @Estado INT = 1 -- 1 = Activo, 0 = Inactivo
)
AS
BEGIN
 EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

 BEGIN TRANSACTION;
 BEGIN TRY

  IF (@IdEmpleado IS NULL OR @Nombre IS NULL OR @Apellido1 IS NULL OR @Apellido2 IS NULL OR @IdPuesto IS NULL OR @Contraseña IS NULL OR @IdRol IS NULL OR @RolFechaInicio IS NULL OR @RolFechaFin IS NULL OR @Cedula IS NULL)
  BEGIN
    RAISERROR('Todos los campos son requeridos', 16, 1);
    RETURN;
  END


  IF EXISTS (SELECT IdEmpleado FROM Empleado WHERE IdEmpleado = @IdEmpleado)
  BEGIN
    RAISERROR('El empleado ya existe', 16, 1);
    RETURN;
  END

  IF NOT EXISTS (SELECT IdRol FROM Rol WHERE IdRol = @IdRol)
  BEGIN
    RAISERROR('El rol no existe', 16, 1);
    RETURN;
  END

  IF NOT EXISTS (SELECT IdPuesto FROM Puesto WHERE IdPuesto = @IdPuesto)
  BEGIN
    RAISERROR('El puesto no existe', 16, 1);
    RETURN;
  END

  

    
        INSERT INTO Empleado (IdEmpleado, Nombre, Apellido1, Apellido2, IdPuesto, Correo)
        VALUES (@IdEmpleado, @Nombre, @Apellido1, @Apellido2, @IdPuesto, @Correo);

        INSERT INTO Usuario (IdUsuario, Contraseña, Estado)
        VALUES (@IdEmpleado, @Contraseña, @Estado);

        INSERT INTO RolUsuario (IdRol, IdUsuario, FechaInicio, FechaFin)
        VALUES (@IdRol, @IdEmpleado, @RolFechaInicio, @RolFechaFin);

        COMMIT TRANSACTION;
    END TRY


    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(100);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH

END





GO


USE ZooMA
GO
IF OBJECT_ID('SP_LOGIN','P') IS NOT NULL
    DROP PROCEDURE SP_LOGIN;
GO
CREATE PROCEDURE SP_LOGIN(
    @IdEmpleado VARCHAR(20),
    @Contraseña VARCHAR(20) 
)
AS
BEGIN

  IF (@IdEmpleado IS NULL OR @Contraseña IS NULL)
  BEGIN
    RAISERROR('Todos los campos son requeridos', 16, 1);
    RETURN;
  END

    BEGIN TRY
        
        IF NOT EXISTS(SELECT IdUsuario FROM Usuario WHERE IdUsuario = @IdEmpleado AND Contraseña = @Contraseña AND Estado = 1)
        BEGIN
            RAISERROR('Credenciales incorrectos', 16, 1);
            RETURN;
        END

      
    END TRY


    BEGIN CATCH
        
        DECLARE @ErrorMessage VARCHAR(100);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH

END




