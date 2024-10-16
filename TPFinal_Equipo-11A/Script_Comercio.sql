USE master
GO
CREATE DATABASE comercio_final
GO
USE comercio_final
GO

CREATE TABLE Permisos (
	ID INT NOT NULL IDENTITY(1,1),
    NombrePermiso VARCHAR(20) NOT NULL,
    PRIMARY KEY(ID)
);
GO
CREATE TABLE Marcas (
	ID INT NOT NULL IDENTITY(1,1),
    NombreMarca VARCHAR(30) NOT NULL,
    Activo BIT NOT NULL default '1',
    PRIMARY KEY(ID)
);
GO
CREATE TABLE Categorias (
	ID INT NOT NULL IDENTITY(1,1),
    NombreCategoria VARCHAR(30) NOT NULL,
    Activo BIT NOT NULL default 1,
    PRIMARY KEY(ID)
);
GO
CREATE TABLE Usuarios(
	ID INT NOT NULL IDENTITY(1,1),
	IDPermiso INT NOT NULL,
	NombreUsuario VARCHAR(30) NOT NULL,
	Contrasenia VARCHAR(30) NOT NULL,
	Activo BIT NOT NULL default 1,
	PRIMARY KEY(ID),
	FOREIGN KEY (IDPermiso) REFERENCES Permisos(ID)
);
GO
CREATE TABLE Clientes(
	ID BIGINT NOT NULL IDENTITY(1,1),
	Nombre VARCHAR(30) NOT NULL,
	Apellido VARCHAR(30) NOT NULL,
	Direccion VARCHAR(50) NOT NULL,
	Telefono VARCHAR(15) NOT NULL,
	Correo VARCHAR(50) NOT NULL,
	Fecha_reg DATETIME DEFAULT GETDATE(),
	Activo BIT NOT NULL default 1,
	PRIMARY KEY(ID),
);
GO
CREATE TABLE Proveedores(
	ID INT NOT NULL IDENTITY(1,1),
	Siglas VARCHAR(5) NOT NULL UNIQUE,
	Nombre VARCHAR(30) NOT NULL,
	Direccion VARCHAR(100) NOT NULL,
	Correo VARCHAR(50) NOT NULL,
	Telefono VARCHAR(15) NOT NULL,
	Activo BIT NOT NULL default 1,
	PRIMARY KEY(ID),
);
GO
CREATE TABLE Productos(
	ID BIGINT NOT NULL IDENTITY(1,10),
	Nombre VARCHAR(30) NOT NULL,
	Descripcion VARCHAR(150) NULL,
	IDMarca INT NOT NULL,
	IDCategoria INT NOT NULL,
	Stock_Actual INT NOT NULL, 
	Stock_Minimo INT NOT NULL,
	Precio_Compra MONEY NOT NULL,
	Precio_Venta MONEY NOT NULL,
	Porcentaje_Ganancia FLOAT NOT NULL,
	Activo BIT NOT NULL default 1,
	PRIMARY KEY(ID),
	FOREIGN KEY (IDMarca) REFERENCES Marcas(ID),
	FOREIGN KEY (IDCategoria) REFERENCES Categorias(ID)
);
GO
CREATE TABLE Productos_x_Proveedores(
	IDProducto BIGINT NOT NULL,
	IDProveedor INT NOT NULL,
	PRIMARY KEY(IDProducto,IDProveedor),
	FOREIGN KEY (IDProducto) REFERENCES Productos(ID),
	FOREIGN KEY (IDProveedor) REFERENCES Proveedores(ID)
);
GO
CREATE TABLE Imagenes(
	ID BIGINT NOT NULL,
	ImagenURL VARCHAR(1000)
	PRIMARY KEY(ID)
);
GO
CREATE TABLE Imagenes_x_producto(
	IDImagen BIGINT NOT NULL,
	IDProducto BIGINT NOT NULL,
	PRIMARY KEY(IDImagen,IDProducto),
	FOREIGN KEY (IDImagen) REFERENCES Imagenes(ID),
	FOREIGN KEY (IDProducto) REFERENCES Productos(ID)
);
GO
CREATE TABLE Ventas(
	ID BIGINT NOT NULL IDENTITY(1,1),
	IDCliente BIGINT NOT NULL,
	Total MONEY NOT NULL,
	Fecha DATETIME DEFAULT GETDATE(),
	Nro_Factura BIGINT NOT NULL UNIQUE,
	PRIMARY KEY(ID),
	FOREIGN KEY (IDCliente) REFERENCES Clientes(ID)
);
GO
CREATE TABLE Productos_x_venta(
	ID BIGINT NOT NULL IDENTITY(1,1),
	IDVenta BIGINT NOT NULL,
	IDProducto BIGINT NOT NULL,
	Cantidad INT NOT NULL,
	Precio_UnitarioV MONEY NOT NULL,
	Subtotal MONEY NOT NULL,
	PRIMARY KEY(ID,IDVenta,IDProducto),
	FOREIGN KEY (IDProducto) REFERENCES Productos(ID),
	FOREIGN KEY (IDVenta) REFERENCES Ventas(ID)
);
GO
CREATE TABLE Compras(
	ID BIGINT NOT NULL IDENTITY(1,1),
	Nro_Recibo BIGINT NOT NULL UNIQUE,
	IDProveedor INT NOT NULL,
	Fecha DATETIME DEFAULT GETDATE(),
	Total MONEY NOT NULL,
	PRIMARY KEY(ID),
	FOREIGN KEY (IDProveedor) REFERENCES Proveedores(ID)
);
GO
CREATE TABLE Productos_x_compra(
	ID BIGINT NOT NULL IDENTITY(1,1),
	IDCompra BIGINT NOT NULL,
	IDProducto BIGINT NOT NULL,
	Cantidad INT NOT NULL,
	Precio_UnitarioC MONEY NOT NULL,
	Subtotal MONEY NOT NULL,
	PRIMARY KEY(ID,IDCompra,IDProducto),
	FOREIGN KEY (IDProducto) REFERENCES Productos(ID),
	FOREIGN KEY (IDCompra) REFERENCES Compras(ID)
);
GO

