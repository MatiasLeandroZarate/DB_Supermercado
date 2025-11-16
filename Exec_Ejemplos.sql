EXEC sp_ReporteGeneral;
/*Qué muestra:
Todas las ventas de todos los clientes.
Todas las compras de todos los proveedores.
Todos los pagos de sueldos registrados.
Stock total valorizado actual.
Todos los movimientos de stock.*/

GO/*Filtrar por rango de fechas*/
EXEC sp_ReporteGeneral 
     @FechaDesde = '2025-01-01',
     @FechaHasta = '2025-03-31';

/*Qué muestra:
Solo registros del primer trimestre 2025.
Ideal para reportes trimestrales.*/
/*Filtrar por cliente específico*/
EXEC sp_ReporteGeneral 
     @IdCliente = 3;

/*Qué muestra:
Reporte general, pero limitado a las operaciones del cliente con Id = 3.
Ventas de ese cliente.
Resto de bloques (compras, sueldos, stock, movimientos) se muestran completos.*/
GO
/*Filtrar por proveedor específico*/
EXEC sp_ReporteGeneral 
     @IdProveedor = 7;
