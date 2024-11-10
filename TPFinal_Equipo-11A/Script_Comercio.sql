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

-- ?Queremos generar un perfil de los usuarios para que se uno mismo pueda modificar algunos campos? y el administrador tiene mas alcance
-- En ese caso necesitariamos por ejemplo una imagen para el usuario, el mail, 
-- USUARIO DEBE SER UNIQUE
GO
CREATE TABLE Clientes(
	ID BIGINT NOT NULL IDENTITY(1,1),
	DNI INT NOT NULL,
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
	CUIT BIGINT NOT NULL,
	Siglas VARCHAR(5) NOT NULL UNIQUE,
	Nombre VARCHAR(30) NOT NULL,
	Direccion VARCHAR(100) NOT NULL,
	Correo VARCHAR(50) NOT NULL,
	Telefono VARCHAR(15) NOT NULL,
	Activo BIT NOT NULL default 1,
	PRIMARY KEY(ID),
);
GO

CREATE TABLE Imagenes(
	ID BIGINT NOT NULL IDENTITY(1,1),
	ImagenURL VARCHAR(1000),
	Activo BIT NOT NULL DEFAULT 1
	PRIMARY KEY(ID)
);
GO

CREATE TABLE Productos(
	ID BIGINT NOT NULL IDENTITY(1,10),
	Nombre VARCHAR(30) NOT NULL,
	Descripcion VARCHAR(150) NULL,
	IDMarca INT NOT NULL,
	IDCategoria INT NOT NULL,
	IDImagen BIGINT NOT NULL,
	Stock_Actual INT NOT NULL, 
	Stock_Minimo INT NOT NULL,
	Precio_Compra MONEY NOT NULL,
	Precio_Venta MONEY NOT NULL,
	Porcentaje_Ganancia decimal NOT NULL,
	Activo BIT NOT NULL default 1,
	PRIMARY KEY(ID),
	FOREIGN KEY (IDMarca) REFERENCES Marcas(ID),
	FOREIGN KEY (IDCategoria) REFERENCES Categorias(ID),
	FOREIGN KEY (IDImagen) REFERENCES Imagenes(ID)
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
INSERT INTO Marcas (NombreMarca, Activo) VALUES 
('Sony', 1),
('Samsung', 1),
('LG', 1),
('Apple', 1),
('Dell', 1);


-- Inserciones en la tabla Categorias
INSERT INTO Categorias (NombreCategoria, Activo) VALUES
('Electr?nica', 1),
('Accesorios', 1),
('Computaci?n', 1),
('Telefon?a', 1),
('Videojuegos', 1);
GO

-- Inserciones en la tabla Clientes
INSERT INTO Clientes (DNI, Nombre, Apellido, Direccion, Telefono, Correo, Fecha_reg, Activo) VALUES 
(12345678, 'Juan', 'Pérez', 'Calle Falsa 123', '1234567890', 'juan.perez@mail.com', '2024-10-01', 1),
(87654321, 'Ana', 'Gómez', 'Av. Siempre Viva 456', '0987654321', 'ana.gomez@mail.com', '2024-10-02', 1),
(23456789, 'Pedro', 'Martínez', 'Calle Luna 789', '1112223333', 'pedro.martinez@mail.com', '2024-10-03', 0),
(34567890, 'Lucía', 'Fernández', 'Av. Sol 987', '4445556666', 'lucia.fernandez@mail.com', '2024-10-04', 1),
(45678901, 'Carlos', 'Sánchez', 'Calle Estrella 321', '7778889990', 'carlos.sanchez@mail.com', '2024-10-05', 0);


-- Inserciones en la tabla Proveedores
INSERT INTO Proveedores (CUIT, Siglas, Nombre, Direccion, Correo, Telefono, Activo) VALUES 
(20345678901, 'ABC', 'Proveedor ABC', 'Calle Proveedor 123', 'abc@proveedor.com', '1122334455', 1),
(30567890123, 'XYZ', 'Proveedor XYZ', 'Av. Proveedor 456', 'xyz@proveedor.com', '2233445566', 1),
(20456789012, 'DEF', 'Proveedor DEF', 'Calle Proveedor 789', 'def@proveedor.com', '3344556677', 1),
(30678901234, 'GHI', 'Proveedor GHI', 'Av. Proveedor 321', 'ghi@proveedor.com', '4455667788', 0),
(20789012345, 'JKL', 'Proveedor JKL', 'Calle Proveedor 654', 'jkl@proveedor.com', '5566778899', 1);

INSERT INTO Imagenes (ImagenURL) VALUES
('https://i.pinimg.com/564x/12/53/84/1253845f3d560a17692bdbfb56335f04.jpg'),
('https://spacegamer.com.ar/img/Public/1058-producto-1019-producto-monitor-samsung-t35f-11-4868-4179.jpg'),
('https://i.blogs.es/47eaa9/1366_2000/500_333.webp'),
('https://mexx-img-2019.s3.amazonaws.com/38348_1.jpeg'),
('https://http2.mlstatic.com/D_NQ_NP_821666-MLA74019269225_012024-O.webp');

--Inserciones en la tabla Productos (solo 5 productos)
INSERT INTO Productos (Nombre, Descripcion, IDMarca, IDCategoria,IDImagen, Stock_Actual, Stock_Minimo, Precio_Compra, Precio_Venta, Porcentaje_Ganancia, Activo) VALUES
('Teclado Logitech', 'Teclado inal?mbrico', 4, 2, 1, 100, 20, 25.00, 40.00, 60.00, 1),
('Monitor Samsung', 'Monitor 24 pulgadas', 3, 3, 2, 30, 5, 150.00, 220.00, 46.67, 1),
('Smartphone Apple', 'iPhone 13 Pro', 2, 4, 3, 15, 5, 800.00, 1100.00, 37.50, 1),
('Mouse Logitech', 'Mouse inal?mbrico', 4, 2, 4, 150, 30, 15.00, 25.00, 66.67, 1),
('PlayStation 5', 'Consola de videojuegos Sony', 5, 5, 5, 10, 2, 450.00, 550.00, 22.22, 1),
('Auriculares Bose', 'Auriculares con cancelación de ruido', 1, 1, 1, 50, 10, 200.00, 300.00, 50.00, 1),
('Laptop Dell', 'Laptop 15 pulgadas', 3, 2, 2, 25, 5, 600.00, 900.00, 50.00, 1),
('Cámara Canon', 'Cámara réflex digital', 2, 3, 3, 20, 4, 400.00, 600.00, 50.00, 1),
('Impresora HP', 'Impresora multifuncional', 4, 4, 4, 15, 3, 100.00, 150.00, 50.00, 1),
('Altavoces JBL', 'Altavoces portátiles Bluetooth', 1, 5, 5, 75, 15, 50.00, 80.00, 60.00, 1);
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

CREATE OR ALTER VIEW VW_ListaProveedores AS
SELECT * FROM Proveedores WHERE Activo = 1
GO

CREATE VIEW VW_ListaClientes AS
SELECT * FROM Clientes
GO

CREATE VIEW VW_ListaUsuarios AS
SELECT U.ID, U.IDPermiso, P.NombrePermiso, U.NombreUsuario, U.Contrasenia, U.Activo 
FROM Usuarios AS U
INNER JOIN Permisos AS P ON P.ID = U.IDPermiso
GO

--CREATE VIEW VW_ListaProductos AS
--SELECT P.ID, P.Nombre, P.Descripcion, I.ImagenURL, P.Activo
--FROM Productos AS P
--INNER JOIN Imagenes as I ON I.ID = P.IDImagen
--GO

CREATE VIEW VW_ALLProducto AS
SELECT P.ID, P.Nombre, P.Descripcion, P.Stock_Actual, P.Stock_Minimo, P.Precio_Compra, P.Precio_Venta, P.Porcentaje_Ganancia, I.ImagenURL, M.NombreMarca, C.NombreCategoria,P.Activo, FROM Productos AS P
INNER JOIN Imagenes AS I ON I.ID = P.IDImagen
INNER JOIN Marcas AS M ON M.ID = P.IDMarca
INNER JOIN Categorias AS C ON C.ID = P.IDCategoria
INNER JOIN Productos_x_Proveedores AS PXP ON PXP.IDProducto = P.ID
INNER JOIN Proveedores AS PROV ON PROV.ID = PXP.IDProveedor
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
	@CUIT BIGINT,
    @Siglas VARCHAR(5),
	@Nombre VARCHAR(30),
	@Direccion VARCHAR(100),
	@Correo VARCHAR(50),
	@Telefono VARCHAR(15)
)
AS
BEGIN
    INSERT INTO Proveedores(CUIT,Siglas,Nombre,Direccion,Correo,Telefono) VALUES (@CUIT,@Siglas,@Nombre,@Direccion,@Correo,@Telefono)
