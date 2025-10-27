use TPI_Supermercado
go

CREATE PROCEDURE sp_RegistrarCompra
    @IDArticulo INT,
    @IDProveedor INT,
    @Cantidad INT,
    @PrecioUnitario MONEY,
    @Descuentos MONEY,
    @IDEmpleado INT,
    @IDFormaPago INT
AS
BEGIN
    DECLARE @Subtotal MONEY = @Cantidad * @PrecioUnitario;
    DECLARE @Total MONEY = @Subtotal - ISNULL(@Descuentos, 0);

    INSERT INTO ComprasDetalle (
        IDArticulo, IDProveedor, Cantidad, PrecioUnitario, Descuentos,
        Subtotal, Total, IDEmpleado, IDFormaPago
    )
    VALUES (
        @IDArticulo, @IDProveedor, @Cantidad, @PrecioUnitario, @Descuentos,
        @Subtotal, @Total, @IDEmpleado, @IDFormaPago
    );

    IF @Cantidad > 0 
    Begin
    UPDATE Articulos
        SET Stock = Stock + @Cantidad
        WHERE IDArticulo = @IDArticulo;
    END
    Else Begin
        RaisError('Cantidad no valida.',16,1)
        END
END

--------------------------------------------------------------------------------------------------------------
go

CREATE PROCEDURE sp_RegistrarVenta
    @IDArticulo INT,
    @IDCliente INT,
    @Cantidad INT,
    @PrecioUnitario MONEY,
    @Descuentos MONEY,
    @IDEmpleado INT,
    @IDFormaPago INT
AS
BEGIN
    DECLARE @Subtotal MONEY = @Cantidad * @PrecioUnitario;
    DECLARE @Total MONEY = @Subtotal - ISNULL(@Descuentos, 0);

    IF EXISTS (
        SELECT 1 FROM Articulos
        WHERE IDArticulo = @IDArticulo AND Stock >= @Cantidad
    )
    BEGIN
        INSERT INTO VentasDetalle (
            IDArticulo, IDCliente, Cantidad, PrecioUnitario, Descuentos,
            Subtotal, Total, IDEmpleado, IDFormaPago
        )
        VALUES (
            @IDArticulo, @IDCliente, @Cantidad, @PrecioUnitario, @Descuentos,
            @Subtotal, @Total, @IDEmpleado, @IDFormaPago
        );

        UPDATE Articulos
        SET Stock = Stock - @Cantidad
        WHERE IDArticulo = @IDArticulo;
    END
    ELSE
    BEGIN
        RAISERROR('Stock insuficiente para realizar la venta.', 16, 1);
    END
END