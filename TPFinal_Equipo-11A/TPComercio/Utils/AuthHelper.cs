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

        public static void ValidarAcceso(List<int> permisosRequeridos, HttpResponse response, HttpSessionState session)
        {

            if (session["usuario"] == null)
            {

                response.Redirect("Login.aspx");
            }
            else
            {

                Usuario usuario = (Usuario)session["usuario"];

  
                if (!permisosRequeridos.Contains(usuario.Permiso.Id))
                {

                    response.Redirect("Error.aspx");
                }
            }
        }

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
            session.Abandon(); 
        }
    }
}