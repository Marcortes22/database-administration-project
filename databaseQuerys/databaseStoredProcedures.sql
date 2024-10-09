--Parte 7: SP Insert
USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_HABITACION(
    @NombreHab VARCHAR(20),
    @Direccion VARCHAR(255),
    @Capacidad INT,
    @IdTipoHabitacion INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreHab = '' OR @Direccion = '' OR @Capacidad = '' OR @IdTipoHabitacion IS NULL)
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        IF NOT EXISTS (SELECT 1 FROM TipoHabitacion WHERE IdTipoHabitacion = @IdTipoHabitacion)
        BEGIN
            PRINT 'El tipo de habitación no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        INSERT INTO Habitacion (NombreHab, Direccion, Capacidad, IdTipoHabitacion)
        VALUES (@NombreHab, @Direccion, @Capacidad, @IdTipoHabitacion);
        
        COMMIT TRANSACTION;
        PRINT 'Habitación registrada correctamente: ' + @NombreHab;
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_EMPLEADO(
    @Nombre VARCHAR(20),
    @Apellido1 VARCHAR(20),
    @Apellido2 VARCHAR(20),
    @IdPuesto INT,
    @IdZoo INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Nombre = '' OR @Apellido1 = '' OR @Apellido2 = '' OR @IdPuesto IS NULL OR @IdZoo IS NULL)
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        IF NOT EXISTS (SELECT 1 FROM ZOO WHERE IdZoo = @IdZoo)
        BEGIN
            PRINT 'El zoológico no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        IF NOT EXISTS (SELECT 1 FROM Puesto WHERE IdPuesto = @IdPuesto)
        BEGIN
            PRINT 'El puesto no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        DECLARE @IdEmpleado VARCHAR(50);
        SET @IdEmpleado = @Nombre + '-' + @Apellido1 + '-' + @Apellido2;

        IF EXISTS (SELECT 1 FROM Empleado WHERE Nombre = @Nombre AND Apellido1 = @Apellido1 AND Apellido2 = @Apellido2)
        BEGIN
            PRINT 'El empleado ya existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Empleado (Nombre, Apellido1, Apellido2, IdPuesto, IdZoo)
        VALUES (@Nombre, @Apellido1, @Apellido2, @IdPuesto, @IdZoo);
        
        COMMIT TRANSACTION;
        PRINT 'Empleado registrado correctamente: ' + @Nombre + ' ' + @Apellido1 + ' ' + @Apellido2;
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_ANIMAL(
    @NombreAni VARCHAR(20),
    @EdadAni INT,
    @IdDieta INT,
    @IdHabitacion INT,
    @IdEspecie INT,
    @IdEstadoSalud INT,
    @IdZoo INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreAni = '' OR @EdadAni IS NULL OR @IdDieta IS NULL OR @IdHabitacion IS NULL OR @IdEspecie IS NULL OR @IdEstadoSalud IS NULL OR @IdZoo IS NULL)
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM ZOO WHERE IdZoo = @IdZoo)
        BEGIN
            PRINT 'El Zoológico no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM Dieta WHERE IdDieta = @IdDieta)
        BEGIN
            PRINT 'La Dieta no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM TipoHabitacion WHERE IdTipoHabitacion = @IdHabitacion)
        BEGIN
            PRINT 'La Habitación no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM Especies WHERE IdEspecie = @IdEspecie)
        BEGIN
            PRINT 'La Especie no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM EstadoSalud WHERE IdEstadoSalud = @IdEstadoSalud)
        BEGIN
            PRINT 'El Estado de Salud no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Animales (NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud, IdZoo)
        VALUES (@NombreAni, @EdadAni, @IdDieta, @IdHabitacion, @IdEspecie, @IdEstadoSalud, @IdZoo);

        COMMIT TRANSACTION;
        PRINT 'Animal registrado correctamente: ' + @NombreAni;
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_DIETA(
    @NombreDiet VARCHAR(20),
    @DescripcionDiet VARCHAR(255)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreDiet = '' OR @DescripcionDiet = '')
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM Dieta WHERE NombreDiet = @NombreDiet)
        BEGIN
            PRINT 'La dieta ya existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Dieta (NombreDiet, DescripcionDiet)
        VALUES (@NombreDiet, @DescripcionDiet);

        COMMIT TRANSACTION;
        PRINT 'Dieta registrada correctamente: ' + @NombreDiet;
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_ESTADO_SALUD(
    @estadoSalud VARCHAR(255)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@estadoSalud = '')
        BEGIN
            PRINT 'No se puede ingresar un estado de salud vacío';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM EstadoSalud WHERE estadoSalud = @estadoSalud)
        BEGIN
            PRINT 'El estado de salud ya existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO EstadoSalud (estadoSalud)
        VALUES (@estadoSalud);

        COMMIT TRANSACTION;
        PRINT 'Estado de salud registrado correctamente: ' + @estadoSalud;

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_ESPECIE(
    @NombreEsp VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreEsp = '')
        BEGIN
            PRINT 'No se puede ingresar un nombre de especie vacío';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM Especies WHERE NombreEsp = @NombreEsp)
        BEGIN
            PRINT 'La especie ya existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Especies (NombreEsp)
        VALUES (@NombreEsp);

        COMMIT TRANSACTION;
        PRINT 'Especie registrada correctamente: ' + @NombreEsp;

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_VISITANTE(
    @NombreVist VARCHAR(20),
    @Apell1Vist VARCHAR(20),
    @Apell2Vist VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreVist = '' OR @Apell1Vist = '' OR @Apell2Vist = '')
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM Visitantes WHERE nombreVist = @NombreVist AND apell1Vist = @Apell1Vist AND apell2Vist = @Apell2Vist)
        BEGIN
            PRINT 'El visitante ya existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Visitantes (nombreVist, apell1Vist, apell2Vist)
        VALUES (@NombreVist, @Apell1Vist, @Apell2Vist);

        COMMIT TRANSACTION;
        PRINT 'Visitante registrado correctamente: ' + @NombreVist + ' ' + @Apell1Vist + ' ' + @Apell2Vist;

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_ESTADOHABITACION(
    @Estado VARCHAR(50),
    @Descripcion VARCHAR(255),
    @Fecha DATE
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Estado = '' OR @Descripcion = '' OR @Fecha IS NULL)
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF (@Fecha > GETDATE())
        BEGIN
            PRINT 'La fecha no puede ser futura';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO EstadoHabitacion (estado, descripcion, Fecha)
        VALUES (@Estado, @Descripcion, @Fecha);

        COMMIT TRANSACTION;
        PRINT 'Estado de habitación registrado correctamente: ' + @Estado + ', Descripción: ' + @Descripcion + ', Fecha: ' + CAST(@Fecha AS VARCHAR);

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_PUESTO(
    @Nombre VARCHAR(20),
    @Salario FLOAT,
    @DescripcionTareas VARCHAR(255)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Nombre = '' OR @DescripcionTareas = '' OR @Salario IS NULL)
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF (@Salario < 0)
        BEGIN
            PRINT 'El salario no puede ser negativo';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM Puesto WHERE Nombre = @Nombre)
        BEGIN
            PRINT 'El puesto ya existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Puesto (Nombre, Salario, DescripcionTareas)
        VALUES (@Nombre, @Salario, @DescripcionTareas);

        COMMIT TRANSACTION;
        PRINT 'Puesto registrado correctamente: ' + @Nombre + ', Salario: ' + CAST(@Salario AS VARCHAR) + ', Descripción: ' + @DescripcionTareas;

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_TIPOHABITACION(
    @NombreTH VARCHAR(255)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreTH = '')
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM TipoHabitacion WHERE NombreTH = @NombreTH)
        BEGIN
            PRINT 'El tipo de habitación ya existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO TipoHabitacion (NombreTH)
        VALUES (@NombreTH);

        COMMIT TRANSACTION;
        PRINT 'Tipo de Habitación registrado correctamente: ' + @NombreTH;

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_ZOO(
    @NombreZoo VARCHAR(20),
    @Direccion VARCHAR(100),
    @DescripcionZoo VARCHAR(255)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreZoo = '' OR @Direccion = '' OR @DescripcionZoo = '')
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM ZOO WHERE NombreZoo = @NombreZoo)
        BEGIN
            PRINT 'El Zoológico Ya Existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO ZOO (NombreZoo, Direccion, DescripcionZoo)
        VALUES (@NombreZoo, @Direccion, @DescripcionZoo);

        COMMIT TRANSACTION;
        PRINT 'Zoológico registrado correctamente: ' + @NombreZoo;

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_TAREA(
    @Nombre VARCHAR(20),
    @Descripcion VARCHAR(255),
    @IdEmpleado INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Nombre = '' OR @Descripcion = '' OR @IdEmpleado IS NULL)
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @IdEmpleado)
        BEGIN
            PRINT 'El empleado no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM Tareas WHERE Nombre = @Nombre AND IdEmpleado = @IdEmpleado)
        BEGIN
            PRINT 'La tarea ya existe para este empleado';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Tareas (Nombre, Descripcion, IdEmpleado)
        VALUES (@Nombre, @Descripcion, @IdEmpleado);

        COMMIT TRANSACTION;
        PRINT 'Tarea registrada correctamente: ' + @Nombre;

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_CALIFICACION_VISITA(
    @Nota INT,
    @SugerenciaMejora VARCHAR(255),
    @Fecha DATE,
    @IdVisitantes INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Nota IS NULL OR @SugerenciaMejora = '' OR @Fecha IS NULL OR @IdVisitantes IS NULL)
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Visitantes WHERE IdVisitantes = @IdVisitantes)
        BEGIN
            PRINT 'El visitante no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO CalificacionVisita (Nota, SugerenciaMejora, fecha, IdVisitantes)
        VALUES (@Nota, @SugerenciaMejora, @Fecha, @IdVisitantes);

        COMMIT TRANSACTION;
        PRINT 'Calificación de visita registrada correctamente. Nota: ' + CAST(@Nota AS VARCHAR)
              + ', Sugerencia: ' + @SugerenciaMejora;

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO


USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_TIPO_ENTRADA(
    @NombreEnt VARCHAR(20),
    @Precio MONEY
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreEnt = '' OR @Precio IS NULL)
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM TipoEntrada WHERE nombreEnt = @NombreEnt)
        BEGIN
            PRINT 'El tipo de entrada ya existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO TipoEntrada (nombreEnt, Precio)
        VALUES (@NombreEnt, @Precio);

        COMMIT TRANSACTION;
        PRINT 'Tipo de entrada registrado correctamente. Nombre: ' + @NombreEnt
              + ', Precio: ' + CAST(@Precio AS VARCHAR);

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_ROL(
    @nombre VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@nombre = '')
        BEGIN
            PRINT 'El nombre del rol no puede estar en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM Rol WHERE nombre = @nombre)
        BEGIN
            PRINT 'El rol ya existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Rol (nombre)
        VALUES (@nombre);
        
        COMMIT TRANSACTION;
        PRINT 'Rol registrado correctamente: ' + @nombre;
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_USUARIO_ROL(
    @Contraseña VARCHAR(255),
    @IdEmpleado INT,
    @IdRol INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Contraseña = '' OR @IdEmpleado IS NULL OR @IdRol IS NULL)
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco o nulos';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @IdEmpleado)
        BEGIN
            PRINT 'El empleado no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Rol WHERE IdRol = @IdRol)
        BEGIN
            PRINT 'El rol no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Usuario (Contraseña, IdEmpleado)
        VALUES (@Contraseña, @IdEmpleado);

        DECLARE @IdUsuario INT;
        SET @IdUsuario = SCOPE_IDENTITY();

        IF EXISTS (SELECT 1 FROM RolUsario WHERE IdUsuario = @IdUsuario AND IdRol = @IdRol)
        BEGIN
            PRINT 'El usuario ya tiene este rol asignado';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO RolUsario (IdUsuario, IdRol)
        VALUES (@IdUsuario, @IdRol);

        COMMIT TRANSACTION;
        PRINT 'Usuario registrado y rol asignado correctamente';

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;

    END CATCH
