use ZooMa
GO
--Consultas para Empleados
DROP VIEW IF EXISTS Vw_Empleados_TareasCompletadas;
GO
CREATE VIEW Vw_Empleados_TareasCompletadas AS
SELECT 
    DE.IdEmpleado, 
    DE.NombreCompleto, 
    DE.Puesto, 
    COUNT(FT.Id) AS 'Tareas Completadas'
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_Tarea FT
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_empleado DE ON FT.IdEmpleado = DE.IdEmpleado
WHERE 
    FT.IdEstadoTarea = 3 -- Estado de completado
GROUP BY 
    DE.IdEmpleado, DE.NombreCompleto, DE.Puesto;


-- SELECT * 
-- FROM Vw_Empleados_TopTareasTerminadas
-- ORDER BY [Tareas Terminadas] DESC;



GO


DROP VIEW IF EXISTS Vw_ResumenTareasPorEstado;
GO

CREATE VIEW Vw_ResumenTareasPorEstado AS
SELECT 
    EST.IdEstadoTarea,
    EST.Nombre AS EstadoTarea, 
    COUNT(FT.Id) AS TotalTareas
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_Tarea FT
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_EstadoTarea EST ON FT.IdEstadoTarea = EST.IdEstadoTarea
WHERE 
    FT.Fecha = (SELECT MAX(Fecha) 
                FROM ZooMa_Data_Warehouse.dbo.Fact_Tarea 
                WHERE IdTarea = FT.IdTarea)
GROUP BY 
    EST.IdEstadoTarea, EST.Nombre;


GO


DROP VIEW IF EXISTS Vw_Empleados_TareasPendientes;
GO

CREATE VIEW Vw_Empleados_TareasPendientes AS
SELECT 
    DE.IdEmpleado,
    DE.NombreCompleto, 
    COUNT(FT.Id) AS TareasPendientes
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_Tarea FT
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_empleado DE ON FT.IdEmpleado = DE.IdEmpleado
WHERE 
    FT.IdEstadoTarea = 1 -- Estado pendiente
    AND FT.Fecha = (SELECT MAX(Fecha) 
                    FROM ZooMa_Data_Warehouse.dbo.Fact_Tarea 
                    WHERE IdTarea = FT.IdTarea)
GROUP BY 
    DE.IdEmpleado, DE.NombreCompleto;



GO




	DROP VIEW IF EXISTS Vw_DistribucionTareasPorTipoYEmpleado;
GO
CREATE VIEW Vw_DistribucionTareasPorTipoYEmpleado AS
SELECT 
    DE.IdEmpleado,
    DE.NombreCompleto, 
    TT.Nombre AS TipoTarea, 
    COUNT(FT.Id) AS TotalTareas
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_Tarea FT
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_empleado DE ON FT.IdEmpleado = DE.IdEmpleado
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_TipoTarea TT ON FT.IdTipoTarea = TT.IdTipoTarea
WHERE FT.IdEstadoTarea = 1
GROUP BY 
    DE.IdEmpleado, DE.NombreCompleto, TT.IdTipoTarea, TT.Nombre;





GO







DROP VIEW IF EXISTS Vw_PorcentajeTareasCompletadasPorTipo;
GO
CREATE VIEW Vw_PorcentajeTareasCompletadasPorTipo AS
SELECT 
    TT.IdTipoTarea,
    TT.Nombre AS TipoTarea,
    CAST(COUNT(CASE WHEN FT.IdEstadoTarea = 3 THEN 1 END) * 100.0 / COUNT(FT.IdTarea)as decimal(5,2)) AS PorcentajeCompletado-- hace un conteo de las tareas completadas y lo divide entre el total de tareas Y SE CASTEA A DECIMAL CON 2 DECIMALES
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_Tarea FT
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_TipoTarea TT ON FT.IdTipoTarea = TT.IdTipoTarea
WHERE 
    FT.Fecha = (SELECT MAX(Fecha)  -- toma solo la tarea mas reciente por su fecha, ya que se puede repetir el id de la tarea y solo cambia su estado
                FROM ZooMa_Data_Warehouse.dbo.Fact_Tarea 
                WHERE IdTarea = FT.IdTarea)
GROUP BY 
    TT.IdTipoTarea, TT.Nombre;




GO



--Consultas para Ventas



DROP VIEW IF EXISTS Vw_TotalVentas;
GO
CREATE VIEW Vw_TotalVentas AS
SELECT 
    COUNT(FV.IdVenta) AS TotalVentas,
    SUM(FV.PrecioTotal) AS MontoTotalVentas
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_Venta FV;


GO


DROP VIEW IF EXISTS Vw_VentasPorDia;
GO
CREATE VIEW Vw_VentasPorDia AS
SELECT 
    CAST(FechaVenta AS DATE) AS Fecha, 
    COUNT(IdVenta) AS TotalVentas,
    SUM(PrecioTotal) AS MontoTotalVentas
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_Venta
GROUP BY 
    CAST(FechaVenta AS DATE)


