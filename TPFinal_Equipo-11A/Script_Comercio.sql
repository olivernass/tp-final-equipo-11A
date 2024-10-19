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
    Activo BIT NOT NULL default 1,
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

-- ¿Queremos generar un perfil de los usuarios para que se uno mismo pueda modificar algunos campos? y el administrador tiene mas alcance
-- En ese caso necesitariamos por ejemplo una imagen para el usuario, el mail, 
-- USUARIO DEBE SER UNIQUE
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

-- FALTARIA EL DNI EN CLIENTES?
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
-- Nro_Factura deberia de tener un identity(1,1)

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
-- Nro_Recibo deberia de tener un identity(1,1)

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

-- Inserciones en la tabla Marcas
INSERT INTO Marcas (NombreMarca) VALUES
('Coca'), 
('Apple'), 
('Samsung'),
('Logitech'), 
('Sony');
GO

-- Inserciones en la tabla Categorias
INSERT INTO Categorias (NombreCategoria, Activo) VALUES
('Electrónica', 1),
('Accesorios', 1),
('Computación', 1),
('Telefonía', 1),
('Videojuegos', 1);
GO

-- Inserciones en la tabla Clientes
INSERT INTO Clientes (Nombre, Apellido, Direccion, Telefono, Correo, Activo, Fecha_reg) VALUES
('Juan', 'Pérez', 'Calle Falsa 123', '555-1234', 'juan.perez@example.com', 1, '2023-01-01'),
('Ana', 'García', 'Av. Principal 456', '555-5678', 'ana.garcia@example.com', 1, '2023-02-01'),
('Carlos', 'López', 'Av. Siempre Viva 789', '555-9876', 'carlos.lopez@example.com', 1, '2023-03-01'),
('Lucía', 'Martínez', 'Calle Secundaria 101', '555-1011', 'lucia.martinez@example.com', 1, '2023-04-01'),
('María', 'Rodríguez', 'Calle del Sol 202', '555-2022', 'maria.rodriguez@example.com', 1, '2023-05-01');
GO

-- Inserciones en la tabla Proveedores
INSERT INTO Proveedores (Siglas, Nombre, Direccion, Correo, Telefono, Activo) VALUES
('ABC', 'ABC Distribuidora', 'Calle Central 123', 'contacto@abcdistribuidora.com', '555-1234', 1),
('XYZ', 'XYZ Proveedores', 'Av. Comercio 456', 'ventas@xyzproveedores.com', '555-5678', 1),
('GHI', 'GHI Importaciones', 'Av. Importadora 789', 'info@ghiimportaciones.com', '555-9876', 1),
('DEF', 'DEF Suministros', 'Calle Comercio 101', 'contacto@defsuministros.com', '555-1011', 1),
('JKL', 'JKL Global', 'Av. Internacional 202', 'info@jklglobal.com', '555-2022', 1);
GO

-- Inserciones en la tabla Productos (solo 5 productos)
INSERT INTO Productos (Nombre, Descripcion, IDMarca, IDCategoria, Stock_Actual, Stock_Minimo, Precio_Compra, Precio_Venta, Porcentaje_Ganancia, Activo) VALUES
('Teclado Logitech', 'Teclado inalámbrico', 4, 2, 100, 20, 25.00, 40.00, 60.00, 1),
('Monitor Samsung', 'Monitor 24 pulgadas', 3, 3, 30, 5, 150.00, 220.00, 46.67, 1),
('Smartphone Apple', 'iPhone 13 Pro', 2, 4, 15, 5, 800.00, 1100.00, 37.50, 1),
('Mouse Logitech', 'Mouse inalámbrico', 4, 2, 150, 30, 15.00, 25.00, 66.67, 1),
('PlayStation 5', 'Consola de videojuegos Sony', 5, 5, 10, 2, 450.00, 550.00, 22.22, 1);
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

CREATE VIEW VW_ListaUsuarios AS
SELECT U.ID, U.IDPermiso, P.NombrePermiso, U.NombreUsuario, U.Contrasenia, U.Activo 
FROM Usuarios AS U
INNER JOIN Permisos AS P ON P.ID = U.IDPermiso
GO

/* STORE PROCEDURE */

