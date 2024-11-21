using Acceso_Datos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class HistorialVentasNegocio
    {
        //public List<HistorialVenta> CargarHistorialVentas()
        //{
        //    List<HistorialVenta> historial = new List<HistorialVenta>();
        //    AccesoDatos datos = new AccesoDatos();

        //    try
        //    {
        //        datos.setearProcedimiento("SP_CargarHistorialVentas");
        //        datos.ejecutarLectura();

        //        while (datos.Lector.Read())
        //        {
        //            HistorialVenta venta = new HistorialVenta
        //            {
        //                NumeroDocumento = (int)datos.Lector["NumeroDocumento"],
        //                NombreCliente = datos.Lector["NombreCliente"].ToString(),
        //                ApellidoCliente = datos.Lector["ApellidoCliente"].ToString(),
        //                NombreProducto = datos.Lector["NombreProducto"].ToString(),
        //                Cantidad = (int)datos.Lector["Cantidad"],
        //                Subtotal = (decimal)datos.Lector["Subtotal"],
        //                NumeroFactura = (long)datos.Lector["NumeroFactura"],
        //                FechaCreacion = (DateTime)datos.Lector["FechaCreacion"]
        //            };
        //            historial.Add(venta);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //    finally
        //    {
        //        datos.cerrarConexion();
        //    }

        //    return historial;
        //}

        //public List<HistorialVenta> CargarHistorialVentas()
        //{
        //    List<HistorialVenta> historial = new List<HistorialVenta>();
        //    AccesoDatos datos = new AccesoDatos();

        //    try
        //    {
        //        datos.setearProcedimiento("SP_CargarHistorialVentas");
        //        datos.ejecutarLectura();

        //        while (datos.Lector.Read())
        //        {
        //            HistorialVenta venta = new HistorialVenta
        //            {
        //                NumeroDocumento = datos.Lector["EsPrimeraFila"].ToString() == "1" ? (int)datos.Lector["NumeroDocumento"] : (int?)null,
        //                NombreCliente = datos.Lector["EsPrimeraFila"].ToString() == "1" ? datos.Lector["NombreCliente"].ToString() : null,
        //                ApellidoCliente = datos.Lector["EsPrimeraFila"].ToString() == "1" ? datos.Lector["ApellidoCliente"].ToString() : null,
        //                NombreProducto = datos.Lector["NombreProducto"].ToString(),
        //                Cantidad = (int)datos.Lector["Cantidad"],
        //                Subtotal = (decimal)datos.Lector["Subtotal"],
        //                NumeroFactura = datos.Lector["EsPrimeraFila"].ToString() == "1" ? (long)datos.Lector["NumeroFactura"] : (long?)null,
        //                FechaCreacion = datos.Lector["EsPrimeraFila"].ToString() == "1" ? (DateTime?)datos.Lector["FechaCreacion"] : null
        //            };
        //            historial.Add(venta);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //    finally
        //    {
        //        datos.cerrarConexion();
        //    }

        //    return historial;
        //}


        public List<HistorialVenta> CargarHistorialVentas()
        {
            List<HistorialVenta> historial = new List<HistorialVenta>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_CargarHistorialVentas");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    HistorialVenta venta = new HistorialVenta
                    {
                        NumeroDocumento = datos.Lector["EsPrimeraFila"].ToString() == "1" ? (int)datos.Lector["NumeroDocumento"] : (int?)null,
                        NombreCliente = datos.Lector["EsPrimeraFila"].ToString() == "1" ? datos.Lector["NombreCliente"].ToString() : null,
                        ApellidoCliente = datos.Lector["EsPrimeraFila"].ToString() == "1" ? datos.Lector["ApellidoCliente"].ToString() : null,
                        NombreProducto = datos.Lector["NombreProducto"].ToString(),
                        Cantidad = (int)datos.Lector["Cantidad"],
                        Subtotal = (decimal)datos.Lector["Subtotal"],
                        NumeroFactura = datos.Lector["EsPrimeraFila"].ToString() == "1" ? (long)datos.Lector["NumeroFactura"] : (long?)null,
                        FechaCreacion = datos.Lector["EsPrimeraFila"].ToString() == "1" ? (DateTime?)datos.Lector["FechaCreacion"] : null,
                        TotalFactura = datos.Lector["EsPrimeraFila"].ToString() == "1" ? (decimal?)datos.Lector["TotalFactura"] : null
                    };
                    historial.Add(venta);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }

            return historial;
        }



    }
}
