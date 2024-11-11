using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPComercio.Utils;

namespace TPComercio
{
    public partial class Proveedores : System.Web.UI.Page
    {
        public bool FiltroAvanzado { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.ValidarAcceso(new List<int> { 1 }, Response, Session);

            FiltroAvanzado = chkAvanzado.Checked;

            if (!IsPostBack)
            {
                cargarProveedores();
            }
        }

        // Cargar la lista de Proveedores
        private void cargarProveedores()
        {
            ProveedorNegocio negocio = new ProveedorNegocio();
            List<Proveedor> listaProveedores = negocio.listar();
            Session.Add("listaProveedores", negocio.listar());
            rptProveedores.DataSource = Session["listaProveedores"];
            //rptProveedores.DataSource = listaProveedores;
            rptProveedores.DataBind();
        }

        // Limpiar campos del modal de agregar
        private void limpiarCampos()
        {
            txtCUITProveedor.Text = string.Empty;
            txtSiglasProveedor.Text = string.Empty;
            txtNombreProveedor.Text = string.Empty;
            txtDireccionProveedor.Text = string.Empty;
            txtCorreoProveedor.Text = string.Empty;
            txtTelefonoProveedor.Text = string.Empty;
        }

        private void limpiarCamposModificacion()
        {
            txtCUITProveedorMod.Text = string.Empty;
            txtSiglasProveedorMod.Text = string.Empty;
            txtNombreProveedorMod.Text = string.Empty;
            txtDireccionProveedorMod.Text = string.Empty;
            txtCorreoProveedorMod.Text = string.Empty;
            txtTelefonoProveedorMod.Text = string.Empty;
            hdnIdProveedor.Value = string.Empty;
        }

        // Agregar un nuevo Proveedor
        //protected void btnGuardarProveedor_Click(object sender, EventArgs e)
        //{
        //    if (!string.IsNullOrEmpty(txtCUITProveedor.Text) && !string.IsNullOrEmpty(txtNombreProveedor.Text))
        //    {
        //        Proveedor nuevoProveedor = new Proveedor
        //        {
        //            CUIT = Convert.ToInt64(txtCUITProveedor.Text),
        //            Siglas = txtSiglasProveedor.Text,
        //            Nombre = txtNombreProveedor.Text,
        //            Direccion = txtDireccionProveedor.Text,
        //            Correo = txtCorreoProveedor.Text,
        //            Telefono = txtTelefonoProveedor.Text
        //        };

        //        ProveedorNegocio negocio = new ProveedorNegocio();
        //        negocio.agregar(nuevoProveedor);

        //        // Recargar la lista de Proveedores para reflejar los cambios
        //        cargarProveedores();

        //        limpiarCampos();

        //        // Cerrar el modal de agregar Proveedor
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModal", "$('#modalAgregarProveedor').modal('hide');", true);
        //    }
        //}

        protected void btnGuardarProveedor_Click(object sender, EventArgs e)
        {
            ProveedorNegocio negocio = new ProveedorNegocio();

            if (!string.IsNullOrEmpty(txtCUITProveedor.Text) && !string.IsNullOrEmpty(txtNombreProveedor.Text))
            {
                // Validar que todos los campos estén llenos
                if (string.IsNullOrEmpty(txtCUITProveedor.Text) ||
                    string.IsNullOrEmpty(txtNombreProveedor.Text) ||
                    string.IsNullOrEmpty(txtDireccionProveedor.Text) ||
                    string.IsNullOrEmpty(txtTelefonoProveedor.Text) ||
                    string.IsNullOrEmpty(txtCorreoProveedor.Text))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Todos los campos son obligatorios.');", true);
                    return;
                }

                // Validar CUIT (solo números)
                if (!Regex.IsMatch(txtCUITProveedor.Text, @"^\d+$"))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El CUIT solo debe contener números.');", true);
                    return;
                }

                // Verificar si el CUIT ya existe en la base de datos
                if (negocio.existeCUITProveedor(Convert.ToInt64(txtCUITProveedor.Text)))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El CUIT ingresado ya está registrado.');", true);
                    return;
                }

                // Validar formato de correo electrónico
                if (!Regex.IsMatch(txtCorreoProveedor.Text, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Correo electrónico no válido.');", true);
                    return;
                }

                // Validar teléfono (solo números)
                if (!Regex.IsMatch(txtTelefonoProveedor.Text, @"^\d+$"))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El teléfono solo debe contener números.');", true);
                    return;
                }

                // Si todas las validaciones son correctas, proceder con la creación del objeto y guardar en base de datos
                Proveedor nuevoProveedor = new Proveedor
                {
                    CUIT = Convert.ToInt64(txtCUITProveedor.Text),
                    Siglas = txtSiglasProveedor.Text,
                    Nombre = txtNombreProveedor.Text,
                    Direccion = txtDireccionProveedor.Text,
                    Correo = txtCorreoProveedor.Text,
                    Telefono = txtTelefonoProveedor.Text
                };

