use TPI_Supermercado
go

INSERT INTO Categorias (Nombre, Descripcion) VALUES
('Bebidas', 'Bebidas alcohólicas y sin alcohol'),
('Lácteos', 'Leche, yogures, quesos'),
('Panadería', 'Pan, facturas, bizcochos'),
('Carnicería', 'Cortes de carne vacuna, cerdo, pollo'),
('Verdulería', 'Frutas y verduras frescas'),
('Limpieza', 'Productos de limpieza y desinfección'),
('Almacén', 'Fideos, arroz, conservas'),
('Congelados', 'Productos congelados'),
('Perfumería', 'Higiene personal y cosmética'),
('Mascotas', 'Alimentos y accesorios para mascotas');

INSERT INTO Clientes (DNI, CUIT, Apellido, Nombre, Telefono, Email, Direccion) VALUES
('30123456', NULL, 'Gómez', 'Lucía', '1123456789', 'lucia.gomez@mail.com', 'Av. Rivadavia 123'),
('28999888', NULL, 'Pérez', 'Juan', '1134567890', 'juan.perez@mail.com', 'Calle Falsa 123'),
('31222333', NULL, 'Fernández', 'María', '1145678901', 'mariaf@mail.com', 'Mitre 456'),
('27888999', NULL, 'Rodríguez', 'Carlos', '1156789012', 'carlosr@mail.com', 'Belgrano 789'),
('33444555', NULL, 'López', 'Ana', '1167890123', 'ana.lopez@mail.com', 'San Martín 321'),
('34566777', NULL, 'Martínez', 'Diego', '1178901234', 'diegom@mail.com', 'Alsina 654'),
('35677888', NULL, 'Sánchez', 'Laura', '1189012345', 'lauras@mail.com', 'Urquiza 987'),
('36788999', NULL, 'García', 'Pedro', '1190123456', 'pedrog@mail.com', 'Lavalle 111'),
('37899000', NULL, 'Díaz', 'Sofía', '1101234567', 'sofiad@mail.com', 'Corrientes 222'),
('38900111', NULL, 'Torres', 'Martín', '1112345678', 'martint@mail.com', 'Independencia 333');

INSERT INTO Proveedores (RazonSocial, CUIT, Telefono, Email, Direccion) VALUES
('Distribuidora Norte S.A.', '30-12345678-9', '1140000001', 'ventas@norte.com', 'Av. Libertador 1000'),
('Lácteos del Sur', '30-87654321-0', '1140000002', 'contacto@lacteossur.com', 'Ruta 8 Km 45'),
('Frutas del Valle', '30-11223344-5', '1140000003', 'info@frutasvalle.com', 'Camino del Buen Ayre 500'),
('Carnes Premium', '30-99887766-5', '1140000004', 'ventas@carnespremium.com', 'Av. San Martín 200'),
('Panadería Don Pan', '30-55667788-9', '1140000005', 'donpan@panaderia.com', 'Calle Panaderos 123'),
('Limpio Hogar', '30-66778899-0', '1140000006', 'ventas@limpiohogar.com', 'Av. Higiene 456'),
('Almacén Mayorista', '30-77889900-1', '1140000007', 'almacen@mayorista.com', 'Av. Central 789'),
('Congelados Frío S.A.', '30-88990011-2', '1140000008', 'info@frio.com', 'Parque Industrial 12'),
('Perfumería Bella', '30-99001122-3', '1140000009', 'contacto@bella.com', 'Av. Belleza 321'),
('Mascotas Felices', '30-10111213-4', '1140000010', 'ventas@mascotasfelices.com', 'Calle Mascotas 456');

-- Cargos
INSERT INTO Cargos (Nombre) VALUES
('Cajero'),
('Repositor'),
('Encargado de Depósito'),
('Gerente de Sucursal'),
('Panadero'),
('Carnicero'),
('Verdulero'),
('Limpieza'),
('Seguridad'),
('Administrativo');

-- Empleados
INSERT INTO Empleados (DNI, Apellido, Nombre, IDCargo, Sueldo) VALUES
('20111222', 'Ruiz', 'Marcos', 1, 250000),
('20222333', 'Alvarez', 'Luciana', 2, 220000),
('20333444', 'Méndez', 'Jorge', 3, 280000),
('20444555', 'Silva', 'Romina', 4, 350000),
('20555666', 'Ortiz', 'Esteban', 5, 240000),
('20666777', 'Moreno', 'Paula', 6, 260000),
('20777888', 'Castro', 'Nicolás', 7, 230000),
('20888999', 'Ramos', 'Julieta', 8, 210000),
('20999000', 'Sosa', 'Matías', 9, 270000),
('21000111', 'Paz', 'Camila', 10, 300000);

INSERT INTO Articulos (Nombre, Descripcion, PrecioCompra, PrecioVenta, Stock, IDCategoria) VALUES
('Coca-Cola 1.5L', 'Bebida gaseosa', 300, 450, 50, 1),
('Leche Entera La Serenísima', 'Tetra Brik 1L', 250, 350, 40, 2),
('Pan Lactal', 'Pan de molde blanco', 200, 300, 30, 3),
('Carne Picada', 'Carne vacuna molida', 1200, 1600, 20, 4),
('Manzana Roja', 'Fruta fresca por kg', 400, 600, 25, 5),
('Lavandina Ayudín', '1L', 150, 250, 60, 6),
('Fideos Spaghetti', 'Paquete 500g', 180, 280, 70, 7),
('Helado de crema', '1L sabor vainilla', 800, 1100, 15, 8),
('Shampoo Sedal', 'Envase 340ml', 500, 750, 35, 9),
('Alimento para perro', 'Bolsa 3kg', 1200, 1800, 18, 10),
('Agua Mineral 2L', 'Sin gas', 250, 400, 45, 1),
('Yogur Bebible', 'Frutilla 1L', 300, 450, 30, 2),
('Medialunas', 'Paquete de 6 unidades', 350, 500, 20, 3),
('Milanesa de pollo', 'Por kg', 1100, 1500, 25, 4),
('Banana', 'Por kg', 350, 500, 40, 5),
('Detergente Magistral', '500ml', 280, 400, 60, 6),
('Arroz largo fino', 'Paquete 1kg', 200, 300, 70, 7),
('Pizza congelada', 'Muzzarella 500g', 700, 950, 15, 8),
('Jabón líquido Dove', 'Envase 250ml', 450, 650, 35, 9),
('Arena para gatos', 'Bolsa 5kg', 900, 1300, 20, 10);


