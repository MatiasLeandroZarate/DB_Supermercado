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

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
