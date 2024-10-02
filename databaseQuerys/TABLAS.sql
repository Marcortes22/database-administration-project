----tablas proyectos 
-----------------------------------------------------------
-- Creaci�n de la tabla EstadoSalud
CREATE TABLE EstadoSalud (
    IdEstadoSalud INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    estado VARCHAR(255) NOT NULL
);

-- Creaci�n de la tabla Especies
CREATE TABLE Especies (
    IdEspecie INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(255) NOT NULL
);

-- Creaci�n de la tabla Dieta
CREATE TABLE Dieta (
    IdDieta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Descripcion VARCHAR(255) NOT NULL
);

-- Creaci�n de la tabla TipoHabitacion
CREATE TABLE TipoHabitacion (
    IdTipoHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL
);

-- Creaci�n de la tabla ZOO
CREATE TABLE ZOO (
    IdZoo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Descripcion VARCHAR(255) NOT NULL,
    Disponibilidad BIT NOT NULL
);

-- Creaci�n de la tabla Habitacion
CREATE TABLE Habitacion (
    IdHabitacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Capacidad BIT NOT NULL,
    IdTipoHabitacion INT NOT NULL,
    CONSTRAINT FK_Habitacion_IdTipoHabitacion FOREIGN KEY (IdTipoHabitacion) REFERENCES TipoHabitacion (IdTipoHabitacion)
);

-- Creaci�n de la tabla Visitantes
CREATE TABLE Visitantes (
    IdVisitantes INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(255) NOT NULL,
    apellido1 VARCHAR(255) NOT NULL,
    apellido2 VARCHAR(255) NOT NULL,
    disponibilidad BIT NOT NULL
);

-- Creaci�n de la tabla MetodoPago
CREATE TABLE MetodoPago (
    IdMetodoPago INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    metodopago VARCHAR(255) NOT NULL
);

-- Creaci�n de la tabla TipoEntrada
CREATE TABLE TipoEntrada (
    IdTipoEntrada INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(255) NOT NULL,
    decripcion VARCHAR(255) NOT NULL,
    Precio MONEY NOT NULL
);

