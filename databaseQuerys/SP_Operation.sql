--realizar la operacion de venta
--realizar la operacion de venta
use ZooMA
GO
IF OBJECT_ID('SP_EJECUTAR_VENTA', 'P') IS NOT NULL
   DROP PROCEDURE SP_EJECUTAR_VENTA;
GO
go
CREATE PROCEDURE SP_EJECUTAR_VENTA(
    @IdVisitantes INT,
    @IdMetodoPago INT,
	@Cedula VARCHAR(25),
    @Detalles DetalleVentaTableType READONLY
)
AS
BEGIN
EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;
    BEGIN TRY

        DECLARE @IdVentaEntrada INT;

        IF NOT EXISTS (SELECT * FROM Visitantes WHERE IdVisitantes = @IdVisitantes)
        BEGIN
            RAISERROR ('El visitante no existe', 16, 1);
        END

        IF NOT EXISTS (SELECT * FROM MetodoPago WHERE IdMetodoPago = @IdMetodoPago)
        BEGIN
            RAISERROR ('El metodo de pago no existe', 16, 1);
        END

        IF(select count(*) from @Detalles) = 0
        BEGIN
            RAISERROR ('No se han ingresado detalles', 16, 1);
        END

        IF  EXISTS(SELECT 1 FROM @Detalles D  WHERE NOT EXISTS (SELECT 1 FROM Entrada E WHERE E.IdEntrada = D.IdEntrada))
        BEGIN
            RAISERROR ('Uno o mas id de entrada no son validas', 16, 1);
        END 
        INSERT INTO VentaEntrada (Fechaventa, IdVisitantes, IdMetodoPago, IdEmpleado)
        VALUES (GETDATE(), @IdVisitantes, @IdMetodoPago, @Cedula );

        SET @IdVentaEntrada = SCOPE_IDENTITY();

        INSERT INTO DetalleVenta (IdEntrada, IdVentaEntrada, Cantidad, Precio)
        SELECT IdEntrada, @IdVentaEntrada, Cantidad, dbo.CalcularPrecioEntrada(IdEntrada, Cantidad)
        FROM @Detalles;
        
        COMMIT TRANSACTION;
      

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
IF OBJECT_ID('SP_INGRESAR_DIETA', 'P') IS NOT NULL
   DROP PROCEDURE SP_INGRESAR_DIETA;
GO
CREATE PROCEDURE SP_INGRESAR_DIETA(
    @NombreDiet VARCHAR(20),
    @Cedula VARCHAR(20),
    @Alimentos AlimentosDeDietaTableType READONLY
)
AS
BEGIN
    EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;
    BEGIN TRY
    DECLARE @IdDieta INT;

        IF (@NombreDiet = '' OR @Cedula = '')
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

        IF(select count(*) from @Alimentos) = 0
        BEGIN
            RAISERROR ('No se han ingresado alimentos a la dieta', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF  EXISTS(SELECT 1 FROM @Alimentos AL   WHERE NOT EXISTS (SELECT 1 FROM Alimentos A WHERE A.IdAlimentos = AL.IdAlimentos))
        BEGIN
            RAISERROR ('Uno o mas id de Alimentos no son validas', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END 

        INSERT INTO Dieta (NombreDiet)
        VALUES (@NombreDiet);

        
        SET @IdDieta = SCOPE_IDENTITY();

        INSERT INTO DietaAlimentos (IdDieta, IdAlimentos) 
        SELECT @IdDieta, IdAlimentos FROM @Alimentos;

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





--ingresar nueva tarea de control animal
--ingresar nueva tarea de control animal
use ZooMA
GO
IF OBJECT_ID('SP_AGREGAR_TAREA_CONTROL_ANIMAL', 'P') IS NOT NULL
   DROP PROCEDURE SP_AGREGAR_TAREA_CONTROL_ANIMAL;
GO
go
CREATE PROCEDURE SP_AGREGAR_TAREA_CONTROL_ANIMAL(
    @IdEmpleado INT,
    @IdAnimales INT,
    @Nombre VARCHAR(50),
	@Cedula VARCHAR(25)
)
AS
BEGIN
EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;
    BEGIN TRANSACTION;
    BEGIN TRY

        DECLARE @IdTarea INT;

		IF(@IdEmpleado IS NULL OR @IdAnimales IS NULL OR @Nombre = '' OR @Cedula = '')
		BEGIN
			 RAISERROR ('No se permiten espacios en blanco', 16, 1);
		END

        IF NOT EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @IdEmpleado)
        BEGIN
            RAISERROR ('El empleado no existe', 16, 1);
        END

        IF NOT EXISTS (SELECT 1 FROM Animales WHERE IdAnimales = @IdAnimales)
        BEGIN
            RAISERROR ('El animal no existe', 16, 1);
        END
		
        IF NOT EXISTS(SELECT 1 FROM Empleado E INNER JOIN Puesto P ON E.IdPuesto = P.IdPuesto  WHERE IdEmpleado = @IdEmpleado AND P.Nombre = 'Veterinario')
        BEGIN
            RAISERROR ('El empleado seleccionado no es veterinario, por lo tanto no puede realizar esta tarea', 16, 1);
        END 

        INSERT INTO Tareas(IdEmpleado, IdTipoTarea, IdEstadoTarea,FechaCreacion)
        VALUES (@IdEmpleado, 1,1,GETDATE() );  --se agrega con 1 el cual es el estado pendieente y tarea medica

        SET @IdTarea = SCOPE_IDENTITY();

        INSERT INTO ControlAnimal (IdTareas, IdAnimales, Nombre)
        VALUES (@IdTarea, @IdAnimales, @Nombre)
		COMMIT TRANSACTION
        
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(100);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END





use ZooMA
GO
IF OBJECT_ID('SP_ACTUALIZAR_ESTADO_TAREA', 'P') IS NOT NULL
   DROP PROCEDURE SP_ACTUALIZAR_ESTADO_TAREA;
GO
go
CREATE PROCEDURE SP_ACTUALIZAR_ESTADO_TAREA(
    @IdEstadoTarea INT,
	@IdTarea INT,
	@Cedula VARCHAR(25)
)
AS
BEGIN
EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

    BEGIN TRY

		IF(@IdEstadoTarea IS NULL OR @IdTarea IS NULL  OR @Cedula = '')
		BEGIN
			 RAISERROR ('No se permiten espacios en blanco', 16, 1);
		END

        IF NOT EXISTS (SELECT 1 FROM Tareas WHERE IdTareas = @IdTarea)
        BEGIN
            RAISERROR ('La tarea no existe', 16, 1);
        END

        IF NOT EXISTS (SELECT 1 FROM EstadoTarea WHERE IdEstadoTarea = @IdEstadoTarea)
        BEGIN
            RAISERROR ('El estado tarea no existe', 16, 1);
        END
		
		DECLARE @IdEmpleadoEncargado INT

		SET @IdEmpleadoEncargado = (SELECT IdEmpleado FROM Tareas WHERE IdTareas = @IdTarea)
		print(@IdEmpleadoEncargado + ' ' + @Cedula)
        IF (@IdEmpleadoEncargado <> @Cedula)
        BEGIN
            RAISERROR ('Solamente el encargado de la tarea puede cambiar su estado', 16, 1);
        END 

		UPDATE Tareas
		SET IdEstadoTarea = @IdEstadoTarea
		WHERE IdTareas = @IdTarea
        
        
    END TRY
    BEGIN CATCH
        
        DECLARE @ErrorMessage VARCHAR(100);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END