using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPComercio
{
    public partial class Proveedores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarProveedores();
            }
        }

        private void cargarProveedores()
        {
            ProveedorNegocio proveedorNegocio = new ProveedorNegocio();
            gvProveedores.DataSource = proveedorNegocio.listar();
            gvProveedores.DataBind();
        }
    }
}