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
    public partial class Categorias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarCategorias();
            }
        }

        private void cargarCategorias()
        {
            CategoriaNegocio negocio = new CategoriaNegocio();
            List<Categoria> listaCategorias = negocio.listar();
            Session.Add("listaCategorias", negocio.listar());
            rptCategorias.DataSource = Session["listaCategorias"];
            //rptCategorias.DataSource = listaCategorias;
            rptCategorias.DataBind();
        }

        // Limpiar campos de modal
        private void limpiarCampos()
        {
            txtNombreCategoria.Text = string.Empty;
        }

        private void limpiarCamposModificacion()
        {
            txtNombreCategoriaMod.Text = string.Empty;
            hdnIdCategoria.Value = string.Empty;
        }

        protected void btnGuardarCategoria_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtNombreCategoria.Text))
            {
                Categoria nuevaCategoria = new Categoria
                {
                    NombreCategoria = txtNombreCategoria.Text
                };

                CategoriaNegocio negocio = new CategoriaNegocio();
                negocio.agregar(nuevaCategoria);

                // Recargar la lista de categorias
                cargarCategorias();

                limpiarCampos();

                // Cerrar el modal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModal", "$('#modalAgregarCategoria').modal('hide');", true);
            }
        }

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtNombreCategoriaMod.Text))
            {
                int idCategoria = int.Parse(hdnIdCategoria.Value); // ID de la categoria almacenado en el HiddenField

                Categoria categoriaModificada = new Categoria
                {
                    Id = idCategoria,
                    NombreCategoria = txtNombreCategoriaMod.Text
                };

                CategoriaNegocio negocio = new CategoriaNegocio();
                negocio.modificar(categoriaModificada);

                // Recargar la lista de categorias
                cargarCategorias();

                limpiarCamposModificacion();

                // Cerrar el modal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarCategoria').modal('hide');", true);
            }
        }

        protected void rptCategorias_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int idCategoria = Convert.ToInt32(e.CommandArgument);
                CategoriaNegocio negocio = new CategoriaNegocio();
                negocio.eliminarL(idCategoria);

                // Recargar la lista de categorias después de eliminar
                cargarCategorias();
            }
        }

        protected void txtFiltroCategoria_TextChanged(object sender, EventArgs e)
        {
            List<Categoria> lista = (List<Categoria>)Session["listaCategorias"];
            List<Categoria> listaFiltrada = lista.FindAll(x => x.NombreCategoria.ToUpper().Contains(txtFiltroCategoria.Text.ToUpper()));
            rptCategorias.DataSource = listaFiltrada;
            rptCategorias.DataBind();
        }

        protected void btnBorrar_Click(object sender, EventArgs e)
        {
            txtFiltroCategoria.Text = string.Empty;
            cargarCategorias();
        }
    }
}
