using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPComercio
{
    public partial class Clientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarClientes();
            }
        }

        private void cargarClientes()
        {
            ClienteNegocio clienteNegocio = new ClienteNegocio();
            gvClientes.DataSource = clienteNegocio.listar();
            gvClientes.DataBind();
        }
    }
}