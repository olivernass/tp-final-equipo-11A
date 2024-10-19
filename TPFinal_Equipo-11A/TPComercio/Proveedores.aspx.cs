using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPComercio 
{
    public partial class Proveedores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
            rptProveedores.DataSource = listaProveedores;
            rptProveedores.DataBind();
        }

        // Agregar un nuevo Proveedor
        protected void btnGuardarProveedor_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtNombreProveedor.Text))
            {
                Proveedor nuevoProveedor = new Proveedor
                {               
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

                // Limpiar el campo de texto
                txtSiglasProveedor.Text = string.Empty;
                txtNombreProveedor.Text = string.Empty;
                txtDireccionProveedor.Text = string.Empty;
                txtCorreoProveedor.Text = string.Empty;
                txtTelefonoProveedor.Text = string.Empty;

                // Cerrar el modal de agregar Proveedor
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModal", "$('#modalAgregarProveedor').modal('hide');", true);
            }
        }

        // Modificar un Proveedor existente
        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtNombreProveedorMod.Text))
            {
                int idProveedor = int.Parse(hdnIdProveedor.Value); // ID del Proveedor almacenado en el HiddenField

                Proveedor ProveedorModificado = new Proveedor
                {
                    Id = idProveedor,
                    Siglas = txtSiglasProveedor.Text,
                    Nombre = txtNombreProveedorMod.Text,
                    Direccion = txtDireccionProveedorMod.Text,                    
                    Correo = txtCorreoProveedorMod.Text,
                    Telefono = txtTelefonoProveedorMod.Text,
                    //Activo = chkActivoProveedorMod.Checked
                };

                ProveedorNegocio negocio = new ProveedorNegocio();
                negocio.modificar(ProveedorModificado);

                // Recargar la lista de Proveedores
                cargarProveedores();

                // Limpiar los campos del modal de modificación
                hdnIdProveedor.Value = string.Empty;
                txtSiglasProveedorMod.Text = string.Empty;
                txtNombreProveedorMod.Text = string.Empty;
                txtDireccionProveedorMod.Text = string.Empty;                
                txtCorreoProveedorMod.Text = string.Empty;
                txtTelefonoProveedorMod.Text = string.Empty;
                //chkActivoProveedorMod.Checked = false;

                // Cerrar el modal de modificar Proveedor
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarProveedor').modal('hide');", true);
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
    }
}