END
GO

CREATE PROCEDURE SP_Alta_Cliente(
	@DNI INT,
	@Nombre VARCHAR(30),
	@Apellido VARCHAR(30),
	@Direccion VARCHAR(50),
	@Telefono VARCHAR(15),
	@Correo VARCHAR(50)
)
AS
BEGIN
    INSERT INTO Clientes(DNI,Nombre,Apellido,Direccion,Telefono,Correo) VALUES (@DNI,@Nombre,@Apellido,@Direccion,@Telefono,@Correo)
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

CREATE OR ALTER PROCEDURE SP_Nueva_Imagen(
    @imagenURL VARCHAR(1000),
    @UltimoID BIGINT OUTPUT
)
AS
BEGIN
    BEGIN TRY
        -- Insertar la URL de la imagen
        INSERT INTO Imagenes(ImagenURL) 
        VALUES (@imagenURL);

        -- Obtener el último ID insertado (ID de la imagen)
        SET @UltimoID = SCOPE_IDENTITY();

        -- Verificar que el ID no sea NULL
        IF @UltimoID IS NULL
        BEGIN
            THROW 50001, 'Error al obtener el ID de la imagen insertada', 1;
        END
    END TRY
    BEGIN CATCH
        -- En caso de error, devolver NULL en @UltimoID
        SET @UltimoID = NULL;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE SP_PRODUCT_X_PROV(
    @IDPRODUCTO BIGINT,
    @IDPROVEEDOR INT
)
AS
BEGIN
    BEGIN TRY
        IF @IDPROVEEDOR IS NULL OR @IDPRODUCTO IS NULL
        BEGIN
            THROW 50004, 'Los parámetros no pueden ser NULL', 1;
        END
			INSERT INTO Productos_x_Proveedores(IDProducto, IDProveedor) 
			VALUES (@IDPRODUCTO, @IDPROVEEDOR);
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE SP_PRODUCT_X_PROV2(
    @IDPRODUCTO BIGINT,
    @IDPROVEEDOR INT
)
AS
BEGIN
    BEGIN TRY
        -- Verifica si los parámetros son NULL
        IF @IDPROVEEDOR IS NULL OR @IDPRODUCTO IS NULL
        BEGIN
            THROW 50004, 'Los parámetros no pueden ser NULL', 1;
        END
        
        -- Verifica si el proveedor ya está asociado al producto
        IF NOT EXISTS (
            SELECT 1 
            FROM Productos_x_Proveedores 
			INNER JOIN PROVEEDORES AS P ON P.ID = @IDPROVEEDOR
            WHERE IDProducto = @IDPRODUCTO AND IDProveedor = @IDPROVEEDOR AND P.Activo = 1
			
        )
        BEGIN
            -- Inserta la asociación en la tabla Productos_x_Proveedores
            INSERT INTO Productos_x_Proveedores (IDProducto, IDProveedor) 
            VALUES (@IDPRODUCTO, @IDPROVEEDOR);
        END
        ELSE
        BEGIN
            -- Si ya existe la asociación, lanzar un error
            THROW 50005, 'El proveedor ya está asociado al producto.', 1;
        END
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        THROW;  -- Vuelve a lanzar el error capturado
    END CATCH
