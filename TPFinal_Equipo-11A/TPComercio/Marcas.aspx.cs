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
    public partial class Marcas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarMarcas();
            }
        }

        private void cargarMarcas()
        {
            MarcaNegocio marcaNegocio = new MarcaNegocio();
            gvMarcas.DataSource = marcaNegocio.listar();
            gvMarcas.DataBind();
        }

        protected void btnGuardarMarca_Click(object sender, EventArgs e)
        {
            Marca nuevaMarca = new Marca
            {
                NombreMarca = txtNombreMarca.Text
            };

            MarcaNegocio marcaNegocio = new MarcaNegocio();
            marcaNegocio.agregar(nuevaMarca);

            cargarMarcas();
            txtNombreMarca.Text = "";
        }

        // Manejar los comandos Modificar y Eliminar
        protected void gvMarcas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int idMarca = Convert.ToInt32(e.CommandArgument);
            MarcaNegocio marcaNegocio = new MarcaNegocio();

            if (e.CommandName == "Eliminar")
            {
                // Eliminar la marca
                marcaNegocio.eliminarF(idMarca);
                cargarMarcas();  // Recargar la lista
            }
            else if (e.CommandName == "Modificar")
            {
                
            }
        }

        // Cambiar el color de la fila o agregar algún estilo al pasar el mouse
        protected void gvMarcas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='#f0f0f0';";
                e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='';";
            }
        }

    }

}

