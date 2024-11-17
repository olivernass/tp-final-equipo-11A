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
        public List<Detalle_Compra> listaDetalle { get; set; }
        public string codigo { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            Detalle_Compra_Negocio negocio = new Detalle_Compra_Negocio();
            codigo = Request.QueryString["id"].ToString();
            int codigoprov = int.Parse(codigo);
            listaDetalle = negocio.listarProductos(codigoprov);
            rptDetalleCompra.DataSource = listaDetalle;
            rptDetalleCompra.DataBind();

        }
    }
}