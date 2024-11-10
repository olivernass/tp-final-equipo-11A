using Acceso_Datos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ProveedorNegocio
    {
        public List<Proveedor> listar()
        {
            List<Proveedor> lista = new List<Proveedor>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT * FROM VW_ListaProveedores");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Proveedor aux = new Proveedor();
                    aux.Id = (int)datos.Lector["ID"];
                    aux.CUIT = (long)datos.Lector["CUIT"];
                    aux.Siglas = (string)datos.Lector["Siglas"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Direccion = (string)datos.Lector["Direccion"];
                    aux.Correo = (string)datos.Lector["Correo"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Activo = (bool)datos.Lector["Activo"];

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
        public void agregar(Proveedor nuevo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_Alta_Proveedor");
                datos.setearParametro("@CUIT", nuevo.CUIT);
                datos.setearParametro("@Siglas", nuevo.Siglas);
                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Direccion", nuevo.Direccion);
                datos.setearParametro("@Correo", nuevo.Correo);
                datos.setearParametro("@Telefono", nuevo.Telefono);
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
        public void eliminarL(Proveedor proveedor)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_BajaProveedor");
                datos.setearParametro("@ID", proveedor.Id);
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
        public void modificar(Proveedor proveedor)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ModificarProveedor");
                datos.setearParametro("@ID", proveedor.Id);
                datos.setearParametro("@CUIT", proveedor.CUIT);
                datos.setearParametro("@Siglas", proveedor.Siglas);
                datos.setearParametro("@Nombre", proveedor.Nombre);
                datos.setearParametro("@Direccion", proveedor.Direccion);
                datos.setearParametro("@Correo", proveedor.Correo);
                datos.setearParametro("@Telefono", proveedor.Telefono);
                datos.setearParametro("@Activo", proveedor.Activo);
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
        public void agregarProducto(long idproducto, int idproveedor)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_PRODUCT_X_PROV2");
                datos.setearParametro("@IDPRODUCTO", idproducto);
                datos.setearParametro("@IDPROVEEDOR", idproveedor);
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
        public List<Proveedor> listarxid(long codigoproducto)
        {
            List<Proveedor> lista = new List<Proveedor>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT ID,Siglas FROM Proveedores WHERE ID IN (SELECT IDProveedor FROM Productos_x_Proveedores WHERE IDProducto = " + codigoproducto + " AND Activo=1)");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Proveedor aux = new Proveedor();
                    aux.Id = (int)datos.Lector["ID"];
                    aux.Siglas = (string)datos.Lector["Siglas"];
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
        public List<Proveedor> listarProvSinProductoAsociado(long codigoproducto)
        {
            List<Proveedor> lista = new List<Proveedor>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT ID,Siglas FROM Proveedores WHERE Activo = 1 AND ID NOT IN (SELECT IDProveedor FROM Productos_x_Proveedores WHERE IDProducto = " + codigoproducto + ")");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Proveedor aux = new Proveedor();
                    aux.Id = (int)datos.Lector["ID"];
                    aux.Siglas = (string)datos.Lector["Siglas"];
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
        public List<Proveedor> filtrar(string campo, string criterio, string filtro, string estado)
        {
            List<Proveedor> lista = new List<Proveedor>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                string consulta = "select CUIT, Siglas, Nombre, Direccion, Correo, Telefono, Activo FROM Proveedores WHERE";

                if (campo == "CUIT")
                {
                    switch (criterio)
                    {
                        case "Mayor a":
                            consulta += " CUIT > " + filtro;
                            break;
                        case "Menor a":
                            consulta += " CUIT <" + filtro;
                            break;
                        default:
                            consulta += " CUIT =" + filtro;
                            break;
                    }
                }
                else if (campo == "Siglas")
                {
                    switch (criterio)
                    {
                        case "Comienza con":
                            consulta += " Siglas LIKE '" + filtro + "%' ";
                            break;
                        case "Termina con":
                            consulta += " Siglas LIKE '%" + filtro + "'";
                            break;
                        default:
                            consulta += " Siglas LIKE '%" + filtro + "%'";
                            break;
                    }
                }
                else
                {
                    switch (campo)
                    {
                        case "Comienza con":
                            consulta += " Correo LIKE '" + filtro + "%' ";
                            break;
                        case "Termina con":
                            consulta += " Correo LIKE '%" + filtro + "'";
                            break;
                        default:
                            consulta += " Correo LIKE '%" + filtro + "%'";
                            break;
                    }
                }

                if (estado == "Activo")
                    consulta += " AND Activo = 1 ";
                else if (estado == "Inactivo")
                    consulta += " AND Activo = 0";

                datos.setearConsulta(consulta);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Proveedor aux = new Proveedor();
                    aux.CUIT = (long)datos.Lector["CUIT"];
                    aux.Siglas = (string)datos.Lector["Siglas"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Direccion = (string)datos.Lector["Direccion"];
                    aux.Correo = (string)datos.Lector["Correo"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Activo = bool.Parse(datos.Lector["Activo"].ToString());

                    lista.Add(aux);
                }

                return lista;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
