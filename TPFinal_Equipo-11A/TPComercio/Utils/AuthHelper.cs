using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using Dominio;

namespace TPComercio.Utils
{
    public static class AuthHelper
    {
        // Método para validar acceso basado en permisos permitidos
        public static void ValidarAcceso(List<int> permisosRequeridos, HttpResponse response, HttpSessionState session)
        {
            // Verifica si el usuario está logueado
            if (session["usuario"] == null)
            {
                // Redirige al login si el usuario no está logueado
                response.Redirect("Login.aspx");
            }
            else
            {
                // Obtiene el usuario de la sesión
                Usuario usuario = (Usuario)session["usuario"];

                // Verifica si el permiso del usuario está en la lista de permisos permitidos
                if (!permisosRequeridos.Contains(usuario.Permiso.Id))
                {
                    // Redirige a una página de acceso denegado si el permiso es insuficiente
                    response.Redirect("AccesoDenegado.aspx");
                }
            }
        }

        // Sobrecarga para validar acceso con un solo permiso
        public static void ValidarAcceso(int permisoRequerido, HttpResponse response, HttpSessionState session)
        {
            ValidarAcceso(new List<int> { permisoRequerido }, response, session);
        }

        public static bool EstaLogueado(HttpSessionState session)
        {
            return session["usuario"] != null;
        }

        public static void CerrarSesion(HttpSessionState session)
        {
            session.Remove("usuario");
            session.Abandon(); // Finaliza la sesión
        }
    }
}