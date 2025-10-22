Create Database TPI_Supermercado
Collate Latin1_General_CI_AI
go
use TPI_Supermercado
go
Create Table Proveedor(
	IDProveedor int primary key identity(1,1),
	Nombre nvarchar (50) not null,
	CUIT nvarchar(25) not null,
	Telefono nvarchar(20) not null,
	Email nvarchar(50) not null,
	Direccion nvarchar(50) not null
)
go

Create Table Cliente(
	IDCliente int primary key identity(1,1),
	DNI nvarchar (25) not null,
	Apellido nvarchar (50) not null,
	Nombre nvarchar (50) not null,
	Telefono nvarchar (20) not null,
	Email nvarchar (50) not null
)
go

Create Table Categoria(
	IDCategoria int primary key identity(1,1),
	Nombre nvarchar (50) not null,
	Descripcion nvarchar (100) null
)
go

Create Table Articulo(
	IDArticulo int primary key identity(1,1),
	Nombre nvarchar (50) not null,
	Descripcion nvarchar (100) null,
	PrecioCompra money not null check (PrecioCompra > 0),
	PrecioVenta money not null check (PrecioVenta > 0),
	Stock int not null,
	IDCategoria int not null,
	FOREIGN KEY (IDCategoria) References Categoria(IDCategoria)
)
go

Create Table Empleado(
	IDEmpleado int primary key identity(1,1),
	DNI nvarchar (25) not null,
	Apellido nvarchar (50) not null,
	Nombre nvarchar (50) not null,
	Cargo nvarchar (50) not null,
	FechaIngreso Datetime not null default getdate(),
	SueldoBase money not null check (SueldoBase > 0)
)
go

Create Table Sueldo(
	IDSueldo int primary key identity(1,1),
	IDEmpleado int not null,
	FechaPago Datetime not null default getdate(),
	Periiodo Datetime not null default getdate(),
	MontoPagado money not null check (MontoPagado > 0)
	FOREIGN KEY (IDEmpleado) References Empleado(IDEmpleado)
)
go

Create Table Compra_Detalle(
	IDCompraDetalle int primary key identity(1,1),
	IDArticulo int not null,
	IDProveedor int not null,
	Cantidad int not null,
	Fecha Datetime not null default getdate(),
	PrecioUnitario money not null check (PrecioUnitario > 0),
	Descuentos money not null check (Descuentos > 0),
	Subtotal money not null check (Subtotal > 0),
	Total money not null check (Total > 0),
	IDEmpleado int not null
	FOREIGN KEY (IDEmpleado) References Empleado(IDEmpleado),
	FOREIGN KEY (IDArticulo) References Articulo(IDArticulo),
	FOREIGN KEY (IDProveedor) References Proveedor(IDProveedor)
)
go

Create Table Venta_Detalle(
	IDVentaDetalle int primary key identity(1,1),
	IDArticulo int not null,
	IDCliente int not null,
	Cantidad int not null,
	Fecha Datetime not null default getdate(),
	PrecioUnitario money not null check (PrecioUnitario > 0),
	Descuentos money not null check (Descuentos > 0),
	Subtotal money not null check (Subtotal > 0),
	Total money not null check (Total > 0),
	IDEmpleado int not null
	FOREIGN KEY (IDEmpleado) References Empleado(IDEmpleado),
	FOREIGN KEY (IDArticulo) References Articulo(IDArticulo),
	FOREIGN KEY (IDCliente) References Cliente(IDCliente)
)