INSERT INTO Personas (DNI, Apellido, Nombre, Direccion, Email, Telefono, CUIT)
VALUES 
('30123456', 'Gómez', 'Lucía', 'Av. Mitre 123', 'lucia.gomez@mail.com', '1134567890', '20-30123456-3'),
('28987654', 'Pérez', 'Juan', 'Calle Falsa 456', 'juan.perez@mail.com', '1145678901', '20-28987654-2'),
('31234567', 'Rodríguez', 'Ana', 'San Martín 789', 'ana.rod@mail.com', '1156789012', NULL),
('27890123', 'Fernández', 'Carlos', 'Belgrano 321', 'carlos.fer@mail.com', '1167890123', '20-27890123-1'),
('29876543', 'López', 'María', 'Rivadavia 654', 'maria.lopez@mail.com', '1178901234', NULL),
('30543210', 'Martínez', 'Diego', 'Corrientes 987', 'diego.mart@mail.com', '1189012345', '20-30543210-4'),
('28765432', 'Sánchez', 'Laura', 'Perón 111', 'laura.san@mail.com', '1190123456', NULL),
('31456789', 'Ramírez', 'José', 'Alsina 222', 'jose.ram@mail.com', '1101234567', '20-31456789-5'),
('27654321', 'Torres', 'Valeria', 'Castelli 333', 'valeria.tor@mail.com', '1112345678', NULL),
('30987654', 'Gutiérrez', 'Miguel', 'Lavalle 444', 'miguel.gut@mail.com', '1123456789', '20-30987654-6');
go

