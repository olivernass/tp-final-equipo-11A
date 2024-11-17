using Acceso_Datos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class CategoriaReportesNegocio
    {
        public List<CategoriaReportes> ObtenerCategoriasConMasProductos()
        {
            List<CategoriaReportes> categoriasRepo = new List<CategoriaReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ObtenerCategoriasConMasProductos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    CategoriaReportes categoriaRepo = new CategoriaReportes
                    {
                        Id = datos.Lector.GetInt32(0),
                        NombreCategoria = datos.Lector.GetString(1),
                        CantidadProductos = datos.Lector.GetInt32(2)
                    };

                    // Agregar a la lista
                    categoriasRepo.Add(categoriaRepo);
                }

                return categoriasRepo;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<CategoriaReportes> ObtenerCategoriasConProductoMasCostoso()
        {
            List<CategoriaReportes> lista = new List<CategoriaReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_CategoriasConProductoMasCostoso");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    CategoriaReportes item = new CategoriaReportes
                    {
                        Id = datos.Lector.GetInt32(0),                 // ID de la categoría
                        NombreCategoria = datos.Lector.GetString(1),   // Nombre de la categoría
                        ProductoID = datos.Lector.GetInt64(2),         // ID del producto más costoso
                        NombreProducto = datos.Lector.GetString(3),    // Nombre del producto más costoso
                        PrecioVenta = datos.Lector.GetDecimal(4),      // Precio del producto más costoso
                        CantidadProductos = datos.Lector.GetInt32(5)   // Cantidad de productos activos
                    };
                    lista.Add(item);
                }

                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<CategoriaReportes> ObtenerCategoriasSinProductos()
        {
            List<CategoriaReportes> categorias = new List<CategoriaReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_CategoriasSinProductos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    CategoriaReportes categoria = new CategoriaReportes
                    {
                        Id = datos.Lector.GetInt32(0),                // ID de la categoría
                        NombreCategoria = datos.Lector.GetString(1)   // Nombre de la categoría
                    };
                    categorias.Add(categoria);
                }

                return categorias;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<CategoriaReportes> ObtenerCategoriasConProductosBajoStock()
        {
            List<CategoriaReportes> categoriasConBajoStock = new List<CategoriaReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_CategoriasConProductosBajoStock");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    CategoriaReportes categoria = new CategoriaReportes
                    {
                        Id = datos.Lector.GetInt32(0),               // ID de la categoría
                        NombreCategoria = datos.Lector.GetString(1), // Nombre de la categoría
                        ProductoID = datos.Lector.GetInt64(2),       // ID del producto
                        NombreProducto = datos.Lector.GetString(3),  // Nombre del producto
                        StockActual = datos.Lector.GetInt32(4),      // Stock actual
                        StockMinimo = datos.Lector.GetInt32(5)       // Stock mínimo
                    };
                    categoriasConBajoStock.Add(categoria);
                }

                return categoriasConBajoStock;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public CategoriaReportes ObtenerReporteCategoriasPorEstado()
        {
            AccesoDatos datos = new AccesoDatos();
            CategoriaReportes reporte = new CategoriaReportes();

            try
            {
                datos.setearProcedimiento("SP_ConteoCategoriasPorEstado");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    bool activo = datos.Lector.GetBoolean(0); // Estado activo/inactivo
                    int total = datos.Lector.GetInt32(1);     // Total de categorías en ese estado

                    if (activo)
                        reporte.TotalActivos = total;
                    else
                        reporte.TotalInactivos = total;
                }

                return reporte;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al generar el reporte de categorías por estado", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

    }
}
