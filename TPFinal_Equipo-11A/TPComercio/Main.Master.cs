using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPComercio.Utils;

namespace TPComercio
{
    public partial class Main : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (AuthHelper.EstaLogueado(Session))
                {
                    btnLogin.Visible = false;
                    btnLogout.Visible = true;
                    btnPerfil.Visible = true;
                }
                else
                {
                    btnLogin.Visible = true;
                    btnLogout.Visible = false;
                    btnPerfil.Visible = false;
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            AuthHelper.CerrarSesion(Session);
            Response.Redirect("Login.aspx");
        }
    }
}