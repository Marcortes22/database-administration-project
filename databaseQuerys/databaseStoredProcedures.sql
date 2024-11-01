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







