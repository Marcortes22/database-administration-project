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

USE ZooMA_Data_Warehouse
GO
CREATE TABLE Dim_empleado (
    Id INT IDENTITY(1,1) PRIMARY KEY CLUSTERED,
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
    IdVisitantes INT PRIMARY KEY CLUSTERED,
    NombreCompleto VARCHAR(64) NULL,
    CorreoElectronico VARCHAR(50),
    TELEFONO INT NULL,
)

GO

    CREATE TABLE Dim_Animal (
    IdAnimales INT PRIMARY KEY CLUSTERED, 
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
    IdHabitacion INT PRIMARY KEY CLUSTERED,
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
    IdAlimento INT PRIMARY KEY CLUSTERED, 
    Nombre VARCHAR(62) NULL,
    UnidadMedida VARCHAR(50)  NULL
)
GO

  CREATE TABLE Dim_Dieta (
    IdDieta INT PRIMARY KEY CLUSTERED,
    Nombre VARCHAR(62) NULL,
)

GO

  CREATE TABLE Dim_Entrada (
    IdEntrada INT PRIMARY KEY CLUSTERED,
    fechaVencimiento DATE,
    descuento INT,
    NombreEnt VARCHAR(20),
    Precio MONEY,
    PrecioTotal MONEY
)

GO

  CREATE TABLE Dim_MetodoPago (
    IdMetodoPago INT PRIMARY KEY CLUSTERED,
    Nombre VARCHAR(70),
)


GO
  CREATE TABLE Dim_EstadoTarea (
    IdEstadoTarea INT PRIMARY KEY CLUSTERED,
    Nombre VARCHAR(70),
)




GO
  CREATE TABLE Dim_TipoTarea (
    IdTipoTarea INT PRIMARY KEY CLUSTERED,
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
    IdVenta INT PRIMARY KEY CLUSTERED,
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
    CONSTRAINT FK_VentaEntrada FOREIGN KEY (IdVentaEntrada) REFERENCES Fact_Venta(IdVenta),
    CONSTRAINT FK_Entrada FOREIGN KEY (IdEntrada) REFERENCES Dim_Entrada(IdEntrada)
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
  IdDietaAlimento INT PRIMARY KEY CLUSTERED,
  IdDieta INT,
  IdAlimento INT,
  Estado BIT DEFAULT 1,
  Cantidad DECIMAL(10, 2) NOT NULL,
  CONSTRAINT FK_Dieta FOREIGN KEY (IdDieta) REFERENCES Dim_Dieta(IdDieta),
  CONSTRAINT FK_Alimento FOREIGN KEY (IdAlimento) REFERENCES Dim_Alimentos(IdAlimento)
)


CREATE TABLE Fact_HistorialMovimientos (
    IdHistorialMovimientos INT PRIMARY KEY,
    IdAnimal INT NOT NULL,
    IdHabitacionAnterior INT,
    IdHabitacionActual INT,
    FechaMovimiento DATETIME,
    Motivo VARCHAR(255) NULL,
    CONSTRAINT FK_Animal FOREIGN KEY (IdAnimal) REFERENCES Dim_Animal(IdAnimales),
    CONSTRAINT FK_HabitacionAnterior FOREIGN KEY (IdHabitacionAnterior) REFERENCES Dim_Habitacion(IdHabitacion),
    CONSTRAINT FK_HabitacionActual FOREIGN KEY (IdHabitacionActual) REFERENCES Dim_Habitacion(IdHabitacion)
);
