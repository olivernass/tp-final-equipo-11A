using Acceso_Datos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ClienteReportesNegocio
    {
        public ClienteReportes ObtenerPrimerCliente()
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("SP_PrimerClienteDadoDeAlta");
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    ClienteReportes cliente = new ClienteReportes
                    {
                        Id = datos.Lector.GetInt64(0), // Asumiendo que la primera columna es ID
                        DNI = datos.Lector.GetInt32(1),
                        Nombre = datos.Lector.GetString(2),
                        Apellido = datos.Lector.GetString(3),
                        Direccion = datos.Lector.GetString(4),
                        Telefono = datos.Lector.GetString(5),
                        Correo = datos.Lector.GetString(6),
                        Fecha_Alta = datos.Lector.GetDateTime(7),
                        Activo = datos.Lector.GetBoolean(8)
                    };
                    return cliente;
                }

                return null; // Si no hay clientes
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener el primer cliente dado de alta", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public ClienteReportes ObtenerUltimoCliente()
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("SP_UltimoClienteDadoDeAlta");
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    ClienteReportes cliente = new ClienteReportes
                    {
                        Id = datos.Lector.GetInt64(0),
                        DNI = datos.Lector.GetInt32(1),
                        Nombre = datos.Lector.GetString(2),
                        Apellido = datos.Lector.GetString(3),
                        Direccion = datos.Lector.GetString(4),
                        Telefono = datos.Lector.GetString(5),
                        Correo = datos.Lector.GetString(6),
                        Fecha_Alta = datos.Lector.GetDateTime(7),
                        Activo = datos.Lector.GetBoolean(8)
                    };
                    return cliente;
                }

                return null; // Si no hay clientes
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener el último cliente dado de alta", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public ClienteReportes ObtenerReporteClientesPorEstado()
        {
            AccesoDatos datos = new AccesoDatos();
            ClienteReportes reporte = new ClienteReportes();

            try
            {
                datos.setearProcedimiento("SP_ConteoClientesPorEstado");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    bool activo = datos.Lector.GetBoolean(0);
                    int total = datos.Lector.GetInt32(1);

                    if (activo)
                        reporte.TotalActivos = total;
                    else
                        reporte.TotalInactivos = total;
                }

                return reporte;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al generar el reporte de clientes por estado", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        //CUIDADO QUE PUEDE ARROJAR ERROR DEPENDIENDO DEL RESULTADO DEL SP, CASI SIEMPRE ARROJARA 1 DIA PERO SI DA MAS PUEDE SALTAR ERROR
        //SI SALE ERROR PROBAR CAMBIAR EN LA CLASE A DECIMAL O DOUBLE
        public ClienteReportes ObtenerPromedioAntiguedadClientes()
        {
            AccesoDatos datos = new AccesoDatos();
            ClienteReportes reporte = new ClienteReportes();

            try
            {
                datos.setearProcedimiento("SP_PromedioAntiguedadClientes");
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    if (!datos.Lector.IsDBNull(0)) // Verificar si el valor no es nulo
                    {
                        // Leer el promedio como decimal directamente
                        reporte.PromedioAntiguedadDias = datos.Lector.GetInt32(0);
                    }
                    else
                    {
                        reporte.PromedioAntiguedadDias = 0; // Valor por defecto si no hay datos
                    }
                }

                return reporte;
            }
            catch (Exception ex)
            {
                throw new Exception($"Error al obtener el promedio de antigüedad: {ex.Message}", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }


    }
}
