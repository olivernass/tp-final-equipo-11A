using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPComercio
{
    public partial class FormularioCompra : System.Web.UI.Page
    {
        public string codigo { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            codigo = Request.QueryString["id"].ToString();
            long numeroCompra = long.Parse(codigo);
            CompraNegocio negocioC = new CompraNegocio();
            
            
        }
    }
}