END
GO

USE ZooMA
GO
CREATE PROCEDURE SP_INGRESAR_VENTA_ENTRADA (
    @fechaventa DATE,
    @horaventa TIME,
    @IdZoo INT,
    @IdVisitantes INT,
    @IdMetodoPago INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@fechaventa IS NULL OR @horaventa IS NULL OR @IdZoo IS NULL OR @IdVisitantes IS NULL OR @IdMetodoPago IS NULL)
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco o nulos';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM ZOO WHERE IdZoo = @IdZoo)
        BEGIN
            PRINT 'El zoológico no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Visitantes WHERE IdVisitantes = @IdVisitantes)
        BEGIN
            PRINT 'El visitante no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM MetodoPago WHERE IdMetodoPago = @IdMetodoPago)
        BEGIN
            PRINT 'El método de pago no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO VentaEntrada (fechaventa, horaventa, IdZoo, IdVisitantes, IdMetodoPago)
        VALUES (@fechaventa, @horaventa, @IdZoo, @IdVisitantes, @IdMetodoPago);
        
        COMMIT TRANSACTION;
        PRINT 'Venta de entrada registrada correctamente: ' + CONVERT(VARCHAR(10), @fechaventa) + ' a las ' + CONVERT(VARCHAR(8), @horaventa);
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO
--FIN SP Insert

