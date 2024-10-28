--table type para la tabla DetalleVenta (permite pasar una tabla como parametro)
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

GO

--table type para la tabla DetalleVenta (permite pasar una tabla como parametro)
 DROP TYPE if exists AlimentosDeDietaTableType
 GO
CREATE TYPE AlimentosDeDietaTableType AS TABLE
(
    IdAlimentos INT NOT NULL
);







