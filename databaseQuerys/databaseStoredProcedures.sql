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
        
        INSERT INTO Habitacion (NombreHab, Direccion, Capacidad, IdTipoHabitacion)
        VALUES (@NombreHab, @Direccion, @Capacidad, @IdTipoHabitacion);
        
        COMMIT TRANSACTION;
        SELECT 'Habitación registrada correctamente: ' + @NombreHab AS 'Mensaje de Confirmación';
        
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
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        IF NOT EXISTS (SELECT 1 FROM ZOO WHERE IdZoo = @IdZoo)
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

        DECLARE @IdEmpleado VARCHAR(50);
        SET @IdEmpleado = @Nombre + '-' + @Apellido1 + '-' + @Apellido2;

        IF EXISTS (SELECT 1 FROM Empleado WHERE Nombre = @Nombre AND Apellido1 = @Apellido1 AND Apellido2 = @Apellido2)
        BEGIN
			RAISERROR ('El empleado ya existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Empleado (Nombre, Apellido1, Apellido2, IdPuesto, IdZoo)
        VALUES (@Nombre, @Apellido1, @Apellido2, @IdPuesto, @IdZoo);
        
        COMMIT TRANSACTION;
        SELECT 'Empleado registrado correctamente: ' + @Nombre + ' ' + @Apellido1 + ' ' + @Apellido2 AS 'Mensaje de Confirmación';
        
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
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM ZOO WHERE IdZoo = @IdZoo)
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

        INSERT INTO Animales (NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud, IdZoo)
        VALUES (@NombreAni, @EdadAni, @IdDieta, @IdHabitacion, @IdEspecie, @IdEstadoSalud, @IdZoo);

        COMMIT TRANSACTION;
        SELECT 'Animal registrado correctamente: ' + @NombreAni AS 'Mensaje de Confirmación';
        
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
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM Dieta WHERE NombreDiet = @NombreDiet)
        BEGIN
			RAISERROR ('La dieta ya existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Dieta (NombreDiet, DescripcionDiet)
        VALUES (@NombreDiet, @DescripcionDiet);

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
CREATE PROCEDURE SP_INGRESAR_ESTADO_SALUD(
    @estadoSalud VARCHAR(255)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@estadoSalud = '')
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

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
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
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
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

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
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
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
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM Visitantes WHERE nombreVist = @NombreVist AND apell1Vist = @Apell1Vist AND apell2Vist = @Apell2Vist)
        BEGIN
            RAISERROR ('El visitante ya existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Visitantes (nombreVist, apell1Vist, apell2Vist)
        VALUES (@NombreVist, @Apell1Vist, @Apell2Vist);

        COMMIT TRANSACTION;
        SELECT 'Visitante registrado correctamente: ' + @NombreVist + ' ' + @Apell1Vist + ' ' + @Apell2Vist AS 'Mensaje de Confirmación';

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

        COMMIT TRANSACTION;
        SELECT 'Puesto registrado correctamente: ' + @Nombre + ', Salario: ' + CAST(@Salario AS VARCHAR) + ', Descripción: ' + @DescripcionTareas AS 'Mensaje de Confirmación';

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
CREATE PROCEDURE SP_INGRESAR_TIPOHABITACION(
    @NombreTH VARCHAR(255)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@NombreTH = '')
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
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
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

        COMMIT TRANSACTION;
        SELECT 'Zoológico registrado correctamente: ' + @NombreZoo AS 'Mensaje de Confirmación';

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

        IF EXISTS (SELECT 1 FROM Tareas WHERE Nombre = @Nombre AND IdEmpleado = @IdEmpleado)
        BEGIN
            RAISERROR ('La tarea ya existe para este empleado', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Tareas (Nombre, Descripcion, IdEmpleado)
        VALUES (@Nombre, @Descripcion, @IdEmpleado);

        COMMIT TRANSACTION;
        SELECT 'Tarea registrada correctamente: ' + @Nombre AS 'Mensaje de Confirmación';

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

        INSERT INTO CalificacionVisita (Nota, SugerenciaMejora, fecha, IdVisitantes)
        VALUES (@Nota, @SugerenciaMejora, @Fecha, @IdVisitantes);

        COMMIT TRANSACTION;
        SELECT 'Calificación de visita registrada correctamente. Nota: ' + CAST(@Nota AS VARCHAR)
              + ', Sugerencia: ' + @SugerenciaMejora AS 'Mensaje de Confirmación';

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
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
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
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
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

        COMMIT TRANSACTION;
        SELECT 'Usuario registrado y rol asignado correctamente' AS 'Mensaje de Confirmación';

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
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM ZOO WHERE IdZoo = @IdZoo)
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

        INSERT INTO VentaEntrada (fechaventa, horaventa, IdZoo, IdVisitantes, IdMetodoPago)
        VALUES (@fechaventa, @horaventa, @IdZoo, @IdVisitantes, @IdMetodoPago);
        
        COMMIT TRANSACTION;
         SELECT 'Venta de entrada registrada correctamente para la fecha ' + CONVERT(VARCHAR(10), @fechaventa) + ' a las ' + CONVERT(VARCHAR(8), @horaventa) AS 'Mensaje de Confirmación';
        
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
END
GO
--FIN SP Insert--

--Parte 8: SP Consultar tablas

--Buscar todas las habitaciones
USE ZooMA
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
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
END;
GO

--Buscar Habitacion por Id
USE ZooMA
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
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
END;
GO
 --Buscar El tipoHabitacion por Nombre
USE ZooMA
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
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
END;
GO

--Buscar Dieta por nombre
USE ZooMA
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
        RAISERROR ('Ha ocurrido un error: %s', 16, 1, @ErrorMessage);
    END CATCH
END;
GO

--Buscar visitante por Id o por Nombre
USE ZooMA
GO
CREATE PROCEDURE SP_BUSCAR_VISITANTES_POR_ID_O_NOMBRE (
    @IdVisitantes INT = NULL,
    @NombreVist VARCHAR(20) = NULL,
    @Apellido1Vist VARCHAR(20) = NULL,
    @Apellido2Vist VARCHAR(20) = NULL
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdVisitantes IS NULL AND 
            (@NombreVist IS NULL OR @NombreVist = '') AND 
            (@Apellido1Vist IS NULL OR @Apellido1Vist = ''))
        BEGIN
            RAISERROR ('Debes proporcionar un ID de visitante o al menos un nombre y apellidos', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT 
            IdVisitantes AS 'Código Visitante', 
            nombreVist AS 'Nombre del Visitante'
        FROM 
            Visitantes 
        WHERE 
            (@IdVisitantes IS NULL OR IdVisitantes = @IdVisitantes) AND
            (@NombreVist IS NULL OR nombreVist LIKE '%' + @NombreVist + '%')

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
END;
GO

--Buscar especie por Nombre
USE ZooMA
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
            NombreEsp AS 'Nombre de la Especie'
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
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
END;
GO


--Buscar Animal por Nombre, Especie, Habitación o estado salud
USE ZooMA
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
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
END;
GO

--Buscar todos los animales
USE ZooMA
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
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
END;
GO
--Buscar Zoo por Nombre o Id
USE ZooMA
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
        RAISERROR ('Ha ocurrido un error: %s', 16, 1, @ErrorMessage);
    END CATCH
END;
GO


--Buscar EstadoHabitación por Id
USE ZooMA
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
        RAISERROR ('Ha ocurrido un error: %s', 16, 1, @ErrorMessage);
    END CATCH
END;
GO
 
 --Buscar empleado por Id
 USE ZooMA
GO
CREATE PROCEDURE SP_BUSCAR_EMPLEADO_POR_ID (
    @IdEmpleado INT = NULL
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        IF (@IdEmpleado IS NULL OR @IdEmpleado <= 0)
        BEGIN
            RAISERROR ('El ID del empleado debe ser un valor positivo y no nulo', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @IdEmpleado)
        BEGIN
            RAISERROR ('El empleado con el ID especificado no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SELECT 
            e.IdEmpleado AS 'ID Empleado',
            e.Nombre AS 'Nombre',
            e.Apellido1 AS 'Apellido 1',
            e.Apellido2 AS 'Apellido 2',
            p.Nombre AS 'Puesto'
        FROM 
            Empleado e
        JOIN 
            Puesto p ON e.IdPuesto = p.IdPuesto
        WHERE 
            e.IdEmpleado = @IdEmpleado;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR ('Ha ocurrido un error: %s', 16, 1, @ErrorMessage);
    END CATCH
END;
GO

--Buscar puesto por Id
USE ZooMA
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
        RAISERROR ('Ha ocurrido un error: %s', 16, 1, @ErrorMessage);
    END CATCH
END;
GO
--FIN SP Consultar tablas--

	    
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

        COMMIT TRANSACTION;

        SELECT 'Registro del estado de salud actualizado correctamente'  AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
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

        COMMIT TRANSACTION;

        SELECT 'Registro de la especie actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);

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
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Dieta WHERE IdDieta = @IdDieta)
    BEGIN
        RAISERROR ('La dieta no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE Dieta
        SET NombreDiet = @NombreDiet,
            DescripcionDiet = @DescripcionDiet
        WHERE IdDieta = @IdDieta;

        COMMIT TRANSACTION;

        SELECT 'Registro de la dieta actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);

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

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
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

        COMMIT TRANSACTION;

        SELECT 'Registro del zoo actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);

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

        COMMIT TRANSACTION;

        SELECT 'Registro de la habitación actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);

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
        RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
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
        SET nombreVist = @nombreVist,
            apell1Vist = @apell1Vist,
            apell2Vist = @apell2Vist
        WHERE IdVisitantes = @IdVisitantes;

        COMMIT TRANSACTION;

        SELECT 'Registro del visitante actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);

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
    BEGIN TRANSACTION;
    BEGIN TRY

        -- Validación de campos en blanco
        IF(@IdAnimal IS NULL OR @NombreAni = '' OR @EdadAni IS NULL OR @IdDieta IS NULL OR 
           @IdHabitacion IS NULL OR @IdEspecie IS NULL OR @IdEstadoSalud IS NULL OR @IdZoo IS NULL)
        BEGIN
            RAISERROR ('No se pueden ingresar campos en blanco', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Verificación de existencia del animal
        IF NOT EXISTS (SELECT 1 FROM Animales WHERE IdAnimales = @IdAnimal)
        BEGIN
            RAISERROR ('El animal no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Actualización de datos del animal
        UPDATE Animales
        SET NombreAni = @NombreAni,
            EdadAni = @EdadAni,
            IdDieta = @IdDieta,
            IdHabitacion = @IdHabitacion,
            IdEspecie = @IdEspecie,
            IdEstadoSalud = @IdEstadoSalud,
            IdZoo = @IdZoo
        WHERE IdAnimales = @IdAnimal;

        -- Confirmación de éxito
        COMMIT TRANSACTION;
        SELECT 'Datos del animal actualizados correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        -- Manejo de errores
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
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

        COMMIT TRANSACTION;

        SELECT 'Registro del estado de la habitación actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
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

        COMMIT TRANSACTION;

        SELECT 'Registro del puesto actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);

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
            IdPuesto = @IdPuesto,
            IdZoo = @IdZoo
        WHERE IdEmpleado = @IdEmpleado;

        COMMIT TRANSACTION;

        SELECT 'Registro del empleado actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);

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

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Tareas
        SET Nombre = @Nombre,
            Descripcion = @Descripcion,
            IdEmpleado = @IdEmpleado
        WHERE IdTareas = @IdTareas;

        COMMIT TRANSACTION;

        SELECT 'Registro de la tarea actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
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

        COMMIT TRANSACTION;

        SELECT 'Registro del usuario actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);

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

        COMMIT TRANSACTION;

        SELECT 'Registro del rol actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);

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

        COMMIT TRANSACTION;

        SELECT 'Registro del tipo de entrada actualizado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);

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
        RAISERROR ('El ID del estado de salud no puede ser un campo vacío o ser cero', 16, 1);
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

        COMMIT TRANSACTION;

        SELECT 'Registro del estado de salud eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);

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
        RAISERROR ('El ID de la especie no puede ser un campo vacío o ser cero', 16, 1);
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

        COMMIT TRANSACTION;

        SELECT 'Registro de la especie eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);

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
        RAISERROR ('El ID de la dieta no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Dieta WHERE IdDieta = @IdDieta)
    BEGIN
        RAISERROR ('La dieta no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM Dieta
        WHERE IdDieta = @IdDieta;

        COMMIT TRANSACTION;

        SELECT 'Registro de la dieta eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);

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

        COMMIT TRANSACTION;

        SELECT 'Registro del tipo de habitación eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
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
        RAISERROR ('El ID del zoo no puede ser un campo vacío o ser cero', 16, 1);
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

        COMMIT TRANSACTION;

        SELECT 'Registro del zoo eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
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
        RAISERROR ('El ID de la habitación no puede ser un campo vacío o ser cero', 16, 1);
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

        COMMIT TRANSACTION;

        SELECT 'Registro de la habitación eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar la habitación: ' + @ErrorMessage;

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
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
        RAISERROR ('El ID del visitante no puede ser un campo vacío o ser cero', 16, 1);
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

        COMMIT TRANSACTION;

        SELECT 'Registro del visitante eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar el visitante: ' + @ErrorMessage;

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
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
    BEGIN TRANSACTION;
    BEGIN TRY

        -- Validación del ID del animal
        IF(@IdAnimal IS NULL OR @IdAnimal = 0)
        BEGIN
            RAISERROR ('El ID del animal no puede ser un campo vacío o ser cero', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Verificación de existencia del animal
        IF NOT EXISTS (SELECT 1 FROM Animales WHERE IdAnimales = @IdAnimal)
        BEGIN
            RAISERROR ('El animal no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Eliminación del registro del animal
        DELETE FROM Animales
        WHERE IdAnimales = @IdAnimal;

        -- Confirmación de éxito
        COMMIT TRANSACTION;
        SELECT 'El registro del animal ha sido eliminado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        -- Manejo de errores
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
END;
GO


USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_ESTADOHABITACION (
    @IdEstadoHabitacion INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        -- Validación del ID del estado de la habitación
        IF (@IdEstadoHabitacion IS NULL OR @IdEstadoHabitacion = 0)
        BEGIN
            RAISERROR ('El ID del estado de la habitación no puede ser un campo vacío o ser cero', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Verificación de existencia del estado de habitación
        IF NOT EXISTS (SELECT 1 FROM EstadoHabitacion WHERE IdEstadoHabitacion = @IdEstadoHabitacion)
        BEGIN
            RAISERROR ('El estado de habitación no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Eliminación del registro del estado de la habitación
        DELETE FROM EstadoHabitacion
        WHERE IdEstadoHabitacion = @IdEstadoHabitacion;

        -- Confirmación de éxito
        COMMIT TRANSACTION;
        SELECT 'El registro del estado de la habitación ha sido eliminado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        -- Manejo de errores
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
END;
GO


USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_PUESTO (
    @IdPuesto INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        -- Validación del ID del puesto
        IF (@IdPuesto IS NULL OR @IdPuesto = 0)
        BEGIN
            RAISERROR ('El ID del puesto no puede ser un campo vacío o ser cero', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Verificación de existencia del puesto
        IF NOT EXISTS (SELECT 1 FROM Puesto WHERE IdPuesto = @IdPuesto)
        BEGIN
            RAISERROR ('El puesto no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Eliminación del registro del puesto
        DELETE FROM Puesto
        WHERE IdPuesto = @IdPuesto;

        -- Confirmación de éxito
        COMMIT TRANSACTION;
        SELECT 'El registro del puesto ha sido eliminado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        -- Manejo de errores
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
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
        RAISERROR ('El ID del empleado no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @IdEmpleado)
    BEGIN
        RAISERROR ('El empleado no existe', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY

        DELETE FROM Empleado
        WHERE IdEmpleado = @IdEmpleado;

        COMMIT TRANSACTION;

        SELECT 'Registro del empleado eliminado correctamente' AS 'Mensaje de Confirmación';
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);

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
    BEGIN TRANSACTION;
    BEGIN TRY

        -- Validación del ID de la tarea
        IF (@IdTareas IS NULL OR @IdTareas = 0)
        BEGIN
            RAISERROR ('El ID de la tarea no puede ser un campo vacío o ser cero', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Verificación de existencia de la tarea
        IF NOT EXISTS (SELECT 1 FROM Tareas WHERE IdTareas = @IdTareas)
        BEGIN
            RAISERROR ('La tarea no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Eliminación del registro de la tarea
        DELETE FROM Tareas
        WHERE IdTareas = @IdTareas;

        -- Confirmación de éxito
        COMMIT TRANSACTION;
        SELECT 'El registro de la tarea ha sido eliminado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        -- Manejo de errores
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
END;
GO

USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_Usuario (
    @IdUsuario INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        -- Validación del ID del usuario
        IF(@IdUsuario IS NULL OR @IdUsuario = 0)
        BEGIN
            RAISERROR ('El ID del usuario no puede ser un campo vacío o ser cero', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Verificación de existencia del usuario
        IF NOT EXISTS (SELECT 1 FROM Usuario WHERE IdUsuario = @IdUsuario)
        BEGIN
            RAISERROR ('El usuario no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Eliminación del registro del usuario
        DELETE FROM Usuario
        WHERE IdUsuario = @IdUsuario;

        -- Confirmación de éxito
        COMMIT TRANSACTION;
        SELECT 'El registro del usuario ha sido eliminado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        -- Manejo de errores
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
END;
GO


USE ZooMA
GO
CREATE PROCEDURE SP_ELIMINAR_Rol (
    @IdRol INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY

        -- Validación del ID del rol
        IF(@IdRol IS NULL OR @IdRol = 0)
        BEGIN
            RAISERROR ('El ID del rol no puede ser un campo vacío o ser cero', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Verificación de existencia del rol
        IF NOT EXISTS (SELECT 1 FROM Rol WHERE IdRol = @IdRol)
        BEGIN
            RAISERROR ('El rol no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Eliminación del registro del rol
        DELETE FROM Rol
        WHERE IdRol = @IdRol;

        -- Confirmación de éxito
        COMMIT TRANSACTION;
        SELECT 'El registro del rol ha sido eliminado correctamente' AS 'Mensaje de Confirmación';

    END TRY
    BEGIN CATCH
        -- Manejo de errores
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);
    END CATCH
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
        RAISERROR ('El ID del tipo de entrada no puede ser un campo vacío o ser cero', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM TipoEntrada WHERE IdTipoEntrada = @IdTipoEntrada)
    BEGIN
        RAISERROR ('El tipo de entrada no existe', 16, 1);
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

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR ('Ha ocurrido un error: ', 16, 1, @ErrorMessage);

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
CREATE TABLE Audit_Tipo_Habitacion (
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
