using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPComercio.Utils;

namespace TPComercio
{
    public partial class VentasHistorial : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.ValidarAcceso(new List<int> { 1, 2 }, Response, Session);

            if (!IsPostBack)
            {
                //CargarHistorialEnVista();

                CargarHistorialEnVista();
            }
        }

        //private void CargarHistorialEnVista()
        //{
        //    HistorialVentasNegocio negocio = new HistorialVentasNegocio();
        //    List<HistorialVenta> historial = negocio.CargarHistorialVentas();
        //    gvHistorialVentas.DataSource = historial;
        //    gvHistorialVentas.DataBind();
        //}

        private void CargarHistorialEnVista()
        {
            HistorialVentasNegocio negocio = new HistorialVentasNegocio();
            List<HistorialVenta> historial = negocio.CargarHistorialVentas();
            gvHistorialVentas.DataSource = historial;
            gvHistorialVentas.DataBind();
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("VentasRedireccion.aspx");
        }
    }
}