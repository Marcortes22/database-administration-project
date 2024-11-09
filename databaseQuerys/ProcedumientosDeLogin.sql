USE ZooMA
GO
IF OBJECT_ID('SP_REGISTER','P') IS NOT NULL
    DROP PROCEDURE SP_REGISTER;
GO
CREATE PROCEDURE SP_REGISTER(
    @IdEmpleado VARCHAR(20),
    @Nombre VARCHAR(20),
    @Apellido1 VARCHAR(20),
    @Apellido2 VARCHAR(20),
    @Correo VARCHAR(50),
    @IdPuesto INT,
    @Contraseña VARCHAR(20),
    @IdRol INT,
    @RolFechaInicio DATE,
    @RolFechaFin DATE,
    @Cedula VARCHAR(20),
    @Estado INT = 1 -- 1 = Activo, 0 = Inactivo
)
AS
BEGIN
 EXEC sp_set_session_context @key = N'CedulaUsuario', @value = @Cedula;

 BEGIN TRANSACTION;
 BEGIN TRY

  IF (@IdEmpleado IS NULL OR @Nombre IS NULL OR @Apellido1 IS NULL OR @Apellido2 IS NULL OR @IdPuesto IS NULL OR @Contraseña IS NULL OR @IdRol IS NULL OR @RolFechaInicio IS NULL OR @RolFechaFin IS NULL OR @Cedula IS NULL)
  BEGIN
    RAISERROR('Todos los campos son requeridos', 16, 1);
    RETURN;
  END


  IF EXISTS (SELECT IdEmpleado FROM Empleado WHERE IdEmpleado = @IdEmpleado)
  BEGIN
    RAISERROR('El empleado ya existe', 16, 1);
    RETURN;
  END

  IF NOT EXISTS (SELECT IdRol FROM Rol WHERE IdRol = @IdRol)
  BEGIN
    RAISERROR('El rol no existe', 16, 1);
    RETURN;
  END

  IF NOT EXISTS (SELECT IdPuesto FROM Puesto WHERE IdPuesto = @IdPuesto)
  BEGIN
    RAISERROR('El puesto no existe', 16, 1);
    RETURN;
  END

  

    
        INSERT INTO Empleado (IdEmpleado, Nombre, Apellido1, Apellido2, IdPuesto, Correo)
        VALUES (@IdEmpleado, @Nombre, @Apellido1, @Apellido2, @IdPuesto, @Correo);

        INSERT INTO Usuario (IdUsuario, Contraseña, Estado)
        VALUES (@IdEmpleado, @Contraseña, @Estado);

        INSERT INTO RolUsuario (IdRol, IdUsuario, FechaInicio, FechaFin)
        VALUES (@IdRol, @IdEmpleado, @RolFechaInicio, @RolFechaFin);

        COMMIT TRANSACTION;
    END TRY


    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage VARCHAR(100);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH

END





GO


USE ZooMA
GO
IF OBJECT_ID('SP_LOGIN','P') IS NOT NULL
    DROP PROCEDURE SP_LOGIN;
GO
CREATE PROCEDURE SP_LOGIN(
    @IdEmpleado VARCHAR(20),
    @Contraseña VARCHAR(20) 
)
AS
BEGIN

  IF (@IdEmpleado IS NULL OR @Contraseña IS NULL)
  BEGIN
    RAISERROR('Todos los campos son requeridos', 16, 1);
    RETURN;
  END

    BEGIN TRY
        
        IF NOT EXISTS(SELECT IdUsuario FROM Usuario WHERE IdUsuario = @IdEmpleado AND Contraseña = @Contraseña AND Estado = 1)
        BEGIN
            RAISERROR('Credenciales incorrectos', 16, 1);
            RETURN;
        END

      
    END TRY


    BEGIN CATCH
        
        DECLARE @ErrorMessage VARCHAR(100);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH

END