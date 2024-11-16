using Acceso_Datos;
using Dominio;
using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class CompraNegocio
    {
        public void agregarCompra(Compra compra)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_Alta_Compra");
                datos.setearParametro("@idproveedor", compra.Proveedor.Id);
                datos.setearParametro("@total", compra.PrecioTotal);
                datos.ejecutarAccion();
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
        public long TraerUltimo()
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT * FROM VW_TraerUltimo");
                datos.ejecutarAccion();

                long idcompra = datos.Lector.GetInt64(0);

                return idcompra;
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

        public List<Compra> listarCompras(int idproveedor)
        {
            List<Compra> lista = new List<Compra>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT * FROM Compras WHERE IDProveedor = " + idproveedor);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Compra aux = new Compra();
                    aux.Proveedor = new Proveedor();
                    aux.Id = (long)datos.Lector["ID"];
                    aux.Recibo = (long)datos.Lector["Nro_Recibo"];
                    aux.Proveedor.Id = (int)datos.Lector["IDProveedor"];
                    aux.FechaCompra = (DateTime)datos.Lector["Fecha"];
                    aux.PrecioTotal = (decimal)datos.Lector["Total"];

                    lista.Add(aux);
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
