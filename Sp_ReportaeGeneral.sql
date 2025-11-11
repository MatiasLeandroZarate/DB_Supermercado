/**********************************************************************************************
  STORE PROCEDURE: sp_ReporteGeneral
  OBJETIVO:
    Generar un reporte consolidado del supermercado que reúna información de:
    - Ventas por cliente
    - Compras por proveedor
    - Gastos en sueldos
    - Stock valorizado actual
    - Movimientos de stock (entradas y salidas)
    
  DESCRIPCIÓN:
    Este procedimiento permite obtener un panorama general de los ingresos, egresos 
    y recursos del sistema. Los resultados pueden filtrarse por rango de fechas, cliente o proveedor.
    No realiza ninguna operación de actualización ni inserción sobre las tablas, por lo tanto
    no activa triggers ni modifica datos.

  PARÁMETROS:
    @FechaDesde   DATE  → Fecha inicial del rango de análisis (opcional)
    @FechaHasta   DATE  → Fecha final del rango de análisis (opcional)
    @IdCliente    INT   → Filtra ventas de un cliente específico (opcional)
    @IdProveedor  INT   → Filtra compras de un proveedor específico (opcional)

  AUTOR: Equipo #51 – Proyecto Supermercado
  MATERIA: Base de Datos II
**********************************************************************************************/

CREATE PROCEDURE sp_ReporteGeneral
    @FechaDesde DATE = NULL,
    @FechaHasta DATE = NULL,
    @IdCliente INT = NULL,
    @IdProveedor INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '==== REPORTE GENERAL DEL SUPERMERCADO ====';
    PRINT ' ';

    /**********************************************************************************************
      BLOQUE 1: VENTAS POR CLIENTE (INGRESOS)
      Muestra cantidad de ventas, monto total y fecha de la última compra.
      Se filtra opcionalmente por cliente y rango de fechas.
    **********************************************************************************************/
    PRINT '>> VENTAS POR CLIENTE';
    SELECT 
        c.IdCliente,
        p.Apellido + ', ' + p.Nombre AS Cliente,
        COUNT(DISTINCT v.IdVenta) AS CantidadVentas,
        SUM(d.Cantidad * d.PrecioUnitario) AS TotalFacturado,
        MAX(v.Fecha) AS UltimaCompra
    FROM Ventas v
    INNER JOIN VentasDetalles d ON v.IdVenta = d.IdVenta
    INNER JOIN Clientes c ON v.IdCliente = c.IdCliente
    INNER JOIN Personas p ON c.IdPersona = p.IdPersona
    WHERE
        (@IdCliente IS NULL OR c.IdCliente = @IdCliente)
        AND (@FechaDesde IS NULL OR v.Fecha >= @FechaDesde)
        AND (@FechaHasta IS NULL OR v.Fecha <= @FechaHasta)
    GROUP BY c.IdCliente, p.Apellido, p.Nombre
    ORDER BY TotalFacturado DESC;

    PRINT ' ';
    /**********************************************************************************************
      BLOQUE 2: COMPRAS POR PROVEEDOR (EGRESOS)
      Muestra la cantidad de compras, monto total y fecha de última compra por proveedor.
      Se filtra opcionalmente por proveedor y rango de fechas.
    **********************************************************************************************/
    PRINT '>> COMPRAS POR PROVEEDOR';
    SELECT 
        pr.IdProveedor,
        pr.RazonSocial AS Proveedor,
        COUNT(DISTINCT c.IdCompra) AS CantidadCompras,
        SUM(cd.Cantidad * cd.PrecioUnitario) AS TotalComprado,
        MAX(c.Fecha) AS UltimaCompra
    FROM Compras c
    INNER JOIN ComprasDetalles cd ON c.IdCompra = cd.IdCompra
    INNER JOIN Proveedores pr ON c.IdProveedor = pr.IdProveedor
    WHERE
        (@IdProveedor IS NULL OR pr.IdProveedor = @IdProveedor)
        AND (@FechaDesde IS NULL OR c.Fecha >= @FechaDesde)
        AND (@FechaHasta IS NULL OR c.Fecha <= @FechaHasta)
    GROUP BY pr.IdProveedor, pr.RazonSocial
    ORDER BY TotalComprado DESC;

    PRINT ' ';
    /**********************************************************************************************
      BLOQUE 2B: GASTOS EN SUELDOS (EGRESOS LABORALES)
      Suma los montos pagados a cada empleado dentro del rango de fechas.
    **********************************************************************************************/
    PRINT '>> GASTOS EN SUELDOS';
    SELECT 
        e.IdEmpleado,
        p.Apellido + ', ' + p.Nombre AS Empleado,
        SUM(ps.MontoPagado) AS TotalPagado,
        MAX(ps.FechaPago) AS UltimoPago
    FROM PagoSueldos ps
    INNER JOIN Empleados e ON ps.IdEmpleado = e.IdEmpleado
    INNER JOIN Personas p ON e.IdPersona = p.IdPersona
    WHERE
        (@FechaDesde IS NULL OR ps.FechaPago >= @FechaDesde)
        AND (@FechaHasta IS NULL OR ps.FechaPago <= @FechaHasta)
    GROUP BY e.IdEmpleado, p.Apellido, p.Nombre
    ORDER BY TotalPagado DESC;

    PRINT ' ';
    /**********************************************************************************************
      BLOQUE 3: STOCK VALORIZADO ACTUAL (RECURSOS)
      Muestra los artículos activos con su stock, precio y valor total en inventario.
      No se filtra por fecha, ya que refleja el estado actual del sistema.
    **********************************************************************************************/
    PRINT '>> STOCK VALORIZADO ACTUAL';
    SELECT 
        a.IdArticulo,
        a.Nombre AS Articulo,
        a.Stock,
        a.Precio,
        (a.Stock * a.Precio) AS ValorInventario,
        c.Nombre AS Categoria
    FROM Articulos a
    INNER JOIN Categorias c ON a.IdCategoria = c.IdCategoria
    WHERE a.Activo = 1
    ORDER BY ValorInventario DESC;

    PRINT ' ';
    /**********************************************************************************************
      BLOQUE 4: MOVIMIENTOS DE STOCK (TRAZABILIDAD)
      Lista las entradas y salidas de productos registradas por los triggers:
        - TR_ActualizarStockCompra (entradas)
        - TR_ActualizarStockVenta (salidas)
      Este bloque solo consulta la información ya registrada, sin modificar datos.
    **********************************************************************************************/
    PRINT '>> MOVIMIENTOS DE STOCK (ENTRADAS Y SALIDAS)';
    SELECT 
        ma.IDMovimientoART,
        ma.FechaMovimiento,
        tm.Descripcion AS TipoMovimiento,
        a.Nombre AS Articulo,
        ma.Cantidad,
        ma.Precio,
        ma.PrecioVente AS PrecioVenta
    FROM MovimientosArticulos ma
    INNER JOIN TiposMovimientos tm ON ma.IDTipoMovimiento = tm.IDTipoMovimiento
    INNER JOIN Articulos a ON ma.IDArticulo = a.IDArticulo
    WHERE 
        (@FechaDesde IS NULL OR ma.FechaMovimiento >= @FechaDesde)
        AND (@FechaHasta IS NULL OR ma.FechaMovimiento <= @FechaHasta)
    ORDER BY ma.FechaMovimiento DESC;

    PRINT ' ';
    PRINT '==== FIN DEL REPORTE GENERAL ====';
END;
GO