INSERT INTO Proveedores (RazonSocial, CUIT, Telefono, Email, Direccion)
VALUES 
('Distribuidora Sur', '30-12345678-9', '1130001111', 'contacto@distsur.com', 'Av. La Plata 100'),
('Alimentos Norte', '30-23456789-0', '1140002222', 'ventas@alnorte.com', 'Calle 25 de Mayo 200'),
('Bebidas del Centro', '30-34567890-1', '1150003333', 'info@bebcentro.com', 'Av. Córdoba 300'),
('Lácteos San Juan', '30-45678901-2', '1160004444', 'sanjuan@lacteos.com', 'Ruta 8 km 45'),
('Verduras Frescas', '30-56789012-3', '1170005555', 'ventas@verdfresca.com', 'Camino Real 500'),
('Carnes del Oeste', '30-67890123-4', '1180006666', 'cdo@carnes.com', 'Av. Roca 600'),
('Panadería Central', '30-78901234-5', '1190007777', 'pan@central.com', 'Calle Pan 700'),
('Limpieza Total', '30-89012345-6', '1100008888', 'info@limptotal.com', 'Av. Higiene 800'),
('Tecnología Hogar', '30-90123456-7', '1110009999', 'ventas@techogar.com', 'Calle Tech 900'),
('Frutas del Valle', '30-01234567-8', '1120000000', 'frutas@valle.com', 'Ruta 3 km 10');
go
INSERT INTO Clientes (IDPersona, FranjaHoraria)
VALUES 
(1, 'Mañana'),
(2, 'Tarde'),
(3, 'Noche'),
(4, NULL),
(5, 'Mañana'),
(6, 'Tarde'),
(7, NULL),
(8, 'Noche'),
(9, 'Mañana'),
(10, 'Tarde');
go
INSERT INTO Cargos (Nombre)
VALUES 
('Cajero'),
('Repositor'),
('Gerente'),
('Encargado de Compras'),
('Vendedor'),
('Supervisor'),
('Administrativo'),
('Seguridad'),
('Limpieza'),
('Auxiliar');
go
INSERT INTO Empleados (IDCargo, IDPersona, Antiguedad, Sueldo)
VALUES 
(1, 1, 2, 120000),
(2, 2, 1, 110000),
(3, 3, 5, 180000),
(4, 4, 3, 150000),
(5, 5, 2, 130000),
(6, 6, 4, 160000),
(7, 7, 1, 115000),
(8, 8, 2, 125000),
(9, 9, 3, 140000),
(10, 10, 1, 100000);
go
INSERT INTO PagoSueldos (IDEmpleado, Periodo, MontoPagado, MetodoPago)
VALUES 
(1, '2025-10', 120000, 'Transferencia'),
(2, '2025-10', 110000, 'Efectivo'),
(3, '2025-10', 180000, 'Transferencia'),
(4, '2025-10', 150000, 'Cheque'),
(5, '2025-10', 130000, 'Transferencia'),
(6, '2025-10', 160000, 'Efectivo'),
(7, '2025-10', 115000, 'Transferencia'),
(8, '2025-10', 125000, 'Transferencia'),
(9, '2025-10', 140000, 'Cheque'),
(10, '2025-10', 100000, 'Efectivo');
go
INSERT INTO Categorias (Nombre, Descripcion)
VALUES 
('Lácteos', 'Productos derivados de la leche'),
('Carnes', 'Carne vacuna, pollo, cerdo'),
('Bebidas', 'Gaseosas, jugos, agua'),
('Panadería', 'Pan, facturas, galletitas'),
('Limpieza', 'Artículos de limpieza'),
('Verduras', 'Vegetales frescos'),
('Frutas', 'Frutas de estación'),
('Tecnología', 'Electrodomésticos y gadgets'),
('Congelados', 'Productos congelados'),
('Snacks', 'Golosinas y snacks');
go
INSERT INTO Articulos (Nombre, Descripcion, Precio, Stock, IDCategoria)
VALUES 
('Leche Entera', '1L', 350, 100, 1),
('Carne Picada', '500g', 800, 50, 2),
('Coca-Cola', '2.25L', 750, 200, 3),
('Pan Francés', 'Unidad', 150, 300, 4),
('Lavandina', '1L', 250, 80, 5),
('Tomate', 'Kg', 400, 60, 6),
('Banana', 'Kg', 300, 70, 7),
('Auriculares', 'Bluetooth', 3500, 20, 8),
('Pizza Congelada', 'Mozzarella', 1200, 40, 9),
('Papas Fritas', 'Bolsa 100g', 500, 90, 10);
go
INSERT INTO TiposMovimientos (Descripcion)
VALUES 
('Compra'),
('Venta'),
('Devolución'),
('Ajuste de Stock'),
('Transferencia'),
('Donación'),
('Rotura'),
('Vencimiento'),
('Promoción'),
('Entrada'),
('Salida'),
('Inventario');
go
INSERT INTO MovimientosArticulos (IDArticulo, Cantidad, Precio, PrecioVenta, IDTipoMovimiento)
VALUES 
(1, 50, 300, 350, 1),
(2, 20, 700, 800, 1),
(3, 100, 600, 750, 1),
(4, 150, 100, 150, 1),
(5, 40, 200, 250, 1),
(6, 30, 350, 400, 1),
(7, 25, 250, 300, 1),
(8, 10, 3000, 3500, 1),
(9, 20, 1000, 1200, 1),
(10, 40, 400, 500, 1);
go
INSERT INTO TiposFacturas (Descripcion)
VALUES 
('Factura A'),
('Factura B'),
('Factura C'),
('Nota de Crédito'),
('Nota de Débito'),
('Recibo'),
('Presupuesto'),
('Ticket'),
('Factura Electrónica'),
('Remito');
go
INSERT INTO FormasPagos (Nombre)
VALUES 
('Efectivo'),
('Transferencia Bancaria'),
('Tarjeta de Crédito'),
('Tarjeta de Débito'),
('Cheque'),
('Mercado Pago'),
('Cuenta Corriente'),
('Crédito Personal'),
('Pago QR'),
('Criptomoneda');
go
INSERT INTO Compras (IDProveedor, IDTipoFactura, NumComprobante, Descuentos, Subtotal, Total, Observaciones, CondicionIVA, IIBB, IDEmpleado, IDFormaPago)
VALUES 
(1, 1, 1001, 200, 3000, 2800, 'Compra mensual', 'Responsable Inscripto', 'Exento', 1, 1),
(2, 2, 1002, NULL, 1500, 1500, NULL, 'Monotributo', 'No corresponde', 2, 2),
(3, 3, 1003, 100, 2500, 2400, 'Descuento por volumen', 'Responsable Inscripto', 'Exento', 3, 3),
(4, 1, 1004, 50, 1800, 1750, NULL, 'Exento', 'No aplica', 4, 4),
(5, 2, 1005, NULL, 2200, 2200, 'Compra urgente', 'Monotributo', 'No corresponde', 5, 5),
(6, 3, 1006, 300, 4000, 3700, 'Promoción especial', 'Responsable Inscripto', 'Exento', 6, 6),
(7, 1, 1007, NULL, 1200, 1200, NULL, 'Exento', 'No aplica', 7, 7),
(8, 2, 1008, 150, 2700, 2550, 'Compra por reposición', 'Monotributo', 'No corresponde', 8, 8),
(9, 3, 1009, NULL, 3500, 3500, NULL, 'Responsable Inscripto', 'Exento', 9, 9),
(10, 1, 1010, 100, 2000, 1900, 'Compra semanal', 'Exento', 'No aplica', 10, 10);
go
INSERT INTO Ventas (IDCliente, IDTipoFactura, NumComprobante, Descuentos, Subtotal, Total, Observaciones, CondicionIVA, IIBB, IDEmpleado, IDFormaPago)
VALUES 
(1, 1, 2001, 100, 1500, 1400, 'Cliente frecuente', 'Consumidor Final', 'No aplica', 1, 1),
(2, 2, 2002, NULL, 800, 800, NULL, 'Monotributo', 'No corresponde', 2, 2),
(3, 3, 2003, 50, 1200, 1150, 'Descuento por promoción', 'Responsable Inscripto', 'Exento', 3, 3),
(4, 1, 2004, NULL, 950, 950, NULL, 'Consumidor Final', 'No aplica', 4, 4),
(5, 2, 2005, 80, 1100, 1020, 'Cliente nuevo', 'Monotributo', 'No corresponde', 5, 5),
(6, 3, 2006, NULL, 1300, 1300, NULL, 'Responsable Inscripto', 'Exento', 6, 6),
(7, 1, 2007, 60, 1000, 940, 'Compra con descuento', 'Consumidor Final', 'No aplica', 7, 7),
(8, 2, 2008, NULL, 1400, 1400, NULL, 'Monotributo', 'No corresponde', 8, 8),
(9, 3, 2009, 90, 1600, 1510, 'Promoción especial', 'Responsable Inscripto', 'Exento', 9, 9),
(10, 1, 2010, NULL, 1700, 1700, NULL, 'Consumidor Final', 'No aplica', 10, 10);
go

INSERT INTO ComprasDetalles (IDArticulo, IDCompra, Cantidad, PrecioUnitario)
VALUES 
(1, 1, 50, 300),
(2, 2, 20, 700),
(3, 3, 100, 600),
(4, 4, 150, 100),
(5, 5, 40, 200),
(6, 6, 30, 350),
(7, 7, 25, 250),
(8, 8, 10, 3000),
(9, 9, 20, 1000),
(10, 10, 40, 400);
go
INSERT INTO VentasDetalles (IDArticulo, IDVenta, Cantidad, PrecioUnitario)
VALUES 
(1, 1, 10, 350),
(2, 2, 5, 800),
(3, 3, 20, 750),
(4, 4, 30, 150),
(5, 5, 10, 250),
(6, 6, 15, 400),
(7, 7, 8, 300),
(8, 8, 3, 3500),
(9, 9, 6, 1200),
(10, 10, 12, 500);