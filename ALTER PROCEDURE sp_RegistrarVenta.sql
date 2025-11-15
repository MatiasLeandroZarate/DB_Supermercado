CREATE PROCEDURE sp_RegistrarVenta
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


EXEC sp_RegistrarVenta 1, 2, 1, 1, '2025-11-15', 5, 3, 1500.00;