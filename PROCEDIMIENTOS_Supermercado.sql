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
    -- =============================================
    -- Procedimiento: sp_RegistrarVenta
    -- Descripción: Registra una venta, actualiza stock
    --              y genera el movimiento de salida.
    -- Incluye manejo de errores y transacción.
    -- =============================================

    BEGIN TRY
        BEGIN TRANSACTION  -- Inicia la transacción para asegurar atomicidad

        DECLARE @StockActual INT,
                @IdVenta INT;

        -- 1. Obtener el stock actual del artículo vendido
        SELECT @StockActual = Stock
        FROM Articulos
        WHERE IdArticulo = @IdArticulo;

        -- 2. Verificar que el artículo exista
        IF @StockActual IS NULL
            THROW 50001, 'El artículo especificado no existe.', 1;

        -- 3. Validar stock suficiente para la venta
        IF @StockActual < @Cantidad
            THROW 50002, 'No hay stock suficiente para realizar la venta.', 1;

        -- 4. Insertar cabecera de la venta en tabla Ventas
        INSERT INTO Ventas (IdCliente, IdEmpleado, IdFormaPago, Fecha)
        VALUES (@IdCliente, @IdEmpleado, @IdFormaPago, @Fecha);

        -- Obtener el ID de la venta recién generada
        SET @IdVenta = SCOPE_IDENTITY();

        -- 5. Insertar el detalle del artículo vendido
        INSERT INTO VentasDetalles (IdVenta, IdArticulo, Cantidad, PrecioUnitario)
        VALUES (@IdVenta, @IdArticulo, @Cantidad, @PrecioUnitario);

        -- 6. Actualizar el stock del artículo
        UPDATE Articulos
        SET Stock = Stock - @Cantidad
        WHERE IdArticulo = @IdArticulo;

        -- Verificar que el stock no quede negativo (seguridad adicional)
        IF (SELECT Stock FROM Articulos WHERE IdArticulo = @IdArticulo) < 0
            THROW 50003, 'El stock resultante es negativo. Revisión requerida.', 1;

        -- 7. Registrar el movimiento en la tabla de movimientos
        INSERT INTO MovimientosArticulos (IDArticulo, FechaMovimiento, IDTipoMovimiento, Cantidad)
        VALUES (@IdArticulo, GETDATE(), 'SALIDA', @Cantidad);

        -- 8. Confirmar toda la transacción
        COMMIT TRANSACTION;

        PRINT 'Venta registrada correctamente.';

    END TRY
    BEGIN CATCH
        -- Si ocurre cualquier error dentro del TRY, se revierte todo
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Relanza el error original con THROW para que la aplicación lo reciba
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
    -- =============================================
    -- Procedimiento: sp_RegistrarCompra
    -- Descripción: Registra una compra a proveedor.
    --              Inserta cabecera y detalle, 
    --              actualiza stock y registra movimiento.
    -- Incluye manejo de errores y control de transacción.
    -- =============================================

    BEGIN TRY
        BEGIN TRANSACTION  -- Inicia la transacción

        DECLARE @IdCompra INT;

        -- 1. Validar que la cantidad y el precio sean positivos
        IF @Cantidad <= 0 OR @PrecioUnitario <= 0
            THROW 50010, 'La cantidad y el precio deben ser mayores a cero.', 1;

        -- 2. Validar que el artículo exista en la tabla Articulos
        IF NOT EXISTS (SELECT 1 FROM Articulos WHERE IdArticulo = @IdArticulo)
            THROW 50011, 'El artículo especificado no existe.', 1;

        -- 3. Insertar la cabecera de la compra
        --    Ajustá el nombre de la columna de fecha según tu DER (ej. FechaCompra o Fecha)
        INSERT INTO Compras (IdProveedor, IdEmpleado, IdFormaPago, Fecha)
        VALUES (@IdProveedor, @IdEmpleado, @IdFormaPago, @FechaCompra);

        -- 4. Obtener el ID generado automáticamente para la compra
        SET @IdCompra = SCOPE_IDENTITY();

        -- 5. Insertar el detalle de la compra
        INSERT INTO ComprasDetalles (IdCompra, IdArticulo, Cantidad, PrecioUnitario)
        VALUES (@IdCompra, @IdArticulo, @Cantidad, @PrecioUnitario);

        -- 6. Actualizar el stock del artículo (entrada de mercadería)
        UPDATE Articulos
        SET Stock = Stock + @Cantidad,
            Precio = @PrecioUnitario   -- Actualiza el precio de compra si corresponde
        WHERE IdArticulo = @IdArticulo;

        -- 7. Registrar el movimiento de entrada
        --    Verificar nombres exactos de columnas según tu esquema (FechaMovimiento, TipoMovimiento, etc.)
        INSERT INTO MovimientosArticulos (IDArticulo, FechaMovimiento, IDTipoMovimiento, Cantidad)
        VALUES (@IdArticulo, GETDATE(), 'ENTRADA', @Cantidad);

        -- 8. Confirmar toda la transacción si no hubo errores
        COMMIT TRANSACTION;

        PRINT 'Compra registrada correctamente.';

    END TRY
    BEGIN CATCH
        -- Si ocurre un error, revertir todos los cambios
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Relanzar el error original al sistema o cliente
        THROW;
    END CATCH
END;