GO



DROP VIEW IF EXISTS Vw_VentasPorEmpleado;
GO
CREATE VIEW Vw_VentasPorEmpleado AS
SELECT 
    DE.NombreCompleto AS Empleado,
    COUNT(FV.IdVenta) AS TotalVentas,
    SUM(FV.PrecioTotal) AS MontoTotalVentas
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_Venta FV
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_empleado DE ON FV.IdEmpleado = DE.IdEmpleado
GROUP BY 
    DE.NombreCompleto


GO

    DROP VIEW IF EXISTS Vw_VentasPorMetodoPago;
GO
CREATE VIEW Vw_VentasPorMetodoPago AS
SELECT 
    MP.Nombre AS MetodoPago,
    COUNT(FV.IdVenta) AS TotalVentas,
    SUM(FV.PrecioTotal) AS MontoTotalVentas
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_Venta FV
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_MetodoPago MP ON FV.IdMetodoPago = MP.IdMetodoPago
GROUP BY 
    MP.Nombre

	--SELECT * FROM Vw_VentasPorMetodoPago order by MontoTotalVentas desc




GO


  DROP VIEW IF EXISTS Vw_VentasPorVisitante;
GO
CREATE VIEW Vw_VentasPorVisitante AS
SELECT 
    DV.NombreCompleto AS Visitante,
    COUNT(FV.IdVenta) AS TotalCompras,
    SUM(FV.PrecioTotal) AS GastoTotal
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_Venta FV
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_Visitantes DV ON FV.IdVisitantes = DV.IdVisitantes
GROUP BY 
    DV.NombreCompleto


	--select * from Vw_VentasPorVisitante  ORDER BY 
  --  GastoTotal DESC;
GO


DROP VIEW IF EXISTS Vw_TopDiasConMasVentas;
GO
CREATE VIEW Vw_TopDiasConMasVentas AS
SELECT TOP 10
    CAST(FechaVenta AS DATE) AS Fecha, 
    COUNT(IdVenta) AS TotalVentas,
    SUM(PrecioTotal) AS MontoTotalVentas
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_Venta
GROUP BY 
    CAST(FechaVenta AS DATE)

	--select * from Vw_TopDiasConMasVentas   ORDER BY 
  --  TotalVentas DESC;



GO




  ---Consultas para fact detalle venta

  DROP VIEW IF EXISTS Vw_TotalEntradasVendidas;
GO
CREATE VIEW Vw_TotalEntradasVendidas AS
SELECT 
    COUNT(IdDetalleVenta) AS TotalEntradasVendidas,
    SUM(Total) AS MontoTotalVentas
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_DetalleVenta;


GO


    DROP VIEW IF EXISTS Vw_VentasPorTipoEntrada;
GO
CREATE VIEW Vw_VentasPorTipoEntrada AS
SELECT 
    TE.NombreEnt AS TipoEntrada,
    COUNT(FDV.IdDetalleVenta) AS TotalEntradas,
    SUM(FDV.Total) AS MontoTotalVentas
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_DetalleVenta FDV
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_Entrada TE ON FDV.IdEntrada = TE.IdEntrada
GROUP BY 
    TE.NombreEnt


	-- select * from Vw_VentasPorTipoEntrada  ORDER BY 
  --   MontoTotalVentas DESC;
GO



DROP VIEW IF EXISTS Vw_VentasPorEntradaYTipo;
GO
CREATE VIEW Vw_VentasPorEntradaYTipo AS
SELECT 
    TE.NombreEnt AS TipoEntrada,
    FDV.Cantidad,
    SUM(FDV.Total) AS MontoTotal
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_DetalleVenta FDV
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_Entrada TE ON FDV.IdEntrada = TE.IdEntrada
GROUP BY 
    TE.NombreEnt, FDV.Cantidad

	-- select * from Vw_VentasPorEntradaYTipo  ORDER BY 
  --   MontoTotal DESC;


GO

--fact calificacion de visitantes

DROP VIEW IF EXISTS Vw_PromedioCalificaciones;
GO
CREATE VIEW Vw_PromedioCalificaciones AS
SELECT 
    AVG(NotaRecorrido) AS PromedioNotaRecorrido,
    AVG(NotaServicioCliente) AS PromedioNotaServicioCliente,
    AVG(NotaFinal) AS PromedioNotaFinal
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_CalificacionVisita;
	--select * from  Vw_PromedioCalificaciones


GO

  DROP VIEW IF EXISTS Vw_CalificacionesPorFecha;
GO
CREATE VIEW Vw_CalificacionesPorFecha AS
SELECT 
    Fecha,
    AVG(NotaRecorrido) AS PromedioNotaRecorrido,
    AVG(NotaServicioCliente) AS PromedioNotaServicioCliente,
    AVG(NotaFinal) AS PromedioNotaFinal
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_CalificacionVisita
GROUP BY 
    Fecha


	-- select * from Vw_CalificacionesPorFecha ORDER BY 
  --   Fecha;
