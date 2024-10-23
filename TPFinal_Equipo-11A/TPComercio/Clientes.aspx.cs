using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPComercio
{
    public partial class Clientes : System.Web.UI.Page
    {
        public bool FiltroAvanzado { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            FiltroAvanzado = chkAvanzado.Checked;

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
            Session.Add("listaClientes", negocio.listar());
            rptClientes.DataSource = Session["listaClientes"];
            //rptClientes.DataSource = listaClientes;
            rptClientes.DataBind();
        }

        // Limpiar campos del modal
        private void limpiarCampos()
        {
            txtNombreCliente.Text = string.Empty;
            txtApellidoCliente.Text = string.Empty;
            txtDireccionCliente.Text = string.Empty;
            txtTelefonoCliente.Text = string.Empty;
            txtCorreoCliente.Text = string.Empty;
        }

        private void limpiarCamposModificacion()
        {
            txtNombreClienteMod.Text = string.Empty;
            txtApellidoClienteMod.Text = string.Empty;
            txtDireccionClienteMod.Text = string.Empty;
            txtTelefonoClienteMod.Text = string.Empty;
            txtCorreoClienteMod.Text = string.Empty;
            hdnIdCliente.Value = string.Empty;
        }

        // Agregar un nuevo cliente
        protected void btnGuardarCliente_Click(object sender, EventArgs e)
        {
            // Validar que todos los campos estén llenos
            if (string.IsNullOrEmpty(txtNombreCliente.Text) ||
                string.IsNullOrEmpty(txtApellidoCliente.Text) ||
                string.IsNullOrEmpty(txtDireccionCliente.Text) ||
                string.IsNullOrEmpty(txtTelefonoCliente.Text) ||
                string.IsNullOrEmpty(txtCorreoCliente.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Todos los campos son obligatorios.');", true);
                return;
            }

            // Validar formato de correo electrónico
            if (!Regex.IsMatch(txtCorreoCliente.Text, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Correo electrónico no válido.');", true);
                return;
            }

            // Validar teléfono (solo números)
            if (!Regex.IsMatch(txtTelefonoCliente.Text, @"^\d+$"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El teléfono solo debe contener números.');", true);
                return;
            }

            // Si todas las validaciones son correctas, proceder con la creación del objeto y guardar en base de datos
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


            cargarClientes();

            limpiarCampos();

            // Cerrar el modal de agregar cliente
            ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModal", "$('#modalAgregarCliente').modal('hide');", true);
        }


        //protected void btnGuardarCambios_Click(object sender, EventArgs e)
        //{
        //    if (!string.IsNullOrEmpty(txtNombreClienteMod.Text))
        //    {
        //        int idCliente = int.Parse(hdnIdCliente.Value); // ID del cliente almacenado en el HiddenField

        //        Cliente clienteModificado = new Cliente
        //        {
        //            Id = idCliente,
        //            Nombre = txtNombreClienteMod.Text,
        //            Apellido = txtApellidoClienteMod.Text,
        //            Direccion = txtDireccionClienteMod.Text,
        //            Telefono = txtTelefonoClienteMod.Text,
        //            Correo = txtCorreoClienteMod.Text
        //        };

        //        ClienteNegocio negocio = new ClienteNegocio();
        //        negocio.modificar(clienteModificado);

        //        // Recargar la lista de clientes
        //        cargarClientes();

        //        // Limpiar los campos del modal de modificación
        //        hdnIdCliente.Value = string.Empty;
        //        txtNombreClienteMod.Text = string.Empty;
        //        txtApellidoClienteMod.Text = string.Empty;
        //        txtDireccionClienteMod.Text = string.Empty;
        //        txtTelefonoClienteMod.Text = string.Empty;
        //        txtCorreoClienteMod.Text = string.Empty;

        //        // Cerrar el modal de modificar cliente
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarCliente').modal('hide');", true);
        //    }
        //}

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            // Validación de los campos del formulario
            if (string.IsNullOrEmpty(txtNombreClienteMod.Text) ||
                string.IsNullOrEmpty(txtApellidoClienteMod.Text) ||
                string.IsNullOrEmpty(txtDireccionClienteMod.Text) ||
                string.IsNullOrEmpty(txtTelefonoClienteMod.Text) ||
                string.IsNullOrEmpty(txtCorreoClienteMod.Text))
            {
                // Mostrar mensaje de error en caso de campos vacíos
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Todos los campos son obligatorios.');", true);
                return;
            }

            if (!Regex.IsMatch(txtCorreoClienteMod.Text, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                // Mostrar mensaje si el formato de correo no es válido
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Correo electrónico no válido.');", true);
                return;
            }

            if (!Regex.IsMatch(txtTelefonoClienteMod.Text, @"^\d+$"))
            {
                // Mostrar mensaje si el teléfono no contiene solo números
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El teléfono solo debe contener números.');", true);
                return;
            }

            // Procesar la actualización del cliente
            try
            {
                long idCliente = Convert.ToInt64(hdnIdCliente.Value); // Obtener el ID del cliente desde el HiddenField
                int dniCliente = Convert.ToInt32(txtDNIClienteMod.Text);

                Cliente clienteModificado = new Cliente
                {
                    Id = idCliente, // Usar el ID obtenido del HiddenField
                    DNI = dniCliente,
                    Nombre = txtNombreClienteMod.Text,
                    Apellido = txtApellidoClienteMod.Text,
                    Direccion = txtDireccionClienteMod.Text,
                    Telefono = txtTelefonoClienteMod.Text,
                    Correo = txtCorreoClienteMod.Text
                };

                ClienteNegocio negocio = new ClienteNegocio();
                negocio.modificar(clienteModificado);

                cargarClientes(); // Recargar la lista de clientes

                // Cerrar el modal y limpiar campos
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarCliente').modal('hide');", true);
                limpiarCamposModificacion(); // Limpia los campos después de la actualización
            }
            catch (Exception ex)
            {
                // Manejo de errores
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "alert('Hubo un error al actualizar el cliente: " + ex.Message + "');", true);
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

        protected void txtFiltroClientes_TextChanged(object sender, EventArgs e)
        {
            List<Cliente> lista = (List<Cliente>)Session["listaClientes"];
            List<Cliente> listaFiltrada = lista.FindAll(x => x.Nombre.ToUpper().Contains(txtFiltroClientes.Text.ToUpper()));
            rptClientes.DataSource = listaFiltrada;
            rptClientes.DataBind();
        }

        protected void chkAvanzado_CheckedChanged(object sender, EventArgs e)
        {
            FiltroAvanzado = chkAvanzado.Checked;
            txtFiltroClientes.Enabled = !FiltroAvanzado;
        }

        protected void ddlCampo_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCriterio.Items.Clear();

            if(ddlCampo.SelectedItem.ToString() == "DNI")
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
                ClienteNegocio negocio = new ClienteNegocio();
                rptClientes.DataSource = negocio.filtrar(ddlCampo.SelectedItem.ToString(),ddlCriterio.SelectedItem.ToString(),txtFiltroAvanzado.Text,ddlEstado.SelectedItem.ToString());
                rptClientes.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex);
                throw;
            }
        }
    }
}