-- ALTAS -- 

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

CREATE PROCEDURE SP_Alta_Usuario(
	@IDPermiso INT,
	@NombreUsuario VARCHAR(30),
	@Contrasenia VARCHAR(30)
)
AS
BEGIN
    INSERT INTO Usuarios(IDPermiso,NombreUsuario,Contrasenia) VALUES (@IDPermiso,@NombreUsuario,@Contrasenia)
END
GO

-- BAJA LOGICA -- 

CREATE PROCEDURE SP_BajaMarca(
	@ID INT
)
AS
BEGIN 
UPDATE Marcas SET Activo = 0 WHERE ID = @ID
END
GO

CREATE PROCEDURE SP_BajaCategoria(
	@ID INT
)
AS
BEGIN 
UPDATE Categorias SET Activo = 0 WHERE ID = @ID
END
GO

CREATE PROCEDURE SP_BajaProveedor(
	@ID INT
)
AS
BEGIN 
UPDATE Proveedores SET Activo = 0 WHERE ID = @ID
END
GO

CREATE PROCEDURE SP_BajaCliente(
	@ID BIGINT
)
AS
BEGIN 
UPDATE Clientes SET Activo = 0 WHERE ID = @ID
END
GO

CREATE PROCEDURE SP_BajaUsuario(
	@ID INT
)
AS
BEGIN 
UPDATE Usuarios SET Activo = 0 WHERE ID = @ID
END
GO


-- MODIFICAR -- 

CREATE PROCEDURE SP_ModificarMarca(
	@ID INT,
	@NombreMarca VARCHAR(30)
)
AS
BEGIN 
UPDATE Marcas SET NombreMarca = @NombreMarca WHERE ID = @ID
END
GO

CREATE PROCEDURE SP_ModificarCategoria(
	@ID INT,
	@NombreCategoria VARCHAR(30)
)
AS
BEGIN 
UPDATE Categorias SET NombreCategoria = @NombreCategoria WHERE ID = @ID
END
GO

CREATE PROCEDURE SP_ModificarPermiso(
	@ID INT,
	@NombrePermiso VARCHAR(30)
)
AS
BEGIN 
UPDATE Permisos SET NombrePermiso = @NombrePermiso WHERE ID = @ID
END
GO

-- CONSULTAR SI MANDAMOS ACTIVO EN LOS MODIFICAR

CREATE PROCEDURE SP_ModificarProveedor(
	@ID INT,
	@Siglas VARCHAR(5),
	@Nombre VARCHAR(30),
	@Direccion VARCHAR(100),
	@Correo VARCHAR(50),
	@Telefono VARCHAR(15),
	@Activo BIT
)
AS
BEGIN 
UPDATE Proveedores SET Siglas = @Siglas, Nombre = @Nombre, Direccion = @Direccion, Correo = @Correo, Telefono = @Telefono, Activo = @Activo
WHERE ID = @ID
END
GO

-- CONSULTAR SI MANDAMOS ACTIVO EN LOS MODIFICAR

CREATE PROCEDURE SP_ModificarCliente(
	@ID BIGINT,
	@Nombre VARCHAR(30),
	@Apellido VARCHAR(30),
	@Direccion VARCHAR(50),
	@Telefono VARCHAR(15),
	@Correo VARCHAR(50),
	@Activo BIT

)
AS
BEGIN 
UPDATE Clientes SET Nombre = @Nombre, Apellido = @Apellido, Direccion = @Direccion, Telefono = @Telefono, Correo = @Correo, Activo = @Activo 
WHERE ID = @ID
END
GO

-- CONSULTAR SI MANDAMOS ACTIVO EN LOS MODIFICAR

CREATE PROCEDURE SP_ModificarUsuario(
	@ID INT,
	@IDPermiso INT,
	@NombreUsuario VARCHAR(30),
	@Contrasenia VARCHAR(30),
	@Activo BIT

)
AS
BEGIN 
UPDATE Usuarios SET IDPermiso = @IDPermiso, NombreUsuario = @NombreUsuario, Contrasenia = @Contrasenia, Activo = @Activo 
WHERE ID = @ID
END
GO

SELECT * FROM Proveedores