END
GO


CREATE OR ALTER PROCEDURE SP_ALTA_PRODUCTO(
    @NOMBRE VARCHAR(30),
    @DESCRIPCION VARCHAR(100),
    @IDMARCA INT,
    @IDCATEGORIA INT,
    @IMAGENURL VARCHAR(1000),
    @STOCKACTUAL INT,
    @STOCKMINIMO INT,
    @PRECIOCOMPRA MONEY,
    @PRECIOVENTA MONEY,
    @PORCENTAJEGANANCIA DECIMAL(18,0),
    @IDPROVEEDOR INT
)
AS
BEGIN
    BEGIN TRANSACTION;  -- Iniciar la transacción

    BEGIN TRY
		 -- Verificar si el proveedor existe
        IF NOT EXISTS (SELECT 1 FROM Proveedores WHERE ID = @IDPROVEEDOR AND Activo = 1)
        BEGIN
            THROW 50004, 'Proveedor no existe.', 1;
        END
        -- Llamar al procedimiento SP_Nueva_Imagen para insertar la imagen y obtener el último ID
        DECLARE @UltimoID BIGINT;
        EXEC SP_Nueva_Imagen @IMAGENURL, @UltimoID OUTPUT;

        -- Verificar que @UltimoID no sea NULL
        IF @UltimoID IS NULL
        BEGIN
            THROW 50002, 'No se pudo obtener un ID válido para la imagen', 1;
        END

        -- Insertar el producto en la tabla Productos
        INSERT INTO Productos (
            Nombre, 
            Descripcion, 
            IDMarca, 
            IDCategoria, 
            IDImagen,
            Stock_Actual, 
            Stock_Minimo, 
            Precio_Compra, 
            Precio_Venta, 
            Porcentaje_Ganancia
        )
        VALUES (
            @NOMBRE, 
            @DESCRIPCION, 
            @IDMARCA, 
            @IDCATEGORIA, 
            @UltimoID,
            @STOCKACTUAL, 
            @STOCKMINIMO, 
            @PRECIOCOMPRA, 
            @PRECIOVENTA, 
            @PORCENTAJEGANANCIA
        );

        -- Obtener el último ID insertado del producto
        DECLARE @PRODUCTOGENERADO BIGINT;
        SET @PRODUCTOGENERADO = SCOPE_IDENTITY();

		IF @PRODUCTOGENERADO IS NULL
        BEGIN
            THROW 50003, 'No se pudo obtener el ID del producto generado', 1;
        END

        EXEC SP_PRODUCT_X_PROV @PRODUCTOGENERADO, @IDPROVEEDOR;

        COMMIT TRANSACTION;  -- Confirmar la transacción

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE SP_Producto_con_proveedor(
	@IDPRODUCTO BIGINT
)
AS
BEGIN
	SELECT ID,Siglas FROM Proveedores WHERE ID IN (SELECT IDProveedor FROM Productos_x_Proveedores WHERE IDProducto = @IDPRODUCTO)
