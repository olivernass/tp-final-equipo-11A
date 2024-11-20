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
    public partial class Clientes : System.Web.UI.Page
    {

        public bool FiltroAvanzado { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.ValidarAcceso(new List<int> { 1, 2 }, Response, Session);

            FiltroAvanzado = chkAvanzado.Checked;

            if (!IsPostBack)
            {
                //FiltroAvanzado = chkAvanzado.Checked;
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
            txtDNICliente.Text = string.Empty;
            txtNombreCliente.Text = string.Empty;
            txtApellidoCliente.Text = string.Empty;
            txtDireccionCliente.Text = string.Empty;
            txtTelefonoCliente.Text = string.Empty;
            txtCorreoCliente.Text = string.Empty;
        }

        private void limpiarCamposModificacion()
        {
            txtDNIClienteMod.Text = string.Empty;
            txtNombreClienteMod.Text = string.Empty;
            txtApellidoClienteMod.Text = string.Empty;
            txtDireccionClienteMod.Text = string.Empty;
            txtTelefonoClienteMod.Text = string.Empty;
            txtCorreoClienteMod.Text = string.Empty;
            hdnIdCliente.Value = string.Empty;
        }
      

        protected void btnGuardarCliente_Click(object sender, EventArgs e)
        {
            ClienteNegocio negocio = new ClienteNegocio();

            if (!string.IsNullOrEmpty(txtDNICliente.Text) && !string.IsNullOrEmpty(txtNombreCliente.Text))
            {
                // Validar que todos los campos estén llenos
                if (string.IsNullOrEmpty(txtDNICliente.Text) ||
                    string.IsNullOrEmpty(txtNombreCliente.Text) ||
                    string.IsNullOrEmpty(txtApellidoCliente.Text) ||
                    string.IsNullOrEmpty(txtDireccionCliente.Text) ||
                    string.IsNullOrEmpty(txtTelefonoCliente.Text) ||
                    string.IsNullOrEmpty(txtCorreoCliente.Text))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Todos los campos son obligatorios.');", true);
                    return;
                }

                // Validar DNI (solo números)
                if (!Regex.IsMatch(txtDNICliente.Text, @"^\d+$"))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El DNI solo debe contener números.');", true);
                    return;
                }

                // Verificar si el DNI ya existe en la base de datos
                if (negocio.existeDNICliente(Convert.ToInt32(txtDNICliente.Text)))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El DNI ingresado ya está registrado.');", true);
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
                    DNI = Convert.ToInt32(txtDNICliente.Text),
                    Nombre = txtNombreCliente.Text,
                    Apellido = txtApellidoCliente.Text,
                    Direccion = txtDireccionCliente.Text,
                    Telefono = txtTelefonoCliente.Text,
                    Correo = txtCorreoCliente.Text
                };

                negocio.agregar(nuevoCliente);

                cargarClientes();
                limpiarCampos();

                // Cerrar el modal de agregar cliente
                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModal", "$('#modalAgregarCliente').modal('hide');", true);
            }
        }




        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            ClienteNegocio negocio = new ClienteNegocio();

            // Validación de los campos del formulario
            if (string.IsNullOrEmpty(txtDNIClienteMod.Text) ||
                string.IsNullOrEmpty(txtNombreClienteMod.Text) ||
                string.IsNullOrEmpty(txtApellidoClienteMod.Text) ||
                string.IsNullOrEmpty(txtDireccionClienteMod.Text) ||
                string.IsNullOrEmpty(txtTelefonoClienteMod.Text) ||
                string.IsNullOrEmpty(txtCorreoClienteMod.Text))
            {
                // Mostrar mensaje de error en caso de campos vacíos
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Todos los campos son obligatorios.');", true);
                return;
            }

            if (!Regex.IsMatch(txtDNIClienteMod.Text, @"^\d+$"))
            {
                // Mostrar mensaje si el DNI no contiene solo números
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El DNI solo debe contener números.');", true);
                return;
            }

            // Obtener el ID del cliente y el DNI ingresado
            long idCliente = Convert.ToInt64(hdnIdCliente.Value); // ID del cliente desde el HiddenField
            int dniCliente = Convert.ToInt32(txtDNIClienteMod.Text);

            // Verificar si el DNI ya existe para otro cliente
            if (negocio.existeDNIClienteModificado(dniCliente, idCliente))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El DNI ingresado ya está registrado para otro cliente.');", true);
                return;
            }

            if (!Regex.IsMatch(txtCorreoClienteMod.Text, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Correo electrónico no válido.');", true);
                return;
            }

            if (!Regex.IsMatch(txtTelefonoClienteMod.Text, @"^\d+$"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El teléfono solo debe contener números.');", true);
                return;
            }

            // Procesar la actualización del cliente
            try
            {
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
            if (e.CommandName == "Inactivar")
            {
                long idCliente = Convert.ToInt64(e.CommandArgument);
                Cliente clienteEliminar = new Cliente();
                {
                    clienteEliminar.Id = idCliente;
                }
                ClienteNegocio negocio = new ClienteNegocio();
                negocio.eliminarL(clienteEliminar);
                cargarClientes();
            }
            else if (e.CommandName == "Activar")
            {
                long idCliente = Convert.ToInt64(e.CommandArgument);
                Cliente clienteActivar = new Cliente();
                {
                    clienteActivar.Id = idCliente;
                }
                ClienteNegocio negocio = new ClienteNegocio();
                negocio.activar(clienteActivar);
                cargarClientes();
            }
        }

        protected void btnInactivarModal_Click(object sender, EventArgs e)
        {
            int idCliente = Convert.ToInt32(hdnIdCliente.Value);
            ClienteNegocio negocio = new ClienteNegocio();

            

            Cliente clienteEliminar = new Cliente { Id = idCliente };
            negocio.eliminarL(clienteEliminar);
            cargarClientes(); // Actualizar la lista de marcas

            // Limpiar los controles de filtro
            txtFiltroClientes.Text = string.Empty;
            ddlEstadoClientes.SelectedValue = "Todos";

            // Restablecer los estados de los filtros
            chkFiltroNombre.Checked = false;
            chkFiltroEstado.Checked = false;

            // Desactivar los controles de filtro
            txtFiltroClientes.Enabled = false;
            ddlEstadoClientes.Enabled = false;
            btnBuscar.Enabled = false;
        }

        protected void btnActivarModal_Click(object sender, EventArgs e)
        {
            int idCliente = Convert.ToInt32(hdnIdCliente.Value);
            ClienteNegocio negocio = new ClienteNegocio();

            Cliente clienteActivar = new Cliente { Id = idCliente };
            negocio.activar(clienteActivar);
            cargarClientes(); // Actualizar la lista de marcas

            // Limpiar los controles de filtro
            txtFiltroClientes.Text = string.Empty;
            ddlEstadoClientes.SelectedValue = "Todos";

            // Restablecer los estados de los filtros
            chkFiltroNombre.Checked = false;
            chkFiltroEstado.Checked = false;

            // Desactivar los controles de filtro
            txtFiltroClientes.Enabled = false;
            ddlEstadoClientes.Enabled = false;
            btnBuscar.Enabled = false;
        }

        protected void txtFiltroClientes_TextChanged(object sender, EventArgs e)
        {
            List<Cliente> lista = (List<Cliente>)Session["listaClientes"];
            List<Cliente> listaFiltrada = lista.FindAll(x => x.Nombre.ToUpper().Contains(txtFiltroClientes.Text.ToUpper()));
            rptClientes.DataSource = listaFiltrada;
            rptClientes.DataBind();
        }

        protected void btnBorrar_Click(object sender, EventArgs e)
        {

            //cargarMarcas();
            //txtFiltroMarcas.Text = string.Empty;
            //ddlEstadoMarcas.SelectedValue = "Todos";

            // Cargar todas las marcas
            cargarClientes();

            // Limpiar los controles de filtro
            txtFiltroClientes.Text = string.Empty;
            ddlEstadoClientes.SelectedValue = "Todos";

            // Restablecer los estados de los filtros
            chkFiltroNombre.Checked = false;
            chkFiltroEstado.Checked = false;

            // Desactivar los controles de filtro
            txtFiltroClientes.Enabled = false;
            ddlEstadoClientes.Enabled = false;
            btnBuscar.Enabled = true;

        }

        //protected void chkAvanzado_CheckedChanged(object sender, EventArgs e)
        //{
        //    FiltroAvanzado = chkAvanzado.Checked;
        //    txtFiltroClientes.Enabled = !FiltroAvanzado;
        //    ddlEstadoClientes.Enabled = !FiltroAvanzado;

        //    if (FiltroAvanzado)
        //    {
        //        // Establecer "DNI" como valor predeterminado en ddlCampo
        //        ddlCampo.SelectedValue = "DNI";

        //        // Llamar al método para actualizar los criterios según el campo seleccionado
        //        ddlCampo_SelectedIndexChanged(sender, e);

        //        // Establecer "Igual a" como valor predeterminado en ddlCriterio
        //        ddlCriterio.SelectedValue = "Igual a";
        //    }

        //}


        protected void chkAvanzado_CheckedChanged(object sender, EventArgs e)
        {
            FiltroAvanzado = chkAvanzado.Checked;
            txtFiltroClientes.Enabled = !FiltroAvanzado;
            ddlEstadoClientes.Enabled = !FiltroAvanzado;

            if (FiltroAvanzado)
            {
                // Quita esta línea si quieres que ddlCampo mantenga el valor que el usuario elija.
                 ddlCampo.SelectedValue = "DNI"; 

                // Llamar al método para actualizar los criterios según el campo seleccionado
                ddlCampo_SelectedIndexChanged(sender, e);

                // Establecer "Igual a" como valor predeterminado en ddlCriterio
                ddlCriterio.SelectedValue = "Igual a";
            }
            
        }


        protected void ddlCampo_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCriterio.Items.Clear();

            if (ddlCampo.SelectedItem.ToString() == "DNI")
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

                // Verificar si se seleccionó algún criterio o texto de filtro avanzado
                string campo = ddlCampo.SelectedItem.ToString();
                string criterio = ddlCriterio.SelectedItem != null ? ddlCriterio.SelectedItem.ToString() : string.Empty;
                string filtroAvanzado = !string.IsNullOrEmpty(txtFiltroAvanzado.Text) ? txtFiltroAvanzado.Text : string.Empty;
                

                // Llamar al método filtrar con los parámetros adecuados
                rptClientes.DataSource = negocio.filtrar(campo, criterio, filtroAvanzado);
                rptClientes.DataBind();

                //// Limpiar los criterios y el filtro avanzado
                ddlCriterio.Items.Clear();
                txtFiltroAvanzado.Text = string.Empty;


                // Limpiar el filtro avanzado
                txtFiltroAvanzado.Text = string.Empty;

                // Restablecer "DNI" como valor predeterminado en ddlCampo
                ddlCampo.SelectedValue = "DNI";

                // Llamar al método para actualizar los criterios de "DNI"
                ddlCampo_SelectedIndexChanged(sender, e);

                // Establecer "Igual a" como valor predeterminado en ddlCriterio
                ddlCriterio.SelectedValue = "Igual a";


                //ClienteNegocio negocio = new ClienteNegocio();
                //rptClientes.DataSource = negocio.filtrar(ddlCampo.SelectedItem.ToString(),ddlCriterio.SelectedItem.ToString(),txtFiltroAvanzado.Text);
                //rptClientes.DataBind();

                //ddlCriterio.Items.Clear();
                //txtFiltroAvanzado.Text = string.Empty;
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex);
                throw;
            }
        }

        protected void btnBuscarEstado_Click(object sender, EventArgs e)
        {
            try
            {
                ClienteNegocio negocio = new ClienteNegocio();
                rptClientes.DataSource = negocio.filtrarEstado(ddlEstadoClientes.SelectedItem.ToString());
                rptClientes.DataBind();

                // Limpiar los controles de filtro
                txtFiltroClientes.Text = string.Empty;
                ddlEstadoClientes.SelectedValue = "Todos";

                // Restablecer los estados de los filtros
                chkFiltroNombre.Checked = false;
                chkFiltroEstado.Checked = false;

                // Desactivar los controles de filtro
                txtFiltroClientes.Enabled = false;
                ddlEstadoClientes.Enabled = false;
                btnBuscar.Enabled = false;
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                throw;
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            cargarClientes();
            //ddlCriterio.Items.Clear();
            txtFiltroAvanzado.Text = string.Empty;

            //// Establecer valores predeterminados en ddlCampo y ddlEstado
            //ddlCampo.SelectedValue = "DNI";
            //ddlCriterio.SelectedValue = "Igual a";
            //ddlEstado.SelectedValue = "Todos";

            // Establecer "DNI" como valor predeterminado en ddlCampo
            ddlCampo.SelectedValue = "DNI";

            // Llamar a ddlCampo_SelectedIndexChanged para cargar los criterios de "DNI"
            ddlCampo_SelectedIndexChanged(sender, e);

            // Establecer "Igual a" como valor predeterminado en ddlCriterio
            ddlCriterio.SelectedValue = "Igual a";

            // Establecer el estado predeterminado en ddlEstado
            ddlEstadoClientes.SelectedValue = "Todos";
        }

        [System.Web.Services.WebMethod]
        public static string FiltrarClientes(string filtro)
        {
            try
            {
                // Crear la instancia de MarcaNegocio
                ClienteNegocio negocio = new ClienteNegocio();

                List<Cliente> listaFiltrada;

                if (string.IsNullOrEmpty(filtro)) // Si el filtro está vacío, devolver toda la lista
                {
                    listaFiltrada = negocio.listar();
                }
                else
                {
                    // Filtrar la lista de marcas basándonos en el texto ingresado
                    listaFiltrada = negocio.listar()
                        .Where(x => x.Nombre.ToLower().Contains(filtro.ToLower())) // Filtrar por nombre
                        .ToList();
                }

                // Generar el HTML para la tabla
                string resultadoHtml = "";
                foreach (var cliente in listaFiltrada)
                {
                    resultadoHtml += $"<tr>" +
                                        $"<th scope='row'>{cliente.Id}</th>" +
                                        $"<td>{cliente.DNI}</td>" +
                                        $"<td>{cliente.Nombre}</td>" +
                                        $"<td>{cliente.Apellido}</td>" +
                                        $"<td>{cliente.Direccion}</td>" +
                                        $"<td>{cliente.Telefono}</td>" +
                                        $"<td>{cliente.Correo}</td>" +
                                        $"<td>{cliente.Fecha_Alta.ToString("dd/MM/yyyy HH:mm")}</td>" +
                                        $"<td>{(cliente.Activo ? "Sí" : "No")}</td>" +
                                        $"<td>" +
                                            $"<button type='button' class='btn btn-primary btn-acciones btn-sm' data-bs-toggle='modal' data-bs-target='#modalModificarCliente' " +
                                            $"onclick='cargarDatosModal({cliente.Id}, \"{cliente.DNI}\", \"{cliente.Nombre}\", \"{cliente.Apellido}\", \"{cliente.Direccion}\", \"{cliente.Telefono}\", \"{cliente.Correo}\", \"{cliente.Activo}\")'>"
 +
                                                $"Modificar" +
                                            $"</button>" +
                                            $"<asp:Button ID='btnEliminar' runat='server' CssClass='btn btn-danger btn-acciones btn-sm' Text='Inactivar' OnClientClick='return confirm(\"¿Estás seguro de que deseas eliminar este cliente?\");' />" +
                                            $"<asp:Button ID='btnActivar' runat='server' CssClass='btn btn-success btn-acciones btn-sm' Text='Activar' OnClientClick='return confirm(\"¿Estás seguro de que deseas activar este cliente?\");' />" +
                                        $"</td>" +
                                     $"</tr>";
                }

                return resultadoHtml; // Devolver el HTML generado
            }
            catch (Exception ex)
            {
                return "Error al filtrar los clientes: " + ex.Message;
            }
        }
    }
}