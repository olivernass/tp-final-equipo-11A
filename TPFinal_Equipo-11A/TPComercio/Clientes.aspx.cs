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
    public partial class Clientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarClientes();
            }
        }

        // Cargar la lista de clientes
        private void cargarClientes()
        {
            ClienteNegocio negocio = new ClienteNegocio();
            List<Cliente> listaClientes = negocio.listar();
            rptClientes.DataSource = listaClientes;
            rptClientes.DataBind();
        }

        // Agregar un nuevo cliente
        protected void btnGuardarCliente_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtNombreCliente.Text))
            {
                Cliente nuevoCliente = new Cliente
                {
                    Nombre = txtNombreCliente.Text,
                    Apellido = txtApellidoCliente.Text,
                    Direccion = txtDireccionCliente.Text,
                    Telefono = txtTelefonoCliente.Text,
                    Correo = txtCorreoCliente.Text
                };

                ClienteNegocio negocio = new ClienteNegocio();
                negocio.agregar(nuevoCliente);

                // Recargar la lista de clientes para reflejar los cambios
                cargarClientes();

                // Limpiar el campo de texto
                txtNombreCliente.Text = string.Empty;
                txtApellidoCliente.Text = string.Empty;
                txtDireccionCliente.Text = string.Empty;
                txtTelefonoCliente.Text = string.Empty;
                txtCorreoCliente.Text = string.Empty;

                // Cerrar el modal de agregar cliente
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModal", "$('#modalAgregarCliente').modal('hide');", true);
            }
        }

        // Modificar un cliente existente
        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtNombreClienteMod.Text))
            {
                int idCliente = int.Parse(hdnIdCliente.Value); // ID del cliente almacenado en el HiddenField

                Cliente clienteModificado = new Cliente
                {
                    Id = idCliente,
                    Nombre = txtNombreClienteMod.Text,
                    Apellido = txtApellidoClienteMod.Text,
                    Direccion = txtDireccionClienteMod.Text,
                    Telefono = txtTelefonoClienteMod.Text,
                    Correo = txtCorreoClienteMod.Text
                };

                ClienteNegocio negocio = new ClienteNegocio();
                negocio.modificar(clienteModificado);

                // Recargar la lista de clientes
                cargarClientes();

                // Limpiar los campos del modal de modificación
                hdnIdCliente.Value = string.Empty;
                txtNombreClienteMod.Text = string.Empty;
                txtApellidoClienteMod.Text = string.Empty;
                txtDireccionClienteMod.Text = string.Empty;
                txtTelefonoClienteMod.Text = string.Empty;
                txtCorreoClienteMod.Text = string.Empty;

                // Cerrar el modal de modificar cliente
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarCliente').modal('hide');", true);
            }
        }

        // Eliminar un cliente
        //protected void rptClientes_ItemCommand(object source, RepeaterCommandEventArgs e)
        //{
        //    if (e.CommandName == "Eliminar")
        //    {
        //        int idCliente = Convert.ToInt32(e.CommandArgument);
        //        ClienteNegocio negocio = new ClienteNegocio();
        //        negocio.eliminarL(idCliente);

        //        // Recargar la lista de clientes después de eliminar
        //        cargarClientes();
        //    }
        //}

        protected void rptClientes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int idCliente = Convert.ToInt32(e.CommandArgument);
                Cliente clienteAEliminar = new Cliente
                {
                    Id = idCliente
                };
                ClienteNegocio negocio = new ClienteNegocio();
                negocio.eliminarL(clienteAEliminar);
                cargarClientes();
            }
        }


    }
}