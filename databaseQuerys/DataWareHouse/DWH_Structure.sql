USE MASTER
DROP DATABASE IF EXISTS ZooMADataWarehouse
go
CREATE DATABASE ZooMADataWarehouse
on Primary 
(Name='ZooMADataWarehouse_Data',
FILENAME='C:\SQLData\ZooMADataWarehouse_Data.Mdf',
SIZE=100Mb,
MAXSIZE=1000Mb,
FILEGROWTH=100Mb)
Log On
(NAME=' ZooMADataWarehouse_Log',
FILENAME='C:\SQLData\ZooMADataWarehouse_Log.Ldf',
SIZE=50Mb,
MAXSIZE=500Mb,
FILEGROWTH=50Mb)
go 

USE ZooMADataWarehouse
GO
CREATE TABLE Dim_empleado (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdEmpleado INT,
    NombreCompleto NVARCHAR(62) NULL,
    Correo VARCHAR(50) NULL,
    Salario FLOAT NULL,
    Puesto VARCHAR(50) NULL,
    Fecha DATE DEFAULT GETDATE(),
    Actual BIT NOT NULL
);
GO

  CREATE TABLE Dim_Visitantes (
    IdVisitantes INT PRIMARY KEY,
    NombreCompleto VARCHAR(64) NULL,
    CorreoElectronico VARCHAR(50),
    TELEFONO INT,
)

GO

    CREATE TABLE Dim_Animal (
    IdAnimales INT,
    Nombre VARCHAR(20),
    Edad INT,
    Dieta VARCHAR(20),
    Especie VARCHAR(20),
    Habitacion VARCHAR(20),
    Estado VARCHAR(255),
    Fecha DATE DEFAULT GETDATE(),
    Actual BIT NOT NULL
)

GO

CREATE TABLE Dim_Habitacion (
    IdHabitacion INT,
    Nombre VARCHAR(20) NULL,
    Direccion VARCHAR(100) NULL,
    Capacidad INT NULL,
    Estado VARCHAR(50) NULL,
    Tipo VARCHAR(75) NULL,
    Fecha DATE NULL,
    Actual BIT NOT NULL
);

GO

  CREATE TABLE Dim_Alimentos (
    IdAlimento INT,
    Nombre VARCHAR(62) NULL,
    UnidadMedica VARCHAR(50)  NULL
)
GO

  CREATE TABLE Dim_Dieta (
    IdDieta INT,
    Nombre VARCHAR(62) NULL,
)

GO

  CREATE TABLE Dim_Entrada (
    IdEntrada INT,
    fechaVencimiento DATE,
    descuento INT,
    NombreEnt VARCHAR(20),
    Precio MONEY,
    PrecioTotal MONEY
)

GO

  CREATE TABLE Dim_MetodoPago (
    IdMetodoPago INT PRIMARY KEY,
    Nombre VARCHAR(70),
)


GO
  CREATE TABLE Dim_EstadoTarea (
    IdEstadoTarea INT PRIMARY KEY,
    Nombre VARCHAR(70),
)


GO
  CREATE TABLE Dim_TipoTarea (
    IdTipoTarea INT PRIMARY KEY,
    Nombre VARCHAR(70),
)


GO


  CREATE TABLE Fact_Tarea (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdTarea INT NOT NULL,
    IdEstadoTarea INT NOT NULL,
    IdTipoTarea INT NOT NULL,
    IdEmpleado INT NOT NULL,	
    Fecha DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_EstadoTarea FOREIGN KEY (IdEstadoTarea) REFERENCES Dim_EstadoTarea(IdEstadoTarea),
    CONSTRAINT FK_TipoTarea FOREIGN KEY (IdTipoTarea) REFERENCES Dim_TipoTarea(IdTipoTarea),
    
)

GO


  CREATE TABLE Fact_Venta (
    IdVenta INT PRIMARY KEY,
    FechaVenta DATETIME,
    IdVisitantes INT NOT NULL,
    IdEmpleado INT NOT NULL,
    IdMetodoPago INT NOT NULL,
    IVA MONEY,
    Precio MONEY,
    PrecioTotal MONEY,
    CantidadEntradas INT
)


GO

CREATE TABLE Fact_DetalleVenta (
    IdDetalleVenta INT PRIMARY KEY,
    IdVentaEntrada INT,
    IdEntrada INT,
    IdTipoEntrada INT,
    Cantidad INT,
    Precio MONEY,
    Descuento MONEY,
    Total MONEY,
);

GO
CREATE TABLE Fact_CalificacionVisita (
    IdCalificacionVisita INT PRIMARY KEY,
    IdVentaEntrada INT,                           
    Fecha DATE,                                   
    NotaRecorrido INT,                            
    SugerenciasRecorrido VARCHAR(255),           
    NotaServicioCliente INT,
    SugerenciasServicioCliente VARCHAR(255), 
    NotaFinal DECIMAL(5, 2)
);

--AGREGAR EL CAMPO CANTIDAD Y LA TABLA UNIDAD DE MEDIDA PARA PODER CLASIFICARLO
--CONSIDERAR AGREGAR EL CAMPO FECHA INICIO Y FIN EN ESTA TABLA
CREATE TABLE Fact_DietaAlimentos(
  IdDietaAlimento INT PRIMARY KEY,
  IdDieta INT,
  IdAlimento INT,
  Estado BIT DEFAULT 1,

)