--parte 9: SP Actualizar
USE ZooMA
GO
CREATE PROCEDURE SP_ACTUALIZAR_EstadoSalud (
    @IdEstadoSalud INT,
    @EstadoSalud VARCHAR(255)
)
AS
BEGIN
    IF(@IdEstadoSalud IS NULL OR @IdEstadoSalud = 0 OR @EstadoSalud = '')
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o inválidos';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM EstadoSalud WHERE IdEstadoSalud = @IdEstadoSalud)
    BEGIN
        PRINT 'El estado de salud no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE EstadoSalud
        SET estadoSalud = @EstadoSalud
        WHERE IdEstadoSalud = @IdEstadoSalud;

        COMMIT TRANSACTION;

        PRINT 'Registro del estado de salud actualizado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al actualizar el estado de salud: ' + @ErrorMessage;

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ACTUALIZAR_Especie (
    @IdEspecie INT,
    @NombreEsp VARCHAR(20)
)
AS
BEGIN

    IF(@IdEspecie IS NULL OR @IdEspecie = 0 OR @NombreEsp = '')
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o inválidos';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Especies WHERE IdEspecie = @IdEspecie)
    BEGIN
        PRINT 'La especie no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE Especies
        SET NombreEsp = @NombreEsp
        WHERE IdEspecie = @IdEspecie;

        COMMIT TRANSACTION;

        PRINT 'Registro de la especie actualizado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al actualizar la especie: ' + @ErrorMessage;

    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ACTUALIZAR_Dieta (
    @IdDieta INT,
    @NombreDiet VARCHAR(20),
    @DescripcionDiet VARCHAR(255)
)
AS
BEGIN
    IF(@IdDieta IS NULL OR @IdDieta = 0 OR @NombreDiet = '' OR @DescripcionDiet = '')
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o inválidos';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Dieta WHERE IdDieta = @IdDieta)
    BEGIN
        PRINT 'La dieta no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE Dieta
        SET NombreDiet = @NombreDiet,
            DescripcionDiet = @DescripcionDiet
        WHERE IdDieta = @IdDieta;

        COMMIT TRANSACTION;

        PRINT 'Registro de la dieta actualizado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al actualizar la dieta: ' + @ErrorMessage;

    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ACTUALIZAR_TIPOHABITACION (
    @IdTipoHabitacion INT,
    @NombreTH VARCHAR(20)
)
AS
BEGIN

    IF (@IdTipoHabitacion IS NULL OR @IdTipoHabitacion = 0 OR @NombreTH = '')
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o inválidos';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM TipoHabitacion WHERE IdTipoHabitacion = @IdTipoHabitacion)
    BEGIN
        PRINT 'El tipo de habitación no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE TipoHabitacion
        SET NombreTH = @NombreTH
        WHERE IdTipoHabitacion = @IdTipoHabitacion;

        COMMIT TRANSACTION;

        PRINT 'Registro del tipo de habitación actualizado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al actualizar el registro del tipo de habitación: ' + @ErrorMessage;
    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ACTUALIZAR_Zoo (
    @IdZoo INT,
    @NombreZoo VARCHAR(20),
    @Direccion VARCHAR(100),
    @DescripcionZoo VARCHAR(255)
)
AS
BEGIN
    IF(@IdZoo IS NULL OR @IdZoo = 0 OR @NombreZoo = '' OR @Direccion = '' OR @DescripcionZoo = '')
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o inválidos';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM ZOO WHERE IdZoo = @IdZoo)
    BEGIN
        PRINT 'El zoo no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE ZOO
        SET NombreZoo = @NombreZoo,
            Direccion = @Direccion,
            DescripcionZoo = @DescripcionZoo
        WHERE IdZoo = @IdZoo;

        COMMIT TRANSACTION;

        PRINT 'Registro del zoo actualizado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al actualizar el registro del zoo: ' + @ErrorMessage;

    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ACTUALIZAR_Habitacion (
    @IdHabitacion INT,
    @NombreHab VARCHAR(20),
    @Direccion VARCHAR(100),
    @Capacidad BIT,
    @IdTipoHabitacion INT
)
AS
BEGIN
    IF(@IdHabitacion IS NULL OR @IdHabitacion = 0 OR @NombreHab = '' OR @Direccion = '')
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o inválidos';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Habitacion WHERE IdHabitacion = @IdHabitacion)
    BEGIN
        PRINT 'La habitación no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Habitacion
        SET NombreHab = @NombreHab,
            Direccion = @Direccion,
            Capacidad = @Capacidad,
            IdTipoHabitacion = @IdTipoHabitacion
        WHERE IdHabitacion = @IdHabitacion;

        COMMIT TRANSACTION;

        PRINT 'Registro de la habitación actualizado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al actualizar la habitación: ' + @ErrorMessage;

    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ACTUALIZAR_Visitante (
    @IdVisitantes INT,
    @nombreVist VARCHAR(20),
    @apell1Vist VARCHAR(20),
    @apell2Vist VARCHAR(20)
)
AS
BEGIN

    IF(@IdVisitantes IS NULL OR @IdVisitantes = 0 OR @nombreVist = '' OR @apell1Vist = '' OR @apell2Vist = '')
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o inválidos';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Visitantes WHERE IdVisitantes = @IdVisitantes)
    BEGIN
        PRINT 'El visitante no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Visitantes
        SET nombreVist = @nombreVist,
            apell1Vist = @apell1Vist,
            apell2Vist = @apell2Vist
        WHERE IdVisitantes = @IdVisitantes;

        COMMIT TRANSACTION;

        PRINT 'Registro del visitante actualizado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al actualizar el visitante: ' + @ErrorMessage;

    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_EDITAR_Animales (
    @IdAnimal INT,
    @NombreAni VARCHAR(20),
    @EdadAni INT,
    @IdDieta INT,
    @IdHabitacion INT,
    @IdEspecie INT,
    @IdEstadoSalud INT,
    @IdZoo INT
)
AS
BEGIN

    IF(@IdAnimal IS NULL OR @NombreAni = '' OR @EdadAni IS NULL OR @IdDieta IS NULL OR 
       @IdHabitacion IS NULL OR @IdEspecie IS NULL OR @IdEstadoSalud IS NULL OR @IdZoo IS NULL)
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o inválidos';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Animales WHERE IdAnimales = @IdAnimal)
    BEGIN
        PRINT 'El animal no existe';
        RETURN;
    END

    UPDATE Animales
    SET NombreAni = @NombreAni,
        EdadAni = @EdadAni,
        IdDieta = @IdDieta,
        IdHabitacion = @IdHabitacion,
        IdEspecie = @IdEspecie,
        IdEstadoSalud = @IdEstadoSalud,
        IdZoo = @IdZoo
    WHERE IdAnimales = @IdAnimal;

    PRINT 'Datos del animal actualizados correctamente';
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_EDITAR_ESTADOHABITACION (
    @IdEstadoHabitacion INT,
    @Estado VARCHAR(50),
    @Descripcion VARCHAR(255),
    @Fecha DATE
)
AS
BEGIN

    IF (@IdEstadoHabitacion IS NULL OR @IdEstadoHabitacion = 0 OR @Estado = '' OR @Descripcion = '' OR @Fecha IS NULL)
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o inválidos';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM EstadoHabitacion WHERE IdEstadoHabitacion = @IdEstadoHabitacion)
    BEGIN
        PRINT 'El estado de habitación no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE EstadoHabitacion
        SET estado = @Estado,
            descripcion = @Descripcion,
            Fecha = @Fecha
        WHERE IdEstadoHabitacion = @IdEstadoHabitacion;

        COMMIT TRANSACTION;

        PRINT 'Registro del estado de la habitación actualizado correctamente';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al actualizar el estado de la habitación: ' + @ErrorMessage;
    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ACTUALIZAR_PUESTO (
    @IdPuesto INT,
    @Nombre VARCHAR(20),
    @Salario FLOAT,
    @DescripcionTareas VARCHAR(255)
)
AS
BEGIN

    IF (@IdPuesto IS NULL OR @IdPuesto = 0 OR @Nombre = '' OR @Salario IS NULL OR @DescripcionTareas = '')
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o inválidos';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Puesto WHERE IdPuesto = @IdPuesto)
    BEGIN
        PRINT 'El puesto no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE Puesto
        SET Nombre = @Nombre,
            Salario = @Salario,
            DescripcionTareas = @DescripcionTareas
        WHERE IdPuesto = @IdPuesto;

        COMMIT TRANSACTION;

        PRINT 'Registro del puesto actualizado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al actualizar el puesto: ' + @ErrorMessage;

    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ACTUALIZAR_Empleado (
    @IdEmpleado INT,
    @Nombre VARCHAR(20),
    @Apellido1 VARCHAR(20),
    @Apellido2 VARCHAR(20),
    @IdPuesto INT,
    @IdZoo INT
)
AS
BEGIN
    IF(@IdEmpleado IS NULL OR @IdEmpleado = 0 OR @Nombre = '' OR @Apellido1 = '' OR @Apellido2 = '' OR @IdPuesto IS NULL OR @IdZoo IS NULL)
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o inválidos';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @IdEmpleado)
    BEGIN
        PRINT 'El empleado no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE Empleado
        SET Nombre = @Nombre,
            Apellido1 = @Apellido1,
            Apellido2 = @Apellido2,
            IdPuesto = @IdPuesto,
            IdZoo = @IdZoo
        WHERE IdEmpleado = @IdEmpleado;

        COMMIT TRANSACTION;

        PRINT 'Registro del empleado actualizado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al actualizar el empleado: ' + @ErrorMessage;

    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ACTUALIZAR_Tareas (
    @IdTareas INT,
    @Nombre VARCHAR(20),
    @Descripcion VARCHAR(255),
    @IdEmpleado INT
)
AS
BEGIN

    IF (@IdTareas IS NULL OR @IdTareas = 0 OR @Nombre = '' OR @Descripcion = '' OR @IdEmpleado IS NULL)
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o inválidos';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Tareas WHERE IdTareas = @IdTareas)
    BEGIN
        PRINT 'La tarea no existe';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @IdEmpleado)
    BEGIN
        PRINT 'El empleado no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Tareas
        SET Nombre = @Nombre,
            Descripcion = @Descripcion,
            IdEmpleado = @IdEmpleado
        WHERE IdTareas = @IdTareas;

        COMMIT TRANSACTION;

        PRINT 'Registro de la tarea actualizado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al actualizar la tarea: ' + @ErrorMessage;
    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ACTUALIZAR_Usuario (
    @IdUsuario INT,
    @Contraseña VARCHAR(20),
    @IdEmpleado INT
)
AS
BEGIN

    IF(@IdUsuario IS NULL OR @IdUsuario = 0 OR @Contraseña = '' OR @IdEmpleado IS NULL)
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o inválidos';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE IdUsuario = @IdUsuario)
    BEGIN
        PRINT 'El usuario no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Usuario
        SET Contraseña = @Contraseña,
            IdEmpleado = @IdEmpleado
        WHERE IdUsuario = @IdUsuario;

        COMMIT TRANSACTION;

        PRINT 'Registro del usuario actualizado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al actualizar el usuario: ' + @ErrorMessage;

    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ACTUALIZAR_Rol (
    @IdRol INT,
    @nombre VARCHAR(20)
)
AS
BEGIN

    IF(@IdRol IS NULL OR @IdRol = 0 OR @nombre = '')
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o inválidos';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Rol WHERE IdRol = @IdRol)
    BEGIN
        PRINT 'El rol no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Rol
        SET nombre = @nombre
        WHERE IdRol = @IdRol;

        COMMIT TRANSACTION;

        PRINT 'Registro del rol actualizado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al actualizar el rol: ' + @ErrorMessage;

    END CATCH