GO



DROP VIEW IF EXISTS Vw_DistribucionCalificacionRecorrido;
GO
CREATE VIEW Vw_DistribucionCalificacionRecorrido AS
SELECT 
    NotaRecorrido,
    COUNT(*) AS TotalVeces
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_CalificacionVisita
GROUP BY 
    NotaRecorrido


	-- select * from Vw_DistribucionCalificacionRecorrido  ORDER BY 
  --   NotaRecorrido;

  GO

DROP VIEW IF EXISTS Vw_PromedioNotaFinalPorMes;
GO
CREATE VIEW Vw_PromedioNotaFinalPorMes AS
SELECT 
    YEAR(Fecha) AS Anio,
    MONTH(Fecha) AS Mes,
    AVG(NotaFinal) AS PromedioNotaFinal
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_CalificacionVisita
GROUP BY 
    YEAR(Fecha), MONTH(Fecha)


	-- select * from  Vw_PromedioNotaFinalPorMes ORDER BY 
  --   Anio, Mes;



  go
---VISTAS DE ALIMENTOS


DROP VIEW IF EXISTS Vw_TotalAlimentosPorDieta;
GO
CREATE VIEW Vw_TotalAlimentosPorDieta AS
SELECT 
    D.Nombre AS Dieta,
    A.Nombre AS Alimento,
	A.UnidadMedida,
    SUM(FA.Cantidad) AS CantidadTotal
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_DietaAlimentos FA
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_Dieta D ON FA.IdDieta = D.IdDieta
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_Alimentos A ON FA.IdAlimento = A.IdAlimento
    WHERE FA.Estado = 1
GROUP BY 
    D.Nombre, A.Nombre, A.UnidadMedida;
GO


--select * from Vw_TotalAlimentosPorDieta order by Dieta DESC










DROP VIEW IF EXISTS Vw_AlimentosMasUtilizados;
GO
CREATE VIEW Vw_AlimentosMasUtilizados AS
SELECT 
    A.Nombre AS Alimento,
    A.UnidadMedida AS UnidadMedida,
    SUM(FA.Cantidad) AS CantidadTotal,
    COUNT(DISTINCT FA.IdDieta) AS NumeroDietas
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_DietaAlimentos FA
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_Alimentos A ON FA.IdAlimento = A.IdAlimento

GROUP BY 
    A.Nombre, A.UnidadMedida

GO



-- select * from Vw_AlimentosMasUtilizados  ORDER BY 
--     CantidadTotal DESC;




DROP VIEW IF EXISTS Vw_PromedioCantidadAlimentosPorDieta;
GO
CREATE VIEW Vw_PromedioCantidadAlimentosPorDieta AS
SELECT 
    A.Nombre AS Alimento,
    A.UnidadMedida,
    AVG(FA.Cantidad) AS PromedioCantidad
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_DietaAlimentos FA
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_Alimentos A ON FA.IdAlimento = A.IdAlimento
GROUP BY 
    A.Nombre, A.UnidadMedida;
GO


--select * from Vw_PromedioCantidadAlimentosPorDieta order by PromedioCantidad desc




-----reportes historial movimientos
DROP VIEW IF EXISTS Vw_HistorialMovimientosPorAnimal;
GO
CREATE VIEW Vw_HistorialMovimientosPorAnimal AS
SELECT 
    A.Nombre AS NombreAnimal, 
    CONVERT(VARCHAR(20),H.FechaMovimiento,103)AS 'Fecha', 
    HA.Nombre AS HabitacionAnterior, 
    HC.Nombre AS HabitacionActual, 
    H.Motivo
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_HistorialMovimientos H
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_Animal A ON H.IdAnimal = A.IdAnimales
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_Habitacion HA ON H.IdHabitacionAnterior = HA.IdHabitacion
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_Habitacion HC ON H.IdHabitacionActual = HC.IdHabitacion;
GO




-- select * from Vw_HistorialMovimientosPorAnimal ORDER BY Fecha DESC





DROP VIEW IF EXISTS Vw_AnimalesConMasMovimientos;
GO
CREATE VIEW Vw_AnimalesConMasMovimientos AS
SELECT 
    A.Nombre AS NombreAnimal, 
    COUNT(*) AS TotalMovimientos
FROM 
    ZooMa_Data_Warehouse.dbo.Fact_HistorialMovimientos H
INNER JOIN 
    ZooMa_Data_Warehouse.dbo.Dim_Animal A ON H.IdAnimal = A.IdAnimales
GROUP BY 
    A.Nombre

GO


-- select *  from Vw_AnimalesConMasMovimientos  ORDER BY 
--     TotalMovimientos DESC;