DROP PROCEDURE [dbo].[sp_RegistrarVenta]
GO
DROP PROCEDURE IF EXISTS sp_RegistrarVenta;
GO
CREATE PROCEDURE sp_RegistrarVenta
    @IDCliente INT,
    @IDFormaPago INT,
    @IDTipoFactura INT,     -- OBLIGATORIO (tu tabla lo exige)
    @IDProducto INT,
    @Cantidad INT,
    @PrecioUnitario DECIMAL(10,2),
    @DescuentoAplicado DECIMAL(10,2) = 0
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Subtotal DECIMAL(10,2);
    DECLARE @Total DECIMAL(10,2);
    DECLARE @IDVenta INT;

    SET @Cantidad = ISNULL(@Cantidad, 0);
    SET @PrecioUnitario = ISNULL(@PrecioUnitario, 0);
    SET @DescuentoAplicado = ISNULL(@DescuentoAplicado, 0);

    SET @Subtotal = @Cantidad * @PrecioUnitario;
    SET @Total = @Subtotal - @DescuentoAplicado;

    INSERT INTO Ventas (IDCliente, IDFormaPago, IDTipoFactura, Fecha, Subtotal, Total)
    VALUES (@IDCliente, @IDFormaPago, @IDTipoFactura, GETDATE(), @Subtotal, @Total);

    SET @IDVenta = SCOPE_IDENTITY();

    INSERT INTO VentasDetalles (IDVenta, IDArticulo, Cantidad, PrecioUnitario)
    VALUES (@IDVenta, @IDProducto, @Cantidad, @PrecioUnitario);
END;
GO
EXEC sp_RegistrarVenta
    @IDCliente = 1,
    @IDFormaPago = 1,
    @IDTipoFactura = 1,
    @IDProducto = 5,
    @Cantidad = 3,
    @PrecioUnitario = 200.00,
    @DescuentoAplicado = 50.00;
GO
EXEC sp_RegistrarVenta
    @Fecha = '2024-11-15',
    @IDCliente = 1,
    @IDTipoFactura = 1,
    @NumComprobante = 'A-0001-00012345',
    @IDArticulo = 1,
    @Cantidad = 3,
    @Precio = 1500;

GO
DROP PROCEDURE IF EXISTS sp_RegistrarVenta;
GO

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
EXEC sp_RegistrarVenta 
    @IDCliente = 1,
    @IDFormaPago = 1,
    @IDTipoFactura = 1,
    @NumComprobante = 1555,
    @IDEmpleado = 2,
    @IDProducto = 5,
    @Cantidad = 3,
    @PrecioUnitario = 200,
    @DescuentoAplicado = 50;