END;
GO


USE ZooMA
GO
CREATE PROCEDURE SP_ACTUALIZAR_TipoEntrada (
    @IdTipoEntrada INT,
    @nombreEnt VARCHAR(20),
    @descripcionEnt VARCHAR(255),
    @Precio MONEY
)
AS
BEGIN
    IF(@IdTipoEntrada IS NULL OR @IdTipoEntrada = 0 OR @nombreEnt = '' OR @descripcionEnt = '' OR @Precio IS NULL)
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o inválidos';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM TipoEntrada WHERE IdTipoEntrada = @IdTipoEntrada)
    BEGIN
        PRINT 'El tipo de entrada no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE TipoEntrada
        SET nombreEnt = @nombreEnt,
            descripcionEnt = @descripcionEnt,
            Precio = @Precio
        WHERE IdTipoEntrada = @IdTipoEntrada;

        COMMIT TRANSACTION;

        PRINT 'Registro del tipo de entrada actualizado correctamente';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al actualizar el tipo de entrada: ' + @ErrorMessage;

    END CATCH
END;
GO
--FIN SP Actualizar

--Parte 10: SP Eliminar
USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_EstadoSalud (
    @IdEstadoSalud INT
)
AS
BEGIN

    IF(@IdEstadoSalud IS NULL OR @IdEstadoSalud = 0)
    BEGIN
        PRINT 'El ID del estado de salud no puede ser un campo vacío o ser cero';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM EstadoSalud WHERE IdEstadoSalud = @IdEstadoSalud)
    BEGIN
        PRINT 'El estado de salud no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM EstadoSalud
        WHERE IdEstadoSalud = @IdEstadoSalud;

        COMMIT TRANSACTION;

        PRINT 'Registro del estado de salud eliminado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar el estado de salud: ' + @ErrorMessage;

    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_Especie (
    @IdEspecie INT
)
AS
BEGIN

    IF(@IdEspecie IS NULL OR @IdEspecie = 0)
    BEGIN
        PRINT 'El ID de la especie no puede ser un campo vacío o ser cero';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Especies WHERE IdEspecie = @IdEspecie)
    BEGIN
        PRINT 'La especie no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM Especies
        WHERE IdEspecie = @IdEspecie;

        COMMIT TRANSACTION;

        PRINT 'Registro de la especie eliminado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar la especie: ' + @ErrorMessage;

    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_Dieta (
    @IdDieta INT
)
AS
BEGIN
    IF(@IdDieta IS NULL OR @IdDieta = 0)
    BEGIN
        PRINT 'El ID de la dieta no puede ser un campo vacío o ser cero';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Dieta WHERE IdDieta = @IdDieta)
    BEGIN
        PRINT 'La dieta no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM Dieta
        WHERE IdDieta = @IdDieta;

        COMMIT TRANSACTION;

        PRINT 'Registro de la dieta eliminado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar la dieta: ' + @ErrorMessage;

    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_TIPOHABITACION (
    @IdTipoHabitacion INT
)
AS
BEGIN
    IF (@IdTipoHabitacion IS NULL OR @IdTipoHabitacion = 0)
    BEGIN
        PRINT 'El ID del tipo de habitación no puede ser un campo vacío o ser cero';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM TipoHabitacion WHERE IdTipoHabitacion = @IdTipoHabitacion)
    BEGIN
        PRINT 'El tipo de habitación no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM TipoHabitacion
        WHERE IdTipoHabitacion = @IdTipoHabitacion;

        COMMIT TRANSACTION;

        PRINT 'Registro del tipo de habitación eliminado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar el tipo de habitación: ' + @ErrorMessage;
    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_ZOO (
    @IdZoo INT
)
AS
BEGIN

    IF (@IdZoo IS NULL OR @IdZoo = 0)
    BEGIN
        PRINT 'El ID del zoo no puede ser un campo vacío o ser cero';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM ZOO WHERE IdZoo = @IdZoo)
    BEGIN
        PRINT 'El zoo no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM ZOO
        WHERE IdZoo = @IdZoo;

        COMMIT TRANSACTION;

        PRINT 'Registro del zoo eliminado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar el registro del zoo: ' + @ErrorMessage;
    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_Habitacion (
    @IdHabitacion INT
)
AS
BEGIN

    IF(@IdHabitacion IS NULL OR @IdHabitacion = 0)
    BEGIN
        PRINT 'El ID de la habitación no puede ser un campo vacío o ser cero';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Habitacion WHERE IdHabitacion = @IdHabitacion)
    BEGIN
        PRINT 'La habitación no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM Habitacion
        WHERE IdHabitacion = @IdHabitacion;

        COMMIT TRANSACTION;

        PRINT 'Registro de la habitación eliminado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar la habitación: ' + @ErrorMessage;

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_Visitante (
    @IdVisitantes INT
)
AS
BEGIN
    IF(@IdVisitantes IS NULL OR @IdVisitantes = 0)
    BEGIN
        PRINT 'El ID del visitante no puede ser un campo vacío o ser cero';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Visitantes WHERE IdVisitantes = @IdVisitantes)
    BEGIN
        PRINT 'El visitante no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM Visitantes
        WHERE IdVisitantes = @IdVisitantes;

        COMMIT TRANSACTION;

        PRINT 'Registro del visitante eliminado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar el visitante: ' + @ErrorMessage;

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_Animales (
    @IdAnimal INT
)
AS
BEGIN

    IF(@IdAnimal IS NULL OR @IdAnimal = 0)
    BEGIN
        PRINT 'El ID del animal no puede ser un campo vacío o ser cero';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Animales WHERE IdAnimales = @IdAnimal)
    BEGIN
        PRINT 'El animal no existe';
        RETURN;
    END

    DELETE FROM Animales
    WHERE IdAnimales = @IdAnimal;

    PRINT 'El registro del animal ha sido eliminado correctamente';
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_ESTADOHABITACION (
    @IdEstadoHabitacion INT
)
AS
BEGIN
    IF (@IdEstadoHabitacion IS NULL OR @IdEstadoHabitacion = 0)
    BEGIN
        PRINT 'El ID del estado de la habitación no puede ser un campo vacío o ser cero';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM EstadoHabitacion WHERE IdEstadoHabitacion = @IdEstadoHabitacion)
    BEGIN
        PRINT 'El estado de habitación no existe';
        RETURN;
    END

    DELETE FROM EstadoHabitacion
    WHERE IdEstadoHabitacion = @IdEstadoHabitacion;

    PRINT 'El registro del estado de la habitación ha sido eliminado correctamente';
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_PUESTO (
    @IdPuesto INT
)
AS
BEGIN

    IF (@IdPuesto IS NULL OR @IdPuesto = 0)
    BEGIN
        PRINT 'El ID del puesto no puede ser un campo vacío o ser cero';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Puesto WHERE IdPuesto = @IdPuesto)
    BEGIN
        PRINT 'El puesto no existe';
        RETURN;
    END

    DELETE FROM Puesto
    WHERE IdPuesto = @IdPuesto;

    PRINT 'El registro del puesto ha sido eliminado correctamente';
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_Empleado (
    @IdEmpleado INT
)
AS
BEGIN

    IF(@IdEmpleado IS NULL OR @IdEmpleado = 0)
    BEGIN
        PRINT 'El ID del empleado no puede ser un campo vacío o ser cero';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @IdEmpleado)
    BEGIN
        PRINT 'El empleado no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM Empleado
        WHERE IdEmpleado = @IdEmpleado;

        COMMIT TRANSACTION;

        PRINT 'Registro del empleado eliminado correctamente';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar el empleado: ' + @ErrorMessage;

    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_Tareas (
    @IdTareas INT
)
AS
BEGIN
    IF (@IdTareas IS NULL OR @IdTareas = 0)
    BEGIN
        PRINT 'El ID de la tarea no puede ser un campo vacío o ser cero';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Tareas WHERE IdTareas = @IdTareas)
    BEGIN
        PRINT 'La tarea no existe';
        RETURN;
    END

    DELETE FROM Tareas
    WHERE IdTareas = @IdTareas;

    PRINT 'El registro de la tarea ha sido eliminado correctamente';
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_Usuario (
    @IdUsuario INT
)
AS
BEGIN

    IF(@IdUsuario IS NULL OR @IdUsuario = 0)
    BEGIN
        PRINT 'El ID del usuario no puede ser un campo vacío o ser cero';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE IdUsuario = @IdUsuario)
    BEGIN
        PRINT 'El usuario no existe';
        RETURN;
    END

    DELETE FROM Usuario
    WHERE IdUsuario = @IdUsuario;

    PRINT 'El registro del usuario ha sido eliminado correctamente';
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_Rol (
    @IdRol INT
)
AS
BEGIN

    IF(@IdRol IS NULL OR @IdRol = 0)
    BEGIN
        PRINT 'El ID del rol no puede ser un campo vacío o ser cero';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Rol WHERE IdRol = @IdRol)
    BEGIN
        PRINT 'El rol no existe';
        RETURN;
    END

    DELETE FROM Rol
    WHERE IdRol = @IdRol;

    PRINT 'El registro del rol ha sido eliminado correctamente';
