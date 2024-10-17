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
            MarcaNegocio negocio = new MarcaNegocio();
            List<Marca> listaMarcas = negocio.listar();
            rptMarcas.DataSource = listaMarcas;
            rptMarcas.DataBind();
        }

        protected void btnGuardarMarca_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtNombreMarca.Text))
            {
                Marca nuevaMarca = new Marca
                {
                    NombreMarca = txtNombreMarca.Text
                };

                MarcaNegocio negocio = new MarcaNegocio();
                negocio.agregar(nuevaMarca);

                // Recargar la lista de marcas para que se vea reflejada la nueva marca
                cargarMarcas();

                // Limpiar el campo de texto
                txtNombreMarca.Text = string.Empty;

                // Cerrar el modal (esto se hace con JS al actualizar la página)
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModal", "$('#modalAgregarMarca').modal('hide');", true);
            }
        }

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtNombreMarcaMod.Text))
            {
                int idMarca = int.Parse(hdnIdMarca.Value); // ID de la marca almacenado en el HiddenField

                Marca marcaModificada = new Marca
                {
                    Id = idMarca,
                    NombreMarca = txtNombreMarcaMod.Text
                };

                MarcaNegocio negocio = new MarcaNegocio();
                negocio.modificar(marcaModificada);

                // Recargar la lista de marcas
                cargarMarcas();

                // Limpiar campos
                hdnIdMarca.Value = string.Empty;
                txtNombreMarcaMod.Text = string.Empty;

                // Cerrar el modal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarMarca').modal('hide');", true);
            }
        }

        protected void rptMarcas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int idMarca = Convert.ToInt32(e.CommandArgument);
                MarcaNegocio negocio = new MarcaNegocio();
                negocio.eliminarF(idMarca);

                // Recargar la lista de marcas después de eliminar
                cargarMarcas();
            }
        }
    }
}
