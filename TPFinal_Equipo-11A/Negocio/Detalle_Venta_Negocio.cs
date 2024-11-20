using Acceso_Datos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class Detalle_Venta_Negocio
    {
        public List<Detalle_Venta> listarProductos()
        {
            List<Detalle_Venta> lista = new List<Detalle_Venta>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT ID, Nombre, Precio_Venta, Stock_Actual FROM Productos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Detalle_Venta aux = new Detalle_Venta();
                    aux.Producto = new Producto();
                    aux.Producto.Id = (long)datos.Lector["ID"];
                    aux.Producto.Nombre = datos.Lector["Nombre"].ToString();
                    aux.Producto.Precio_Venta = (decimal)datos.Lector["Precio_Venta"];
                    aux.Producto.StockActual = (int)datos.Lector["Stock_Actual"];

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
