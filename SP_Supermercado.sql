CREATE PROCEDURE sp_RegistrarVenta
(
    @IDCliente INT,
    @IDFormaPago INT,
    @IDTipoFactura INT,
    @NumComprobante INT,
    @IDEmpleado INT,
    @IDProducto INT,
    @Cantidad INT,
    @PrecioUnitario DECIMAL(10,2),
    @DescuentoAplicado MONEY = 0,
    @Observaciones NVARCHAR(250) = NULL,
    @CondicionIVA NVARCHAR(100) = NULL,
    @IIBB NVARCHAR(100) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Subtotal MONEY;
    DECLARE @Total MONEY;
    DECLARE @IDVenta INT;

    -- Evitar nulos
    SET @Cantidad = ISNULL(@Cantidad, 0);
    SET @PrecioUnitario = ISNULL(@PrecioUnitario, 0);
    SET @DescuentoAplicado = ISNULL(@DescuentoAplicado, 0);

    -- Calculos
    SET @Subtotal = @Cantidad * @PrecioUnitario;
    SET @Total = @Subtotal - @DescuentoAplicado;

    -- INSERT VENTA
    INSERT INTO Ventas (
        IDCliente,
        IDTipoFactura,
        NumComprobante,
        Fecha,
        Descuentos,
        Subtotal,
        Total,
        Observaciones,
        CondicionIVA,
        IIBB,
        IDEmpleado,
        IDFormaPago
    )
    VALUES (
        @IDCliente,
        @IDTipoFactura,
        @NumComprobante,
        GETDATE(),
        @DescuentoAplicado,
        @Subtotal,
        @Total,
        @Observaciones,
        @CondicionIVA,
        @IIBB,
        @IDEmpleado,
        @IDFormaPago
    );

    -- ID de la venta generada
    SET @IDVenta = SCOPE_IDENTITY();

    -- INSERT DETALLE
    INSERT INTO VentasDetalles (
        IDVenta,
        IDArticulo,
        Cantidad,
        PrecioUnitario
    )
    VALUES (
        @IDVenta,
        @IDProducto,
        @Cantidad,
        @PrecioUnitario
    );
END;
GO

CREATE PROCEDURE sp_RegistrarCompra
    @IdProveedor INT,
    @IdEmpleado INT,
    @IdFormaPago INT,
    @FechaCompra DATE,
    @IdArticulo INT,
    @Cantidad INT,
    @PrecioUnitario DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @IdCompra INT;

        IF @Cantidad <= 0 OR @PrecioUnitario <= 0
            THROW 50010, 'La cantidad y el precio deben ser mayores a cero.', 1;

        IF NOT EXISTS (SELECT 1 FROM Articulos WHERE IDArticulo = @IdArticulo)
            THROW 50011, 'El artículo especificado no existe.', 1;

        INSERT INTO Compras (IdProveedor, IdEmpleado, IdFormaPago, Fecha)
        VALUES (@IdProveedor, @IdEmpleado, @IdFormaPago, @FechaCompra);

        SET @IdCompra = SCOPE_IDENTITY();

        INSERT INTO ComprasDetalles (IdCompra, IdArticulo, Cantidad, PrecioUnitario)
        VALUES (@IdCompra, @IdArticulo, @Cantidad, @PrecioUnitario);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

CREATE PROCEDURE sp_RegistrarPagoSueldo
    @IdEmpleado INT,
    @FechaPago DATE,
    @Monto DECIMAL(10,2) = NULL
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (
            SELECT 1
            FROM Empleados E
            INNER JOIN Personas P ON E.IDPersona = P.IDPersona
            WHERE E.IDEmpleado = @IdEmpleado AND P.Activo = 1
        )
            THROW 53001, 'El empleado no existe o está inactivo.', 1;

        IF @Monto IS NULL
            SELECT @Monto = Sueldo FROM Empleados WHERE IDEmpleado = @IdEmpleado;

        IF @Monto IS NULL OR @Monto <= 0
            THROW 53002, 'Monto de pago inválido.', 1;

        INSERT INTO PagoSueldos (IDEmpleado, FechaPago, Periodo, MontoPagado, MetodoPago)
        VALUES (
            @IdEmpleado,
            @FechaPago,
            FORMAT(@FechaPago, 'yyyy-MM'), -- Ejemplo: '2025-11'
            @Monto,
            'Sistema' 
        );

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;


GO
CREATE PROCEDURE Sp_EliminarProveedor
    @IdProveedor INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM Proveedores WHERE IDProveedor = @IdProveedor)
          THROW 50001, 'El proveedor especificado no existe.', 1;
       
       IF EXISTS (SELECT 1 FROM Compras WHERE IDProveedor = @IdProveedor)
        BEGIN

            UPDATE Proveedores
            SET Activo = 0,
                FechaUltimaModificacion = GETDATE()
            WHERE IDProveedor = @IdProveedor;
        END
        ELSE
        BEGIN

            DELETE FROM Proveedores
            WHERE IDProveedor = @IdProveedor;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

 
        THROW;
    END CATCH
END;
GO
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