END;
GO


USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_TipoEntrada (
    @IdTipoEntrada INT
)
AS
BEGIN
    IF(@IdTipoEntrada IS NULL OR @IdTipoEntrada = 0)
    BEGIN
        PRINT 'El ID del tipo de entrada no puede ser un campo vacío o ser cero';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM TipoEntrada WHERE IdTipoEntrada = @IdTipoEntrada)
    BEGIN
        PRINT 'El tipo de entrada no existe';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        DELETE FROM TipoEntrada
        WHERE IdTipoEntrada = @IdTipoEntrada;

        COMMIT TRANSACTION;

        PRINT 'Registro del tipo de entrada eliminado correctamente';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar el tipo de entrada: ' + @ErrorMessage;

    END CATCH
END;
GO
--FIN SP Eliminar

---Parte 11: SP mostrar registro Auditoria
USE ZooMA
GO
CREATE PROCEDURE SP_Audit_ZOO
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdZoo AS [ID del Zoológico],
        NombreZoo AS [Nombre del Zoológico],
        Direccion AS [Dirección del Zoológico],
        DescripcionZoo AS [Descripción del Zoológico],
        Disponibilidad AS [Disponibilidad],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_ZOO
    ORDER BY IdAudit;
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_Audit_Habitacion
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdHabitacion AS [ID de la Habitación],
        NombreHab AS [Nombre de la Habitación],
        Direccion AS [Dirección de la Habitación],
        Capacidad AS [Capacidad],
        IdTipoHabitacion AS [ID del Tipo de Habitación],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_Habitacion
    ORDER BY IdAudit;
