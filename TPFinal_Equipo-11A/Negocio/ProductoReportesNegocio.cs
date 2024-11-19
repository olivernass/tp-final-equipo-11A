using Acceso_Datos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ProductoReportesNegocio
    {
        public List<ProductoReportes> ObtenerProductosMasCaros()
        {
            AccesoDatos datos = new AccesoDatos();
            List<ProductoReportes> productosMasCaros = new List<ProductoReportes>();

            try
            {
                datos.setearProcedimiento("SP_ProductoMasCaro");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    long productoId = datos.Lector.GetInt64(0);

                    // Buscar si el producto ya existe en la lista
                    var productoExistente = productosMasCaros.FirstOrDefault(p => p.Id == productoId);

                    if (productoExistente == null)
                    {
                        // Crear un nuevo producto si no existe
                        ProductoReportes producto = new ProductoReportes
                        {
                            Id = productoId,
                            Nombre = datos.Lector.GetString(1),
                            Descripcion = datos.Lector.IsDBNull(2) ? null : datos.Lector.GetString(2),
                            Precio_Venta = datos.Lector.GetDecimal(3),
                            Marca = new Marca { NombreMarca = datos.Lector.GetString(4) },
                            Categoria = new Categoria { NombreCategoria = datos.Lector.GetString(5) },
                            Proveedores = new List<Proveedor>()
                        };

                        // Agregar proveedor asociado si existe
                        if (!datos.Lector.IsDBNull(6))
                        {
                            Proveedor proveedor = new Proveedor
                            {
                                Id = datos.Lector.GetInt32(6),
                                Nombre = datos.Lector.GetString(7)
                            };
                            producto.Proveedores.Add(proveedor);
                        }

                        productosMasCaros.Add(producto);
                    }
                    else
                    {
                        // Agregar proveedor al producto existente
                        if (!datos.Lector.IsDBNull(6))
                        {
                            Proveedor proveedor = new Proveedor
                            {
                                Id = datos.Lector.GetInt32(6),
                                Nombre = datos.Lector.GetString(7)
                            };
                            productoExistente.Proveedores.Add(proveedor);
                        }
                    }
                }

                return productosMasCaros;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los productos más caros", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }


        public List<ProductoReportes> ObtenerProductosConMasProveedoresYDetalles()
        {
            AccesoDatos datos = new AccesoDatos();
            List<ProductoReportes> productosConProveedores = new List<ProductoReportes>();

            try
            {
                datos.setearProcedimiento("SP_ProductoConMasProveedoresYDetalles");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    long productoId = datos.Lector.GetInt64(0);
                    ProductoReportes producto = productosConProveedores
                        .FirstOrDefault(p => p.Id == productoId);

                    if (producto == null)
                    {
                        producto = new ProductoReportes
                        {
                            Id = productoId,
                            Nombre = datos.Lector.GetString(1),
                            Descripcion = datos.Lector.IsDBNull(2) ? null : datos.Lector.GetString(2),
                            CantidadProveedores = datos.Lector.GetInt32(3),
                            ProveedoresAsociados = new List<ProveedorReportes>()
                        };

                        productosConProveedores.Add(producto);
                    }

                    ProveedorReportes proveedor = new ProveedorReportes
                    {
                        Id = datos.Lector.GetInt32(4),
                        Nombre = datos.Lector.GetString(5),
                        CUIT = datos.Lector.GetInt64(6),
                        Telefono = datos.Lector.GetString(7),
                        Correo = datos.Lector.GetString(8)
                    };

                    producto.ProveedoresAsociados.Add(proveedor);
                }

                return productosConProveedores;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los productos con más proveedores y sus detalles", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public List<ProductoReportes> ObtenerProductosConBajoStock()
        {
            List<ProductoReportes> productosBajoStock = new List<ProductoReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ProductosConBajoStock");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    ProductoReportes producto = new ProductoReportes
                    {
                        Id = datos.Lector.GetInt64(0),
                        Nombre = datos.Lector.GetString(1),
                        StockActual = datos.Lector.GetInt32(2),
                        StockMinimo = datos.Lector.GetInt32(3),
                        Precio_Venta = datos.Lector.GetDecimal(4),
                        Precio_Compra = datos.Lector.GetDecimal(5),
                        NombreMarca = datos.Lector.GetString(6),
                        NombreCategoria = datos.Lector.GetString(7),
                        Proveedores2 = datos.Lector.GetString(8) // Los proveedores se obtienen como un string separado por comas
                    };
                    productosBajoStock.Add(producto);
                }

                return productosBajoStock;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los productos con bajo stock", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public List<ProductoReportes> ObtenerProductosSinStock()
        {
            List<ProductoReportes> productosSinStock = new List<ProductoReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ProductosSinStock");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    ProductoReportes producto = new ProductoReportes
                    {
                        Id = datos.Lector.GetInt64(0),
                        Nombre = datos.Lector.GetString(1),
                        StockActual = datos.Lector.GetInt32(2),
                        Precio_Compra = datos.Lector.GetDecimal(3),
                        Precio_Venta = datos.Lector.GetDecimal(4),
                        Marca = new Marca { NombreMarca = datos.Lector.GetString(5) },
                        Categoria = new Categoria { NombreCategoria = datos.Lector.GetString(6) },
                        Proveedores = new List<Proveedor>() // Proveedores se almacenarán como lista
                    };

                    // Proveedores asociados como texto
                    string proveedoresTexto = datos.Lector.IsDBNull(7) ? string.Empty : datos.Lector.GetString(7);
                    if (!string.IsNullOrEmpty(proveedoresTexto))
                    {
                        foreach (var proveedorNombre in proveedoresTexto.Split(','))
                        {
                            producto.Proveedores.Add(new Proveedor { Nombre = proveedorNombre.Trim() });
                        }
                    }

                    productosSinStock.Add(producto);
                }

                return productosSinStock;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los productos sin stock", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public List<ProductoReportes> ObtenerProductosMasRentables()
        {
            List<ProductoReportes> productos = new List<ProductoReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ProductosMasRentables");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    ProductoReportes producto = new ProductoReportes
                    {
                        Id = datos.Lector.GetInt64(0),                // ID del producto
                        Nombre = datos.Lector.GetString(1),          // Nombre del producto
                        Precio_Compra = datos.Lector.GetDecimal(2),  // Precio de compra
                        Precio_Venta = datos.Lector.GetDecimal(3),   // Precio de venta
                        Porcentaje_Ganancia = datos.Lector.GetDecimal(4), // Margen de ganancia
                        Marca = new Marca
                        {
                            NombreMarca = datos.Lector.GetString(5)  // Nombre de la marca
                        },
                        Categoria = new Categoria
                        {
                            NombreCategoria = datos.Lector.GetString(6) // Nombre de la categoría
                        }
                    };
                    productos.Add(producto);
                }

                return productos;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los productos más rentables", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public List<ProductoReportes> ObtenerProductosConProveedoresExclusivos()
        {
            List<ProductoReportes> productos = new List<ProductoReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ProductosConProveedoresExclusivos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    ProductoReportes producto = new ProductoReportes
                    {
                        Id = datos.Lector.GetInt64(0),              // ID del producto
                        Nombre = datos.Lector.GetString(1),        // Nombre del producto
                        StockActual = datos.Lector.GetInt32(2),    // Stock actual
                        StockMinimo = datos.Lector.GetInt32(3),    // Stock mínimo
                        Marca = new Marca
                        {
                            NombreMarca = datos.Lector.GetString(4) // Nombre de la marca
                        },
                        Categoria = new Categoria
                        {
                            NombreCategoria = datos.Lector.GetString(5) // Nombre de la categoría
                        },
                        ProveedorExclusivo = new Proveedor
                        {
                            Id = datos.Lector.GetInt32(6),          // ID del proveedor
                            Nombre = datos.Lector.GetString(7)      // Nombre del proveedor
                        }
                    };
                    productos.Add(producto);
                }

                return productos;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los productos con proveedores exclusivos", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public List<ProductoReportes> ObtenerProductosConPrecioMasBajo()
        {
            List<ProductoReportes> productos = new List<ProductoReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ProductosConPrecioMasBajo");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    long productoId = datos.Lector.GetInt64(0);

                    // Buscar si ya existe el producto en la lista
                    var productoExistente = productos.FirstOrDefault(p => p.Id == productoId);

                    if (productoExistente == null)
                    {
                        // Crear un nuevo producto si no existe
                        ProductoReportes producto = new ProductoReportes
                        {
                            Id = productoId,
                            Nombre = datos.Lector.GetString(1),
                            Precio_Venta = datos.Lector.GetDecimal(2),
                            Marca = new Marca { NombreMarca = datos.Lector.GetString(3) },
                            Categoria = new Categoria { NombreCategoria = datos.Lector.GetString(4) },
                            StockActual = datos.Lector.GetInt32(5),
                            Proveedores = new List<Proveedor>()
                        };

                        // Agregar proveedor asociado
                        if (!datos.Lector.IsDBNull(6))
                        {
                            Proveedor proveedor = new Proveedor
                            {
                                Id = datos.Lector.GetInt32(6),
                                Nombre = datos.Lector.GetString(7)
                            };
                            producto.Proveedores.Add(proveedor);
                        }

                        productos.Add(producto);
                    }
                    else
                    {
                        // Agregar proveedor al producto existente
                        if (!datos.Lector.IsDBNull(6))
                        {
                            Proveedor proveedor = new Proveedor
                            {
                                Id = datos.Lector.GetInt32(6),
                                Nombre = datos.Lector.GetString(7)
                            };
                            productoExistente.Proveedores.Add(proveedor);
                        }
                    }
                }

                return productos;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener productos con precio más bajo", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

    }
}
