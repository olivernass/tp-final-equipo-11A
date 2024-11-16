using Acceso_Datos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class MarcaReportesNegocio
    {
        public List<MarcaReportes> ObtenerMarcasConMasProductos()
        {
            List<MarcaReportes> marcasRepo = new List<MarcaReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ObtenerMarcasConMasProductos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    MarcaReportes marcaRepo = new MarcaReportes
                    {
                        Id = datos.Lector.GetInt32(0),
                        NombreMarca = datos.Lector.GetString(1),
                        CantidadProductos = datos.Lector.GetInt32(2)
                    };
                    marcasRepo.Add(marcaRepo);
                }

                return marcasRepo;
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

        public List<MarcaReportes> ObtenerMarcasConProductoMasCostoso()
        {
            List<MarcaReportes> lista = new List<MarcaReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_MarcasConProductoMasCostoso");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    MarcaReportes item = new MarcaReportes
                    {
                        Id = datos.Lector.GetInt32(0),                 // ID de la marca
                        NombreMarca = datos.Lector.GetString(1),       // Nombre de la marca
                        ProductoID = datos.Lector.GetInt64(2),         // ID del producto más costoso
                        NombreProducto = datos.Lector.GetString(3),    // Nombre del producto más costoso
                        PrecioVenta = datos.Lector.GetDecimal(4),      // Precio del producto más costoso
                        CantidadProductos = datos.Lector.GetInt32(5)   // Cantidad de productos activos de la marca
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

        public List<MarcaReportes> ObtenerMarcasSinProductos()
        {
            List<MarcaReportes> marcas = new List<MarcaReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_MarcasSinProductos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    MarcaReportes marca = new MarcaReportes
                    {
                        Id = datos.Lector.GetInt32(0),             // ID de la marca
                        NombreMarca = datos.Lector.GetString(1)    // Nombre de la marca
                    };
                    marcas.Add(marca);
                }

                return marcas;
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
