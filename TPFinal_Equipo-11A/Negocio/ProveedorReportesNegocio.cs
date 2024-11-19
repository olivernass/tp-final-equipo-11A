using Acceso_Datos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ProveedorReportesNegocio
    {
        public List<ProveedorReportes> ObtenerProveedoresConMasProductos()
        {
            List<ProveedorReportes> proveedoresRepo = new List<ProveedorReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ObtenerProveedoresConMasProductos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    ProveedorReportes proveedorRepo = new ProveedorReportes
                    {
                        Id = datos.Lector.GetInt32(0),
                        Nombre = datos.Lector.GetString(1),
                        CantidadProductos = datos.Lector.GetInt32(2)
                    };
                    proveedoresRepo.Add(proveedorRepo);
                }

                return proveedoresRepo;
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

        public List<ProveedorReportes> ObtenerProveedoresConProductoMasCostoso()
        {
            List<ProveedorReportes> lista = new List<ProveedorReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ProveedoresConProductoMasCostoso");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    ProveedorReportes item = new ProveedorReportes
                    {
                        Id = datos.Lector.GetInt32(0),                 // ID del proveedor
                        Nombre = datos.Lector.GetString(1),           // Nombre del proveedor
                        ProductoID = datos.Lector.GetInt64(2),        // ID del producto más costoso
                        NombreProducto = datos.Lector.GetString(3),   // Nombre del producto más costoso
                        PrecioVenta = datos.Lector.GetDecimal(4),     // Precio del producto más costoso
                        CantidadProductos = datos.Lector.GetInt32(5)  // Cantidad de productos activos del proveedor
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
        public List<ProveedorReportes> ObtenerProveedoresSinProductos()
        {
            List<ProveedorReportes> proveedores = new List<ProveedorReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ProveedoresSinProductos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    ProveedorReportes proveedor = new ProveedorReportes
                    {
                        Id = datos.Lector.GetInt32(0),             // ID del proveedor
                        Nombre = datos.Lector.GetString(1)         // Nombre del proveedor
                    };
                    proveedores.Add(proveedor);
                }

                return proveedores;
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
        public List<ProveedorReportes> ObtenerProveedoresConProductosBajoStock()
        {
            List<ProveedorReportes> proveedoresConBajoStock = new List<ProveedorReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ProveedoresConProductosBajoStock");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    ProveedorReportes proveedor = new ProveedorReportes
                    {
                        Id = datos.Lector.GetInt32(0),             // ID del proveedor
                        Nombre = datos.Lector.GetString(1),        // Nombre del proveedor
                        ProductoID = datos.Lector.GetInt64(2),     // ID del producto
                        NombreProducto = datos.Lector.GetString(3),// Nombre del producto
                        StockActual = datos.Lector.GetInt32(4),    // Stock actual
                        StockMinimo = datos.Lector.GetInt32(5)     // Stock mínimo
                    };
                    proveedoresConBajoStock.Add(proveedor);
                }

                return proveedoresConBajoStock;
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

        public ProveedorReportes ObtenerReporteProveedoresPorEstado()
        {
            AccesoDatos datos = new AccesoDatos();
            ProveedorReportes reporte = new ProveedorReportes();

            try
            {
                datos.setearProcedimiento("SP_ConteoProveedoresPorEstado");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    bool activo = datos.Lector.GetBoolean(0); // Estado activo/inactivo
                    int total = datos.Lector.GetInt32(1);     // Total de proveedores en ese estado

                    if (activo)
                        reporte.TotalActivos = total;
                    else
                        reporte.TotalInactivos = total;
                }

                return reporte;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al generar el reporte de proveedores por estado", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }


    }
}
