CREATE TRIGGER TR_ActualizarStockCompra
ON ComprasDetalles
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE A
    SET A.Stock = A.Stock + I.Cantidad
    FROM Articulos A
    INNER JOIN INSERTED I ON A.IDArticulo = I.IDArticulo;

    DECLARE @IdTipoEntrada INT;
    SELECT TOP 1 @IdTipoEntrada = IDTipoMovimiento FROM TiposMovimientos WHERE Descripcion = 'ENTRADA';
    IF @IdTipoEntrada IS NULL
        THROW 52001, 'Falta el tipo de movimiento ENTRADA en TiposMovimientos.', 1;

    INSERT INTO MovimientosArticulos (IDArticulo, FechaMovimiento, IDTipoMovimiento, Cantidad, Precio, PrecioVente)
    SELECT I.IDArticulo, GETDATE(), @IdTipoEntrada, I.Cantidad, COALESCE(I.PrecioUnitario,0), 0
    FROM INSERTED I;
END;
GO

CREATE TRIGGER TR_ActualizarStockVenta
ON VentasDetalles
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE A
    SET A.Stock = A.Stock - I.Cantidad
    FROM Articulos A
    INNER JOIN INSERTED I ON A.IDArticulo = I.IDArticulo;

    DECLARE @IdTipoSalida INT;
    SELECT TOP 1 @IdTipoSalida = IDTipoMovimiento FROM TiposMovimientos WHERE Descripcion = 'SALIDA';
    IF @IdTipoSalida IS NULL
        THROW 52002, 'Falta el tipo de movimiento SALIDA en TiposMovimientos.', 1;

    INSERT INTO MovimientosArticulos (IDArticulo, FechaMovimiento, IDTipoMovimiento, Cantidad, Precio, PrecioVente)
    SELECT I.IDArticulo, GETDATE(), @IdTipoSalida, I.Cantidad, 0, COALESCE(I.PrecioUnitario,0)
    FROM INSERTED I;
END;
GO

CREATE TRIGGER TR_ControlPagoSueldos
ON PagoSueldos
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH Nuevos AS (
        SELECT IdEmpleado, MONTH(FechaPago) AS MesPago, YEAR(FechaPago) AS AnioPago, COUNT(*) AS CantNuevos
        FROM INSERTED
        GROUP BY IdEmpleado, MONTH(FechaPago), YEAR(FechaPago)
    ),
    Existentes AS (
        SELECT P.IdEmpleado, MONTH(P.FechaPago) AS MesPago, YEAR(P.FechaPago) AS AnioPago, COUNT(*) AS CantExist
        FROM PagoSueldos P
        INNER JOIN Nuevos N ON P.IdEmpleado = N.IdEmpleado
            AND MONTH(P.FechaPago) = N.MesPago
            AND YEAR(P.FechaPago) = N.AnioPago
        GROUP BY P.IdEmpleado, MONTH(P.FechaPago), YEAR(P.FechaPago)
    ),
    Conflictos AS (
        SELECT N.IdEmpleado, N.MesPago, N.AnioPago, N.CantNuevos, COALESCE(E.CantExist,0) AS CantExist,
               (N.CantNuevos + COALESCE(E.CantExist,0)) AS Total
        FROM Nuevos N
        LEFT JOIN Existentes E ON N.IdEmpleado = E.IdEmpleado AND N.MesPago = E.MesPago AND N.AnioPago = E.AnioPago
    )
    SELECT * INTO #ConflictosTemp FROM Conflictos WHERE Total > 1;

    IF EXISTS (SELECT 1 FROM #ConflictosTemp)
    BEGIN
        DECLARE @msg NVARCHAR(400) = 'Conflicto: pago duplicado detectado para empleado(s): ';
        SELECT @msg = @msg + CAST(IdEmpleado AS NVARCHAR(10)) + ' (mes=' + CAST(MesPago AS NVARCHAR(2)) + '/anio=' + CAST(AnioPago AS NVARCHAR(4)) + '); '
        FROM #ConflictosTemp;

        DROP TABLE #ConflictosTemp;
        THROW 52100, @msg, 1;
    END

    DROP TABLE IF EXISTS #ConflictosTemp;
END;
GO

CREATE TRIGGER Trg_ValidarComprasProveedor
ON Proveedores
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdProveedor INT;
  
    DECLARE proveedor_cursor CURSOR FOR
        SELECT IDProveedor FROM DELETED;

    OPEN proveedor_cursor;
    FETCH NEXT FROM proveedor_cursor INTO @IdProveedor;

    WHILE @@FETCH_STATUS = 0
    BEGIN
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

        FETCH NEXT FROM proveedor_cursor INTO @IdProveedor;
    END

    CLOSE proveedor_cursor;
    DEALLOCATE proveedor_cursor;
END;