END;
GO


USE ZooMA
GO
CREATE PROCEDURE SP_Audit_Especies
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdEspecie AS [ID de la Especie],
        NombreEsp AS [Nombre de la Especie],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_Especies
    ORDER BY IdAudit;
END;
GO

USE	ZooMA
GO
CREATE PROCEDURE SP_Audit_EstadoSalud
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdEstadoSalud AS [ID del Estado de Salud],
        EstadoSalud AS [Estado de Salud],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_EstadoSalud
    ORDER BY IdAudit;
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_Audit_Dieta
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdDieta AS [ID de la Dieta],
        NombreDiet AS [Nombre de la Dieta],
        DescripcionDiet AS [Descripción de la Dieta],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_Dieta
    ORDER BY IdAudit;
END;
GO

USE ZooMA
GO
CREATE TABLE Audit_TipoHabitacion (
    IdAudit INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla VARCHAR(100),
    Operacion VARCHAR(10),
    IdTipoHabitacion INT,
    NombreTH VARCHAR(255),
    RealizadoPor VARCHAR(128),
    FechaDeEjecucion DATETIME DEFAULT GETDATE()
);

USE ZooMA
GO
CREATE PROCEDURE SP_Audit_Visitantes
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdVisitantes AS [ID de Visitante],
        NombreVist AS [Nombre del Visitante],
        Apell1Vist AS [Primer Apellido],
        Apell2Vist AS [Segundo Apellido],
        Disponibilidad AS [Disponibilidad],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_Visitantes
    ORDER BY IdAudit;
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_Audit_TipoEntrada
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdTipoEntrada AS [ID de Tipo de Entrada],
        NombreEnt AS [Nombre de Entrada],
        Precio AS [Precio],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_TipoEntrada
    ORDER BY IdAudit;
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_Audit_EstadoHabitacion
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdEstadoHabitacion AS [ID de Estado de Habitación],
        Estado AS [Estado],
        Descripcion AS [Descripción],
        Fecha AS [Fecha],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_EstadoHabitacion
    ORDER BY IdAudit;
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_Audit_Empleado
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdEmpleado AS [ID de Empleado],
        Nombre AS [Nombre],
        Apellido1 AS [Primer Apellido],
        Apellido2 AS [Segundo Apellido],
        IdPuesto AS [ID de Puesto],
        IdZoo AS [ID de Zoo],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_Empleado
    ORDER BY IdAudit;
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_Audit_Puesto
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdPuesto AS [ID de Puesto],
        Nombre AS [Nombre],
        Salario AS [Salario],
        DescripcionTareas AS [Descripción de Tareas],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_Puesto
    ORDER BY IdAudit;