INSERT INTO FormaPagos (Efectivo, Debito, Credito, TransferenciaBco, Cheque) VALUES
(1, 0, 0, 0, 0),
(0, 1, 0, 0, 0),
(0, 0, 1, 0, 0),
(0, 0, 0, 1, 0),
(0, 0, 0, 0, 1),
(1, 1, 0, 0, 0),
(0, 1, 1, 0, 0),
(0, 0, 1, 1, 0),
(1, 0, 0, 1, 0),
(0, 1, 0, 0, 1);

INSERT INTO PagoSueldos (IDEmpleado, FechaPago, Periodo, MontoPagado, MetodoPago) VALUES
(1, '2025-10-01', '2025-09-01', 250000, 'Transferencia'),
(2, '2025-10-01', '2025-09-01', 220000, 'Efectivo'),
(3, '2025-10-01', '2025-09-01', 280000, 'Cheque'),
(4, '2025-10-01', '2025-09-01', 350000, 'Transferencia'),
(5, '2025-10-01', '2025-09-01', 240000, 'Débito'),
(6, '2025-10-01', '2025-09-01', 260000, 'Crédito'),
(7, '2025-10-01', '2025-09-01', 230000, 'Transferencia'),
(8, '2025-10-01', '2025-09-01', 210000, 'Efectivo'),
(9, '2025-10-01', '2025-09-01', 270000, 'Débito'),
(10, '2025-10-01', '2025-09-01', 300000, 'Transferencia');

-- Compras de artículos variados
INSERT INTO ComprasDetalle (IDArticulo, IDProveedor, Cantidad, PrecioUnitario, Descuentos, Subtotal, Total, IDEmpleado, IDFormaPago) VALUES
(1, 1, 20, 300, 0, 6000, 6000, 1, 1),
(2, 2, 15, 250, 100, 3750, 3650, 2, 2),
(3, 5, 30, 200, 0, 6000, 6000, 3, 3),
(4, 4, 10, 1200, 200, 12000, 11800, 4, 4),
(5, 3, 25, 400, 0, 10000, 10000, 5, 5),
(6, 6, 40, 150, 0, 6000, 6000, 6, 6),
(7, 7, 50, 180, 100, 9000, 8900, 7, 7),
(8, 8, 10, 800, 0, 8000, 8000, 8, 8),
(9, 9, 20, 500, 200, 10000, 9800, 9, 9),
(10, 10, 15, 1200, 0, 18000, 18000, 10, 10),
(11, 1, 30, 250, 0, 7500, 7500, 1, 2),
(12, 2, 20, 300, 100, 6000, 5900, 2, 3),
(13, 3, 25, 350, 0, 8750, 8750, 3, 4),
(14, 4, 15, 1100, 150, 16500, 16350, 4, 5),
(15, 5, 35, 350, 0, 12250, 12250, 5, 6),
(16, 6, 40, 280, 0, 11200, 11200, 6, 7),
(17, 7, 50, 200, 100, 10000, 9900, 7, 8),
(18, 8, 10, 700, 0, 7000, 7000, 8, 9),
(19, 9, 20, 450, 150, 9000, 8850, 9, 10),
(20, 10, 15, 900, 0, 13500, 13500, 10, 1);

-- Ventas a clientes variados
INSERT INTO VentasDetalle (IDArticulo, IDCliente, Cantidad, PrecioUnitario, Descuentos, Subtotal, Total, IDEmpleado, IDFormaPago) VALUES
(1, 1, 5, 450, 0, 2250, 2250, 1, 1),
(2, 2, 3, 350, 50, 1050, 1000, 2, 2),
(3, 3, 4, 300, 0, 1200, 1200, 3, 3),
(4, 4, 2, 1600, 100, 3200, 3100, 4, 4),
(5, 5, 6, 600, 0, 3600, 3600, 5, 5),
(6, 6, 8, 250, 0, 2000, 2000, 6, 6),
(7, 7, 10, 280, 100, 2800, 2700, 7, 7),
(8, 8, 2, 1100, 0, 2200, 2200, 8, 8),
(9, 9, 5, 750, 150, 3750, 3600, 9, 9),
(10, 10, 3, 1800, 0, 5400, 5400, 10, 10),
(11, 1, 4, 400, 0, 1600, 1600, 1, 2),
(12, 2, 3, 450, 50, 1350, 1300, 2, 3),
(13, 3, 5, 500, 0, 2500, 2500, 3, 4),
(14, 4, 2, 1500, 100, 3000, 2900, 4, 5),
(15, 5, 6, 500, 0, 3000, 3000, 5, 6),
(16, 6, 7, 400, 0, 2800, 2800, 6, 7),
(17, 7, 8, 300, 100, 2400, 2300, 7, 8),
(18, 8, 2, 950, 0, 1900, 1900, 8, 9),
(19, 9, 4, 650, 100, 2600, 2500, 9, 10),
(20, 10, 3, 1300, 0, 3900, 3900, 10, 1);