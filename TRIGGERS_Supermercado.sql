CREATE TRIGGER TR_ActualizarStockCompra
ON ComprasDetalles
AFTER INSERT
AS
BEGIN
    -- =============================================
    -- Trigger: TR_ActualizarStockCompra
    -- Descripción: Actualiza stock y registra movimiento
    --              cada vez que se inserta un detalle de compra.
    -- =============================================

    DECLARE @IdArticulo INT,
            @CantidadComprada INT;

    -- Obtener los datos insertados
    SELECT @IdArticulo = IdArticulo,
           @CantidadComprada = Cantidad
    FROM INSERTED;/*Tabla virtual temporal disponible y creada solo dentro del trigger y 
    va a contener todas laf ilas que se acaband e insertar en la atabla que activo el trigger.*/

    -- 1. Actualizar el stock del artículo (entrada de productos)
    UPDATE Articulos
    SET Stock = Stock + @CantidadComprada
    WHERE IdArticulo = @IdArticulo;

    -- 2. Registrar el movimiento de entrada en el historial
    
    INSERT INTO MovimientosArticulos (IdArticulo, FechaMovimiento, IDTipoMovimiento, Cantidad)
    VALUES (@IdArticulo, GETDATE(), 'ENTRADA', @CantidadComprada);

    PRINT 'Trigger TR_ActualizarStockCompra ejecutado: stock actualizado y movimiento registrado.';
END;
GO
CREATE TRIGGER TR_ActualizarStockVenta
ON VentasDetalles
AFTER INSERT
AS
BEGIN
    -- =============================================
    -- Trigger: TR_ActualizarStockVenta
    -- Descripción: Descuenta stock y registra
    --              movimiento al insertar una venta.
    -- =============================================

    -- Actualizar stock de todos los artículos vendidos
    UPDATE A
    SET A.Stock = A.Stock - I.Cantidad
    FROM Articulos A
    INNER JOIN INSERTED I ON A.IdArticulo = I.IdArticulo;

    -- Registrar movimientos de salida
    INSERT INTO MovimientosArticulos (IdArticulo, FechaMovimiento, IDTipoMovimiento, Cantidad)
    SELECT I.IdArticulo, GETDATE(), 'SALIDA', I.Cantidad
    FROM INSERTED I;
END;