/* INSERTS */
INSERT INTO Marcas (NombreMarca) values ('Coca')
INSERT INTO Marcas (NombreMarca) values ('Apple')
INSERT INTO Marcas (NombreMarca) values ('Samsung')
GO


/* Vistas */

CREATE VIEW VW_ListaMarcas AS 
SELECT * FROM Marcas
GO

CREATE VIEW VW_ListaPermisos AS
SELECT * FROM Permisos
GO

CREATE VIEW VW_ListaCategorias AS
SELECT * FROM Categorias
GO

CREATE VIEW VW_ListaProveedores AS
SELECT * FROM Proveedores
GO

CREATE VIEW VW_ListaClientes AS
SELECT * FROM Clientes
GO

/* STORE PROCEDURE */

CREATE PROCEDURE SP_Alta_Marca(
    @NombreMarca VARCHAR(30)
)
AS
BEGIN
    INSERT INTO Marcas (NombreMarca) VALUES (@NombreMarca)
END
GO

CREATE PROCEDURE SP_Alta_Categoria(
    @NombreCategoria VARCHAR(30)
)
AS
BEGIN
    INSERT INTO Categorias(NombreCategoria) VALUES (@NombreCategoria)
END
GO

CREATE PROCEDURE SP_Alta_Permiso(
    @NombrePermiso VARCHAR(30)
)
AS
BEGIN
    INSERT INTO Permisos(NombrePermiso) VALUES (@NombrePermiso)
END
GO

CREATE PROCEDURE SP_Alta_Proveedor(
    @Siglas VARCHAR(5),
	@Nombre VARCHAR(30),
	@Direccion VARCHAR(100),
	@Correo VARCHAR(50),
	@Telefono VARCHAR(15)
)
AS
BEGIN
    INSERT INTO Proveedores(Siglas,Nombre,Direccion,Correo,Telefono) VALUES (@Siglas,@Nombre,@Direccion,@Correo,@Telefono)
END
GO

CREATE PROCEDURE SP_Alta_Cliente(
	@Nombre VARCHAR(30),
	@Apellido VARCHAR(30),
	@Direccion VARCHAR(50),
	@Telefono VARCHAR(15),
	@Correo VARCHAR(50)
)
AS
BEGIN
    INSERT INTO Clientes(Nombre,Apellido,Direccion,Telefono,Correo) VALUES (@Nombre,@Apellido,@Direccion,@Telefono,@Correo)
END
GO
