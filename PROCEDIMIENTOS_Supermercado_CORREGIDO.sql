CREATE PROCEDURE sp_RegistrarVenta
    @IdCliente INT,
    @IdEmpleado INT,
    @IdFormaPago INT,
    @Fecha DATE,
    @IdArticulo INT,
    @Cantidad INT,
    @PrecioUnitario DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @StockActual INT, @IdVenta INT;

        SELECT @StockActual = Stock FROM Articulos WHERE IDArticulo = @IdArticulo;

        IF @StockActual IS NULL
            THROW 50001, 'El artículo especificado no existe.', 1;

        IF @StockActual < @Cantidad
            THROW 50002, 'No hay stock suficiente para realizar la venta.', 1;

        INSERT INTO Ventas (IdCliente, IdEmpleado, IdFormaPago, Fecha)
        VALUES (@IdCliente, @IdEmpleado, @IdFormaPago, @Fecha);

        SET @IdVenta = SCOPE_IDENTITY();

        INSERT INTO VentasDetalles (IdVenta, IdArticulo, Cantidad, PrecioUnitario)
        VALUES (@IdVenta, @IdArticulo, @Cantidad, @PrecioUnitario);

        UPDATE Articulos
        SET Stock = Stock - @Cantidad
        WHERE IDArticulo = @IdArticulo;

        -- Insertar movimiento de salida (buscar tipo SALIDA)
        DECLARE @IdTipoSalida INT;
        SELECT TOP 1 @IdTipoSalida = IDTipoMovimiento FROM TiposMovimientos WHERE Descripcion = 'SALIDA';
        IF @IdTipoSalida IS NULL
            THROW 52002, 'Falta el tipo de movimiento SALIDA en TiposMovimientos.', 1;

        INSERT INTO MovimientosArticulos (IDArticulo, FechaMovimiento, IDTipoMovimiento, Cantidad, Precio, PrecioVente)
        VALUES (@IdArticulo, GETDATE(), @IdTipoSalida, @Cantidad, 0, @PrecioUnitario);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
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

        UPDATE Articulos
        SET Stock = Stock + @Cantidad, Precio = @PrecioUnitario
        WHERE IDArticulo = @IdArticulo;

        DECLARE @IdTipoEntrada INT;
        SELECT TOP 1 @IdTipoEntrada = IDTipoMovimiento FROM TiposMovimientos WHERE Descripcion = 'ENTRADA';
        IF @IdTipoEntrada IS NULL
            THROW 52001, 'Falta el tipo de movimiento ENTRADA en TiposMovimientos.', 1;

        INSERT INTO MovimientosArticulos (IDArticulo, FechaMovimiento, IDTipoMovimiento, Cantidad, Precio, PrecioVente)
        VALUES (@IdArticulo, GETDATE(), @IdTipoEntrada, @Cantidad, @PrecioUnitario, 0);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
