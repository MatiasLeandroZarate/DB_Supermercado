use TPI_Supermercado
go

CREATE FUNCTION FN_ComprasPorProveedor(@IDProveedor INT)
RETURNS TABLE
AS
RETURN
(
    SELECT c.IDCompra, c.Fecha, SUM(cd.Cantidad * cd.PrecioUnitario) AS Total
    FROM Compras c
    INNER JOIN ComprasDetalles cd ON c.IDCompra = cd.IDCompra
    WHERE c.IDProveedor = @IDProveedor
    GROUP BY c.IDCompra, c.Fecha
);

--SELECT * FROM dbo.FN_ComprasPorProveedor(1);