                negocio.agregar(nuevoProveedor);

                cargarProveedores(); // Recargar la lista de proveedores

                limpiarCampos(); // Limpiar los campos de entrada

                // Cerrar el modal de agregar proveedor
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModal", "$('#modalAgregarProveedor').modal('hide');", true);
            }
        }


        // Modificar un Proveedor existente
        //protected void btnGuardarCambios_Click(object sender, EventArgs e)
        //{
        //    if (!string.IsNullOrEmpty(txtCUITProveedorMod.Text) && !string.IsNullOrEmpty(txtNombreProveedorMod.Text))
        //    {
        //        int idProveedor = int.Parse(hdnIdProveedor.Value); // ID del Proveedor almacenado en el HiddenField
        //        long cuitProveedor = Convert.ToInt64(txtCUITProveedorMod.Text);

        //        Proveedor ProveedorModificado = new Proveedor
        //        {
        //            Id = idProveedor,
        //            CUIT = cuitProveedor,
        //            Siglas = txtSiglasProveedorMod.Text,
        //            Nombre = txtNombreProveedorMod.Text,
        //            Direccion = txtDireccionProveedorMod.Text,
        //            Correo = txtCorreoProveedorMod.Text,
        //            Telefono = txtTelefonoProveedorMod.Text,
        //        };

        //        ProveedorNegocio negocio = new ProveedorNegocio();
        //        negocio.modificar(ProveedorModificado);

        //        // Recargar la lista de Proveedores
        //        cargarProveedores();

        //        limpiarCamposModificacion();

        //        // Cerrar el modal de modificar Proveedor
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarProveedor').modal('hide');", true);
        //    }
        //}

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            ProveedorNegocio negocio = new ProveedorNegocio();

            // Validación de los campos del formulario
            if (string.IsNullOrEmpty(txtCUITProveedorMod.Text) ||
                string.IsNullOrEmpty(txtNombreProveedorMod.Text) ||
                string.IsNullOrEmpty(txtDireccionProveedorMod.Text) ||
                string.IsNullOrEmpty(txtTelefonoProveedorMod.Text) ||
                string.IsNullOrEmpty(txtCorreoProveedorMod.Text))
            {
                // Mostrar mensaje de error en caso de campos vacíos
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Todos los campos son obligatorios.');", true);
                return;
            }

            // Validar CUIT (solo números)
            if (!Regex.IsMatch(txtCUITProveedorMod.Text, @"^\d+$"))
            {
                // Mostrar mensaje si el CUIT no contiene solo números
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El CUIT solo debe contener números.');", true);
                return;
            }

            // Obtener el ID del proveedor y el CUIT ingresado
            int idProveedor = Convert.ToInt32(hdnIdProveedor.Value); // ID del proveedor desde el HiddenField
            long cuitProveedor = Convert.ToInt64(txtCUITProveedorMod.Text);

            // Verificar si el CUIT ya existe para otro proveedor
            if (negocio.existeCUITProveedorModificado(cuitProveedor, idProveedor))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El CUIT ingresado ya está registrado para otro proveedor.');", true);
                return;
            }

            // Validar formato de correo electrónico
            if (!Regex.IsMatch(txtCorreoProveedorMod.Text, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Correo electrónico no válido.');", true);
                return;
            }

            // Validar teléfono (solo números)
            if (!Regex.IsMatch(txtTelefonoProveedorMod.Text, @"^\d+$"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El teléfono solo debe contener números.');", true);
                return;
            }

            // Procesar la actualización del proveedor
            try
            {
                Proveedor proveedorModificado = new Proveedor
                {
                    Id = idProveedor, // Usar el ID obtenido del HiddenField
                    CUIT = cuitProveedor,
                    Siglas = txtSiglasProveedorMod.Text,
                    Nombre = txtNombreProveedorMod.Text,
                    Direccion = txtDireccionProveedorMod.Text,
                    Telefono = txtTelefonoProveedorMod.Text,
                    Correo = txtCorreoProveedorMod.Text
                };

                negocio.modificar(proveedorModificado);

                cargarProveedores(); // Recargar la lista de proveedores

                // Cerrar el modal y limpiar campos
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarProveedor').modal('hide');", true);
                limpiarCamposModificacion(); // Limpia los campos después de la actualización
            }
            catch (Exception ex)
            {
                // Manejo de errores
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "alert('Hubo un error al actualizar el proveedor: " + ex.Message + "');", true);
            }
        }


        // Eliminar un Proveedor
        protected void rptProveedores_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Inactivar")
            {
                int idProveedor = Convert.ToInt32(e.CommandArgument);
                Proveedor proveedorEliminar = new Proveedor();
                {
                    proveedorEliminar.Id = idProveedor;
                }
                ProveedorNegocio negocio = new ProveedorNegocio();
                negocio.eliminarL(proveedorEliminar);
                cargarProveedores();
            }
            else if (e.CommandName == "Activar")
            {
                int idProveedor = Convert.ToInt32(e.CommandArgument);
                Proveedor proveedorActivar = new Proveedor();
                {
                    proveedorActivar.Id = idProveedor;
                }
                ProveedorNegocio negocio = new ProveedorNegocio();
                negocio.activar(proveedorActivar);
                cargarProveedores();
            }
        }

        protected void txtFiltroProveedores_TextChanged(object sender, EventArgs e)
        {
            List<Proveedor> lista = (List<Proveedor>)Session["listaProveedores"];
            List<Proveedor> listaFiltrada = lista.FindAll(x => x.Nombre.ToUpper().Contains(txtFiltroProveedores.Text.ToUpper()));
            rptProveedores.DataSource = listaFiltrada;
            rptProveedores.DataBind();
        }

        protected void chkAvanzado_CheckedChanged(object sender, EventArgs e)
        {
            FiltroAvanzado = chkAvanzado.Checked;
            txtFiltroProveedores.Enabled = !FiltroAvanzado;

            if (FiltroAvanzado)
            {
                // Establecer "CUIT" como valor predeterminado en ddlCampo
                ddlCampo.SelectedValue = "CUIT";

                // Llamar al método para actualizar los criterios según el campo seleccionado
                ddlCampo_SelectedIndexChanged(sender, e);

                // Establecer "Igual a" como valor predeterminado en ddlCriterio
                ddlCriterio.SelectedValue = "Igual a";
            }
        }

        protected void ddlCampo_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCriterio.Items.Clear();

            if (ddlCampo.SelectedItem.ToString() == "CUIT")
            {
                ddlCriterio.Items.Add("Igual a");
                ddlCriterio.Items.Add("Menor a");
                ddlCriterio.Items.Add("Mayor a");
            }
            else
            {
                ddlCriterio.Items.Add("Contiene");
                ddlCriterio.Items.Add("Comienza con");
                ddlCriterio.Items.Add("Termina con");
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {

                ProveedorNegocio negocio = new ProveedorNegocio();

                // Verificar si se seleccionó algún criterio o texto de filtro avanzado
                string campo = ddlCampo.SelectedItem.ToString();
                string criterio = ddlCriterio.SelectedItem != null ? ddlCriterio.SelectedItem.ToString() : string.Empty;
                string filtroAvanzado = !string.IsNullOrEmpty(txtFiltroAvanzado.Text) ? txtFiltroAvanzado.Text : string.Empty;
                string estado = ddlEstado.SelectedItem.ToString();

                // Llamar al método filtrar con los parámetros adecuados
                rptProveedores.DataSource = negocio.filtrar(campo, criterio, filtroAvanzado, estado);
                rptProveedores.DataBind();

                //// Limpiar los criterios y el filtro avanzado
                //ddlCriterio.Items.Clear();
                //txtFiltroAvanzado.Text = string.Empty;

                // Limpiar el filtro avanzado
                txtFiltroAvanzado.Text = string.Empty;

                // Restablecer "CUIT" como valor predeterminado en ddlCampo
                ddlCampo.SelectedValue = "CUIT";

                // Llamar al método para actualizar los criterios de "DNI"
                ddlCampo_SelectedIndexChanged(sender, e);

                // Establecer "Igual a" como valor predeterminado en ddlCriterio
                ddlCriterio.SelectedValue = "Igual a";


                //ProveedorNegocio negocio = new ProveedorNegocio();
                //rptProveedores.DataSource = negocio.filtrar(ddlCampo.SelectedItem.ToString(), ddlCriterio.SelectedItem.ToString(), txtFiltroAvanzado.Text, ddlEstado.SelectedItem.ToString());
                //rptProveedores.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex);
                throw;
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            cargarProveedores();
            ddlCriterio.Items.Clear();
            txtFiltroAvanzado.Text = string.Empty;

            //// Establecer valores predeterminados en ddlCampo y ddlEstado
            //ddlCampo.SelectedValue = "CUIT";
            //ddlEstado.SelectedValue = "Todos";

            // Establecer "CUIT" como valor predeterminado en ddlCampo
            ddlCampo.SelectedValue = "CUIT";

            // Llamar a ddlCampo_SelectedIndexChanged para cargar los criterios de "DNI"
            ddlCampo_SelectedIndexChanged(sender, e);

            // Establecer "Igual a" como valor predeterminado en ddlCriterio
            ddlCriterio.SelectedValue = "Igual a";

            // Establecer el estado predeterminado en ddlEstado
            ddlEstado.SelectedValue = "Todos";
        }
    }
}

// Eliminar un Proveedor
//protected void rptProveedores_ItemCommand(object source, RepeaterCommandEventArgs e)
//{
//    if (e.CommandName == "Eliminar")
//    {
//        int idProveedor = Convert.ToInt32(e.CommandArgument);
//        ProveedorNegocio negocio = new ProveedorNegocio();
//        negocio.eliminarL(idProveedor);

//        // Recargar la lista de Proveedores después de eliminar
//        cargarProveedores();
//    }
//}

