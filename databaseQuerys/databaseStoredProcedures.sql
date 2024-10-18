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
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    
    BEGIN TRY

        IF (@NombreHab = '' OR @Direccion = '' OR @Capacidad = '' OR @IdTipoHabitacion IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        IF NOT EXISTS (SELECT 1 FROM TipoHabitacion WHERE IdTipoHabitacion = @IdTipoHabitacion)
        BEGIN
            RAISERROR ('El tipo de habitación no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        INSERT INTO Habitacion (NombreHab, Direccion, Capacidad, IdTipoHabitacion)
        VALUES (@NombreHab, @Direccion, @Capacidad, @IdTipoHabitacion);
        
        COMMIT TRANSACTION;
        SELECT 'Habitación registrada correctamente: ' + @NombreHab AS 'Mensaje de Confirmación';
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
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
	
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Nombre = '' OR @Apellido1 = '' OR @Apellido2 = '' OR @IdPuesto IS NULL OR @IdEmpleado IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
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

        --DECLARE @IdEmpleado VARCHAR(50);
        --SET @IdEmpleado = @Nombre + '-' + @Apellido1 + '-' + @Apellido2;

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
        DECLARE @ErrorMessage VARCHAR(4000);
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
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreAni = '' OR @EdadAni IS NULL OR @IdDieta IS NULL OR @IdHabitacion IS NULL OR @IdEspecie IS NULL OR @IdEstadoSalud IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

        IF NOT EXISTS (SELECT 1 FROM ZOO WHERE IdZoo = 1)
        BEGIN
			RAISERROR ('El Zoológico no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM Dieta WHERE IdDieta = @IdDieta)
        BEGIN
			RAISERROR ('La Dieta no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM TipoHabitacion WHERE IdTipoHabitacion = @IdHabitacion)
        BEGIN
			RAISERROR ('La Habitación no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM Especies WHERE IdEspecie = @IdEspecie)
        BEGIN
			RAISERROR ('La Especie no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM EstadoSalud WHERE IdEstadoSalud = @IdEstadoSalud)
        BEGIN
			RAISERROR ('El Estado de Salud no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Animales (NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud)
        VALUES (@NombreAni, @EdadAni, @IdDieta, @IdHabitacion, @IdEspecie, @IdEstadoSalud);

        COMMIT TRANSACTION;
        SELECT 'Animal registrado correctamente: ' + @NombreAni AS 'Mensaje de Confirmación';
        
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
IF OBJECT_ID('SP_INGRESAR_DIETA', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_DIETA;
GO
CREATE PROCEDURE SP_INGRESAR_DIETA(
    @NombreDiet VARCHAR(20),
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreDiet = '' OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        IF EXISTS (SELECT 1 FROM Dieta WHERE NombreDiet = @NombreDiet)
        BEGIN
			RAISERROR ('La dieta ya existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Dieta (NombreDiet)
        VALUES (@NombreDiet);

        COMMIT TRANSACTION;
        SELECT 'Dieta registrada correctamente: ' + @NombreDiet AS 'Mensaje de Confirmación';
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreEsp = '' OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

        IF EXISTS (SELECT 1 FROM Especies WHERE NombreEsp = @NombreEsp)
        BEGIN
			RAISERROR ('La especie ya existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Especies (NombreEsp)
        VALUES (@NombreEsp);

        COMMIT TRANSACTION;
        SELECT 'Especie registrada correctamente: ' + @NombreEsp AS 'Mensaje de Confirmación';

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
        DECLARE @ErrorMessage VARCHAR(4000);
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
    @Descripcion VARCHAR(255),
    @Fecha DATE,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Estado = '' OR @Descripcion = '' OR @Fecha IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        IF (@Fecha > GETDATE())
        BEGIN
            RAISERROR ('La fecha no puede ser futura', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        INSERT INTO EstadoHabitacion (estado, descripcion, Fecha)
        VALUES (@Estado, @Descripcion, @Fecha);

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Estado de habitación registrado correctamente: ' + @Estado + ', Descripción: ' + @Descripcion + ', Fecha: ' + CAST(@Fecha AS VARCHAR) AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
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
    @DescripcionTareas VARCHAR(255),
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Nombre = '' OR @DescripcionTareas = '' OR @Salario IS NULL OR @Cedula = '')
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

        INSERT INTO Puesto (Nombre, Salario, DescripcionTareas)
        VALUES (@Nombre, @Salario, @DescripcionTareas);

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Puesto registrado correctamente: ' + @Nombre + ', Salario: ' + CAST(@Salario AS VARCHAR) + ', Descripción: ' + @DescripcionTareas AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
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
    @NombreTH VARCHAR(255),
	@Cedula VARCHAR(255)
)
AS
BEGIN
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

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Tipo de Habitación registrado correctamente: ' + @NombreTH AS 'Mensaje de Confirmación';

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

        INSERT INTO ZOO (NombreZoo, Direccion, DescripcionZoo)
        VALUES (@NombreZoo, @Direccion, @DescripcionZoo);

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Zoológico registrado correctamente: ' + @NombreZoo AS 'Mensaje de Confirmación';

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
IF OBJECT_ID('SP_INGRESAR_TAREA', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_TAREA;
GO
CREATE PROCEDURE SP_INGRESAR_TAREA(
    @Nombre VARCHAR(20),
    @IdEmpleado INT,
    @IdTipoTarea INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Nombre = '' OR @IdEmpleado IS NULL OR @IdTipoTarea IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @IdEmpleado)
        BEGIN
            RAISERROR ('El empleado no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM TipoTarea WHERE IdTipoTarea = @IdTipoTarea)
        BEGIN
            RAISERROR ('El tipo de tarea no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM Tareas WHERE Nombre = @Nombre AND IdEmpleado = @IdEmpleado AND IdTipoTarea = @IdTipoTarea)
        BEGIN
            RAISERROR ('La tarea ya existe para este empleado y tipo de tarea', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Tareas (Nombre, IdEmpleado, IdTipoTarea)
        VALUES (@Nombre, @IdEmpleado, @IdTipoTarea);

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Tarea registrada correctamente: ' + @Nombre AS 'Mensaje de Confirmación';

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
IF OBJECT_ID('SP_INGRESAR_CALIFICACION_VISITA', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_CALIFICACION_VISITA;
GO
CREATE PROCEDURE SP_INGRESAR_CALIFICACION_VISITA(
    @Nota INT,
    @SugerenciaMejora VARCHAR(255),
    @Fecha DATE,
    @IdVisitantes INT,
    @IdCalificacionServicioAlCliente INT,
    @IdCalificacionRecorrido INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        IF (@Nota IS NULL OR @SugerenciaMejora = '' OR @Fecha IS NULL OR @IdVisitantes IS NULL 
            OR @IdCalificacionServicioAlCliente IS NULL OR @IdCalificacionRecorrido IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Visitantes WHERE IdVisitantes = @IdVisitantes)
        BEGIN
            RAISERROR ('El visitante no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM CalificacionServicioAlCliente WHERE IdCalificacionServicioAlCliente = @IdCalificacionServicioAlCliente)
        BEGIN
            RAISERROR ('La calificación de servicio al cliente no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM CalificacionRecorrido WHERE IdCalificacionRecorrido = @IdCalificacionRecorrido)
        BEGIN
            RAISERROR ('La calificación de recorrido no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO CalificacionVisita (Nota, SugerenciaMejora, Fecha, IdVisitantes, IdCalificacionServicioAlCliente, IdCalificacionRecorrido)
        VALUES (@Nota, @SugerenciaMejora, @Fecha, @IdVisitantes, @IdCalificacionServicioAlCliente, @IdCalificacionRecorrido);

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Calificación de visita registrada correctamente. Nota: ' + CAST(@Nota AS VARCHAR)
              + ', Sugerencia: ' + @SugerenciaMejora AS 'Mensaje de Confirmación';

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

        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Tipo de entrada registrado correctamente. Nombre: ' + @NombreEnt
              + ', Precio: ' + CAST(@Precio AS VARCHAR) AS 'Mensaje de Confirmación';

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
IF OBJECT_ID('SP_INGRESAR_ROL', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_ROL;
GO
CREATE PROCEDURE SP_INGRESAR_ROL(
    @nombre VARCHAR(20),
    @Cedula VARCHAR(20)
)
AS
BEGIN
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
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Rol registrado correctamente: ' + @nombre AS 'Mensaje de Confirmación';
        
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
IF OBJECT_ID('SP_INGRESAR_USUARIO_ROL', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_USUARIO_ROL;
GO
CREATE PROCEDURE SP_INGRESAR_USUARIO_ROL(
    @Contraseña VARCHAR(255),
    @IdEmpleado INT,
    @IdRol INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@Contraseña = '' OR @IdEmpleado IS NULL OR @IdRol IS NULL OR @Cedula = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @IdEmpleado)
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

        INSERT INTO Usuario (Contraseña, IdEmpleado)
        VALUES (@Contraseña, @IdEmpleado);

        DECLARE @IdUsuario INT;
        SET @IdUsuario = SCOPE_IDENTITY();

        IF EXISTS (SELECT 1 FROM RolUsario WHERE IdUsuario = @IdUsuario AND IdRol = @IdRol)
        BEGIN
            RAISERROR ('El usuario ya tiene este rol asignado', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO RolUsario (IdUsuario, IdRol)
        VALUES (@IdUsuario, @IdRol);
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Usuario registrado y rol asignado correctamente' AS 'Mensaje de Confirmación';

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
IF OBJECT_ID('SP_INGRESAR_VENTA_ENTRADA', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_VENTA_ENTRADA;
GO
CREATE PROCEDURE SP_INGRESAR_VENTA_ENTRADA (
    @fechaventa DATE,
    @horaventa TIME,
    @IdVisitantes INT,
    @IdMetodoPago INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@fechaventa IS NULL OR @horaventa IS NULL OR @IdVisitantes IS NULL OR @IdMetodoPago IS NULL OR @Cedula = '')
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

        INSERT INTO VentaEntrada (fechaventa, horaventa, IdVisitantes, IdMetodoPago)
        VALUES (@fechaventa, @horaventa, @IdVisitantes, @IdMetodoPago);
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
         SELECT 'Venta de entrada registrada correctamente para la fecha ' + CONVERT(VARCHAR(10), @fechaventa) + ' a las ' + CONVERT(VARCHAR(8), @horaventa) AS 'Mensaje de Confirmación';
        
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
        DECLARE @ErrorMessage VARCHAR(4000);
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

        INSERT INTO Alimentos (Nombre)
        VALUES (@Nombre);
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'Alimento registrado correctamente: ' + @Nombre AS 'Mensaje de Confirmación';
        
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
			NombreTH AS 'Nombre Tipo de Habitación'
		FROM 
			TipoHabitacion 
		WHERE 
			NombreTH LIKE '%' + @NombreTH + '%';

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
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
            NombreDiet AS 'Nombre de la Dieta'
        FROM 
            Dieta 
        WHERE 
            NombreDiet LIKE '%' + @NombreDiet + '%';

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
            A.NombreAni AS 'Nombre Animal', 
            E.NombreEsp AS 'Especie', 
            H.NombreHab AS 'Nombre de la Habitación', 
            ES.estadoSalud AS 'Estado de Salud'
        FROM Animales A
        INNER JOIN Especies E ON A.IdEspecie = E.IdEspecie
        INNER JOIN Habitacion H ON A.IdHabitacion = H.IdHabitacion
        INNER JOIN EstadoSalud ES ON A.IdEstadoSalud = ES.IdEstadoSalud
        WHERE A.NombreAni = @NombreAnimal;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
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
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Buscar Zoo por Nombre o Id
USE ZooMA
GO
IF OBJECT_ID('SP_BUSCAR_ZOO_POR_ID_O_NOMBRE', 'P') IS NOT NULL
   DROP PROCEDURE SP_BUSCAR_ZOO_POR_ID_O_NOMBRE;
GO
CREATE PROCEDURE SP_BUSCAR_ZOO_POR_ID_O_NOMBRE (
    @IdZoo INT = NULL,
    @NombreZoo VARCHAR(20) = NULL
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdZoo IS NULL AND (LTRIM(RTRIM(@NombreZoo)) = '' OR @NombreZoo IS NULL))
        BEGIN
            RAISERROR ('Debes proporcionar un ID de zoológico o al menos un nombre', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT 
            IdZoo AS 'Código Zoológico', 
            NombreZoo AS 'Nombre del Zoológico'
        FROM 
            ZOO
        WHERE 
            (@IdZoo IS NULL OR IdZoo = @IdZoo) AND
            (@NombreZoo IS NULL OR NombreZoo LIKE '%' + @NombreZoo + '%');

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
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
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
--Buscar puesto por Id
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
            IdPuesto AS 'Id Puesto',
            Nombre AS 'Nombre',
            Salario AS 'Salario',
            DescripcionTareas AS 'Descripción de Tareas'
        FROM 
            Puesto 
        WHERE 
            Nombre LIKE '%' + @NombrePuesto + '%';

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
            IdAlimentos AS 'Código Alimento', 
            Nombre AS 'Nombre del Alimento'
        FROM 
            Alimentos 
        WHERE 
            (@IdAlimentos IS NULL OR IdAlimentos = @IdAlimentos) AND
            (@Nombre IS NULL OR Nombre LIKE '%' + @Nombre + '%')

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
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
            IdTareas AS 'Código Tarea', 
            Nombre AS 'Nombre de la Tarea',
            IdEmpleado AS 'ID del Empleado',
            IdTipoTarea AS 'ID del Tipo de Tarea'
        FROM 
            Tareas 
        WHERE 
            (@IdTareas IS NULL OR IdTareas = @IdTareas) AND
            (@Nombre IS NULL OR Nombre LIKE '%' + @Nombre + '%') AND
            (@IdEmpleado IS NULL OR IdEmpleado = @IdEmpleado) AND
            (@IdTipoTarea IS NULL OR IdTipoTarea = @IdTipoTarea)

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
        DECLARE @ErrorMessage VARCHAR(4000);
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

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del tipo de habitación actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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
    IF(@IdZoo IS NULL OR @IdZoo = 0 OR @NombreZoo = '' OR @Direccion = '' OR @DescripcionZoo = '' OR @Cedula = '')
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
        SET NombreZoo = @NombreZoo,
            Direccion = @Direccion,
            DescripcionZoo = @DescripcionZoo
        WHERE IdZoo = @IdZoo;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del zoo actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;
GO

USE ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_Habitacion', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_Habitacion;
GO
CREATE PROCEDURE SP_ACTUALIZAR_Habitacion (
    @IdHabitacion INT,
    @NombreHab VARCHAR(20),
    @Direccion VARCHAR(100),
    @Capacidad BIT,
    @IdTipoHabitacion INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    IF(@IdHabitacion IS NULL OR @IdHabitacion = 0 OR @NombreHab = '' OR @Direccion = '' OR @Capacidad IS NULL OR @IdTipoHabitacion IS NULL OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Habitacion WHERE IdHabitacion = @IdHabitacion)
    BEGIN
        RAISERROR ('La habitación no existe', 16, 1);
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
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro de la habitación actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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
    @Disponibilidad VARCHAR(100),
    @Correo VARCHAR(50),
    @Telefono INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF(@IdVisitantes IS NULL OR @IdVisitantes = 0 OR @NombreVist = '' OR @Apell1Vist = '' OR @Apell2Vist = '' OR @Disponibilidad = '' OR @Correo = '' OR @Telefono IS NULL OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco o valores nulos', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Visitantes WHERE IdVisitantes = @IdVisitantes)
    BEGIN
        RAISERROR ('El visitante no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Visitantes
        SET NombreVist = @NombreVist,
            Apell1Vist = @Apell1Vist,
            Apell2Vist = @Apell2Vist,
            CorreoElectronico = @Correo,
            TELEFONO = @Telefono
        WHERE IdVisitantes = @IdVisitantes;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del visitante actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
        SET estado = @Estado,
            descripcion = @Descripcion,
            Fecha = @Fecha
        WHERE IdEstadoHabitacion = @IdEstadoHabitacion;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del estado de la habitación actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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
    @DescripcionTareas VARCHAR(255),
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF (@IdPuesto IS NULL OR @IdPuesto = 0 OR @Nombre = '' OR @Salario IS NULL OR @DescripcionTareas = '' OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Puesto WHERE IdPuesto = @IdPuesto)
    BEGIN
        RAISERROR ('El puesto no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE Puesto
        SET Nombre = @Nombre,
            Salario = @Salario,
            DescripcionTareas = @DescripcionTareas
        WHERE IdPuesto = @IdPuesto;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del puesto actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
		
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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
        SET Nombre = @Nombre,
            IdEmpleado = @IdEmpleado,
            IdTipoTarea = @IdTipoTarea
        WHERE IdTareas = @IdTareas;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro de la tarea actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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
    @IdEmpleado INT,
    @Cedula VARCHAR(20)
)
AS
BEGIN

    IF(@IdUsuario IS NULL OR @IdUsuario = 0 OR @Contraseña = '' OR @IdEmpleado IS NULL OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE IdUsuario = @IdUsuario)
    BEGIN
        RAISERROR ('El usuario no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Usuario
        SET Contraseña = @Contraseña,
            IdEmpleado = @IdEmpleado
        WHERE IdUsuario = @IdUsuario;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del usuario actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Rol
        SET nombre = @nombre
        WHERE IdRol = @IdRol;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del rol actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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
    @descripcionEnt VARCHAR(255),
    @Precio MONEY,
    @Cedula VARCHAR(20)
)
AS
BEGIN
    IF(@IdTipoEntrada IS NULL OR @IdTipoEntrada = 0 OR @nombreEnt = '' OR @descripcionEnt = '' OR @Precio IS NULL OR @Cedula = '')
    BEGIN
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM TipoEntrada WHERE IdTipoEntrada = @IdTipoEntrada)
    BEGIN
        RAISERROR ('El tipo de entrada no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE TipoEntrada
        SET nombreEnt = @nombreEnt,
            Precio = @Precio
        WHERE IdTipoEntrada = @IdTipoEntrada;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del tipo de entrada actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM TipoHabitacion
        WHERE IdTipoHabitacion = @IdTipoHabitacion;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del tipo de habitación eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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

        DELETE FROM ZOO
        WHERE IdZoo = @IdZoo;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del zoo eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM Habitacion
        WHERE IdHabitacion = @IdHabitacion;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro de la habitación eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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

    IF NOT EXISTS (SELECT 1 FROM Visitantes WHERE IdVisitantes = @IdVisitantes)
    BEGIN
        RAISERROR ('El visitante no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM Visitantes
        WHERE IdVisitantes = @IdVisitantes;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del visitante eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
        DECLARE @ErrorMessage VARCHAR(4000);
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

        DELETE FROM Puesto
        WHERE IdPuesto = @IdPuesto;
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'El registro del puesto ha sido eliminado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
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

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
        DECLARE @ErrorMessage VARCHAR(4000);
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
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;
        SELECT 'El registro del rol ha sido eliminado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
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
        EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
        COMMIT TRANSACTION;

        SELECT 'Registro del tipo de entrada eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;
GO
--FIN SP Eliminar
