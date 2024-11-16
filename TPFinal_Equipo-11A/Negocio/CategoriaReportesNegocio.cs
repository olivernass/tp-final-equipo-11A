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


    }
}
