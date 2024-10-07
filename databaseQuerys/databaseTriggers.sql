--Trigger
USE ZooMA
GO

CREATE TRIGGER trg_Audit_ZOO
ON ZOO
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'ZOO';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdZoo, NombreZoo, Direccion, DescripcionZoo, Disponibilidad FROM inserted)
       AND NOT EXISTS (SELECT IdZoo, NombreZoo, Direccion, DescripcionZoo, Disponibilidad FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_ZOO (NombreTabla, Operacion, IdZoo, NombreZoo, Direccion, DescripcionZoo, Disponibilidad, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdZoo, NombreZoo, Direccion, DescripcionZoo, Disponibilidad, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdZoo, NombreZoo, Direccion, DescripcionZoo, Disponibilidad FROM inserted)
       AND EXISTS (SELECT IdZoo, NombreZoo, Direccion, DescripcionZoo, Disponibilidad FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_ZOO (NombreTabla, Operacion, IdZoo, NombreZoo, Direccion, DescripcionZoo, Disponibilidad, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdZoo, NombreZoo, Direccion, DescripcionZoo, Disponibilidad, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdZoo, NombreZoo, Direccion, DescripcionZoo, Disponibilidad FROM deleted)
       AND NOT EXISTS (SELECT IdZoo, NombreZoo, Direccion, DescripcionZoo, Disponibilidad FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_ZOO (NombreTabla, Operacion, IdZoo, NombreZoo, Direccion, DescripcionZoo, Disponibilidad, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdZoo, NombreZoo, Direccion, DescripcionZoo, Disponibilidad, @User, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO
CREATE TRIGGER trg_Audit_Habitacion
ON Habitacion
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Habitacion';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion FROM inserted)
       AND NOT EXISTS (SELECT IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Habitacion (NombreTabla, Operacion, IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion FROM inserted)
       AND EXISTS (SELECT IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Habitacion (NombreTabla, Operacion, IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion FROM deleted)
       AND NOT EXISTS (SELECT IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Habitacion (NombreTabla, Operacion, IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdHabitacion, NombreHab, Direccion, Capacidad, IdTipoHabitacion, @User, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO

CREATE TRIGGER trg_Audit_Animales
ON Animales
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Animales';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecies, IdEstadoSalud, IdZoo FROM inserted)
       AND NOT EXISTS (SELECT IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecies, IdEstadoSalud, IdZoo FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Animales (NombreTabla, Operacion, IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecies, IdEstadoSalud, IdZoo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecies, IdEstadoSalud, IdZoo, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecies, IdEstadoSalud, IdZoo FROM inserted)
       AND EXISTS (SELECT IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecies, IdEstadoSalud, IdZoo FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Animales (NombreTabla, Operacion, IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecies, IdEstadoSalud, IdZoo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecies, IdEstadoSalud, IdZoo, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecies, IdEstadoSalud, IdZoo FROM deleted)
       AND NOT EXISTS (SELECT IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecies, IdEstadoSalud, IdZoo FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Animales (NombreTabla, Operacion, IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecies, IdEstadoSalud, IdZoo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdAnimales, NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecies, IdEstadoSalud, IdZoo, @User, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO

CREATE TRIGGER trg_Audit_Especies
ON Especies
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Especies';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdEspecie, NombreEsp FROM inserted)
       AND NOT EXISTS (SELECT IdEspecie, NombreEsp FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Especies (NombreTabla, Operacion, IdEspecie, NombreEsp, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEspecie, NombreEsp, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdEspecie, NombreEsp FROM inserted)
       AND EXISTS (SELECT IdEspecie, NombreEsp FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Especies (NombreTabla, Operacion, IdEspecie, NombreEsp, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEspecie, NombreEsp, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdEspecie, NombreEsp FROM deleted)
       AND NOT EXISTS (SELECT IdEspecie, NombreEsp FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Especies (NombreTabla, Operacion, IdEspecie, NombreEsp, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEspecie, NombreEsp, @User, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO

CREATE TRIGGER trg_Audit_EstadoSalud
ON EstadoSalud
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'EstadoSalud';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdEstadoSalud, estadoSalud FROM inserted)
       AND NOT EXISTS (SELECT IdEstadoSalud, estadoSalud FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_EstadoSalud (NombreTabla, Operacion, IdEstadoSalud, EstadoSalud, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoSalud, estadoSalud, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdEstadoSalud, estadoSalud FROM inserted)
       AND EXISTS (SELECT IdEstadoSalud, estadoSalud FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_EstadoSalud (NombreTabla, Operacion, IdEstadoSalud, EstadoSalud, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoSalud, estadoSalud, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdEstadoSalud, estadoSalud FROM deleted)
       AND NOT EXISTS (SELECT IdEstadoSalud, estadoSalud FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_EstadoSalud (NombreTabla, Operacion, IdEstadoSalud, EstadoSalud, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoSalud, estadoSalud, @User, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO

CREATE TRIGGER trg_Audit_Dieta
ON Dieta
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Dieta';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdDieta, NombreDiet, DescripcionDiet FROM inserted)
       AND NOT EXISTS (SELECT IdDieta, NombreDiet, DescripcionDiet FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Dieta (NombreTabla, Operacion, IdDieta, NombreDiet, DescripcionDiet, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdDieta, NombreDiet, DescripcionDiet, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdDieta, NombreDiet, DescripcionDiet FROM inserted)
       AND EXISTS (SELECT IdDieta, NombreDiet, DescripcionDiet FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Dieta (NombreTabla, Operacion, IdDieta, NombreDiet, DescripcionDiet, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdDieta, NombreDiet, DescripcionDiet, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdDieta, NombreDiet, DescripcionDiet FROM deleted)
       AND NOT EXISTS (SELECT IdDieta, NombreDiet, DescripcionDiet FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Dieta (NombreTabla, Operacion, IdDieta, NombreDiet, DescripcionDiet, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdDieta, NombreDiet, DescripcionDiet, @User, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO

CREATE TRIGGER trg_Audit_TipoHabitacion
ON TipoHabitacion
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'TipoHabitacion';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdTipoHabitacion, NombreTH FROM inserted)
       AND NOT EXISTS (SELECT IdTipoHabitacion, NombreTH FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_TipoHabitacion (NombreTabla, Operacion, IdTipoHabitacion, NombreTH, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTipoHabitacion, NombreTH, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdTipoHabitacion, NombreTH FROM inserted)
       AND EXISTS (SELECT IdTipoHabitacion, NombreTH FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_TipoHabitacion (NombreTabla, Operacion, IdTipoHabitacion, NombreTH, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTipoHabitacion, NombreTH, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdTipoHabitacion, NombreTH FROM deleted)
       AND NOT EXISTS (SELECT IdTipoHabitacion, NombreTH FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_TipoHabitacion (NombreTabla, Operacion, IdTipoHabitacion, NombreTH, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTipoHabitacion, NombreTH, @User, GETDATE()
        FROM deleted;
    END
END
GO

USE ZooMA
GO

CREATE TRIGGER trg_Audit_Alimentos
ON Alimentos
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Alimentos';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdAlimentos, NombreAli FROM inserted)
       AND NOT EXISTS (SELECT IdAlimentos, NombreAli FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Alimentos (NombreTabla, Operacion, IdAlimentos, NombreAli, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdAlimentos, NombreAli, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdAlimentos, NombreAli FROM inserted)
       AND EXISTS (SELECT IdAlimentos, NombreAli FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Alimentos (NombreTabla, Operacion, IdAlimentos, NombreAli, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdAlimentos, NombreAli, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdAlimentos, NombreAli FROM deleted)
       AND NOT EXISTS (SELECT IdAlimentos, NombreAli FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Alimentos (NombreTabla, Operacion, IdAlimentos, NombreAli, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdAlimentos, NombreAli, @User, GETDATE()
        FROM deleted;
    END
END
GO

USE ZooMA
GO

CREATE TRIGGER trg_Audit_DietaAlimentos
ON DietaAlimentos
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'DietaAlimentos';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdDietaAlimentos, IdDieta, IdAlimentos FROM inserted)
       AND NOT EXISTS (SELECT IdDietaAlimentos, IdDieta, IdAlimentos FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_DietaAlimentos (NombreTabla, Operacion, IdDietaAlimentos, IdDieta, IdAlimentos, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdDietaAlimentos, IdDieta, IdAlimentos, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdDietaAlimentos, IdDieta, IdAlimentos FROM inserted)
       AND EXISTS (SELECT IdDietaAlimentos, IdDieta, IdAlimentos FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_DietaAlimentos (NombreTabla, Operacion, IdDietaAlimentos, IdDieta, IdAlimentos, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdDietaAlimentos, IdDieta, IdAlimentos, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdDietaAlimentos, IdDieta, IdAlimentos FROM deleted)
       AND NOT EXISTS (SELECT IdDietaAlimentos, IdDieta, IdAlimentos FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_DietaAlimentos (NombreTabla, Operacion, IdDietaAlimentos, IdDieta, IdAlimentos, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdDietaAlimentos, IdDieta, IdAlimentos, @User, GETDATE()
        FROM deleted;
    END
END
GO

USE ZooMA
GO

CREATE TRIGGER trg_Audit_Visitantes
ON Visitantes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Visitantes';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdVisitantes, nombreVist, apell1Vist, apell2Vist FROM inserted)
       AND NOT EXISTS (SELECT IdVisitantes, nombreVist, apell1Vist, apell2Vist FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Visitantes (NombreTabla, Operacion, IdVisitantes, NombreVist, Apell1Vist, Apell2Vist, Disponibilidad, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdVisitantes, nombreVist, apell1Vist, apell2Vist, disponibilidad, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdVisitantes, nombreVist, apell1Vist, apell2Vist FROM inserted)
       AND EXISTS (SELECT IdVisitantes, nombreVist, apell1Vist, apell2Vist FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Visitantes (NombreTabla, Operacion, IdVisitantes, NombreVist, Apell1Vist, Apell2Vist, Disponibilidad, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdVisitantes, nombreVist, apell1Vist, apell2Vist, disponibilidad, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdVisitantes, nombreVist, apell1Vist, apell2Vist FROM deleted)
       AND NOT EXISTS (SELECT IdVisitantes, nombreVist, apell1Vist, apell2Vist FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Visitantes (NombreTabla, Operacion, IdVisitantes, NombreVist, Apell1Vist, Apell2Vist, Disponibilidad, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdVisitantes, nombreVist, apell1Vist, apell2Vist, disponibilidad, @User, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO

CREATE TRIGGER trg_Audit_TipoEntrada
ON TipoEntrada
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'TipoEntrada';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdTipoEntrada, nombreEnt, decripcionEnt, Precio FROM inserted)
       AND NOT EXISTS (SELECT IdTipoEntrada, nombreEnt, decripcionEnt, Precio FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_TipoEntrada (NombreTabla, Operacion, IdTipoEntrada, NombreEnt, DescripcionEnt, Precio, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTipoEntrada, nombreEnt, decripcionEnt, Precio, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdTipoEntrada, nombreEnt, decripcionEnt, Precio FROM inserted)
       AND EXISTS (SELECT IdTipoEntrada, nombreEnt, decripcionEnt, Precio FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_TipoEntrada (NombreTabla, Operacion, IdTipoEntrada, NombreEnt, DescripcionEnt, Precio, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTipoEntrada, nombreEnt, decripcionEnt, Precio, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdTipoEntrada, nombreEnt, decripcionEnt, Precio FROM deleted)
       AND NOT EXISTS (SELECT IdTipoEntrada, nombreEnt, decripcionEnt, Precio FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_TipoEntrada (NombreTabla, Operacion, IdTipoEntrada, NombreEnt, DescripcionEnt, Precio, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTipoEntrada, nombreEnt, decripcionEnt, Precio, @User, GETDATE()
        FROM deleted;
    END
END
GO

USE ZooMA
GO

CREATE TRIGGER trg_Audit_EstadoHabitacion
ON EstadoHabitacion
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'EstadoHabitacion';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdEstadoHabitacion, estado, descripcion, Fecha FROM inserted)
       AND NOT EXISTS (SELECT IdEstadoHabitacion, estado, descripcion, Fecha FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_EstadoHabitacion (NombreTabla, Operacion, IdEstadoHabitacion, Estado, Descripcion, Fecha, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoHabitacion, estado, descripcion, Fecha, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdEstadoHabitacion, estado, descripcion, Fecha FROM inserted)
       AND EXISTS (SELECT IdEstadoHabitacion, estado, descripcion, Fecha FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_EstadoHabitacion (NombreTabla, Operacion, IdEstadoHabitacion, Estado, Descripcion, Fecha, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoHabitacion, estado, descripcion, Fecha, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdEstadoHabitacion, estado, descripcion, Fecha FROM deleted)
       AND NOT EXISTS (SELECT IdEstadoHabitacion, estado, descripcion, Fecha FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_EstadoHabitacion (NombreTabla, Operacion, IdEstadoHabitacion, Estado, Descripcion, Fecha, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoHabitacion, estado, descripcion, Fecha, @User, GETDATE()
        FROM deleted;
    END
END
GO

USE ZooMA
GO

CREATE TRIGGER trg_Audit_Empleado
ON Empleado
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Empleado';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdEmpleado, Nombre, Apellido1, Apellido2, IdPuesto, IdZoo FROM inserted)
       AND NOT EXISTS (SELECT IdEmpleado, Nombre, Apellido1, Apellido2, IdPuesto, IdZoo FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Empleado (NombreTabla, Operacion, IdEmpleado, Nombre, Apellido1, Apellido2, IdPuesto, IdZoo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEmpleado, Nombre, Apellido1, Apellido2, IdPuesto, IdZoo, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdEmpleado, Nombre, Apellido1, Apellido2, IdPuesto, IdZoo FROM inserted)
       AND EXISTS (SELECT IdEmpleado, Nombre, Apellido1, Apellido2, IdPuesto, IdZoo FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Empleado (NombreTabla, Operacion, IdEmpleado, Nombre, Apellido1, Apellido2, IdPuesto, IdZoo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEmpleado, Nombre, Apellido1, Apellido2, IdPuesto, IdZoo, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdEmpleado, Nombre, Apellido1, Apellido2, IdPuesto, IdZoo FROM deleted)
       AND NOT EXISTS (SELECT IdEmpleado, Nombre, Apellido1, Apellido2, IdPuesto, IdZoo FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Empleado (NombreTabla, Operacion, IdEmpleado, Nombre, Apellido1, Apellido2, IdPuesto, IdZoo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEmpleado, Nombre, Apellido1, Apellido2, IdPuesto, IdZoo, @User, GETDATE()
        FROM deleted;
    END
END
GO

USE ZooMA
GO

CREATE TRIGGER trg_Audit_Puesto
ON Puesto
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Puesto';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdPuesto, Nombre, Salario, DescripcionTareas FROM inserted)
       AND NOT EXISTS (SELECT IdPuesto, Nombre, Salario, DescripcionTareas FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Puesto (NombreTabla, Operacion, IdPuesto, Nombre, Salario, DescripcionTareas, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdPuesto, Nombre, Salario, DescripcionTareas, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdPuesto, Nombre, Salario, DescripcionTareas FROM inserted)
       AND EXISTS (SELECT IdPuesto, Nombre, Salario, DescripcionTareas FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Puesto (NombreTabla, Operacion, IdPuesto, Nombre, Salario, DescripcionTareas, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdPuesto, Nombre, Salario, DescripcionTareas, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdPuesto, Nombre, Salario, DescripcionTareas FROM deleted)
       AND NOT EXISTS (SELECT IdPuesto, Nombre, Salario, DescripcionTareas FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Puesto (NombreTabla, Operacion, IdPuesto, Nombre, Salario, DescripcionTareas, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdPuesto, Nombre, Salario, DescripcionTareas, @User, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO

CREATE TRIGGER trg_Audit_Tareas
ON Tareas
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Tareas';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdTareas, Nombre, Descripcion, IdEmpleado FROM inserted)
       AND NOT EXISTS (SELECT IdTareas, Nombre, Descripcion, IdEmpleado FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Tareas (NombreTabla, Operacion, IdTareas, Nombre, Descripcion, IdEmpleado, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTareas, Nombre, Descripcion, IdEmpleado, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdTareas, Nombre, Descripcion, IdEmpleado FROM inserted)
       AND EXISTS (SELECT IdTareas, Nombre, Descripcion, IdEmpleado FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Tareas (NombreTabla, Operacion, IdTareas, Nombre, Descripcion, IdEmpleado, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTareas, Nombre, Descripcion, IdEmpleado, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdTareas, Nombre, Descripcion, IdEmpleado FROM deleted)
       AND NOT EXISTS (SELECT IdTareas, Nombre, Descripcion, IdEmpleado FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Tareas (NombreTabla, Operacion, IdTareas, Nombre, Descripcion, IdEmpleado, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdTareas, Nombre, Descripcion, IdEmpleado, @User, GETDATE()
        FROM deleted;
    END
END
GO

USE ZooMA
GO

CREATE TRIGGER trg_Audit_EstadoTarea
ON EstadoTarea
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'EstadoTarea';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdEstadoTarea, Nombre FROM inserted)
       AND NOT EXISTS (SELECT IdEstadoTarea, Nombre FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_EstadoTarea (NombreTabla, Operacion, IdEstadoTarea, Nombre, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoTarea, Nombre, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdEstadoTarea, Nombre FROM inserted)
       AND EXISTS (SELECT IdEstadoTarea, Nombre FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_EstadoTarea (NombreTabla, Operacion, IdEstadoTarea, Nombre, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoTarea, Nombre, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdEstadoTarea, Nombre FROM deleted)
       AND NOT EXISTS (SELECT IdEstadoTarea, Nombre FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_EstadoTarea (NombreTabla, Operacion, IdEstadoTarea, Nombre, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdEstadoTarea, Nombre, @User, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO

CREATE TRIGGER trg_Audit_VentaEntrada
ON VentaEntrada
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'VentaEntrada';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdVentaEntrada, fechaventa, horaventa, IdZoo, IdVisitantes, IdMetodoPago FROM inserted)
       AND NOT EXISTS (SELECT IdVentaEntrada, fechaventa, horaventa, IdZoo, IdVisitantes, IdMetodoPago FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_VentaEntrada (NombreTabla, Operacion, IdVentaEntrada, fechaventa, horaventa, IdZoo, IdVisitantes, IdMetodoPago, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdVentaEntrada, fechaventa, horaventa, IdZoo, IdVisitantes, IdMetodoPago, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdVentaEntrada, fechaventa, horaventa, IdZoo, IdVisitantes, IdMetodoPago FROM inserted)
       AND EXISTS (SELECT IdVentaEntrada, fechaventa, horaventa, IdZoo, IdVisitantes, IdMetodoPago FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_VentaEntrada (NombreTabla, Operacion, IdVentaEntrada, fechaventa, horaventa, IdZoo, IdVisitantes, IdMetodoPago, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdVentaEntrada, fechaventa, horaventa, IdZoo, IdVisitantes, IdMetodoPago, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdVentaEntrada, fechaventa, horaventa, IdZoo, IdVisitantes, IdMetodoPago FROM deleted)
       AND NOT EXISTS (SELECT IdVentaEntrada, fechaventa, horaventa, IdZoo, IdVisitantes, IdMetodoPago FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_VentaEntrada (NombreTabla, Operacion, IdVentaEntrada, fechaventa, horaventa, IdZoo, IdVisitantes, IdMetodoPago, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdVentaEntrada, fechaventa, horaventa, IdZoo, IdVisitantes, IdMetodoPago, @User, GETDATE()
        FROM deleted;
    END
END
GO

USE ZooMA
GO

CREATE TRIGGER trg_Audit_MetodoPago
ON MetodoPago
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'MetodoPago';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdMetodoPago, MetodoPago FROM inserted)
       AND NOT EXISTS (SELECT IdMetodoPago, MetodoPago FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_MetodoPago (NombreTabla, Operacion, IdMetodoPago, MetodoPago, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdMetodoPago, MetodoPago, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdMetodoPago, MetodoPago FROM inserted)
       AND EXISTS (SELECT IdMetodoPago, MetodoPago FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_MetodoPago (NombreTabla, Operacion, IdMetodoPago, MetodoPago, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdMetodoPago, MetodoPago, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdMetodoPago, MetodoPago FROM deleted)
       AND NOT EXISTS (SELECT IdMetodoPago, MetodoPago FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_MetodoPago (NombreTabla, Operacion, IdMetodoPago, MetodoPago, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdMetodoPago, MetodoPago, @User, GETDATE()
        FROM deleted;
    END
END
GO



USE ZooMA
GO

CREATE TRIGGER trg_Audit_CalificacionVisita
ON CalificacionVisita
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'CalificacionVisita';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdCalificacionVisita, Nota, SugerenciaMejora, fecha, IdVisitantes FROM inserted)
       AND NOT EXISTS (SELECT IdCalificacionVisita, Nota, SugerenciaMejora, fecha, IdVisitantes FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_CalificacionVisita (NombreTabla, Operacion, IdCalificacionVisita, Nota, SugerenciaMejora, fecha, IdVisitantes, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdCalificacionVisita, Nota, SugerenciaMejora, fecha, IdVisitantes, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdCalificacionVisita, Nota, SugerenciaMejora, fecha, IdVisitantes FROM inserted)
       AND EXISTS (SELECT IdCalificacionVisita, Nota, SugerenciaMejora, fecha, IdVisitantes FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_CalificacionVisita (NombreTabla, Operacion, IdCalificacionVisita, Nota, SugerenciaMejora, fecha, IdVisitantes, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdCalificacionVisita, Nota, SugerenciaMejora, fecha, IdVisitantes, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdCalificacionVisita, Nota, SugerenciaMejora, fecha, IdVisitantes FROM deleted)
       AND NOT EXISTS (SELECT IdCalificacionVisita, Nota, SugerenciaMejora, fecha, IdVisitantes FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_CalificacionVisita (NombreTabla, Operacion, IdCalificacionVisita, Nota, SugerenciaMejora, fecha, IdVisitantes, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdCalificacionVisita, Nota, SugerenciaMejora, fecha, IdVisitantes, @User, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO

CREATE TRIGGER trg_Audit_Rol
ON Rol
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Rol';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdRol, Nombre FROM inserted)
       AND NOT EXISTS (SELECT IdRol, Nombre FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Rol (NombreTabla, Operacion, IdRol, Nombre, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdRol, Nombre, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdRol, Nombre FROM inserted)
       AND EXISTS (SELECT IdRol, Nombre FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Rol (NombreTabla, Operacion, IdRol, Nombre, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdRol, Nombre, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdRol, Nombre FROM deleted)
       AND NOT EXISTS (SELECT IdRol, Nombre FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Rol (NombreTabla, Operacion, IdRol, Nombre, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdRol, Nombre, @User, GETDATE()
        FROM deleted;
    END
END
GO


USE ZooMA
GO

CREATE TRIGGER trg_Audit_Usuario
ON Usuario
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Usuario';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT IdUsuario, Contraseña, IdEmpleado FROM inserted)
       AND NOT EXISTS (SELECT IdUsuario, Contraseña, IdEmpleado FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Usuario (NombreTabla, Operacion, IdUsuario, Contraseña, IdEmpleado, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdUsuario, Contraseña, IdEmpleado, @User, GETDATE()
        FROM inserted;
    END

    -- UPDATE
    IF EXISTS (SELECT IdUsuario, Contraseña, IdEmpleado FROM inserted)
       AND EXISTS (SELECT IdUsuario, Contraseña, IdEmpleado FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Usuario (NombreTabla, Operacion, IdUsuario, Contraseña, IdEmpleado, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdUsuario, Contraseña, IdEmpleado, @User, GETDATE()
        FROM inserted;
    END

    -- DELETE
    IF EXISTS (SELECT IdUsuario, Contraseña, IdEmpleado FROM deleted)
       AND NOT EXISTS (SELECT IdUsuario, Contraseña, IdEmpleado FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Usuario (NombreTabla, Operacion, IdUsuario, Contraseña, IdEmpleado, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdUsuario, Contraseña, IdEmpleado, @User, GETDATE()
        FROM deleted;
    END
END
GO
--FIN Trigger
