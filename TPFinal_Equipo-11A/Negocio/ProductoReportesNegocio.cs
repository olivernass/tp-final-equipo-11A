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
                    ProductoReportes producto = new ProductoReportes
                    {
                        Id = datos.Lector.GetInt64(0),             // ID del producto
                        Nombre = datos.Lector.GetString(1),        // Nombre del producto
                        Descripcion = datos.Lector.IsDBNull(2) ? null : datos.Lector.GetString(2), // Descripción
                        Precio_Venta = datos.Lector.GetDecimal(3)   // Precio de venta
                    };

                    productosMasCaros.Add(producto);
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
    }
}