END;
GO


uSE ZooMA
GO
CREATE PROCEDURE SP_Audit_Tareas
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdTareas AS [ID de Tareas],
        Nombre AS [Nombre],
        Descripcion AS [Descripción],
        IdEmpleado AS [ID de Empleado],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_Tareas
    ORDER BY IdAudit;
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_Audit_EstadoTarea
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdEstadoTarea AS [ID de Estado de Tarea],
        Nombre AS [Nombre],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_EstadoTarea
    ORDER BY IdAudit;
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_Audit_VentaEntrada
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdVentaEntrada AS [ID de Venta de Entrada],
        fechaventa AS [Fecha de Venta],
        horaventa AS [Hora de Venta],
        IdEmpleado AS [ID de Empleado],
        IdVisitantes AS [ID de Visitantes],
        IdMetodoPago AS [ID de Método de Pago],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_VentaEntrada
    ORDER BY IdAudit;
END;
GO


USE ZooMA
GO
CREATE PROCEDURE SP_Audit_MetodoPago
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdMetodoPago AS [ID de Método de Pago],
        MetodoPago AS [Método de Pago],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_MetodoPago
    ORDER BY IdAudit;
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_Audit_CalificacionVisita
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdCalificacionVisita AS [ID de Calificación de Visita],
        Nota AS [Nota],
        SugerenciaMejora AS [Sugerencia de Mejora],
        fecha AS [Fecha],
        IdVisitantes AS [ID de Visitante],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_CalificacionVisita
    ORDER BY IdAudit;
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_Audit_Rol
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdRol AS [ID de Rol],
        Nombre AS [Nombre de Rol],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_Rol
    ORDER BY IdAudit;
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_Audit_Usuario
AS
BEGIN
    SELECT 
        IdAudit AS [Identificador de Auditoría],
        NombreTabla AS [Nombre de la tabla],
        Operacion AS [Operación],
        IdUsuario AS [ID de Usuario],
        Contraseña AS [Contraseña],
        IdEmpleado AS [ID de Empleado],
        RealizadoPor AS [Responsable],
        FechaDeEjecucion AS [Fecha de Ejecución]
    FROM Audit_Usuario
    ORDER BY IdAudit;
END;
GO

--FIN SP MOSTRAR AUDIT
--file to create stored procedures
