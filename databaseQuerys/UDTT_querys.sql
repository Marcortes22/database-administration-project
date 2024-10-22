USE ZooMA;
GO
IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DetalleVentaTableType')
  DROP TYPE DetalleVentaTableType;
GO
CREATE TYPE DetalleVentaTableType AS TABLE
(
    IdEntrada INT NOT NULL,
    Cantidad INT NOT NULL

);

--Fechaventa DATE NOT NULL,

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

        IF NOT EXISTS(SELECT 1 FROM @Detalles D  WHERE NOT EXISTS (SELECT 1 FROM Entrada E WHERE E.IdEntrada = D.IdEntrada))
        BEGIN
            RAISERROR ('Uno o mas id de entrada no son validas', 16, 1);
        END 

        INSERT INTO VentaEntrada (Fechaventa, IdVisitantes, IdMetodoPago, IdEmpleado)
        VALUES (GETDATE(), @IdVisitantes, @IdMetodoPago, @Cedula);

        SET @IdVentaEntrada = SCOPE_IDENTITY();

        INSERT INTO DetalleVenta (IdEntrada, IdVentaEntrada, Cantidad)
        SELECT IdEntrada, @IdVentaEntrada, Cantidad
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





SELECT *
FROM sys.types
WHERE is_user_defined = 1;