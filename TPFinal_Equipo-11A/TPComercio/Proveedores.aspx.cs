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
        protected void btnGuardarProveedor_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtCUITProveedor.Text) && !string.IsNullOrEmpty(txtNombreProveedor.Text))
            {
                Proveedor nuevoProveedor = new Proveedor
                {
                    CUIT = Convert.ToInt64(txtCUITProveedor.Text),
                    Siglas = txtSiglasProveedor.Text,
                    Nombre = txtNombreProveedor.Text,
                    Direccion = txtDireccionProveedor.Text,
                    Correo = txtCorreoProveedor.Text,
                    Telefono = txtTelefonoProveedor.Text
                };

                ProveedorNegocio negocio = new ProveedorNegocio();
                negocio.agregar(nuevoProveedor);

                // Recargar la lista de Proveedores para reflejar los cambios
                cargarProveedores();

                limpiarCampos();

                // Cerrar el modal de agregar Proveedor
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModal", "$('#modalAgregarProveedor').modal('hide');", true);
            }
        }

        // Modificar un Proveedor existente
        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtCUITProveedorMod.Text) && !string.IsNullOrEmpty(txtNombreProveedorMod.Text))
            {
                int idProveedor = int.Parse(hdnIdProveedor.Value); // ID del Proveedor almacenado en el HiddenField
                long cuitProveedor = Convert.ToInt64(txtCUITProveedorMod.Text);

                Proveedor ProveedorModificado = new Proveedor
                {
                    Id = idProveedor,
                    CUIT = cuitProveedor,
                    Siglas = txtSiglasProveedorMod.Text,
                    Nombre = txtNombreProveedorMod.Text,
                    Direccion = txtDireccionProveedorMod.Text,
                    Correo = txtCorreoProveedorMod.Text,
                    Telefono = txtTelefonoProveedorMod.Text,
                };

                ProveedorNegocio negocio = new ProveedorNegocio();
                negocio.modificar(ProveedorModificado);

                // Recargar la lista de Proveedores
                cargarProveedores();

                limpiarCamposModificacion();

                // Cerrar el modal de modificar Proveedor
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarProveedor').modal('hide');", true);
            }
        }

        // Eliminar un Proveedor
        protected void rptProveedores_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int idProveedor = Convert.ToInt32(e.CommandArgument);
                Proveedor proveedorAEliminar = new Proveedor
                {
                    Id = idProveedor
                };
                ProveedorNegocio negocio = new ProveedorNegocio();
                negocio.eliminarL(proveedorAEliminar);
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
                rptProveedores.DataSource = negocio.filtrar(ddlCampo.SelectedItem.ToString(), ddlCriterio.SelectedItem.ToString(), txtFiltroAvanzado.Text, ddlEstado.SelectedItem.ToString());
                rptProveedores.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex);
                throw;
            }
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