END
GO

SELECT ID,Siglas FROM Proveedores WHERE ID NOT IN (SELECT IDProveedor FROM Productos_x_Proveedores WHERE IDProducto = 221) AND Activo = 1
SELECT ID,Siglas FROM Proveedores WHERE ID IN (SELECT IDProveedor FROM Productos_x_Proveedores WHERE IDProducto = 221) AND Activo = 1

SELECT * FROM Proveedores
select * from Imagenes
select * from Productos
select * from Productos_x_Proveedores

GO
-- ACTIVAR

CREATE PROCEDURE SP_ActivarProducto(
	@ID BIGINT
)
AS
BEGIN 
UPDATE Productos SET Activo = 1 WHERE ID = @ID
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

CREATE PROCEDURE SP_BajaProducto(
	@ID BIGINT
)
AS
BEGIN 
UPDATE Productos SET Activo = 0 WHERE ID = @ID
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
	@CUIT BIGINT,
	@Siglas VARCHAR(5),
	@Nombre VARCHAR(30),
	@Direccion VARCHAR(100),
	@Correo VARCHAR(50),
	@Telefono VARCHAR(15),
	@Activo BIT
)
AS
BEGIN 
UPDATE Proveedores SET CUIT = @CUIT, Siglas = @Siglas, Nombre = @Nombre, Direccion = @Direccion, Correo = @Correo, Telefono = @Telefono, Activo = @Activo
WHERE ID = @ID
END
GO

-- CONSULTAR SI MANDAMOS ACTIVO EN LOS MODIFICAR

CREATE PROCEDURE SP_ModificarCliente(
	@ID BIGINT,
	@DNI INT,
	@Nombre VARCHAR(30),
	@Apellido VARCHAR(30),
	@Direccion VARCHAR(50),
	@Telefono VARCHAR(15),
	@Correo VARCHAR(50),
	@Activo BIT

)
AS
BEGIN 
UPDATE Clientes SET DNI = @DNI, Nombre = @Nombre, Apellido = @Apellido, Direccion = @Direccion, Telefono = @Telefono, Correo = @Correo, Activo = @Activo 
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

CREATE OR ALTER PROCEDURE SP_MODIFICAR_PRODUCTO(
	@ID BIGINT,
	@NOMBRE VARCHAR(30),
    @DESCRIPCION VARCHAR(100),
    @IDMARCA INT,
    @IDCATEGORIA INT,
    @STOCKACTUAL INT,
    @STOCKMINIMO INT,
    @PRECIOCOMPRA MONEY,
    @PRECIOVENTA MONEY,
    @PORCENTAJEGANANCIA DECIMAL(18,0)
)
AS
BEGIN
	UPDATE Productos SET Nombre = @NOMBRE, Descripcion = @DESCRIPCION, IDMarca = @IDMARCA, IDCategoria = @IDCATEGORIA, Stock_Actual = @STOCKACTUAL, Stock_Minimo = @STOCKMINIMO, Precio_Compra = @PRECIOCOMPRA, Precio_Venta = @PRECIOVENTA, Porcentaje_Ganancia = @PORCENTAJEGANANCIA WHERE ID = @ID
END




-------

-- DETALLE DE PRODUCTO
-- SIN PROVEEDOR
CREATE or alter PROCEDURE SP_DetalleProducto(
	@ID BIGINT
) 
AS
BEGIN
SELECT P.ID,I.ImagenURL, P.Nombre, P.Descripcion, M.ID as IdMarca, M.NombreMarca, C.ID as IdCategoria, C.NombreCategoria, P.Stock_Actual, P.Stock_Minimo, P.Precio_Compra, P.Precio_Venta, P.Porcentaje_Ganancia, P.Activo
FROM Productos AS P
INNER JOIN Marcas AS M ON M.ID = P.IDMarca
INNER JOIN Categorias AS C ON C.ID = P.IDCategoria
INNER JOIN Imagenes AS I ON I.ID = P.IDImagen
WHERE P.ID = @ID
END
GO