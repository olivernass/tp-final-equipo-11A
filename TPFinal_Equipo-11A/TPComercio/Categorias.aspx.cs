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

        //protected void btnGuardarCategoria_Click(object sender, EventArgs e)
        //{
        //    if (!string.IsNullOrEmpty(txtNombreCategoria.Text))
        //    {
        //        Categoria nuevaCategoria = new Categoria
        //        {
        //            NombreCategoria = txtNombreCategoria.Text
        //        };

        //        CategoriaNegocio negocio = new CategoriaNegocio();
        //        negocio.agregar(nuevaCategoria);

        //        // Recargar la lista de categorias
        //        cargarCategorias();

        //        limpiarCampos();

        //        // Cerrar el modal
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModal", "$('#modalAgregarCategoria').modal('hide');", true);
        //    }
        //}

        protected void btnGuardarCategoria_Click(object sender, EventArgs e)
        {
            CategoriaNegocio negocio = new CategoriaNegocio();

            // Validar que el campo de nombre no esté vacío
            if (string.IsNullOrEmpty(txtNombreCategoria.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El nombre de la categoría es obligatorio.');", true);
                return;
            }

            // Validar si ya existe una categoría con el mismo nombre
            if (negocio.existeCategoria(txtNombreCategoria.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('La categoría ya existe. Por favor, ingrese un nombre diferente.');", true);
                return;
            }

            // Si pasa las validaciones, crear la nueva categoría
            Categoria nuevaCategoria = new Categoria
            {
                NombreCategoria = txtNombreCategoria.Text
            };

            negocio.agregar(nuevaCategoria);

            // Recargar la lista de categorías y limpiar el formulario
            cargarCategorias();
            limpiarCampos();

            // Cerrar el modal
            ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModal", "$('#modalAgregarCategoria').modal('hide');", true);
        }


        //protected void btnGuardarCambios_Click(object sender, EventArgs e)
        //{
        //    if (!string.IsNullOrEmpty(txtNombreCategoriaMod.Text))
        //    {
        //        int idCategoria = int.Parse(hdnIdCategoria.Value); // ID de la categoria almacenado en el HiddenField

        //        Categoria categoriaModificada = new Categoria
        //        {
        //            Id = idCategoria,
        //            NombreCategoria = txtNombreCategoriaMod.Text
        //        };

        //        CategoriaNegocio negocio = new CategoriaNegocio();
        //        negocio.modificar(categoriaModificada);

        //        // Recargar la lista de categorias
        //        cargarCategorias();

        //        limpiarCamposModificacion();

        //        // Cerrar el modal
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarCategoria').modal('hide');", true);
        //    }
        //}

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            // Verificar que el nombre de la categoría no esté vacío
            if (!string.IsNullOrEmpty(txtNombreCategoriaMod.Text))
            {
                string nombreCategoria = txtNombreCategoriaMod.Text;
                int idCategoria = int.Parse(hdnIdCategoria.Value); // Obtener el ID de la categoría desde el HiddenField

                CategoriaNegocio negocio = new CategoriaNegocio();

                // Validar que no exista otra categoría con el mismo nombre
                if (negocio.existeNombreCategoriaModificado(nombreCategoria, idCategoria))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El nombre de la categoría ya está registrado para otra categoría.');", true);
                    return;
                }

                // Si la validación pasa, proceder con la modificación de la categoría
                Categoria categoriaModificada = new Categoria
                {
                    Id = idCategoria,
                    NombreCategoria = nombreCategoria
                };

                negocio.modificar(categoriaModificada); // Llamar al método de modificación

                // Recargar la lista de categorías
                cargarCategorias();

                // Limpiar los campos del formulario de modificación
                limpiarCamposModificacion();

                // Cerrar el modal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarCategoria').modal('hide');", true);
            }
        }


        //protected void rptCategorias_ItemCommand(object source, RepeaterCommandEventArgs e)
        //{
        //    if (e.CommandName == "Inactivar")
        //    {
        //        int idCategoria = Convert.ToInt32(e.CommandArgument);
        //        Categoria categoriaEliminar = new Categoria();
        //        {
        //            categoriaEliminar.Id = idCategoria;
        //        }
        //        CategoriaNegocio negocio = new CategoriaNegocio();
        //        negocio.eliminarL(categoriaEliminar);
        //        cargarCategorias();
        //    }
        //    else if (e.CommandName == "Activar")
        //    {
        //        int idCategoria = Convert.ToInt32(e.CommandArgument);
        //        Categoria categoriaActivar = new Categoria();
        //        {
        //            categoriaActivar.Id = idCategoria;
        //        }
        //        CategoriaNegocio negocio = new CategoriaNegocio();
        //        negocio.activar(categoriaActivar);
        //        cargarCategorias();
        //    }
        //}

        protected void rptCategorias_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int idCategoria = Convert.ToInt32(e.CommandArgument);
            CategoriaNegocio negocio = new CategoriaNegocio();

            if (e.CommandName == "Inactivar")
            {
                // Verificar si la categoría tiene productos activos asociados
                if (negocio.tieneProductosActivos(idCategoria))
                {
                    // Mostrar un mensaje de error si la categoría tiene productos activos
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No se puede inactivar esta categoría porque tiene productos activos asociados.');", true);
                    return;
                }

                // Proceder con la inactivación si no hay productos activos asociados
                Categoria categoriaEliminar = new Categoria { Id = idCategoria };
                negocio.eliminarL(categoriaEliminar);
                cargarCategorias();
            }
            else if (e.CommandName == "Activar")
            {
                Categoria categoriaActivar = new Categoria { Id = idCategoria };
                negocio.activar(categoriaActivar);
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
            ddlEstadoCategorias.SelectedValue = "Todos";
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                CategoriaNegocio negocio = new CategoriaNegocio();
                rptCategorias.DataSource = negocio.filtrar(ddlEstadoCategorias.SelectedItem.ToString());
                rptCategorias.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                throw;
            }
        }
    }
}
