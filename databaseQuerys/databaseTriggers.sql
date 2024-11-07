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


