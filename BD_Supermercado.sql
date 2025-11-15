Create Database TPI_Supermercado
Collate Latin1_General_CI_AI
go
use TPI_Supermercado
go

Create Table Personas(
	IDPersona int primary key identity(1,1),
	DNI nvarchar(10) not null,
	Apellido nvarchar(50) not null,
	Nombre nvarchar(50) not null,
	Direccion nvarchar(100) not null,
	Email nvarchar(50) not null,
	Telefono nvarchar(15) not null,
	Activo bit DEFAULT 1 not null,
	FechaAlta datetime not null DEFAULT GETDATE(),
	FechaUltimaModificacion datetime not null DEFAULT GETDATE(),
	CUIT nvarchar (15) null
)
go

Create Table Proveedores(
	IDProveedor int primary key identity(1,1),
	RazonSocial nvarchar(50) not null,
	CUIT nvarchar(15) not null,
	Telefono nvarchar(25) not null,
	Email nvarchar(50) not null,
	Direccion nvarchar(100) not null,
	FechaAlta datetime not null DEFAULT GETDATE(),
	FechaUltimaModificacion datetime not null DEFAULT GETDATE(),
	Activo bit DEFAULT 1 not null
)
go 

Create Table Clientes(
	IDCliente int primary key identity(1,1),
	IDPersona int not null,
	FranjaHoraria nvarchar (20) null,
	FOREIGN KEY (IDPersona) References Personas(IDPersona)
)
go

Create Table Cargos(
	IDCargo int primary key identity(1,1),
	Nombre nvarchar (50) not null,
)
go

Create Table Empleados(
	IDEmpleado int primary key identity(1,1),
	IDCargo int not null,
	IDPersona int not null,
	Antiguedad int not null,
    Sueldo money not NULL DEFAULT 0,
	FOREIGN KEY (IDPersona) References Personas(IDPersona),
	FOREIGN KEY (IDCargo) References Cargos(IDCargo)

)
go

Create Table PagoSueldos(
	IDSueldo int primary key identity(1,1),
	IDEmpleado int not null,
	FechaPago datetime not null DEFAULT GETDATE(),
	Periodo nvarchar(50) not null,
	MontoPagado money not null,
	MetodoPago nvarchar(25) not null,
	FOREIGN KEY (IDEmpleado) references Empleados(IDEmpleado)
)
go

Create Table Categorias(
	IDCategoria int primary key identity(1,1),
	Nombre nvarchar(50) not null,
	Descripcion nvarchar(50)null
)
go

Create Table Articulos(
	IDArticulo int primary key identity(1,1),
	Nombre nvarchar (50) not null,
	Descripcion nvarchar (50) null,
	Precio Money not null,
	Stock int not null,
	Activo bit DEFAULT 1 not null,
	IDCategoria int not null,
	FOREIGN KEY(IDCategoria) references Categorias(IDCategoria)
)
go

Create Table TiposMovimientos(
	IDTipoMovimiento int primary key identity(1,1),
	Descripcion nvarchar(50) not null
)
go

Create Table MovimientosArticulos(
	IDMovimientoART int primary key identity(1,1),
	FechaMovimiento datetime not null DEFAULT GETDATE(),
	IDArticulo int not null,
	Cantidad int not null,
	Precio Money not null,
	PrecioVenta Money not null,
	IDTipoMovimiento int not null,
	FOREIGN KEY(IDArticulo) references Articulos(IDArticulo),
	FOREIGN KEY(IDTipoMovimiento) references TiposMovimientos(IDTipoMovimiento)
)
go

Create Table TiposFacturas(
	IDTipoFactura int primary key identity(1,1),
	Descripcion nvarchar(50) not null
)
go

Create Table FormasPagos(
	IDFormaPago int primary key identity(1,1),
	Nombre nvarchar(50) not null,
	Activo bit DEFAULT 1 not null
)
go

Create Table Compras(
	IDCompra int primary key identity(1,1),
	IDProveedor int not null,
	IDTipoFactura int not null,
	NumComprobante int not null,
	Fecha datetime not null DEFAULT GETDATE(),
	Descuentos Money null,
	Subtotal Money null,
	Total Money not null,
	Observaciones nvarchar(250) null,
	CondicionIVA nvarchar(100) null,
	IIBB nvarchar (100) null,
	IDEmpleado int not null,
	IDFormaPago int not null,
	FOREIGN KEY (IDProveedor) references Proveedores(IDProveedor),
	FOREIGN KEY (IDTipoFactura) references TiposFacturas(IDTipoFactura),
	FOREIGN KEY (IDEmpleado) references Empleados(IDEmpleado),
	FOREIGN KEY (IDFormaPago) references FormasPagos(IDFormaPago)
)
go

Create Table Ventas(
	IDVenta int primary key identity(1,1),
	IDCliente int not null,
	IDTipoFactura int not null,
	NumComprobante int not null,
	Fecha datetime not null DEFAULT GETDATE(),
	Descuentos Money null,
	Subtotal Money not null,
	Total Money not null,
	Observaciones nvarchar(250) null,
	CondicionIVA nvarchar(100) null,
	IIBB nvarchar (100) null,
	IDEmpleado int not null,
	IDFormaPago int not null,
	FOREIGN KEY (IDCliente) references Clientes(IDCliente),
	FOREIGN KEY (IDTipoFactura) references TiposFacturas(IDTipoFactura),
	FOREIGN KEY (IDEmpleado) references Empleados(IDEmpleado),
	FOREIGN KEY (IDFormaPago) references FormasPagos(IDFormaPago)
)
go

Create Table ComprasDetalles(
	IDCompradetalle int primary key identity(1,1),
	IDArticulo int not null,
	IDCompra int not null,
	Cantidad int not null,
	PrecioUnitario money not null,
	FOREIGN KEY (IDArticulo) references Articulos(IDArticulo),
	FOREIGN KEY (IDCompra) references Compras(IDCompra)
)
go

Create Table VentasDetalles(
	IDVentadetalle int primary key identity(1,1),
	IDArticulo int not null,
	IDVenta int not null,
	Cantidad int not null,
	PrecioUnitario money not null,
	FOREIGN KEY (IDArticulo) references Articulos(IDArticulo),
	FOREIGN KEY (IDVenta) references Ventas(IDVenta)
)
