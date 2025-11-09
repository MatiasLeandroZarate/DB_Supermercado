CREATE VIEW VW_VentasPorCliente AS
SELECT 
    c.IdCliente,
    p.Apellido + ', ' + p.Nombre AS Cliente,
    COUNT(DISTINCT v.IdVenta) AS CantidadVentas,
    SUM(d.Cantidad * d.PrecioUnitario) AS TotalFacturado,
    MAX(v.Fecha) AS UltimaCompra
FROM Clientes c
INNER JOIN Personas p ON c.IdPersona = p.IdPersona
INNER JOIN Ventas v ON v.IdCliente = c.IdCliente
INNER JOIN VentasDetalles d ON d.IdVenta = v.IdVenta
GROUP BY c.IdCliente, p.Apellido, p.Nombre;

GO

CREATE VIEW VW_ComprasPorProveedor AS
SELECT 
    pr.IdProveedor,
    pr.RazonSocial AS Proveedor,
    COUNT(DISTINCT c.IdCompra) AS CantidadCompras,
    SUM(cd.Cantidad * cd.PrecioUnitario) AS TotalComprado,
    MAX(c.Fecha) AS UltimaCompra
FROM Proveedores pr
INNER JOIN Compras c ON c.IDProveedor = pr.IDProveedor
INNER JOIN ComprasDetalles cd ON cd.IdCompra = c.IDCompra
GROUP BY pr.IdProveedor, pr.RazonSocial;

GO

CREATE VIEW VW_StockValorizado AS
SELECT 
    a.IDArticulo,
    a.Nombre AS Articulo,
    a.Stock,
    a.Precio,
    (a.Stock * a.Precio) AS ValorInventario,
    c.Nombre AS Categoria
FROM Articulos a
INNER JOIN Categorias c ON a.IDCategoria = c.IDCategoria
WHERE a.Activo = 1;

