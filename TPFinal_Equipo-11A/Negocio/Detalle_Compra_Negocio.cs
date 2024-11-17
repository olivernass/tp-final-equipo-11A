using Acceso_Datos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class Detalle_Compra_Negocio
    {
        public List<Detalle_Compra> listar(long idcompra)
        {
            List<Detalle_Compra> lista = new List<Detalle_Compra>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT * FROM Productos_x_compra WHERE IDCompra = " + idcompra);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Detalle_Compra aux = new Detalle_Compra();
                    aux.Compra = new Compra();
                    aux.Producto = new Producto();
                    aux.Id = (long)datos.Lector["ID"];
                    aux.Compra.Id = (long)datos.Lector["IDCompra"];
                    aux.Producto.Id = (long)datos.Lector["IDProducto"];
                    aux.Cantidad = (int)datos.Lector["Cantidad"];
                    aux.Precio_Compra_Unitario = (decimal)datos.Lector["Precio_UnitarioC"];
                    aux.Subtotal = (decimal)datos.Lector["Subtotal"];

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

        public List<Detalle_Compra> listarProductos(int idproveedor)
        {
            List<Detalle_Compra> lista = new List<Detalle_Compra>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT P.ID, P.Nombre, P.Precio_Compra, P.Stock_Actual, P.Stock_Minimo FROM Productos AS P INNER JOIN Productos_x_Proveedores AS PXP ON PXP.IDProducto = P.ID INNER JOIN Proveedores AS PROV ON PROV.ID = PXP.IDProveedor WHERE PROV.ID =" + idproveedor);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Detalle_Compra aux = new Detalle_Compra();
                    aux.Compra = new Compra();
                    aux.Producto = new Producto();
                    aux.Producto.Id = (long)datos.Lector["ID"];
                    aux.Producto.Nombre = datos.Lector["Nombre"].ToString();
                    aux.Precio_Compra_Unitario = (decimal)datos.Lector["Precio_Compra"];
                    aux.Producto.StockActual = (int)datos.Lector["Stock_Actual"];
                    aux.Producto.StockMinimo = (int)datos.Lector["Stock_Minimo"];

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
