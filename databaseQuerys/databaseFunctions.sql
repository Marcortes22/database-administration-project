
USE ZooMA
go
DROP function IF EXISTS CalcularPrecioEntrada
go
CREATE FUNCTION dbo.CalcularPrecioEntrada(@IdEntrada INT, @Cantidad INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Precio DECIMAL(10, 2);
    
    -- Obtener el precio y el descuento de la entrada
    SET @Precio = (SELECT  (TP.Precio - (TP.Precio * (ISNULL(E.descuento, 0)/100.0)))* @Cantidad  FROM Entrada E 
    INNER JOIN TipoEntrada TP ON E.IdTipoEntrada = TP.IdTipoEntrada WHERE E.IdEntrada = @IdEntrada);
    RETURN @Precio;
END