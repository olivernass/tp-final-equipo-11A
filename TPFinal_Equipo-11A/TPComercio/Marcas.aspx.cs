using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.Mime.MediaTypeNames;

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
            Session.Add("listaMarcas", negocio.listar());
            rptMarcas.DataSource = Session["listaMarcas"];
            //rptMarcas.DataSource = listaMarcas;
            rptMarcas.DataBind();
        }

        // Limpiar campos de modal
        private void limpiarCampos()
        {
            txtNombreMarca.Text = string.Empty;
        }

        private void limpiarCamposModificacion()
        {
            txtNombreMarcaMod.Text = string.Empty;
            hdnIdMarca.Value = string.Empty;
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

                limpiarCampos();

                // Cerrar el modal
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

                limpiarCamposModificacion();

                // Cerrar el modal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarMarca').modal('hide');", true);
            }
        }

        protected void rptMarcas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
                if (e.CommandName == "Inactivar")
                {
                    int idMarca = Convert.ToInt32(e.CommandArgument);
                    Marca marcaEliminar = new Marca();
                    {
                        marcaEliminar.Id = idMarca;
                    }
                    MarcaNegocio negocio = new MarcaNegocio();
                    negocio.eliminarL(marcaEliminar);
                    cargarMarcas();
                }
                else if (e.CommandName == "Activar")
                {
                    int idMarca = Convert.ToInt32(e.CommandArgument);
                    Marca marcaActivar = new Marca();
                    {
                        marcaActivar.Id = idMarca;
                    }
                    MarcaNegocio negocio = new MarcaNegocio();
                    negocio.activar(marcaActivar);
                    cargarMarcas();
                }
        }

        protected void txtFiltroMarcas_TextChanged(object sender, EventArgs e)
        {
            List<Marca> lista = (List<Marca>)Session["listaMarcas"];
            List<Marca> listaFiltrada = lista.FindAll(x => x.NombreMarca.ToUpper().Contains(txtFiltroMarcas.Text.ToUpper()));
            rptMarcas.DataSource = listaFiltrada;
            rptMarcas.DataBind();
        }

        protected void btnBorrar_Click(object sender, EventArgs e)
        {
            txtFiltroMarcas.Text = string.Empty;
            cargarMarcas();
        }

        //protected void ddlEstadoMarcas_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        MarcaNegocio negocio = new MarcaNegocio();
        //        rptMarcas.DataSource = negocio.filtrar(ddlEstadoMarcas.ToString());
        //        rptMarcas.DataBind();
        //    }
        //    catch (Exception ex)
        //    {
        //        Session.Add("error", ex);
        //        throw;
        //    }
        //}

        protected void btnBuscar_Click(object sender, EventArgs e)
        {   
            try
            {
                MarcaNegocio negocio = new MarcaNegocio();
                rptMarcas.DataSource = negocio.filtrar(ddlEstadoMarcas.SelectedItem.ToString());
                rptMarcas.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                throw;
            }
        }

        //protected void ddlEstadoMarcas_SelectedIndexChanged1(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        MarcaNegocio negocio = new MarcaNegocio();
        //        rptMarcas.DataSource = negocio.filtrar(ddlEstadoMarcas.ToString());
        //        rptMarcas.DataBind();
        //    }
        //    catch (Exception ex)
        //    {
        //        Session.Add("error", ex);
        //        throw;
        //    }
        //}
    }
}
