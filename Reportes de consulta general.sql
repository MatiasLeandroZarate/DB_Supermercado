/**********************************************************************************************
  PROCEDIMIENTO: sp_ReporteGeneral
  OBJETIVO:
    Generar un reporte integral del supermercado con resúmenes de:
      - Ventas por cliente
      - Compras por proveedor
      - Gastos en sueldos
      - Stock valorizado
      - Movimientos de stock
    Usa la función dbo.fn_NivelMonto para clasificar montos ('BAJO', 'MEDIO', 'ALTO')
**********************************************************************************************/



CREATE PROCEDURE sp_ReporteGeneral
    @FechaDesde DATE = NULL,   
    @FechaHasta DATE = NULL,   
    @IdCliente INT = NULL,     
    @IdProveedor INT = NULL    
AS
BEGIN
    PRINT '==== REPORTE GENERAL DEL SUPERMERCADO ====';
    PRINT ' ';

    /********************************************************************
      BLOQUE 1: VENTAS POR CLIENTE
    ********************************************************************/
    PRINT '>> VENTAS POR CLIENTE';
    SELECT 
        c.[IdCliente],
        p.[Apellido] + ', ' + p.[Nombre] AS Cliente,
        COUNT(DISTINCT v.[IdVenta]) AS CantidadVentas,
        SUM(d.[Cantidad] * d.[PrecioUnitario]) AS TotalFacturado,
        dbo.fn_NivelMonto(SUM(d.[Cantidad] * d.[PrecioUnitario])) AS NivelFacturacion,
        MAX(v.[Fecha]) AS UltimaCompra
    FROM [Ventas] v
    INNER JOIN [VentasDetalles] d ON v.[IdVenta] = d.[IdVenta]
    INNER JOIN [Clientes] c ON v.[IdCliente] = c.[IdCliente]
    INNER JOIN [Personas] p ON c.[IdPersona] = p.[IdPersona]
    WHERE
        (@IdCliente IS NULL OR c.[IdCliente] = @IdCliente)
        AND (@FechaDesde IS NULL OR v.[Fecha] >= @FechaDesde)
        AND (@FechaHasta IS NULL OR v.[Fecha] <= @FechaHasta)
    GROUP BY c.[IdCliente], p.[Apellido], p.[Nombre]
    ORDER BY TotalFacturado DESC;

    PRINT ' ';

    /********************************************************************
      BLOQUE 2: COMPRAS POR PROVEEDOR
    ********************************************************************/
    PRINT '>> COMPRAS POR PROVEEDOR';
    SELECT 
        pr.[IdProveedor],
        pr.[RazonSocial] AS Proveedor,
        COUNT(DISTINCT c.[IdCompra]) AS CantidadCompras,
        SUM(cd.[Cantidad] * cd.[PrecioUnitario]) AS TotalComprado,
        dbo.fn_NivelMonto(SUM(cd.[Cantidad] * cd.[PrecioUnitario])) AS NivelInversion,
        MAX(c.[Fecha]) AS UltimaCompra
    FROM [Compras] c
    INNER JOIN [ComprasDetalles] cd ON c.[IdCompra] = cd.[IdCompra]
    INNER JOIN [Proveedores] pr ON c.[IdProveedor] = pr.[IdProveedor]
    WHERE
        (@IdProveedor IS NULL OR pr.[IdProveedor] = @IdProveedor)
        AND (@FechaDesde IS NULL OR c.[Fecha] >= @FechaDesde)
        AND (@FechaHasta IS NULL OR c.[Fecha] <= @FechaHasta)
    GROUP BY pr.[IdProveedor], pr.[RazonSocial]
    ORDER BY TotalComprado DESC;

    PRINT ' ';

    /********************************************************************
      BLOQUE 3: GASTOS EN SUELDOS
      ps.MontoPagado confirmado
    ********************************************************************/
    PRINT '>> GASTOS EN SUELDOS';
    SELECT 
        e.[IdEmpleado],
        p.[Apellido] + ', ' + p.[Nombre] AS Empleado,
        SUM(ps.[MontoPagado]) AS TotalPagado,
        dbo.fn_NivelMonto(SUM(ps.[MontoPagado])) AS NivelGastoSueldo,
        MAX(ps.[FechaPago]) AS UltimoPago
    FROM [PagoSueldos] ps
    INNER JOIN [Empleados] e ON ps.[IdEmpleado] = e.[IdEmpleado]
    INNER JOIN [Personas] p ON e.[IdPersona] = p.[IdPersona]
    WHERE
        (@FechaDesde IS NULL OR ps.[FechaPago] >= @FechaDesde)
        AND (@FechaHasta IS NULL OR ps.[FechaPago] <= @FechaHasta)
    GROUP BY e.[IdEmpleado], p.[Apellido], p.[Nombre]
    ORDER BY TotalPagado DESC;

    PRINT ' ';

    /********************************************************************
      BLOQUE 4: STOCK VALORIZADO ACTUAL
    ********************************************************************/
    PRINT '>> STOCK VALORIZADO ACTUAL';
    SELECT 
        a.[IdArticulo],
        a.[Nombre] AS Articulo,
        a.[Stock],
        a.[Precio],
        (a.[Stock] * a.[Precio]) AS ValorInventario,
        dbo.fn_NivelMonto((a.[Stock] * a.[Precio])) AS NivelValorInventario,
        c.[Nombre] AS Categoria
    FROM [Articulos] a
    INNER JOIN [Categorias] c ON a.[IdCategoria] = c.[IdCategoria]
    WHERE a.[Activo] = 1
    ORDER BY ValorInventario DESC;

    PRINT ' ';

    /********************************************************************
      BLOQUE 5: MOVIMIENTOS DE STOCK
      ma.IDMovimientoART y ma.PrecioVente confirmados
    ********************************************************************/
    PRINT '>> MOVIMIENTOS DE STOCK (ENTRADAS Y SALIDAS)';
    SELECT 
        ma.[IDMovimientoART],
        ma.[FechaMovimiento],
        tm.[Descripcion] AS TipoMovimiento,
        a.[Nombre] AS Articulo,
        ma.[Cantidad],
        ma.[Precio],
        ma.[PrecioVente] AS PrecioVenta
    FROM [MovimientosArticulos] ma
    INNER JOIN [TiposMovimientos] tm ON ma.[IDTipoMovimiento] = tm.[IDTipoMovimiento]
    INNER JOIN [Articulos] a ON ma.[IDArticulo] = a.[IDArticulo]
    WHERE 
        (@FechaDesde IS NULL OR ma.[FechaMovimiento] >= @FechaDesde)
        AND (@FechaHasta IS NULL OR ma.[FechaMovimiento] <= @FechaHasta)
    ORDER BY ma.[FechaMovimiento] DESC;

    PRINT ' ';
    PRINT '==== FIN DEL REPORTE GENERAL ====';
END;
GO
EXEC sp_ReporteGeneral;
/*Qué muestra:
Todas las ventas de todos los clientes.
Todas las compras de todos los proveedores.
Todos los pagos de sueldos registrados.
Stock total valorizado actual.
Todos los movimientos de stock.*/

GO/*Filtrar por rango de fechas*/
EXEC sp_ReporteGeneral 
     @FechaDesde = '2025-01-01',
     @FechaHasta = '2025-03-31';

/*Qué muestra:
Solo registros del primer trimestre 2025.
Ideal para reportes trimestrales.*/
/*Filtrar por cliente específico*/
EXEC sp_ReporteGeneral 
     @IdCliente = 3;

/*Qué muestra:
Reporte general, pero limitado a las operaciones del cliente con Id = 3.
Ventas de ese cliente.
Resto de bloques (compras, sueldos, stock, movimientos) se muestran completos.*/
GO
/*Filtrar por proveedor específico*/
EXEC sp_ReporteGeneral 
     @IdProveedor = 7;