-- Creaci�n de la tabla Animales
CREATE TABLE Animales (
    IdAnimales INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Edad INT NOT NULL,
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

-- Creaci�n de la tabla Alimentos
CREATE TABLE Alimentos (
    IdAlimentos INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL
);
-- Creaci�n de la tabla DietaAlimentos
CREATE TABLE DietaAlimentos (
    IdDietaAlimentos INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdDieta INT NOT NULL,
    IdAlimentos INT NOT NULL,
    CONSTRAINT FK_DietaAlimentos_IdDieta FOREIGN KEY (IdDieta) REFERENCES Dieta (IdDieta),
    CONSTRAINT FK_DietaAlimentos_IdAlimentos FOREIGN KEY (IdAlimentos) REFERENCES Alimentos (IdAlimentos)
);



-- Creaci�n de la tabla HistorialMovimientos
CREATE TABLE HistorialMovimientos (
    IdHistorialMovimientos INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    FechaMovimiento DATE NOT NULL,
    IdHabitacionAnterior INT NOT NULL,
    IdHabitacionActual INT NOT NULL,
    Motivo VARCHAR(255) NOT NULL,
    IdAnimales INT NOT NULL,
    CONSTRAINT FK_HistorialMovimientos_IdAnimales FOREIGN KEY (IdAnimales) REFERENCES Animales (IdAnimales)
);

-- Creaci�n de la tabla EstadoHabitaci�n
CREATE TABLE EstadoHabitaci�n (
    IdEstadoHabitaci�n INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    estado VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    Fecha DATE NOT NULL
);

-- Creaci�n de la tabla Habitaci�nEstadoHabitaci�n
CREATE TABLE Habitaci�nEstadoHabitaci�n (
    IdHabitaci�nEstadoHabitaci�n INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdHabitacion INT NOT NULL,
    IdEstadoHabitacion INT NOT NULL,
    CONSTRAINT FK_HabitacionEstadoHabitacion_IdHabitacion FOREIGN KEY (IdHabitacion) REFERENCES Habitacion (IdHabitacion),
    CONSTRAINT FK_HabitacionEstadoHabitacion_IdEstadoHabitacion FOREIGN KEY (IdEstadoHabitacion) REFERENCES EstadoHabitaci�n (IdEstadoHabitaci�n)
);

-- Creaci�n de la tabla MantenimientoHabitaci�n
CREATE TABLE MantenimientoHabitaci�n (
    IdMantenimientoHabitaci�n INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    reporte VARCHAR(255) NOT NULL,
    IdTareas INT NOT NULL,
    IdHabitacion INT NOT NULL,
    CONSTRAINT FK_MantenimientoHabitacion_IdHabitacion FOREIGN KEY (IdHabitacion) REFERENCES Habitacion (IdHabitacion)
);

-- Creaci�n de la tabla ControlAnimal
CREATE TABLE ControlAnimal (
    IdControl INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Reporte VARCHAR(255) NOT NULL,
    IdTareas INT NOT NULL,
    IdAnimales INT NOT NULL,
    CONSTRAINT FK_ControlAnimal_IdAnimales FOREIGN KEY (IdAnimales) REFERENCES Animales (IdAnimales)
);


-- Creaci�n de la tabla EstadoTarea
CREATE TABLE EstadoTarea (
    IdEstadoTarea INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL
);


-- Creaci�n de la tabla Puesto
CREATE TABLE Puesto (
    IdPuesto INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Salario FLOAT NOT NULL,
    DescripcionTareas VARCHAR(255) NOT NULL
);
-- Creaci�n de la tabla Empleado
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

-- Creaci�n de la tabla TareasEstadosTareas
CREATE TABLE TareasEstadosTareas (
    IdTareasEstadosTareas INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdTareas INT NOT NULL,
    IdEstadoTarea INT NOT NULL,
    CONSTRAINT FK_TareasEstadosTareas_IdTareas FOREIGN KEY (IdTareas) REFERENCES Tareas (IdTareas),
    CONSTRAINT FK_TareasEstadosTareas_IdEstadoTarea FOREIGN KEY (IdEstadoTarea) REFERENCES EstadoTarea (IdEstadoTarea)
);

-- Creaci�n de la tabla Usuario
CREATE TABLE Usuario (
    IdUsuario INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Contrase�a VARCHAR(255) NOT NULL,
    IdEmpleado INT NOT NULL,
    CONSTRAINT FK_Usuario_IdEmpleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado)
);

-- Creaci�n de la tabla Rol
CREATE TABLE Rol (
    IdRol INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(255) NOT NULL
);

-- Creaci�n de la tabla RolUsario
CREATE TABLE RolUsario (
    IdRolUsario INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdRol INT NOT NULL,
    IdEmpleado INT NOT NULL,
    CONSTRAINT FK_RolUsario_IdEmpleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado),
    CONSTRAINT FK_RolUsario_IdRol FOREIGN KEY (IdRol) REFERENCES Rol (IdRol)
);



-- Creaci�n de la tabla VentaEntrada
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

-- Creaci�n de la tabla DetalleVenta
CREATE TABLE DetalleVenta (
    IdDetalleVenta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdVentaEntrada INT NOT NULL,
    IdTipoEntrada INT NOT NULL,
    Cantidad INT NOT NULL,
    CONSTRAINT FK_DetalleVenta_IdVentaEntrada FOREIGN KEY (IdVentaEntrada) REFERENCES VentaEntrada (IdVentaEntrada),
    CONSTRAINT FK_DetalleVenta_IdTipoEntrada FOREIGN KEY (IdTipoEntrada) REFERENCES TipoEntrada (IdTipoEntrada)
);

-- Creaci�n de la tabla Calificaci�nVisita
CREATE TABLE Calificaci�nVisita (
    IdCalificaci�nVisita BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nota FLOAT NOT NULL,
    SugerenciaMejora VARCHAR(255) NOT NULL,
    fecha DATE NOT NULL,
    IdVisitantes INT NOT NULL,
    CONSTRAINT FK_Calificaci�nVisita_IdVisitantes FOREIGN KEY (IdVisitantes) REFERENCES Visitantes (IdVisitantes)
);

