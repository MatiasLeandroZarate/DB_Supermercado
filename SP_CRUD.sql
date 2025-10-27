use TPI_Supermercado
go
CREATE PROCEDURE sp_AltaArticulo
    @Nombre NVARCHAR(50),
    @Descripcion NVARCHAR(100),
    @PrecioCompra MONEY,
    @PrecioVenta MONEY,
    @Stock INT,
    @IDCategoria INT
AS
BEGIN
    INSERT INTO Articulos (Nombre, Descripcion, PrecioCompra, PrecioVenta, Stock, IDCategoria, Activo)
    VALUES (@Nombre, @Descripcion, @PrecioCompra, @PrecioVenta, @Stock, @IDCategoria, 1);
END
go
-----------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE sp_ModificarArticulo
    @IDArticulo INT,
    @Nombre NVARCHAR(50),
    @Descripcion NVARCHAR(100),
    @PrecioCompra MONEY,
    @PrecioVenta MONEY,
    @Stock INT,
    @IDCategoria INT,
    @Activo BIT
AS
BEGIN

    UPDATE Articulos
    SET Nombre = @Nombre,
        Descripcion = @Descripcion,
        PrecioCompra = @PrecioCompra,
        PrecioVenta = @PrecioVenta,
        Stock = @Stock,
        IDCategoria = @IDCategoria,
        Activo = @Activo
    WHERE IDArticulo = @IDArticulo;
END

go
---------------------------------------------------------------------------------------------------

CREATE PROCEDURE sp_ListarArticulos
AS
BEGIN
    SELECT 
        A.IDArticulo,
        A.Nombre AS NombreArticulo,
        A.Descripcion,
        A.PrecioCompra,
        A.PrecioVenta,
        A.Stock,
        C.Nombre AS Categoria,
        A.Activo
    FROM Articulos A
    INNER JOIN Categorias C ON A.IDCategoria = C.IDCategoria
    --WHERE A.Activo = 1;
END

go
---------------------------------------------------------------------------------------------------
CREATE PROCEDURE sp_EliminarArticulo
    @IDArticulo INT
AS
BEGIN

    UPDATE Articulos
    SET Activo = 0
    WHERE IDArticulo = @IDArticulo;
END
go
----------------------------------------------------------------------------------------------------

CREATE PROCEDURE sp_AltaCategoria
    @Nombre NVARCHAR(50),
    @Descripcion NVARCHAR(100)
AS
BEGIN
    INSERT INTO Categorias (Nombre, Descripcion)
    VALUES (@Nombre, @Descripcion);
END

-------------------------------------------------------------------------------------------------------------------
go

CREATE PROCEDURE sp_AltaCliente
    @DNI NVARCHAR(25),
    @CUIT NVARCHAR(25),
    @Apellido NVARCHAR(50),
    @Nombre NVARCHAR(50),
    @Telefono NVARCHAR(20),
    @Email NVARCHAR(50),
    @Direccion NVARCHAR(50)
AS
BEGIN
    INSERT INTO Clientes (
        DNI, CUIT, Apellido, Nombre, Telefono, Email, Direccion, Estado
    )
    VALUES (
        @DNI, @CUIT, @Apellido, @Nombre, @Telefono, @Email, @Direccion, 1
    );
END

-----------------------------------------------------------------------------------------------------------------------------
go

CREATE PROCEDURE sp_BuscarClientePorDNI
    @DNI NVARCHAR(25)
AS
BEGIN
    SELECT *
    FROM Clientes
    WHERE DNI = @DNI;
END
------------------------------------------------------------------------------------------------------------------------------------
go

CREATE PROCEDURE sp_AltaProveedor
    @RazonSocial NVARCHAR(50),
    @CUIT NVARCHAR(25),
    @Telefono NVARCHAR(20),
    @Email NVARCHAR(50),
    @Direccion NVARCHAR(50)
AS
BEGIN
    INSERT INTO Proveedores (
        RazonSocial, CUIT, Telefono, Email, Direccion, Estado
    )
    VALUES (
        @RazonSocial, @CUIT, @Telefono, @Email, @Direccion, 1
    );
END
-------------------------------------------------------------------------------------------------------------------------------------------
go

CREATE PROCEDURE sp_AltaEmpleado
    @DNI NVARCHAR(25),
    @Apellido NVARCHAR(50),
    @Nombre NVARCHAR(50),
    @IDCargo INT,
    @Sueldo MONEY
AS
BEGIN
    INSERT INTO Empleados (
        DNI, Apellido, Nombre, IDCargo, Estado, Sueldo
    )
    VALUES (
        @DNI, @Apellido, @Nombre, @IDCargo, 1, @Sueldo
    );
END
---------------------------------------------------------------------------------------------------------------------------------------------
