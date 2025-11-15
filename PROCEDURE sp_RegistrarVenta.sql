ALTER PROCEDURE sp_RegistrarVenta
    @IdCliente INT,
    @IdEmpleado INT,
    @IdFormaPago INT,
    @IdTipoFactura INT,
    @Fecha DATE,
    @IdArticulo INT,
    @Cantidad INT,
    @PrecioUnitario DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @StockActual INT, @IdVenta INT;

        SELECT @StockActual = Stock
        FROM Articulos
        WHERE IDArticulo = @IdArticulo;

        IF @StockActual IS NULL
            THROW 50001, 'El artículo especificado no existe.', 1;

        IF @StockActual < @Cantidad
            THROW 50002, 'No hay stock suficiente para realizar la venta.', 1;

        INSERT INTO Ventas (IdCliente, IdEmpleado, IdFormaPago, IdTipoFactura, Fecha)
        VALUES (@IdCliente, @IdEmpleado, @IdFormaPago, @IdTipoFactura, @Fecha);

        SET @IdVenta = SCOPE_IDENTITY();

        INSERT INTO VentasDetalles (IdVenta, IdArticulo, Cantidad, PrecioUnitario)
        VALUES (@IdVenta, @IdArticulo, @Cantidad, @PrecioUnitario);

        UPDATE Articulos
        SET Stock = Stock - @Cantidad
        WHERE IDArticulo = @IdArticulo;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
EXEC sp_RegistrarVenta
    @IdCliente = 1,
    @IdEmpleado = 1,
    @IdFormaPago = 1,
    @IdTipoFactura = 1,
    @Fecha = '2025-01-01',
    @IdArticulo = 1,
    @Cantidad = 1,
    @PrecioUnitario = 100.00;
GO
DROP PROCEDURE IF EXISTS sp_RegistrarVenta;
GO
CREATE PROCEDURE sp_RegistrarVenta
    @IdCliente INT,
    @IdEmpleado INT,
    @IdFormaPago INT,
    @IdTipoFactura INT,
    @NumComprobante INT,
    @Fecha DATE,
    @IdArticulo INT,
    @Cantidad INT,
    @PrecioUnitario DECIMAL(10,2),
    @DescuentoPorcentaje DECIMAL(5,2)   -- ejemplo: 10 = 10%
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @StockActual INT;
        DECLARE @IdVenta INT;
        DECLARE @Subtotal DECIMAL(12,2);
        DECLARE @DescuentoAplicado DECIMAL(12,2);

        -- Validación de artículo
        SELECT @StockActual = Stock
        FROM Articulos
        WHERE IDArticulo = @IdArticulo;

        IF @StockActual IS NULL
            THROW 50001, 'El artículo especificado no existe.', 1;

        IF @StockActual < @Cantidad
            THROW 50002, 'No hay stock suficiente para realizar la venta.', 1;

        -- Calcular descuento
        SET @DescuentoAplicado = (@Cantidad * @PrecioUnitario) * (@DescuentoPorcentaje / 100.0);

        -- Calcular subtotal final
        SET @Subtotal = (@Cantidad * @PrecioUnitario) - @DescuentoAplicado;

        -- Insertar venta
        INSERT INTO Ventas (
            IdCliente, IdEmpleado, IdFormaPago, IdTipoFactura,
            NumComprobante, Fecha, Subtotal, Descuentos
        )
        VALUES (
            @IdCliente, @IdEmpleado, @IdFormaPago, @IdTipoFactura,
            @NumComprobante, @Fecha, @Subtotal, @DescuentoAplicado
        );

        SET @IdVenta = SCOPE_IDENTITY();

        -- Insertar detalle
        INSERT INTO VentasDetalles (
            IdVenta, IdArticulo, Cantidad, PrecioUnitario
        )
        VALUES (
            @IdVenta, @IdArticulo, @Cantidad, @PrecioUnitario
        );

        -- Actualizar stock
        UPDATE Articulos
        SET Stock = Stock - @Cantidad
        WHERE IDArticulo = @IdArticulo;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;

GO
EXEC sp_RegistrarVenta 
    @IdCliente = 1,
    @IdEmpleado = 2,
    @IdFormaPago = 1,
    @IdTipoFactura = 1,
    @NumComprobante = 1001,
    @Fecha = '2025-11-15',
    @IdArticulo = 5,
    @Cantidad = 3,
    @PrecioUnitario = 200.00,
    @DescuentoPorcentaje = 10;     -- porcentaje
GO

DROP PROCEDURE IF EXISTS sp_RegistrarVenta;
GO
CREATE PROCEDURE sp_RegistrarVenta
    @IdCliente INT,
    @IdEmpleado INT,
    @IdFormaPago INT,
    @IdTipoFactura INT,
    @NumComprobante INT,
    @Fecha DATE,
    @IdArticulo INT,
    @Cantidad INT,
    @PrecioUnitario DECIMAL(10,2),
    @DescuentoPorcentaje DECIMAL(5,2)   -- ejemplo: 10 = 10%
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @StockActual INT;
        DECLARE @IdVenta INT;
        DECLARE @Subtotal DECIMAL(12,2);
        DECLARE @DescuentoAplicado DECIMAL(12,2);
        DECLARE @Total DECIMAL(12,2);

        -- Validación de artículo
        SELECT @StockActual = Stock
        FROM Articulos
        WHERE IDArticulo = @IdArticulo;

        IF @StockActual IS NULL
            THROW 50001, 'El artículo especificado no existe.', 1;

        IF @StockActual < @Cantidad
            THROW 50002, 'No hay stock suficiente para realizar la venta.', 1;

        -- Calcular descuento
        SET @DescuentoAplicado = (@Cantidad * @PrecioUnitario) * (@DescuentoPorcentaje / 100.0);

        -- Calcular subtotal
        SET @Subtotal = (@Cantidad * @PrecioUnitario) - @DescuentoAplicado;

        -- Total (tu tabla exige NOT NULL)
        SET @Total = @Subtotal;

        -- Insertar venta
        INSERT INTO Ventas (
            IdCliente, IdEmpleado, IdFormaPago, IdTipoFactura,
            NumComprobante, Fecha, Subtotal, Descuentos, Total
        )
        VALUES (
            @IdCliente, @IdEmpleado, @IdFormaPago, @IdTipoFactura,
            @NumComprobante, @Fecha, @Subtotal, @DescuentoAplicado, @Total
        );

        SET @IdVenta = SCOPE_IDENTITY();

        -- Insertar detalle
        INSERT INTO VentasDetalles (
            IdVenta, IdArticulo, Cantidad, PrecioUnitario
        )
        VALUES (
            @IdVenta, @IdArticulo, @Cantidad, @PrecioUnitario
        );

        -- Actualizar stock
        UPDATE Articulos
        SET Stock = Stock - @Cantidad
        WHERE IDArticulo = @IdArticulo;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO


    INSERT INTO TiposMovimientos (Descripcion)
VALUES ('SALIDA');
GO
EXEC sp_RegistrarVenta 
    @IdCliente = 1,
    @IdEmpleado = 2,
    @IdFormaPago = 1,
    @IdTipoFactura = 1,
    @NumComprobante = 1001,
    @Fecha = '2025-11-15',
    @IdArticulo = 5,
    @Cantidad = 3,
    @PrecioUnitario = 200.00,
    @DescuentoPorcentaje = 10;     -- porcentaje



