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

        //protected void btnGuardarMarca_Click(object sender, EventArgs e)
        //{
        //    if (!string.IsNullOrEmpty(txtNombreMarca.Text))
        //    {
        //        Marca nuevaMarca = new Marca
        //        {
        //            NombreMarca = txtNombreMarca.Text
        //        };

        //        MarcaNegocio negocio = new MarcaNegocio();
        //        negocio.agregar(nuevaMarca);

        //        // Recargar la lista de marcas para que se vea reflejada la nueva marca
        //        cargarMarcas();

        //        limpiarCampos();

        //        // Cerrar el modal
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModal", "$('#modalAgregarMarca').modal('hide');", true);
        //    }
        //}

        protected void btnGuardarMarca_Click(object sender, EventArgs e)
        {
            MarcaNegocio negocio = new MarcaNegocio();

            // Validar que el campo de nombre no esté vacío
            if (string.IsNullOrEmpty(txtNombreMarca.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El nombre de la marca es obligatorio.');", true);
                return;
            }

            // Validar si ya existe una marca con el mismo nombre
            if (negocio.existeMarca(txtNombreMarca.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('La marca ya existe. Por favor, ingrese un nombre diferente.');", true);
                return;
            }

            // Si pasa las validaciones, crear la nueva marca
            Marca nuevaMarca = new Marca
            {
                NombreMarca = txtNombreMarca.Text
            };

            negocio.agregar(nuevaMarca);

            // Recargar la lista de marcas y limpiar el formulario
            cargarMarcas();
            limpiarCampos();

            // Cerrar el modal
            ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModal", "$('#modalAgregarMarca').modal('hide');", true);
        }


        //protected void btnGuardarCambios_Click(object sender, EventArgs e)
        //{
        //    if (!string.IsNullOrEmpty(txtNombreMarcaMod.Text))
        //    {
        //        int idMarca = int.Parse(hdnIdMarca.Value); // ID de la marca almacenado en el HiddenField

        //        Marca marcaModificada = new Marca
        //        {
        //            Id = idMarca,
        //            NombreMarca = txtNombreMarcaMod.Text
        //        };

        //        MarcaNegocio negocio = new MarcaNegocio();
        //        negocio.modificar(marcaModificada);

        //        // Recargar la lista de marcas
        //        cargarMarcas();

        //        limpiarCamposModificacion();

        //        // Cerrar el modal
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarMarca').modal('hide');", true);
        //    }
        //}

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            // Verificar que el nombre de la marca no esté vacío
            if (!string.IsNullOrEmpty(txtNombreMarcaMod.Text))
            {
                string nombreMarca = txtNombreMarcaMod.Text;
                int idMarca = int.Parse(hdnIdMarca.Value); // Obtener el ID de la marca desde el HiddenField

                MarcaNegocio negocio = new MarcaNegocio();

                // Validar que no exista otra marca con el mismo nombre
                if (negocio.existeNombreMarcaModificado(nombreMarca, idMarca))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El nombre de la marca ya está registrado para otra marca.');", true);
                    return;
                }

                // Si la validación pasa, proceder con la modificación de la marca
                Marca marcaModificada = new Marca
                {
                    Id = idMarca,
                    NombreMarca = nombreMarca
                };

                negocio.modificar(marcaModificada); // Llamar al método de modificación

                // Recargar la lista de marcas
                cargarMarcas();

                // Limpiar los campos del formulario de modificación
                limpiarCamposModificacion();

                // Cerrar el modal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarMarca').modal('hide');", true);

                // Cargar todas las marcas
                cargarMarcas();

                // Limpiar los controles de filtro
                txtFiltroMarcas.Text = string.Empty;
                ddlEstadoMarcas.SelectedValue = "Todos";

                // Restablecer los estados de los filtros
                chkFiltroNombre.Checked = false;
                chkFiltroEstado.Checked = false;

                // Desactivar los controles de filtro
                txtFiltroMarcas.Enabled = false;
                ddlEstadoMarcas.Enabled = false;
                btnBuscar.Enabled = false;
            }
        }


        //protected void rptMarcas_ItemCommand(object source, RepeaterCommandEventArgs e)
        //{
        //        if (e.CommandName == "Inactivar")
        //        {
        //            int idMarca = Convert.ToInt32(e.CommandArgument);
        //            Marca marcaEliminar = new Marca();
        //            {
        //                marcaEliminar.Id = idMarca;
        //            }
        //            MarcaNegocio negocio = new MarcaNegocio();
        //            negocio.eliminarL(marcaEliminar);
        //            cargarMarcas();
        //        }
        //        else if (e.CommandName == "Activar")
        //        {
        //            int idMarca = Convert.ToInt32(e.CommandArgument);
        //            Marca marcaActivar = new Marca();
        //            {
        //                marcaActivar.Id = idMarca;
        //            }
        //            MarcaNegocio negocio = new MarcaNegocio();
        //            negocio.activar(marcaActivar);
        //            cargarMarcas();
        //        }
        //}

        protected void rptMarcas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int idMarca = Convert.ToInt32(e.CommandArgument);
            MarcaNegocio negocio = new MarcaNegocio();

            if (e.CommandName == "Inactivar")
            {
                // Verificar si la marca tiene productos activos asociados
                if (negocio.tieneProductosActivos(idMarca))
                {
                    // Mostrar un mensaje de error si la marca tiene productos activos
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No se puede inactivar esta marca porque tiene productos activos asociados.');", true);
                    return;
                }

                // Proceder con la inactivación si no hay productos activos asociados
                Marca marcaEliminar = new Marca { Id = idMarca };
                negocio.eliminarL(marcaEliminar);
                cargarMarcas();
            }
            else if (e.CommandName == "Activar")
            {
                Marca marcaActivar = new Marca { Id = idMarca };
                negocio.activar(marcaActivar);
                cargarMarcas();
            }
        }




        protected void btnInactivarModal_Click(object sender, EventArgs e)
        {
            int idMarca = Convert.ToInt32(hdnIdMarca.Value);
            MarcaNegocio negocio = new MarcaNegocio();

            // Verificar si la marca tiene productos activos asociados antes de inactivarla
            if (negocio.tieneProductosActivos(idMarca))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No se puede inactivar esta marca porque tiene productos activos asociados.');", true);
                return;
            }

            Marca marcaEliminar = new Marca { Id = idMarca };
            negocio.eliminarL(marcaEliminar);
            cargarMarcas(); // Actualizar la lista de marcas
        }

        protected void btnActivarModal_Click(object sender, EventArgs e)
        {
            int idMarca = Convert.ToInt32(hdnIdMarca.Value);
            MarcaNegocio negocio = new MarcaNegocio();

            Marca marcaActivar = new Marca { Id = idMarca };
            negocio.activar(marcaActivar);
            cargarMarcas(); // Actualizar la lista de marcas
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

            //cargarMarcas();
            //txtFiltroMarcas.Text = string.Empty;
            //ddlEstadoMarcas.SelectedValue = "Todos";

            // Cargar todas las marcas
            cargarMarcas();

            // Limpiar los controles de filtro
            txtFiltroMarcas.Text = string.Empty;
            ddlEstadoMarcas.SelectedValue = "Todos";

            // Restablecer los estados de los filtros
            chkFiltroNombre.Checked = false;
            chkFiltroEstado.Checked = false;

            // Desactivar los controles de filtro
            txtFiltroMarcas.Enabled = false;
            ddlEstadoMarcas.Enabled = false;
            btnBuscar.Enabled = false;

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

                // Limpiar los controles de filtro
                txtFiltroMarcas.Text = string.Empty;
                ddlEstadoMarcas.SelectedValue = "Todos";

                // Restablecer los estados de los filtros
                chkFiltroNombre.Checked = false;
                chkFiltroEstado.Checked = false;

                // Desactivar los controles de filtro
                txtFiltroMarcas.Enabled = false;
                ddlEstadoMarcas.Enabled = false;
                btnBuscar.Enabled = false;
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


        [System.Web.Services.WebMethod]
        public static string FiltrarMarcas(string filtro)
        {
            try
            {
                // Crear la instancia de MarcaNegocio
                MarcaNegocio negocio = new MarcaNegocio();

                List<Marca> listaFiltrada;

                if (string.IsNullOrEmpty(filtro)) // Si el filtro está vacío, devolver toda la lista
                {
                    listaFiltrada = negocio.listar();
                }
                else
                {
                    // Filtrar la lista de marcas basándonos en el texto ingresado
                    listaFiltrada = negocio.listar()
                        .Where(x => x.NombreMarca.ToLower().Contains(filtro.ToLower())) // Filtrar por nombre
                        .ToList();
                }

                // Generar el HTML para la tabla
                string resultadoHtml = "";
                foreach (var marca in listaFiltrada)
                {
                    resultadoHtml += $"<tr>" +
                                        $"<th scope='row'>{marca.Id}</th>" +
                                        $"<td>{marca.NombreMarca}</td>" +
                                        $"<td>{(marca.Activo ? "Sí" : "No")}</td>" +
                                        $"<td>" +
                                            $"<button type='button' class='btn btn-primary btn-acciones btn-sm' data-bs-toggle='modal' data-bs-target='#modalModificarMarca' " +
                                            $"onclick='cargarDatosModal({marca.Id}, \"{marca.NombreMarca}\")'>" +
                                                $"Modificar" +
                                            $"</button>" +
                                            $"<asp:Button ID='btnEliminar' runat='server' CssClass='btn btn-danger btn-acciones btn-sm' Text='Inactivar' OnClientClick='return confirm(\"¿Estás seguro de que deseas eliminar esta marca?\");' />" +
                                            $"<asp:Button ID='btnActivar' runat='server' CssClass='btn btn-success btn-acciones btn-sm' Text='Activar' OnClientClick='return confirm(\"¿Estás seguro de que deseas activar esta marca?\");' />" +
                                        $"</td>" +
                                     $"</tr>";
                }

                return resultadoHtml; // Devolver el HTML generado
            }
            catch (Exception ex)
            {
                return "Error al filtrar las marcas: " + ex.Message;
            }
        }





    }
}
