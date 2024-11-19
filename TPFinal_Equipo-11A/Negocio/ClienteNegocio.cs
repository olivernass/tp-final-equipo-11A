using Acceso_Datos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ClienteNegocio
    {

        public List<Cliente> listar()
        {
            List<Cliente> lista = new List<Cliente>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT * FROM VW_ListaClientes");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Cliente aux = new Cliente();
                    aux.Id = (long)datos.Lector["ID"];
                    aux.DNI = (int)datos.Lector["DNI"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Direccion = (string)datos.Lector["Direccion"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Correo = (string)datos.Lector["Correo"];
                    aux.Fecha_Alta = (DateTime)datos.Lector["Fecha_reg"];
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
        public void agregar(Cliente nuevo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_Alta_Cliente");
                datos.setearParametro("@DNI", nuevo.DNI);
                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Apellido", nuevo.Apellido);
                datos.setearParametro("@Direccion", nuevo.Direccion);
                datos.setearParametro("@Telefono", nuevo.Telefono);
                datos.setearParametro("@Correo", nuevo.Correo);
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
        public void eliminarL(Cliente cliente)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_BajaCliente");
                datos.setearParametro("@ID", cliente.Id);
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

        // cambiar método eliminarL para aceptar un int
        //public void eliminarL(int id)
        //{
        //    AccesoDatos datos = new AccesoDatos();

        //    try
        //    {
        //        datos.setearProcedimiento("SP_BajaCliente");
        //        datos.setearParametro("@ID", id);
        //        datos.ejecutarAccion();
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //    finally
        //    {
        //        datos.cerrarConexion();
        //    }
        //}

        public void activar(Cliente cliente)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ActivarCliente");
                datos.setearParametro("@ID", cliente.Id);
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
        public void modificar(Cliente cliente)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ModificarCliente");
                datos.setearParametro("@ID", cliente.Id);
                datos.setearParametro("@DNI", cliente.DNI);
                datos.setearParametro("@Nombre", cliente.Nombre);
                datos.setearParametro("@Apellido", cliente.Apellido);
                datos.setearParametro("@Direccion", cliente.Direccion);
                datos.setearParametro("@Telefono", cliente.Telefono);
                datos.setearParametro("@Correo", cliente.Correo);
                datos.setearParametro("@Activo", cliente.Activo);
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

        //public List<Cliente> filtrar(string campo, string criterio, string filtro, string estado)
        //{
        //    List<Cliente> lista = new List<Cliente>();
        //    AccesoDatos datos = new AccesoDatos();

        //    try
        //    {
        //        string consulta = "select DNI, Nombre, Apellido, Direccion, Telefono, Correo, Fecha_reg, Activo FROM Clientes WHERE";

        //        if(campo == "DNI")
        //        {
        //            switch (criterio)
        //            {
        //                case "Mayor a":
        //                    consulta += " DNI > " + filtro;
        //                    break;
        //                case "Menor a":
        //                    consulta += " DNI <" + filtro;
        //                    break;
        //                default:
        //                    consulta += " DNI =" + filtro;
        //                    break;
        //            }
        //        }
        //        else if(campo == "Apellido")
        //        {
        //            switch(criterio)
        //            {
        //                case "Comienza con":
        //                    consulta += " Apellido LIKE '" + filtro + "%' ";
        //                    break;
        //                case "Termina con":
        //                    consulta += " Apellido LIKE '%" + filtro + "'";
        //                    break;
        //                default:
        //                    consulta += " Apellido LIKE '%" + filtro + "%'";
        //                    break;
        //            }
        //        }
        //        else
        //        {
        //            switch(campo)
        //            {
        //                case "Comienza con":
        //                    consulta += " Correo LIKE '" + filtro + "%' ";
        //                    break;
        //                case "Termina con":
        //                    consulta += " Correo LIKE '%" + filtro + "'";
        //                    break;
        //                default:
        //                    consulta += " Correo LIKE '%" + filtro + "%'";
        //                    break;
        //            }
        //        }

        //        if (estado == "Activo")
        //            consulta += " AND Activo = 1 ";
        //        else if (estado == "Inactivo")
        //            consulta += " AND Activo = 0";

        //        datos.setearConsulta( consulta );
        //        datos.ejecutarLectura();

        //        while(datos.Lector.Read())
        //        {
        //            Cliente aux = new Cliente();
        //            aux.DNI = (int)datos.Lector["DNI"];
        //            aux.Nombre = (string)datos.Lector["Nombre"];
        //            aux.Apellido = (string)datos.Lector["Apellido"];
        //            aux.Direccion = (string)datos.Lector["Direccion"];
        //            aux.Telefono = (string)datos.Lector["Telefono"];
        //            aux.Correo = (string)datos.Lector["Correo"];
        //            aux.Fecha_Alta = (DateTime)datos.Lector["Fecha_reg"];
        //            aux.Activo = bool.Parse(datos.Lector["Activo"].ToString());
        //            aux.Activo = (bool)datos.Lector["Activo"];

        //            lista.Add(aux);
        //        }

        //        return lista;
        //    }
        //    catch (Exception ex)
        //    {

        //        throw ex;
        //    }
        //}

        public List<Cliente> filtrar(string campo, string criterio, string filtro)
        {
            List<Cliente> lista = new List<Cliente>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                // Iniciar la consulta
                string consulta = "select ID, DNI, Nombre, Apellido, Direccion, Telefono, Correo, Fecha_reg, Activo FROM Clientes WHERE 1=1";

                // Agregar condición del campo y criterio solo si ambos están presentes
                if (!string.IsNullOrEmpty(campo) && !string.IsNullOrEmpty(criterio) && !string.IsNullOrEmpty(filtro))
                {
                    if (campo == "DNI")
                    {
                        switch (criterio)
                        {
                            case "Mayor a":
                                consulta += " AND DNI > " + filtro;
                                break;
                            case "Menor a":
                                consulta += " AND DNI < " + filtro;
                                break;
                            default:
                                consulta += " AND DNI = " + filtro;
                                break;
                        }
                    }
                    else if (campo == "Apellido")
                    {
                        switch (criterio)
                        {
                            case "Comienza con":
                                consulta += " AND Apellido LIKE '" + filtro + "%'";
                                break;
                            case "Termina con":
                                consulta += " AND Apellido LIKE '%" + filtro + "'";
                                break;
                            default:
                                consulta += " AND Apellido LIKE '%" + filtro + "%'";
                                break;
                        }
                    }
                    else if (campo == "Correo")
                    {
                        switch (criterio)
                        {
                            case "Comienza con":
                                consulta += " AND Correo LIKE '" + filtro + "%'";
                                break;
                            case "Termina con":
                                consulta += " AND Correo LIKE '%" + filtro + "'";
                                break;
                            default:
                                consulta += " AND Correo LIKE '%" + filtro + "%'";
                                break;
                        }
                    }
                }

                

                datos.setearConsulta(consulta);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Cliente aux = new Cliente();
                    aux.Id = (long)datos.Lector["Id"];
                    aux.DNI = (int)datos.Lector["DNI"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Direccion = (string)datos.Lector["Direccion"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Correo = (string)datos.Lector["Correo"];
                    aux.Fecha_Alta = (DateTime)datos.Lector["Fecha_reg"];
                    aux.Activo = (bool)datos.Lector["Activo"];

                    lista.Add(aux);
                }

                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<Cliente> filtrarEstado(string estado)
        {
            List<Cliente> lista = new List<Cliente>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                string consulta = "select ID, DNI, Nombre, Apellido, Direccion, Telefono, Correo, Fecha_reg, Activo FROM Clientes";

                if (estado == "Activo")
                    consulta += " WHERE Activo = 1 ";
                else if (estado == "Inactivo")
                    consulta += " WHERE Activo = 0";
                else if (estado == "Todos")
                    consulta += " select * FROM Clientes";

                datos.setearConsulta(consulta);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Cliente aux = new Cliente();
                    aux.Id = (long)datos.Lector["Id"];
                    aux.DNI = (int)datos.Lector["DNI"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Direccion = (string)datos.Lector["Direccion"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Correo = (string)datos.Lector["Correo"];
                    aux.Fecha_Alta = (DateTime)datos.Lector["Fecha_reg"];
                    //aux.Activo = bool.Parse(datos.Lector["Activo"].ToString());
                    aux.Activo = (bool)datos.Lector["Activo"];

                    lista.Add(aux);
                }

                return lista;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public bool existeDNICliente(int dni)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ExisteDNICliente"); // Nombre del procedimiento almacenado
                datos.setearParametro("@DNI", dni);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    int count = datos.Lector.GetInt32(0);
                    return count > 0; // Retorna true si el DNI ya existe
                }

                return false; // Retorna false si no se encontró el DNI
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

        public bool existeDNIClienteModificado(int dni, long idCliente)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ExisteDNIClienteModificado"); // Nombre del procedimiento almacenado
                datos.setearParametro("@DNI", dni);
                datos.setearParametro("@IDCliente", idCliente);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    int count = datos.Lector.GetInt32(0);
                    return count > 0; // Retorna true si el DNI ya existe para otro cliente
                }

                return false; // Retorna false si no se encontró el DNI duplicado
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

        //public Cliente ObtenerPrimerCliente()
        //{
        //    AccesoDatos datos = new AccesoDatos();
        //    try
        //    {
        //        datos.setearProcedimiento("SP_PrimerClienteDadoDeAlta");
        //        datos.ejecutarLectura();

        //        if (datos.Lector.Read())
        //        {
        //            Cliente cliente = new Cliente
        //            {
        //                Id = datos.Lector.GetInt64(0), // Asumiendo que la primera columna es ID
        //                DNI = datos.Lector.GetInt32(1),
        //                Nombre = datos.Lector.GetString(2),
        //                Apellido = datos.Lector.GetString(3),
        //                Direccion = datos.Lector.GetString(4),
        //                Telefono = datos.Lector.GetString(5),
        //                Correo = datos.Lector.GetString(6),
        //                Fecha_Alta = datos.Lector.GetDateTime(7),
        //                Activo = datos.Lector.GetBoolean(8)
        //            };
        //            return cliente;
        //        }

        //        return null; // Si no hay clientes
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception("Error al obtener el primer cliente dado de alta", ex);
        //    }
        //    finally
        //    {
        //        datos.cerrarConexion();
        //    }
        //}

        //public Cliente ObtenerUltimoCliente()
        //{
        //    AccesoDatos datos = new AccesoDatos();
        //    try
        //    {
        //        datos.setearProcedimiento("SP_UltimoClienteDadoDeAlta");
        //        datos.ejecutarLectura();

        //        if (datos.Lector.Read())
        //        {
        //            Cliente cliente = new Cliente
        //            {
        //                Id = datos.Lector.GetInt64(0),
        //                DNI = datos.Lector.GetInt32(1),
        //                Nombre = datos.Lector.GetString(2),
        //                Apellido = datos.Lector.GetString(3),
        //                Direccion = datos.Lector.GetString(4),
        //                Telefono = datos.Lector.GetString(5),
        //                Correo = datos.Lector.GetString(6),
        //                Fecha_Alta = datos.Lector.GetDateTime(7),
        //                Activo = datos.Lector.GetBoolean(8)
        //            };
        //            return cliente;
        //        }

        //        return null; // Si no hay clientes
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception("Error al obtener el último cliente dado de alta", ex);
        //    }
        //    finally
        //    {
        //        datos.cerrarConexion();
        //    }
        //}

    }
}
