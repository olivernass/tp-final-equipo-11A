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
    public partial class Reportes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MostrarMarcaConMasProductos();
            }
        }

        private void MostrarMarcaConMasProductos()
        {
            MarcaNegocio marcaNegocio = new MarcaNegocio();
            Marca marcaConMasProductos = marcaNegocio.ObtenerMarcaConMasProductos();

            if (marcaConMasProductos != null)
            {
                // Muestra los datos en la página, por ejemplo en etiquetas Label
                lblMarcaNombre.Text = "Marca con más productos: " + marcaConMasProductos.NombreMarca;
                lblMarcaID.Text = "ID de la marca: " + marcaConMasProductos.Id;
            }
            else
            {
                lblMarcaNombre.Text = "No se encontró ninguna marca con productos.";
                lblMarcaID.Text = string.Empty;
            }
        }
    }
}