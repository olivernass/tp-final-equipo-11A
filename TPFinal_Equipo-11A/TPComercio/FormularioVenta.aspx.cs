using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPComercio
{
    public partial class FormularioVenta : System.Web.UI.Page
    {
        public List<Detalle_Venta_Negocio> listaProductos { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void cargarProductos()
        {
            Detalle_Venta_Negocio negocio = new Detalle_Venta_Negocio();
            
        }

        protected void rptDetalleVenta_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                TextBox txtCantidad = (TextBox)e.Item.FindControl("txtCantidad");
                if (Session["idCompra"] != null)
                {
                    txtCantidad.Enabled = false;

                }
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Ventas.aspx");
            Session.Remove("ListaDetalleVenta");
            Session.Remove("idVenta");
        }
    }
}