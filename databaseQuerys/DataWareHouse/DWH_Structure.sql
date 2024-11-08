USE MASTER
DROP DATABASE IF EXISTS ZooMADataWarehouse
GO

CREATE DATABASE ZooMADataWarehouse
ON PRIMARY 
(
    NAME='ZooMADataWarehouse_Data',
    FILENAME='C:\SQLData\ZooMADataWarehouse_Data.Mdf',
    SIZE=5000MB,
    MAXSIZE=9000MB,
    FILEGROWTH=500MB
)
LOG ON
(
    NAME='ZooMADataWarehouse_Log',
    FILENAME='C:\SQLData\ZooMADataWarehouse_Log.Ldf',
    SIZE=300MB,
    MAXSIZE=700MB,
    FILEGROWTH=100MB
)
GO 

USE ZooMADataWarehouse
GO

CREATE TABLE Dim_empleado (
    Id INT IDENTITY(1,1),
    IdEmpleado INT,
    NombreCompleto VARCHAR(62) NULL,
    Correo VARCHAR(50) NULL,
    Salario FLOAT NULL,
    Puesto VARCHAR(50) NULL,
    Fecha DATE DEFAULT GETDATE(),
    Actual BIT NOT NULL,
    CONSTRAINT PK_Dim_empleado_Id PRIMARY KEY CLUSTERED (Id)
);
GO

CREATE TABLE Dim_Visitantes (
    IdVisitantes INT IDENTITY(1,1),
    NombreCompleto VARCHAR(62) NULL,
    CorreoElectronico VARCHAR(50) NOT NULL,
    TELEFONO INT NOT NULL,
    CONSTRAINT PK_Dim_Visitantes_IdVisitantes PRIMARY KEY CLUSTERED (IdVisitantes)
);
GO

CREATE TABLE Dim_Animal (
    IdAnimales INT IDENTITY(1,1),
    Nombre VARCHAR(20),
    Edad INT,
    Dieta VARCHAR(20),
    Especie VARCHAR(20),
    Habitacion VARCHAR(20),
    Estado VARCHAR(255),
    Fecha DATE DEFAULT GETDATE(),
    Actual BIT NOT NULL,
    CONSTRAINT PK_Dim_Animal_IdAnimales PRIMARY KEY CLUSTERED (IdAnimales)
);
GO

CREATE TABLE Dim_Habitacion (
    IdHabitacion INT IDENTITY(1,1),
    Nombre VARCHAR(20) NULL,
    Direccion VARCHAR(100) NULL,
    Capacidad INT NULL,
    Estado VARCHAR(50) NULL,
    Tipo VARCHAR(75) NULL,
    Fecha DATE NULL,
    Actual BIT NOT NULL,
    CONSTRAINT PK_Dim_Habitacion_IdHabitacion PRIMARY KEY CLUSTERED (IdHabitacion)
);
GO

CREATE TABLE Dim_Alimentos (
    IdAlimento INT IDENTITY(1,1),
    Nombre VARCHAR(62) NULL,
    CONSTRAINT PK_Dim_Alimentos_IdAlimento PRIMARY KEY CLUSTERED (IdAlimento)
);
GO

CREATE TABLE Dim_Dieta (
    IdDieta INT IDENTITY(1,1),
    Nombre VARCHAR(62) NULL,
    CONSTRAINT PK_Dim_Dieta_IdDieta PRIMARY KEY CLUSTERED (IdDieta)
);
GO

CREATE TABLE Dim_Entrada (
    IdEntrada INT IDENTITY(1,1),
    FechaVencimiento DATE,
    Descuento INT,
    NombreEnt VARCHAR(20),
    Precio MONEY,
    PrecioTotal MONEY,
    CONSTRAINT PK_Dim_Entrada_IdEntrada PRIMARY KEY CLUSTERED (IdEntrada)
);
GO

CREATE TABLE Dim_MetodoPago (
    IdMetodoPago INT IDENTITY(1,1),
    Nombre VARCHAR(70),
    CONSTRAINT PK_Dim_MetodoPago_IdMetodoPago PRIMARY KEY CLUSTERED (IdMetodoPago)
);
GO

CREATE TABLE Dim_EstadoTarea (
    IdEstadoTarea INT IDENTITY(1,1),
    Nombre VARCHAR(70),
    CONSTRAINT PK_Dim_EstadoTarea_IdEstadoTarea PRIMARY KEY CLUSTERED (IdEstadoTarea)
);
GO

CREATE TABLE Dim_TipoTarea (
    IdTipoTarea INT IDENTITY(1,1),
    Nombre VARCHAR(70),
    CONSTRAINT PK_Dim_TipoTarea_IdTipoTarea PRIMARY KEY CLUSTERED (IdTipoTarea)
);
GO

CREATE TABLE Fact_Tarea (
    Id INT IDENTITY(1,1),
    IdTarea INT NOT NULL,
    IdEstadoTarea INT NOT NULL,
    IdTipoTarea INT NOT NULL,
    IdEmpleado INT NOT NULL,	
    Fecha DATETIME DEFAULT GETDATE(),
    CONSTRAINT PK_Fact_Tarea_Id PRIMARY KEY CLUSTERED (Id),
    CONSTRAINT FK_EstadoTarea FOREIGN KEY (IdEstadoTarea) REFERENCES Dim_EstadoTarea(IdEstadoTarea),
    CONSTRAINT FK_TipoTarea FOREIGN KEY (IdTipoTarea) REFERENCES Dim_TipoTarea(IdTipoTarea),
    CONSTRAINT FK_Empleado FOREIGN KEY (Id) REFERENCES Dim_empleado(Id)
);
GO

CREATE TABLE Fact_Venta (
    IdVenta INT IDENTITY(1,1),
    FechaVenta DATETIME,
    IdVisitantes INT NOT NULL,
    IdEmpleado INT NOT NULL,
    IdMetodoPago INT NOT NULL,
    IVA MONEY,
    Precio MONEY,
    PrecioTotal MONEY,
    CantidadEntradas INT,
    CONSTRAINT PK_Fact_Venta_IdVenta PRIMARY KEY CLUSTERED (IdVenta),
    CONSTRAINT FK_MetodoPago FOREIGN KEY (IdMetodoPago) REFERENCES Dim_MetodoPago(IdMetodoPago)
);
GO

CREATE TABLE Fact_DetalleVenta (
    IdDetalleVenta INT IDENTITY(1,1),
    IdVentaEntrada INT,
    IdEntrada INT,
    IdTipoEntrada INT,
    Cantidad INT,
    Precio MONEY,
    Descuento MONEY,
    Total MONEY,
    CONSTRAINT PK_Fact_DetalleVenta_IdDetalleVenta PRIMARY KEY CLUSTERED (IdDetalleVenta),
    CONSTRAINT FK_Entrada FOREIGN KEY (IdEntrada) REFERENCES Dim_Entrada(IdEntrada)
);
GO

CREATE TABLE Fact_CalificacionVisita (
    IdCalificacionVisita INT IDENTITY(1,1),
    IdVentaEntrada INT,                            
    Fecha DATE,                                   
    NotaRecorrido INT,                            
    SugerenciasRecorrido VARCHAR(255),           
    NotaServicioCliente INT,
    SugerenciasServicioCliente VARCHAR(255), 
    NotaFinal DECIMAL(5, 2),
    CONSTRAINT PK_Fact_CalificacionVisita_IdCalificacionVisita PRIMARY KEY CLUSTERED (IdCalificacionVisita)
);
GO
