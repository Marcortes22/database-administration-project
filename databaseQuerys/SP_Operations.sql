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

        IF NOT EXISTS(SELECT 1 FROM @Detalles D  WHERE NOT EXISTS (SELECT 1 FROM Entrada E WHERE E.IdEntrada = D.IdEntrada))
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