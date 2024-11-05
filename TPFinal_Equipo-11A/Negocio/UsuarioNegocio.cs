using Acceso_Datos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class UsuarioNegocio
    {

        public bool loguear(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT ID, IDPermiso, NombrePermiso FROM VW_ListaUsuarios WHERE NombreUsuario = @NombreUsuario AND Contrasenia = @Contrasenia AND Activo = 1");
                datos.setearParametro("@NombreUsuario", usuario.NombreUsuario);
                datos.setearParametro("@Contrasenia", usuario.Contrasenia);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    usuario.Id = (int)datos.Lector["ID"];
                    usuario.Permiso = new Permiso
                    {
                        Id = (int)datos.Lector["IDPermiso"],
                        NombrePermiso = (string)datos.Lector["NombrePermiso"]
                    };

                    return true;
                }

                return false;
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

        public List<Usuario> listar()
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT * FROM VW_ListaUsuarios");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Usuario aux = new Usuario
                    {
                        Id = (int)datos.Lector["ID"],
                        NombreUsuario = (string)datos.Lector["NombreUsuario"],
                        Contrasenia = (string)datos.Lector["Contrasenia"],
                        Activo = (bool)datos.Lector["Activo"],
                        Permiso = new Permiso
                        {
                            Id = (int)datos.Lector["IDPermiso"],
                            NombrePermiso = (string)datos.Lector["NombrePermiso"]
                        }
                    };

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
        public void agregar(Usuario nuevo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_Alta_Usuario");
                datos.setearParametro("@IDPermiso", nuevo.Permiso.Id);
                datos.setearParametro("@NombreUsuario", nuevo.NombreUsuario);
                datos.setearParametro("@Contrasenia", nuevo.Contrasenia);
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
        public void eliminarL(Usuario aux)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_BajaUsuario");
                datos.setearParametro("@ID", aux.Id);
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
        public void modificar(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("SP_ModificarUsuario");
                datos.setearParametro("@ID", usuario.Id);
                datos.setearParametro("@IDPermiso", usuario.Permiso.Id);
                datos.setearParametro("@NombreUsuario", usuario.NombreUsuario);
                datos.setearParametro("@Contrasenia", usuario.Contrasenia);
                datos.setearParametro("@Activo", usuario.Activo);
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
    }
}
