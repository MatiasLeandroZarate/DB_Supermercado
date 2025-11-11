DROP procedure sp_RegistrarVenta;
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
