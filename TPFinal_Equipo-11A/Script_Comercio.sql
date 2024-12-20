﻿USE master
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

CREATE TABLE Imagenes(
	ID BIGINT NOT NULL IDENTITY(1,1),
	ImagenURL VARCHAR(1000),
	Activo BIT NOT NULL DEFAULT 1
	PRIMARY KEY(ID)
);
GO

CREATE TABLE Usuarios(
	ID INT NOT NULL IDENTITY(1,1),
	IDPermiso INT NOT NULL,
	NombreUsuario VARCHAR(30) NOT NULL,
	Contrasenia VARCHAR(30) NOT NULL,
	Nombre VARCHAR(30) NULL,
    Apellido VARCHAR(30) NULL,
    CorreoElectronico VARCHAR(50) NULL,
    Telefono VARCHAR(15) NULL,
	IDImagen BIGINT NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
	Activo BIT NOT NULL default 1,
	PRIMARY KEY(ID),
	FOREIGN KEY (IDPermiso) REFERENCES Permisos(ID),
	FOREIGN KEY (IDImagen) REFERENCES Imagenes(ID)
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

CREATE SEQUENCE NroFacturaSeq
    START WITH 1
    INCREMENT BY 1;
GO

CREATE TABLE Ventas(
    ID BIGINT NOT NULL IDENTITY(1,1),
    IDCliente BIGINT NOT NULL,
    Total MONEY NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    Nro_Factura BIGINT NOT NULL DEFAULT NEXT VALUE FOR NroFacturaSeq,
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

CREATE SEQUENCE NroReciboSeq
    START WITH 1
    INCREMENT BY 1;
GO

CREATE TABLE Compras(
    ID BIGINT NOT NULL IDENTITY(1,1),
    Nro_Recibo BIGINT NOT NULL DEFAULT NEXT VALUE FOR NroReciboSeq,
    IDProveedor INT NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
	FechaEntrega DATETIME NULL,
    Total MONEY NOT NULL,
	Estado bit default 0,
    PRIMARY KEY(ID),
    FOREIGN KEY (IDProveedor) REFERENCES Proveedores(ID)
);
GO

CREATE TABLE Productos_x_compra(
	ID BIGINT NOT NULL IDENTITY(1,1),
	IDCompra BIGINT NOT NULL,
	IDProducto BIGINT NOT NULL,
	Cantidad INT NOT NULL,
	CantidadVieja INT NOT NULL,
	Precio_UnitarioC MONEY NOT NULL,
	Subtotal MONEY NOT NULL,
	PRIMARY KEY(ID,IDCompra,IDProducto),
	FOREIGN KEY (IDProducto) REFERENCES Productos(ID),
	FOREIGN KEY (IDCompra) REFERENCES Compras(ID)
);
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
SELECT * FROM Proveedores WHERE Activo = 1
GO

CREATE VIEW VW_ListaClientes AS
SELECT * FROM Clientes
GO

CREATE VIEW VW_ListaUsuarios AS
SELECT U.ID,
    U.IDPermiso,
    P.NombrePermiso,
    U.NombreUsuario,
    U.Contrasenia,
    U.Activo,
    U.Nombre,
    U.Apellido,
    U.CorreoElectronico,
    U.Telefono,
    U.FechaCreacion,
    U.IDImagen,
    I.ImagenURL
FROM Usuarios AS U
INNER JOIN Permisos AS P ON P.ID = U.IDPermiso
LEFT JOIN Imagenes AS I ON I.ID = U.IDImagen;
GO

CREATE VIEW VW_ListaProductos AS
SELECT P.ID, P.Nombre, P.Descripcion, P.Activo
FROM Productos AS P
GO

CREATE VIEW VW_TraerUltimo
AS
SELECT TOP 1 ID FROM Compras ORDER BY FechaCreacion DESC
GO

CREATE VIEW VW_TraerUltimaVenta
AS
SELECT TOP 1 ID FROM Ventas ORDER BY FechaCreacion DESC
GO

-------- NO VA
--SELECT PXC.IDProducto, PXC.Precio_UnitarioC, PXC.Cantidad, PXC.Subtotal FROM Productos_x_compra AS PXC
--INNER JOIN Compras AS C ON C.ID = PXC.ID
--INNER JOIN Productos_x_Proveedores AS PXP ON PXP.IDProducto = PXC.IDProducto
--INNER JOIN Proveedores AS PROV ON PROV.ID = PXP.IDProveedor
--WHERE PXC.IDCompra = 2 AND PROV.ID = C.IDProveedor

--CREATE VIEW VW_ListaProductos AS
--SELECT P.ID, P.Nombre, P.Descripcion, I.ImagenURL, P.Activo
--FROM Productos AS P
--INNER JOIN Imagenes as I ON I.ID = P.IDImagen
--GO

CREATE OR ALTER VIEW VW_ALLProducto AS
SELECT P.ID, P.Nombre, P.Descripcion, P.Stock_Actual, P.Stock_Minimo, P.Precio_Compra, P.Precio_Venta, P.Porcentaje_Ganancia, I.ImagenURL, M.NombreMarca, C.NombreCategoria,P.Activo FROM Productos AS P
INNER JOIN Imagenes AS I ON I.ID = P.IDImagen
INNER JOIN Marcas AS M ON M.ID = P.IDMarca
INNER JOIN Categorias AS C ON C.ID = P.IDCategoria
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

CREATE PROCEDURE SP_Nueva_Imagen(
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

CREATE PROCEDURE SP_Alta_Usuario
(
    @IDPermiso INT,
    @NombreUsuario VARCHAR(30),
    @Contrasenia VARCHAR(30),
    @Nombre VARCHAR(30) = NULL,
    @Apellido VARCHAR(30) = NULL,
    @CorreoElectronico VARCHAR(50) = NULL,
    @Telefono VARCHAR(15) = NULL,
    @ImagenURL VARCHAR(1000) = NULL
)
AS
BEGIN
    DECLARE @IDImagen BIGINT;

    -- Insertar la imagen y obtener el ID
    EXEC SP_Nueva_Imagen @ImagenURL, @IDImagen OUTPUT;

    -- Insertar el usuario con el ID de la imagen
    INSERT INTO Usuarios (
        IDPermiso,
        NombreUsuario,
        Contrasenia,
        Nombre,
        Apellido,
        CorreoElectronico,
        Telefono,
        IDImagen
    ) 
    VALUES (
        @IDPermiso,
        @NombreUsuario,
        @Contrasenia,
        @Nombre,
        @Apellido,
        @CorreoElectronico,
        @Telefono,
        @IDImagen
    );
END;
GO

CREATE PROCEDURE SP_PRODUCT_X_PROV(
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

CREATE PROCEDURE SP_ALTA_PRODUCTO(
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

CREATE TYPE ProductoCompraType AS TABLE
(
    IDProducto INT,
    Cantidad INT,
    Precio_UnitarioC MONEY,
    Subtotal MONEY
);
GO


CREATE PROCEDURE RegistrarCompra
    @IDProveedor INT,
    @Productos ProductoCompraType READONLY, -- Tipo de tabla para los productos
    @Total MONEY
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Insertar la compra
        DECLARE @IDCompra BIGINT;
        INSERT INTO Compras (IDProveedor, FechaCreacion, Total)
        VALUES (@IDProveedor, GETDATE(), @Total);

        SET @IDCompra = SCOPE_IDENTITY();

        -- Insertar productos en Productos_x_Compra
		DECLARE @Subtotal MONEY
		SELECT @Subtotal = Cantidad * Precio_UnitarioC FROM @Productos 
        INSERT INTO Productos_x_Compra (IDCompra, IDProducto, Cantidad, Precio_UnitarioC, Subtotal)
        SELECT @IDCompra, IDProducto, Cantidad, Precio_UnitarioC, @Subtotal
        FROM @Productos;

        -- (Opcional) Actualizar el stock actual de los productos
        UPDATE p
        SET p.Stock_Actual = p.Stock_Actual + t.Cantidad
        FROM Productos p
        INNER JOIN @Productos t ON p.ID = t.IDProducto;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_Alta_Compra(
	@idproveedor int,
	@total money
)
AS
BEGIN
	INSERT INTO Compras(IDProveedor,FechaCreacion,FechaEntrega,Total) VALUES (@idproveedor,GETDATE(),DATEADD(DAY, 5, GETDATE()),@total)
END
GO

CREATE PROCEDURE SP_Alta_Venta(
	@idcliente bigint,
	@total money
)
AS
BEGIN
	INSERT INTO Ventas(IDCliente,Total,FechaCreacion) VALUES (@idcliente,@total,GETDATE())
END
GO

-- ACTIVAR

CREATE PROCEDURE SP_ActivarMarca(
	@ID INT
)
AS BEGIN
UPDATE Marcas SET Activo = 1 WHERE ID = @ID
END
GO

CREATE PROCEDURE SP_ActivarCategoria(
	@ID INT
)
AS BEGIN
UPDATE Categorias SET Activo = 1 WHERE ID = @ID
END
GO

CREATE PROCEDURE SP_ActivarProducto(
	@ID BIGINT
)
AS BEGIN 
UPDATE Productos SET Activo = 1 WHERE ID = @ID
END
GO

CREATE PROCEDURE SP_ActivarProveedor(
	@ID INT
)
AS BEGIN
UPDATE Proveedores SET Activo = 1 WHERE ID = @ID
END
GO

CREATE PROCEDURE SP_ActivarCliente(
	@ID BIGINT
)
AS BEGIN
UPDATE Clientes SET Activo = 1 WHERE ID = @ID
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

CREATE PROCEDURE SP_ModificarUsuario
(
    @ID INT,
    @IDPermiso INT,
    @NombreUsuario VARCHAR(30),
    @Contrasenia VARCHAR(30),
    @Nombre VARCHAR(30) = NULL,
    @Apellido VARCHAR(30) = NULL,
    @CorreoElectronico VARCHAR(50) = NULL,
    @Telefono VARCHAR(15) = NULL,
    @ImagenURL VARCHAR(1000) = NULL,
    @Activo BIT
)
AS
BEGIN
    DECLARE @IDImagen BIGINT;

    -- Insertar o actualizar la imagen
    EXEC SP_Nueva_Imagen @ImagenURL, @IDImagen OUTPUT;

    -- Actualizar el usuario con el ID de la nueva imagen
    UPDATE Usuarios SET 
        IDPermiso = @IDPermiso,
        NombreUsuario = @NombreUsuario,
        Contrasenia = @Contrasenia,
        Nombre = @Nombre,
        Apellido = @Apellido,
        CorreoElectronico = @CorreoElectronico,
        Telefono = @Telefono,
        IDImagen = @IDImagen,
        Activo = @Activo
    WHERE ID = @ID;
END;
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
GO
-------

-- DETALLE DE PRODUCTO
-- FALTAN PROVEEDORES Y IMAGENES

--CREATE PROCEDURE SP_DetalleProducto(
--	@ID BIGINT
--) 
--AS
--BEGIN
--SELECT P.ID, P.Nombre, P.Descripcion, M.NombreMarca, C.NombreCategoria, P.Stock_Actual, P.Stock_Minimo, P.Precio_Compra, P.Precio_Venta, P.Porcentaje_Ganancia, P.Activo
--FROM Productos AS P
--INNER JOIN Marcas AS M ON M.ID = P.IDMarca
--INNER JOIN Categorias AS C ON C.ID = P.IDCategoria
--WHERE P.ID = @ID
--END
--GO

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

-- VERIFICAR DUPLICIDAD AL CARGAR

--CREATE PROCEDURE SP_ExisteMarca(
--	@NombreMarca NVARCHAR(50)
--)
--AS
--BEGIN
--    SELECT COUNT(*) FROM Marcas WHERE NombreMarca = @NombreMarca
--END
--GO

CREATE PROCEDURE SP_ExisteMarca(
    @NombreMarca NVARCHAR(50)
)
AS
BEGIN
    SELECT COUNT(*)
    FROM Marcas
    WHERE NombreMarca COLLATE SQL_Latin1_General_CP1_CI_AI = @NombreMarca COLLATE SQL_Latin1_General_CP1_CI_AI
END
GO

--CREATE PROCEDURE SP_ExisteCategoria(
--	@NombreCategoria NVARCHAR(50)
--)
--AS
--BEGIN
--    SELECT COUNT(*) FROM Categorias WHERE NombreCategoria = @NombreCategoria
--END
--GO

CREATE PROCEDURE SP_ExisteCategoria(
    @NombreCategoria NVARCHAR(50)
)
AS
BEGIN
    SELECT COUNT(*)
    FROM Categorias
    WHERE NombreCategoria COLLATE SQL_Latin1_General_CP1_CI_AI = @NombreCategoria COLLATE SQL_Latin1_General_CP1_CI_AI
END
GO

CREATE PROCEDURE SP_ExisteDNICliente(
	@DNI INT
)
AS
BEGIN
    SELECT COUNT(*) FROM Clientes WHERE DNI = @DNI
END
GO

CREATE PROCEDURE SP_ExisteCUITProveedor(
	@CUIT BIGINT
)
AS
BEGIN
    SELECT COUNT(*) FROM Proveedores WHERE CUIT = @CUIT
END
GO

--VERIFICAR DUPLICIDAD AL MODIFICAR

--CREATE PROCEDURE SP_ExisteNombreMarcaModificado(
--	@NombreMarca VARCHAR(50),
--	@IDMarca INT
--)
--AS
--BEGIN
--    SELECT COUNT(*) 
--    FROM Marcas 
--    WHERE NombreMarca = @NombreMarca AND Id <> @IDMarca
--END
--GO

CREATE PROCEDURE SP_ExisteNombreMarcaModificado(
    @NombreMarca NVARCHAR(50),
    @IDMarca INT
)
AS
BEGIN
    SELECT COUNT(*) 
    FROM Marcas 
    WHERE NombreMarca COLLATE SQL_Latin1_General_CP1_CI_AI = @NombreMarca COLLATE SQL_Latin1_General_CP1_CI_AI 
    AND Id <> @IDMarca
END
GO

--CREATE PROCEDURE SP_ExisteNombreCategoriaModificado(
--	@NombreCategoria VARCHAR(50),
--	@IDCategoria INT
--)
--AS
--BEGIN
--    SELECT COUNT(*) 
--    FROM Categorias 
--    WHERE NombreCategoria = @NombreCategoria AND Id <> @IDCategoria
--END
--GO

CREATE PROCEDURE SP_ExisteNombreCategoriaModificado(
    @NombreCategoria NVARCHAR(50),
    @IDCategoria INT
)
AS
BEGIN
    SELECT COUNT(*) 
    FROM Categorias 
    WHERE NombreCategoria COLLATE SQL_Latin1_General_CP1_CI_AI = @NombreCategoria COLLATE SQL_Latin1_General_CP1_CI_AI 
    AND Id <> @IDCategoria
END
GO

CREATE PROCEDURE SP_ExisteDNIClienteModificado(
	@DNI INT,
	@IDCliente BIGINT
)
AS
BEGIN
    SELECT COUNT(*) 
    FROM Clientes 
    WHERE DNI = @DNI AND ID <> @IDCliente
END
GO

CREATE PROCEDURE SP_ExisteCUITProveedorModificado(
	@CUIT BIGINT,
	@IDProveedor INT
)
AS
BEGIN
    SELECT COUNT(*) 
    FROM Proveedores 
    WHERE CUIT = @CUIT AND ID <> @IDProveedor
END
GO

--VERIFICAR SI HAY ARTICULOS
CREATE PROCEDURE SP_TieneProductosActivosCategoria(
	@IdCategoria INT
)
AS
BEGIN
    SELECT COUNT(*)
    FROM Productos
    WHERE IDCategoria = @IdCategoria AND Activo = 1
END
GO

CREATE PROCEDURE SP_TieneProductosActivosMarca(
	@IdMarca INT
)
AS
BEGIN
    SELECT COUNT(*)
    FROM Productos
    WHERE IDMarca = @IdMarca AND Activo = 1
END
GO

--CONTADOR DE PRODUCTOS X MARCA Y CATEGORIA
--CREATE PROCEDURE SP_ObtenerMarcaConMasProductos
--AS
--BEGIN
--    SELECT TOP 1 M.Id, M.NombreMarca, COUNT(P.Id) AS CantidadProductos
--    FROM Marcas M
--    JOIN Productos P ON p.IdMarca = M.ID
--    WHERE P.Activo = 1
--    GROUP BY M.ID, M.NombreMarca
--    ORDER BY CantidadProductos DESC;
--END
--GO

CREATE PROCEDURE SP_ObtenerMarcasConMasProductos
AS
BEGIN
    -- Obtener las 5 marcas con la mayor cantidad de productos activos
    SELECT TOP 5
        M.Id,
        M.NombreMarca,
        COUNT(P.Id) AS CantidadProductos
    FROM Marcas M
    JOIN Productos P ON P.IdMarca = M.Id
    WHERE P.Activo = 1
    GROUP BY M.Id, M.NombreMarca
    ORDER BY CantidadProductos DESC;
END
GO

CREATE PROCEDURE SP_ObtenerCategoriasConMasProductos
AS
BEGIN
    
    SELECT TOP 5
        C.Id,
        C.NombreCategoria,
        COUNT(P.Id) AS CantidadProductos
    FROM Categorias C
    JOIN Productos P ON P.IdCategoria = C.Id
    WHERE P.Activo = 1
    GROUP BY C.Id, C.NombreCategoria
    ORDER BY COUNT(P.Id) DESC; 
END
GO


CREATE PROCEDURE SP_ObtenerProveedoresConMasProductos
AS
BEGIN
    -- Obtener la cantidad máxima de productos asociados a un proveedor
    WITH CTE_CantidadProductos AS (
        SELECT 
            P.ID AS IdProveedor,
            P.Nombre,
            COUNT(PxP.IDProducto) AS CantidadProductos
        FROM Proveedores P
        JOIN Productos_x_Proveedores PxP ON PxP.IDProveedor = P.ID
        JOIN Productos Prod ON Prod.ID = PxP.IDProducto
        WHERE P.Activo = 1 AND Prod.Activo = 1
        GROUP BY P.ID, P.Nombre
    )
    SELECT 
        IdProveedor,
        Nombre,
        CantidadProductos
    FROM CTE_CantidadProductos
    WHERE CantidadProductos = (SELECT MAX(CantidadProductos) FROM CTE_CantidadProductos);
END
GO


--PRODUCTO CON PRECIO MAS CARO
CREATE PROCEDURE SP_ProductoMasCaro
AS
BEGIN
    SET NOCOUNT ON;

    -- Obtener el precio máximo entre los productos activos
    DECLARE @PrecioMaximo MONEY;
    SELECT @PrecioMaximo = MAX(Precio_Venta)
    FROM Productos
    WHERE Activo = 1;

    -- Seleccionar todos los productos que tienen el precio máximo junto con su marca, categoría y proveedores
    SELECT 
        P.ID AS ProductoID,
        P.Nombre AS NombreProducto,
        P.Descripcion,
        P.Precio_Venta,
        M.NombreMarca,
        C.NombreCategoria,
        PR.ID AS ProveedorID,
        PR.Nombre AS NombreProveedor
    FROM Productos P
    LEFT JOIN Marcas M ON P.IDMarca = M.ID
    LEFT JOIN Categorias C ON P.IDCategoria = C.ID
    LEFT JOIN Productos_x_Proveedores PxP ON P.ID = PxP.IDProducto
    LEFT JOIN Proveedores PR ON PxP.IDProveedor = PR.ID
    WHERE P.Precio_Venta = @PrecioMaximo AND P.Activo = 1
    ORDER BY P.ID, PR.Nombre;
END
GO

--CREATE PROCEDURE SP_MarcasConProductoMasCostoso
--AS
--BEGIN
--    -- CTE para obtener el producto más costoso por marca
--    ;WITH CTE_ProductoMasCostoso AS (
--        SELECT 
--            P.ID AS ProductoID,
--            P.Nombre AS NombreProducto,
--            P.Precio_Venta,
--            P.IDMarca,
--            DENSE_RANK() OVER (PARTITION BY P.IDMarca ORDER BY P.Precio_Venta DESC) AS Rnk
--        FROM Productos P
--        WHERE P.Activo = 1
--    )
--    SELECT 
--        M.ID AS MarcaID,
--        M.NombreMarca,
--        P.ProductoID,
--        P.NombreProducto,
--        P.Precio_Venta,
--        (SELECT COUNT(*) 
--         FROM Productos P2 
--         WHERE P2.IDMarca = M.ID AND P2.Activo = 1) AS CantidadProductos
--    FROM Marcas M
--    JOIN CTE_ProductoMasCostoso P ON M.ID = P.IDMarca
--    WHERE P.Rnk = 1; -- Incluye todos los productos con el precio más alto por marca
--END
--GO

--CREATE PROCEDURE SP_CategoriasConProductoMasCostoso
--AS
--BEGIN
--    -- CTE para obtener el producto más costoso por categoría
--    ;WITH CTE_ProductoMasCostoso AS (
--        SELECT 
--            P.ID AS ProductoID,
--            P.Nombre AS NombreProducto,
--            P.Precio_Venta,
--            P.IDCategoria,
--            DENSE_RANK() OVER (PARTITION BY P.IDCategoria ORDER BY P.Precio_Venta DESC) AS Rnk
--        FROM Productos P
--        WHERE P.Activo = 1
--    )
--    SELECT 
--        C.ID AS CategoriaID,
--        C.NombreCategoria,
--        P.ProductoID,
--        P.NombreProducto,
--        P.Precio_Venta,
--        (SELECT COUNT(*) 
--         FROM Productos P2 
--         WHERE P2.IDCategoria = C.ID AND P2.Activo = 1) AS CantidadProductos
--    FROM Categorias C
--    JOIN CTE_ProductoMasCostoso P ON C.ID = P.IDCategoria
--    WHERE P.Rnk = 1; -- Incluye todos los productos con el precio más alto por categoría
--END
--GO

CREATE PROCEDURE SP_MarcasConProductoMasCostoso
AS
BEGIN
    -- CTE para obtener el producto más costoso por marca
    ;WITH CTE_ProductoMasCostoso AS (
        SELECT 
            P.ID AS ProductoID,
            P.Nombre AS NombreProducto,
            P.Precio_Venta,
            P.IDMarca,
            DENSE_RANK() OVER (PARTITION BY P.IDMarca ORDER BY P.Precio_Venta DESC) AS Rnk
        FROM Productos P
        WHERE P.Activo = 1
    ),
    -- CTE para obtener el producto más costoso por cada marca y rankearlo globalmente
    CTE_Top10 AS (
        SELECT 
            M.ID AS MarcaID,
            M.NombreMarca,
            P.ProductoID,
            P.NombreProducto,
            P.Precio_Venta,
            (SELECT COUNT(*) 
             FROM Productos P2 
             WHERE P2.IDMarca = M.ID AND P2.Activo = 1) AS CantidadProductos,
            ROW_NUMBER() OVER (ORDER BY P.Precio_Venta DESC) AS GlobalRank -- Rankeamos globalmente por precio
        FROM Marcas M
        JOIN CTE_ProductoMasCostoso P ON M.ID = P.IDMarca
        WHERE P.Rnk = 1 -- Incluye solo los productos más costosos por marca
    )
    -- Seleccionamos las 10 marcas con productos más costosos
    SELECT 
        MarcaID,
        NombreMarca,
        ProductoID,
        NombreProducto,
        Precio_Venta,
        CantidadProductos
    FROM CTE_Top10
    WHERE GlobalRank <= 10; -- Limitamos a las 10 marcas con productos más costosos
END
GO

CREATE PROCEDURE SP_CategoriasConProductoMasCostoso
AS
BEGIN
    -- CTE para obtener el producto más costoso por categoría
    ;WITH CTE_ProductoMasCostoso AS (
        SELECT 
            P.ID AS ProductoID,
            P.Nombre AS NombreProducto,
            P.Precio_Venta,
            P.IDCategoria,
            DENSE_RANK() OVER (PARTITION BY P.IDCategoria ORDER BY P.Precio_Venta DESC) AS Rnk
        FROM Productos P
        WHERE P.Activo = 1
    )
    -- Seleccionar las categorías con su producto más costoso y limitar a 10 categorías
    SELECT TOP 10
        C.ID AS CategoriaID,
        C.NombreCategoria,
        P.ProductoID,
        P.NombreProducto,
        P.Precio_Venta,
        (SELECT COUNT(*) 
         FROM Productos P2 
         WHERE P2.IDCategoria = C.ID AND P2.Activo = 1) AS CantidadProductos
    FROM Categorias C
    JOIN CTE_ProductoMasCostoso P ON C.ID = P.IDCategoria
    WHERE P.Rnk = 1 -- Solo productos más caros por categoría
    ORDER BY P.Precio_Venta DESC; -- Ordenar por el precio más costoso
END
GO

CREATE PROCEDURE SP_ProveedoresConProductoMasCostoso
AS
BEGIN
    -- CTE para obtener el producto más costoso por proveedor
    ;WITH CTE_ProductoMasCostoso AS (
        SELECT 
            P.ID AS ProductoID,
            P.Nombre AS NombreProducto,
            P.Precio_Venta,
            PxP.IDProveedor,
            DENSE_RANK() OVER (PARTITION BY PxP.IDProveedor ORDER BY P.Precio_Venta DESC) AS Rnk
        FROM Productos P
        JOIN Productos_x_Proveedores PxP ON PxP.IDProducto = P.ID
        WHERE P.Activo = 1
    )
    SELECT 
        Pr.ID AS ProveedorID,
        Pr.Nombre,
        P.ProductoID,
        P.NombreProducto,
        P.Precio_Venta,
        (SELECT COUNT(*)
         FROM Productos_x_Proveedores PxP2
         JOIN Productos P2 ON PxP2.IDProducto = P2.ID
         WHERE PxP2.IDProveedor = Pr.ID AND P2.Activo = 1) AS CantidadProductos
    FROM Proveedores Pr
    JOIN CTE_ProductoMasCostoso P ON Pr.ID = P.IDProveedor
    WHERE P.Rnk = 1; -- Incluye todos los productos con el precio más alto por proveedor
END
GO

--PRODUCTOS CON PRECIO MAS BAJO
CREATE PROCEDURE SP_ProductosConPrecioMasBajo
AS
BEGIN
    SELECT 
        P.ID AS ProductoID,
        P.Nombre AS NombreProducto,
        P.Precio_Venta,
        M.NombreMarca,
        C.NombreCategoria,
        P.Stock_Actual,
        PR.ID AS ProveedorID,
        PR.Nombre AS NombreProveedor
    FROM Productos P
    LEFT JOIN Marcas M ON P.IDMarca = M.ID
    LEFT JOIN Categorias C ON P.IDCategoria = C.ID
    LEFT JOIN Productos_x_Proveedores PxP ON P.ID = PxP.IDProducto
    LEFT JOIN Proveedores PR ON PxP.IDProveedor = PR.ID
    WHERE P.Activo = 1
      AND P.Stock_Actual > 0 -- Solo productos disponibles
      AND P.Precio_Venta = (
          SELECT MIN(Precio_Venta)
          FROM Productos
          WHERE Activo = 1 AND Stock_Actual > 0
      )
    ORDER BY P.Nombre, PR.Nombre;
END
GO

--MARCAS Y CATEGORIAS SIN PRODUCTOS ASOCIADOS
CREATE PROCEDURE SP_MarcasSinProductos
AS
BEGIN
    SELECT 
        M.Id,
        M.NombreMarca
    FROM Marcas M
    LEFT JOIN Productos P ON P.IDMarca = M.Id
    WHERE P.ID IS NULL;
END
GO

CREATE PROCEDURE SP_CategoriasSinProductos
AS
BEGIN
    SELECT 
        C.Id,
        C.NombreCategoria
    FROM Categorias C
    LEFT JOIN Productos P ON P.IdCategoria = C.Id
    WHERE P.Id IS NULL;
END
GO

CREATE PROCEDURE SP_ProveedoresSinProductos
AS
BEGIN
    SELECT 
        P.Id,
        P.Nombre
    FROM Proveedores P
    LEFT JOIN Productos_x_Proveedores PxP ON PxP.IDProveedor = P.Id
    WHERE PxP.IDProducto IS NULL;
END
GO

--MARCAS Y CATEGORIAS CON PRODUCTOS BAJOS DE STOCK
CREATE PROCEDURE SP_MarcasConProductosBajoStock
AS
BEGIN
    SELECT 
        M.ID AS MarcaID,
        M.NombreMarca,
        P.ID AS ProductoID,
        P.Nombre AS NombreProducto,
        P.Stock_Actual,
        P.Stock_Minimo
    FROM Marcas M
    JOIN Productos P ON M.ID = P.IDMarca
    WHERE P.Stock_Actual < P.Stock_Minimo
    ORDER BY M.NombreMarca, P.Nombre; -- Ordenado por marca y producto
END
GO

CREATE PROCEDURE SP_CategoriasConProductosBajoStock
AS
BEGIN
    SELECT 
        C.ID AS CategoriaID,
        C.NombreCategoria,
        P.ID AS ProductoID,
        P.Nombre AS NombreProducto,
        P.Stock_Actual,
        P.Stock_Minimo
    FROM Categorias C
    JOIN Productos P ON C.ID = P.IDCategoria
    WHERE P.Stock_Actual < P.Stock_Minimo
    ORDER BY C.NombreCategoria, P.Nombre; -- Ordenado por categoría y producto
END
GO

CREATE PROCEDURE SP_ProveedoresConProductosBajoStock
AS
BEGIN
    SELECT 
        P.ID AS ProveedorID,
        P.Nombre AS NombreProveedor,
        PR.ID AS ProductoID,
        PR.Nombre AS NombreProducto,
        PR.Stock_Actual,
        PR.Stock_Minimo
    FROM Proveedores P
    JOIN Productos_x_Proveedores PxP ON P.ID = PxP.IDProveedor
    JOIN Productos PR ON PxP.IDProducto = PR.ID
    WHERE PR.Stock_Actual < PR.Stock_Minimo
    ORDER BY P.Nombre, PR.Nombre; -- Ordenado por proveedor y producto
END
GO


--OBTENER EL PRIMER Y ULTIMO CLIENTE DADOS DE ALTA
CREATE PROCEDURE SP_PrimerClienteDadoDeAlta
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1 *
    FROM Clientes
    ORDER BY ID ASC;
END
GO

CREATE PROCEDURE SP_UltimoClienteDadoDeAlta
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1 *
    FROM Clientes
    ORDER BY ID DESC; -- Ordenar por ID en orden descendente para obtener el último
END
GO

--TOTAL ACTIVOS E INACTIVOS
CREATE PROCEDURE SP_ReporteMarcasEstadoYProductos
AS
BEGIN
    SET NOCOUNT ON;

    -- Subconsulta para el conteo de marcas activas e inactivas
    SELECT 
        'Cantidad de activos' AS Descripcion,
        COUNT(*) AS Total
    FROM Marcas
    WHERE Activo = 1

    UNION ALL

    SELECT 
        'Cantidad de inactivos' AS Descripcion,
        COUNT(*) AS Total
    FROM Marcas
    WHERE Activo = 0

    UNION ALL

    -- Subconsulta para marcas sin productos
    SELECT 
        'Marcas sin productos' AS Descripcion,
        COUNT(*) AS Total
    FROM Marcas M
    LEFT JOIN Productos P ON P.IDMarca = M.Id
    WHERE P.ID IS NULL;
END
GO

CREATE PROCEDURE SP_ConteoMarcasPorEstado
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        Activo,
        COUNT(*) AS Total
    FROM Marcas
    GROUP BY Activo;
END
GO

CREATE PROCEDURE SP_ConteoCategoriasPorEstado
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        Activo,
        COUNT(*) AS Total
    FROM Categorias
    GROUP BY Activo;
END
GO

CREATE PROCEDURE SP_ReporteCategorias
AS
BEGIN
    SET NOCOUNT ON;

    -- Subconsulta para el conteo de categorías activas e inactivas
    SELECT 
        'Categorias Activas' AS Descripcion,
        COUNT(*) AS Total
    FROM Categorias
    WHERE Activo = 1

    UNION ALL

    SELECT 
        'Categorias Inactivas' AS Descripcion,
        COUNT(*) AS Total
    FROM Categorias
    WHERE Activo = 0

    UNION ALL

    -- Subconsulta para categorías sin productos
    SELECT 
        'Categorias Sin Productos' AS Descripcion,
        COUNT(*) AS Total
    FROM Categorias C
    LEFT JOIN Productos P ON P.IdCategoria = C.Id
    WHERE P.Id IS NULL;
END
GO


CREATE PROCEDURE SP_ConteoProveedoresPorEstado
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        Activo,
        COUNT(*) AS Total
    FROM Proveedores
    GROUP BY Activo;
END
GO

CREATE PROCEDURE SP_ConteoClientesPorEstado
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        Activo,
        COUNT(*) AS Total
    FROM Clientes
    GROUP BY Activo;
END
GO

--PROMEDIO ANTIGUEDAD DE LOS CLIENTES
CREATE PROCEDURE SP_PromedioAntiguedadClientes
AS
BEGIN
    SET NOCOUNT ON;

    SELECT AVG(DATEDIFF(DAY, Fecha_reg, GETDATE())) AS PromedioDias
    FROM Clientes
    WHERE Activo = 1; -- Solo incluir clientes activos, si es requerido
END
GO

--PRODUCTO CON EL MAYOR NUMERO DE PROVEEDORES
CREATE PROCEDURE SP_ProductoConMasProveedoresYDetalles
AS
BEGIN
    SET NOCOUNT ON;

    -- CTE para contar proveedores por producto
    ;WITH CTE_ConteoProveedores AS (
        SELECT 
            PxP.IDProducto,
            COUNT(PxP.IDProveedor) AS CantidadProveedores
        FROM Productos_x_Proveedores PxP
        JOIN Productos P ON PxP.IDProducto = P.ID
        WHERE P.Activo = 1
        GROUP BY PxP.IDProducto
    ),
    -- CTE para obtener el máximo número de proveedores asociados
    CTE_ProductosConMaximo AS (
        SELECT 
            C.IDProducto,
            C.CantidadProveedores
        FROM CTE_ConteoProveedores C
        WHERE C.CantidadProveedores = (SELECT MAX(CantidadProveedores) FROM CTE_ConteoProveedores)
    )
    -- Obtener productos con el máximo número de proveedores y sus detalles
    SELECT 
        P.ID AS ProductoID,
        P.Nombre AS NombreProducto,
        P.Descripcion,
        C.CantidadProveedores,
        Pr.ID AS ProveedorID,
        Pr.Nombre AS NombreProveedor,
        Pr.CUIT,
        Pr.Telefono,
        Pr.Correo
    FROM CTE_ProductosConMaximo C
    JOIN Productos P ON P.ID = C.IDProducto
    JOIN Productos_x_Proveedores PxP ON P.ID = PxP.IDProducto
    JOIN Proveedores Pr ON PxP.IDProveedor = Pr.ID
    ORDER BY P.ID, Pr.Nombre; -- Ordenar por producto y proveedor
END
GO

--PRODUCTOS CON BAJO STOCK POR DEBAJO DEL STOCK MINIMO
CREATE PROCEDURE SP_ProductosConBajoStock
AS
BEGIN
    SELECT 
        P.ID AS ProductoID,
        P.Nombre AS NombreProducto,
        P.Stock_Actual,
        P.Stock_Minimo,
        P.Precio_Venta,
        P.Precio_Compra,
        M.NombreMarca,
        C.NombreCategoria,
        -- Agregar Proveedores asociados al producto
        STUFF((
            SELECT ', ' + PR.Nombre
            FROM Proveedores PR
            JOIN Productos_x_Proveedores PP ON PR.ID = PP.IDProveedor
            WHERE PP.IDProducto = P.ID
            FOR XML PATH('')
        ), 1, 2, '') AS Proveedores
    FROM Productos P
    JOIN Marcas M ON P.IDMarca = M.ID
    JOIN Categorias C ON P.IDCategoria = C.ID
    WHERE P.Stock_Actual < P.Stock_Minimo
    ORDER BY P.Nombre;  -- Opcional, puedes ordenar por nombre o cualquier otro criterio
END
GO

--PRODUCTOS SIN STOCK
CREATE PROCEDURE SP_ProductosSinStock
AS
BEGIN
    SELECT 
        P.ID AS ProductoID,
        P.Nombre AS NombreProducto,
        P.Stock_Actual,
        P.Precio_Compra,
        P.Precio_Venta,
        M.NombreMarca,
        C.NombreCategoria,
        -- Proveedores asociados al producto
        STUFF((
            SELECT ', ' + PR.Nombre
            FROM Proveedores PR
            JOIN Productos_x_Proveedores PP ON PR.ID = PP.IDProveedor
            WHERE PP.IDProducto = P.ID
            FOR XML PATH('')
        ), 1, 2, '') AS Proveedores
    FROM Productos P
    JOIN Marcas M ON P.IDMarca = M.ID
    JOIN Categorias C ON P.IDCategoria = C.ID
    WHERE P.Stock_Actual = 0
    ORDER BY P.Nombre;
END
GO

--PRODUCTOS MAS RENTABLES
CREATE PROCEDURE SP_ProductosMasRentables
AS
BEGIN
    -- CTE para calcular el margen de ganancia de cada producto
    ;WITH CTE_MargenGanancia AS (
        SELECT 
            P.ID AS ProductoID,
            P.Nombre AS NombreProducto,
            P.Precio_Compra,
            P.Precio_Venta,
            (P.Precio_Venta - P.Precio_Compra) AS MargenGanancia,
            P.IDMarca,
            P.IDCategoria
        FROM Productos P
        WHERE P.Activo = 1
    )
    SELECT 
        P.ProductoID,
        P.NombreProducto,
        P.Precio_Compra,
        P.Precio_Venta,
        P.MargenGanancia,
        M.NombreMarca,
        C.NombreCategoria
    FROM CTE_MargenGanancia P
    LEFT JOIN Marcas M ON P.IDMarca = M.ID
    LEFT JOIN Categorias C ON P.IDCategoria = C.ID
    WHERE P.MargenGanancia = (
        SELECT MAX(MargenGanancia) FROM CTE_MargenGanancia
    )
    ORDER BY P.NombreProducto;
END
GO

--PRODUCTOS CON PROVEEDOR EXCLUSIVO
CREATE PROCEDURE SP_ProductosConProveedoresExclusivos
AS
BEGIN
    -- CTE para identificar productos con un único proveedor
    WITH ProductosUnicoProveedor AS (
        SELECT 
            P.ID AS ProductoID,
            P.Nombre AS NombreProducto,
            P.Stock_Actual,
            P.Stock_Minimo,
            M.NombreMarca,
            C.NombreCategoria,
            COUNT(PP.IDProveedor) AS CantidadProveedores
        FROM Productos P
        JOIN Productos_x_Proveedores PP ON P.ID = PP.IDProducto
        LEFT JOIN Marcas M ON P.IDMarca = M.ID
        LEFT JOIN Categorias C ON P.IDCategoria = C.ID
        WHERE P.Activo = 1
        GROUP BY 
            P.ID, P.Nombre, P.Stock_Actual, P.Stock_Minimo, M.NombreMarca, C.NombreCategoria
        HAVING COUNT(PP.IDProveedor) = 1 -- Solo productos con un proveedor
    )
    SELECT 
        PUP.ProductoID,
        PUP.NombreProducto,
        PUP.Stock_Actual,
        PUP.Stock_Minimo,
        PUP.NombreMarca,
        PUP.NombreCategoria,
        PR.ID AS ProveedorID,
        PR.Nombre AS NombreProveedor
    FROM ProductosUnicoProveedor PUP
    JOIN Productos_x_Proveedores PP ON PUP.ProductoID = PP.IDProducto
    JOIN Proveedores PR ON PP.IDProveedor = PR.ID
    ORDER BY PUP.NombreProducto;
END
GO

--INSERTS

INSERT INTO Marcas (NombreMarca, Activo) VALUES
('Sony', 1),
('Samsung', 1),
('LG', 1),
('Apple', 1),
('Huawei', 1),
('Dell', 1),
('HP', 1),
('Lenovo', 1),
('Acer', 1),
('Asus', 1),
('Xiaomi', 1),
('Microsoft', 1),
('Nokia', 1),
('Panasonic', 1),
('Canon', 1);
GO

INSERT INTO Categorias (NombreCategoria, Activo) VALUES
('Electrónica', 1),
('Computadoras', 1),
('Smartphones', 1),
('Cámaras', 1),
('Audio', 1),
('Televisores', 1),
('Electrodomésticos', 1),
('Gaming', 1),
('Tablets', 1),
('Accesorios', 1),
('Relojes inteligentes', 1),
('Impresoras', 1),
('Proyectores', 1),
('Componentes', 1),
('Hogar Inteligente', 1);
GO

INSERT INTO Clientes (DNI, Nombre, Apellido, Direccion, Telefono, Correo, Activo) VALUES
(30123456, 'Juan', 'Pérez', 'Av. Siempre Viva 123', '1234567890', 'juan.perez@email.com', 1),
(31456789, 'Ana', 'Gómez', 'Calle Falsa 456', '0987654321', 'ana.gomez@email.com', 1),
(32987654, 'María', 'López', 'Av. del Libertador 789', '1122334455', 'maria.lopez@email.com', 1),
(34234567, 'Carlos', 'Martínez', 'Pje. las Flores 12', '2233445566', 'carlos.martinez@email.com', 1),
(35678901, 'Laura', 'García', 'Av. Corrientes 432', '3344556677', 'laura.garcia@email.com', 1),
(36123456, 'Jorge', 'Rodríguez', 'Calle Luna 50', '4455667788', 'jorge.rodriguez@email.com', 1),
(37567890, 'Rosa', 'Fernández', 'Av. de Mayo 345', '5566778899', 'rosa.fernandez@email.com', 1),
(38901234, 'Pablo', 'Giménez', 'Calle Olivos 28', '6677889900', 'pablo.gimenez@email.com', 1),
(39012345, 'Lucía', 'Ruiz', 'Av. Mitre 222', '7788990011', 'lucia.ruiz@email.com', 1),
(40456789, 'Pedro', 'Sánchez', 'Calle Aconcagua 456', '8899001122', 'pedro.sanchez@email.com', 1),
(41789012, 'Florencia', 'Luna', 'Av. Belgrano 789', '9900112233', 'florencia.luna@email.com', 1),
(43012345, 'Federico', 'Méndez', 'Calle San Martín 100', '1010101010', 'federico.mendez@email.com', 1),
(44567890, 'Elena', 'Paredes', 'Av. Alem 500', '2020202020', 'elena.paredes@email.com', 1),
(45901234, 'David', 'Díaz', 'Calle Roca 1122', '3030303030', 'david.diaz@email.com', 1),
(47345678, 'Marta', 'Ramos', 'Av. Sarmiento 333', '4040404040', 'marta.ramos@email.com', 1);
GO

INSERT INTO Proveedores (CUIT, Siglas, Nombre, Direccion, Correo, Telefono, Activo) VALUES
(30712345678, 'SONY', 'Sony Corp.', 'Av. Principal 123, Tokio, Japón', 'contacto@sony.com', '1123456789', 1),
(30798765432, 'SAMG', 'Samsung Ltd.', 'Samsung Town, Seúl, Corea del Sur', 'info@samsung.com', '2123456789', 1),
(30812345678, 'APPLE', 'Apple Inc.', '1 Infinite Loop, Cupertino, CA, EE.UU.', 'support@apple.com', '3123456789', 1),
(30898765432, 'LG', 'LG Electronics', 'LG Twin Towers, Seúl, Corea del Sur', 'contact@lg.com', '4123456789', 1),
(30912345678, 'HUAWE', 'Huawei Ltd.', 'Huawei Campus, Shenzhen, China', 'support@huawei.com', '5123456789', 1),
(30998765432, 'DELL', 'Dell Technologies', 'Round Rock, TX, EE.UU.', 'info@dell.com', '6123456789', 1),
(31012345678, 'HP', 'HP Inc.', '1501 Page Mill Road, Palo Alto, CA, EE.UU.', 'contact@hp.com', '7123456789', 1),
(31098765432, 'LENOV', 'Lenovo Group', 'No.6 Chuangye Road, Beijing, China', 'support@lenovo.com', '8123456789', 1),
(31112345678, 'ACER', 'Acer Inc.', 'Xizhi District, Taipéi, Taiwán', 'contact@acer.com', '9123456789', 1),
(31198765432, 'ASUS', 'AsusTek', 'Beitou, Taipéi, Taiwán', 'support@asus.com', '1023456789', 1),
(31212345678, 'XIAOM', 'Xiaomi Corp.', 'Haidian District, Pekín, China', 'info@xiaomi.com', '1123456789', 1),
(31298765432, 'MSFT', 'Microsoft', 'Redmond, WA, EE.UU.', 'contact@microsoft.com', '1223456789', 1),
(31312345678, 'NOKIA', 'Nokia Corp.', 'Espoo, Finlandia', 'support@nokia.com', '1323456789', 1),
(31398765432, 'PANA', 'Panasonic', 'Kadoma, Osaka, Japón', 'info@panasonic.com', '1423456789', 1),
(31412345678, 'CANON', 'Canon Inc.', 'Ota, Tokio, Japón', 'contact@canon.com', '1523456789', 1);
GO

INSERT INTO Permisos (NombrePermiso)
VALUES ('Admin');
GO

INSERT INTO Permisos (NombrePermiso)
VALUES ('Vendedor');
GO

INSERT INTO Usuarios (IDPermiso, NombreUsuario, Contrasenia, Activo)
VALUES (1, 'admin', 'admin', 1);
GO

INSERT INTO Usuarios (IDPermiso, NombreUsuario, Contrasenia, Activo)
VALUES (2, 'vendedor1', '123', 1);
GO

INSERT INTO Imagenes (ImagenURL) VALUES
('https://i.pinimg.com/564x/12/53/84/1253845f3d560a17692bdbfb56335f04.jpg'),
('https://spacegamer.com.ar/img/Public/1058-producto-1019-producto-monitor-samsung-t35f-11-4868-4179.jpg'),
('https://i.blogs.es/47eaa9/1366_2000/500_333.webp'),
('https://mexx-img-2019.s3.amazonaws.com/38348_1.jpeg'),
('https://http2.mlstatic.com/D_NQ_NP_821666-MLA74019269225_012024-O.webp');
GO

--Inserciones en la tabla Productos (solo 5 productos)
INSERT INTO Productos (Nombre, Descripcion, IDMarca, IDCategoria,IDImagen, Stock_Actual, Stock_Minimo, Precio_Compra, Precio_Venta, Porcentaje_Ganancia, Activo) VALUES
('Teclado Logitech', 'Teclado inalambrico', 4, 2, 1, 100, 20, 25.00, 40.00, 60.00, 1),
('Monitor Samsung', 'Monitor 24 pulgadas', 3, 3, 2, 30, 5, 150.00, 220.00, 46.67, 1),
('Smartphone Apple', 'iPhone 13 Pro', 2, 4, 3, 15, 5, 800.00, 1100.00, 37.50, 1),
('Mouse Logitech', 'Mouse inalambrico', 4, 2, 4, 150, 30, 15.00, 25.00, 66.67, 1),
('PlayStation 5', 'Consola de videojuegos Sony', 5, 5, 5, 10, 2, 450.00, 550.00, 22.22, 1);
GO

/* INSERTS */
/*VIEJOS INSERTS

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
(12345678, 'Juan', 'P rez', 'Calle Falsa 123', '1234567890', 'juan.perez@mail.com', '2024-10-01', 1),
(87654321, 'Ana', 'G mez', 'Av. Siempre Viva 456', '0987654321', 'ana.gomez@mail.com', '2024-10-02', 1),
(23456789, 'Pedro', 'Mart nez', 'Calle Luna 789', '1112223333', 'pedro.martinez@mail.com', '2024-10-03', 0),
(34567890, 'Luc a', 'Fern ndez', 'Av. Sol 987', '4445556666', 'lucia.fernandez@mail.com', '2024-10-04', 1),
(45678901, 'Carlos', 'S nchez', 'Calle Estrella 321', '7778889990', 'carlos.sanchez@mail.com', '2024-10-05', 0);


-- Inserciones en la tabla Proveedores
INSERT INTO Proveedores (CUIT, Siglas, Nombre, Direccion, Correo, Telefono, Activo) VALUES 
(20345678901, 'ABC', 'Proveedor ABC', 'Calle Proveedor 123', 'abc@proveedor.com', '1122334455', 1),
(30567890123, 'XYZ', 'Proveedor XYZ', 'Av. Proveedor 456', 'xyz@proveedor.com', '2233445566', 1),
(20456789012, 'DEF', 'Proveedor DEF', 'Calle Proveedor 789', 'def@proveedor.com', '3344556677', 1),
(30678901234, 'GHI', 'Proveedor GHI', 'Av. Proveedor 321', 'ghi@proveedor.com', '4455667788', 0),
(20789012345, 'JKL', 'Proveedor JKL', 'Calle Proveedor 654', 'jkl@proveedor.com', '5566778899', 1);


-- Inserciones en la tabla Productos (solo 5 productos)
INSERT INTO Productos (Nombre, Descripcion, IDMarca, IDCategoria, Stock_Actual, Stock_Minimo, Precio_Compra, Precio_Venta, Porcentaje_Ganancia, Activo) VALUES
('Teclado Logitech', 'Teclado inal?mbrico', 4, 2, 100, 20, 25.00, 40.00, 60.00, 1),
('Monitor Samsung', 'Monitor 24 pulgadas', 3, 3, 30, 5, 150.00, 220.00, 46.67, 1),
('Smartphone Apple', 'iPhone 13 Pro', 2, 4, 15, 5, 800.00, 1100.00, 37.50, 1),
('Mouse Logitech', 'Mouse inal?mbrico', 4, 2, 150, 30, 15.00, 25.00, 66.67, 1),
('PlayStation 5', 'Consola de videojuegos Sony', 5, 5, 10, 2, 450.00, 550.00, 22.22, 1);
GO
*/

CREATE PROCEDURE SP_AgregarProductoCompra(
	@idcompra bigint,
	@idproducto bigint,
	@cantidad int,
	@cantidadvieja int,
	@preciounitario money,
	@subtotal money
)
AS
BEGIN
	INSERT INTO Productos_x_compra(IDCompra,IDProducto,Cantidad,CantidadVieja,Precio_UnitarioC,Subtotal)
	VALUES (@idcompra,@idproducto,@cantidad,@cantidadvieja,@preciounitario,@subtotal)
END
GO

CREATE PROCEDURE SP_ActualizarMontoEnCompra(
	@idcompra bigint,
	@total money
)
as
begin
	UPDATE Compras SET Total = @total WHERE ID = @idcompra
end
go

CREATE OR ALTER PROCEDURE SP_ActualizarStock(
	@idproducto bigint,
	@stock int
)
as
begin
	UPDATE Productos SET Stock_Actual += @stock WHERE ID = @idproducto
end
go

CREATE PROCEDURE SP_ActualizarStockVenta(
	@idproducto bigint,
	@stock int
)
AS
BEGIN
	UPDATE Productos SET Stock_Actual -= @stock WHERE ID = @idproducto
END
GO

CREATE PROCEDURE SP_ConfirmarCompra(
	@idcompra BIGINT
)
AS 
BEGIN
	UPDATE Compras SET FechaEntrega = GETDATE(), Estado = 1 WHERE ID = @idcompra
END
GO

CREATE PROCEDURE SP_AgregarProductoVenta(
	@idventa bigint,
	@idproducto bigint,
	@cantidad int,
	@preciounitario money,
	@subtotal money
)
AS
BEGIN
	INSERT INTO Productos_x_venta(IDVenta,IDProducto,Cantidad,Precio_UnitarioV,Subtotal)
	VALUES (@idventa,@idproducto,@cantidad,@preciounitario,@subtotal)
END
GO

CREATE PROCEDURE SP_ActualizarMontoEnVenta(
	@idventa bigint,
	@total money
)
as
begin
	UPDATE Ventas SET Total = @total WHERE ID = @idventa
end
go

--CARGA EL HISOTRIAL DE VENTAS
CREATE PROCEDURE SP_CargarHistorialVentas
AS
BEGIN
    SELECT 
        c.DNI AS NumeroDocumento,
        c.Nombre AS NombreCliente,
        c.Apellido AS ApellidoCliente,
        p.Nombre AS NombreProducto,
        pxv.Cantidad,
        pxv.Subtotal,
        v.Nro_Factura AS NumeroFactura,
        v.FechaCreacion,
        ROW_NUMBER() OVER (PARTITION BY v.Nro_Factura ORDER BY pxv.ID) AS EsPrimeraFila,
        SUM(pxv.Subtotal) OVER (PARTITION BY v.Nro_Factura) AS TotalFactura
    FROM Clientes c
    JOIN Ventas v ON c.ID = v.IDCliente
    JOIN Productos_x_venta pxv ON v.ID = pxv.IDVenta
    JOIN Productos p ON pxv.IDProducto = p.ID
    WHERE pxv.Cantidad > 0
    ORDER BY v.FechaCreacion DESC, v.Nro_Factura, pxv.ID;
END;
GO