﻿using Acceso_Datos;
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

        public List<MarcaReportes> ObtenerMarcasConProductosBajoStock()
        {
            List<MarcaReportes> marcasConBajoStock = new List<MarcaReportes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_MarcasConProductosBajoStock");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    MarcaReportes marca = new MarcaReportes
                    {
                        Id = datos.Lector.GetInt32(0),
                        NombreMarca = datos.Lector.GetString(1),
                        ProductoID = datos.Lector.GetInt64(2),
                        NombreProducto = datos.Lector.GetString(3),
                        StockActual = datos.Lector.GetInt32(4),
                        StockMinimo = datos.Lector.GetInt32(5)
                    };
                    marcasConBajoStock.Add(marca);
                }

                return marcasConBajoStock;
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

        public MarcaReportes ObtenerReporteMarcasPorEstado()
        {
            AccesoDatos datos = new AccesoDatos();
            MarcaReportes reporte = new MarcaReportes();

            try
            {
                datos.setearProcedimiento("SP_ConteoMarcasPorEstado");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    bool activo = datos.Lector.GetBoolean(0); // Estado activo/inactivo
                    int total = datos.Lector.GetInt32(1);     // Total de marcas en ese estado

                    if (activo)
                        reporte.TotalActivos = total;
                    else
                        reporte.TotalInactivos = total;
                }

                return reporte;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al generar el reporte de marcas por estado", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public MarcaReportes ObtenerReporteCompletoDeMarcas()
        {
            AccesoDatos datos = new AccesoDatos();
            MarcaReportes reporte = new MarcaReportes();

            try
            {
                datos.setearProcedimiento("SP_ReporteMarcasEstadoYProductos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    string descripcion = datos.Lector.GetString(0); // Descripción del dato (activos, inactivos, sin productos)
                    int total = datos.Lector.GetInt32(1);          // Total correspondiente

                    if (descripcion == "Cantidad de activos")
                        reporte.TotalActivos = total;
                    else if (descripcion == "Cantidad de inactivos")
                        reporte.TotalInactivos = total;
                    else if (descripcion == "Marcas sin productos")
                        reporte.TotalSinProductos = total;
                }

                return reporte;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener el reporte completo de marcas", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

    }
}
