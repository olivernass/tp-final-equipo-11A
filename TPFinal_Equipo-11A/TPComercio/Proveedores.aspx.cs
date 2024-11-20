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
            AuthHelper.ValidarAcceso(new List<int> { 1, 2 }, Response, Session);

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
            List<Proveedor> listaProveedores = negocio.listar2();
            Session.Add("listaProveedores", negocio.listar2());
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






        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            ProveedorNegocio negocio = new ProveedorNegocio();


            if (string.IsNullOrEmpty(txtCUITProveedorMod.Text) ||
                string.IsNullOrEmpty(txtSiglasProveedorMod.Text) ||
                string.IsNullOrEmpty(txtNombreProveedorMod.Text) ||
                string.IsNullOrEmpty(txtDireccionProveedorMod.Text) ||
                string.IsNullOrEmpty(txtTelefonoProveedorMod.Text) ||
                string.IsNullOrEmpty(txtCorreoProveedorMod.Text))
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Todos los campos son obligatorios.');", true);
                return;
            }


            if (!Regex.IsMatch(txtCUITProveedorMod.Text, @"^\d+$"))
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El CUIT solo debe contener números.');", true);
                return;
            }


            int idProveedor = Convert.ToInt32(hdnIdProveedor.Value);
            long cuitProveedor = Convert.ToInt64(txtCUITProveedorMod.Text);


            if (negocio.existeCUITProveedorModificado(cuitProveedor, idProveedor))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El CUIT ingresado ya está registrado para otro proveedor.');", true);
                return;
            }


            if (!Regex.IsMatch(txtCorreoProveedorMod.Text, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Correo electrónico no válido.');", true);
                return;
            }


            if (!Regex.IsMatch(txtTelefonoProveedorMod.Text, @"^\d+$"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('El teléfono solo debe contener números.');", true);
                return;
            }


            try
            {
                Proveedor proveedorModificado = new Proveedor
                {
                    Id = idProveedor,
                    CUIT = cuitProveedor,
                    Siglas = txtSiglasProveedorMod.Text,
                    Nombre = txtNombreProveedorMod.Text,
                    Direccion = txtDireccionProveedorMod.Text,
                    Telefono = txtTelefonoProveedorMod.Text,
                    Correo = txtCorreoProveedorMod.Text
                };

                negocio.modificar(proveedorModificado);

                cargarProveedores();


                ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarProveedor').modal('hide');", true);
                limpiarCamposModificacion();
            }
            catch (Exception ex)
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "alert('Hubo un error al actualizar el proveedor: " + ex.Message + "');", true);
            }
        }



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

        protected void btnInactivarModal_Click(object sender, EventArgs e)
        {
            int idProveedor = Convert.ToInt32(hdnIdProveedor.Value);
            ProveedorNegocio negocio = new ProveedorNegocio();



            Proveedor proveedorEliminar = new Proveedor { Id = idProveedor };
            negocio.eliminarL(proveedorEliminar);
            cargarProveedores();


            txtFiltroProveedores.Text = string.Empty;
            ddlEstadoProveedores.SelectedValue = "Todos";


            chkFiltroNombre.Checked = false;
            chkFiltroEstado.Checked = false;


            txtFiltroProveedores.Enabled = false;
            ddlEstadoProveedores.Enabled = false;
            btnBuscar.Enabled = false;
        }

        protected void btnActivarModal_Click(object sender, EventArgs e)
        {
            int idProveedor = Convert.ToInt32(hdnIdProveedor.Value);
            ProveedorNegocio negocio = new ProveedorNegocio();

            Proveedor proveedorActivar = new Proveedor { Id = idProveedor };
            negocio.activar(proveedorActivar);
            cargarProveedores();


            txtFiltroProveedores.Text = string.Empty;
            ddlEstadoProveedores.SelectedValue = "Todos";


            chkFiltroNombre.Checked = false;
            chkFiltroEstado.Checked = false;


            txtFiltroProveedores.Enabled = false;
            ddlEstadoProveedores.Enabled = false;
            btnBuscar.Enabled = false;
        }

        protected void txtFiltroProveedores_TextChanged(object sender, EventArgs e)
        {
            List<Proveedor> lista = (List<Proveedor>)Session["listaProveedores"];
            List<Proveedor> listaFiltrada = lista.FindAll(x => x.Nombre.ToUpper().Contains(txtFiltroProveedores.Text.ToUpper()));
            rptProveedores.DataSource = listaFiltrada;
            rptProveedores.DataBind();
        }

        protected void btnBorrar_Click(object sender, EventArgs e)
        {


            cargarProveedores();


            txtFiltroProveedores.Text = string.Empty;
            ddlEstadoProveedores.SelectedValue = "Todos";


            chkFiltroNombre.Checked = false;
            chkFiltroEstado.Checked = false;


            txtFiltroProveedores.Enabled = false;
            ddlEstadoProveedores.Enabled = false;
            btnBuscar.Enabled = true;

        }

        protected void chkAvanzado_CheckedChanged(object sender, EventArgs e)
        {
            FiltroAvanzado = chkAvanzado.Checked;
            txtFiltroProveedores.Enabled = !FiltroAvanzado;
            ddlEstadoProveedores.Enabled = !FiltroAvanzado;

            if (FiltroAvanzado)
            {

                ddlCampo.SelectedValue = "CUIT";

                ddlCampo_SelectedIndexChanged(sender, e);

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

                
                string campo = ddlCampo.SelectedItem.ToString();
                string criterio = ddlCriterio.SelectedItem != null ? ddlCriterio.SelectedItem.ToString() : string.Empty;
                string filtroAvanzado = !string.IsNullOrEmpty(txtFiltroAvanzado.Text) ? txtFiltroAvanzado.Text : string.Empty;


               
                rptProveedores.DataSource = negocio.filtrar(campo, criterio, filtroAvanzado);
                rptProveedores.DataBind();

           
                ddlCriterio.Items.Clear();
                txtFiltroAvanzado.Text = string.Empty;


                txtFiltroAvanzado.Text = string.Empty;

              
                ddlCampo.SelectedValue = "CUIT";

           
                ddlCampo_SelectedIndexChanged(sender, e);

           
                ddlCriterio.SelectedValue = "Igual a";


           
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
                ProveedorNegocio negocio = new ProveedorNegocio();
                rptProveedores.DataSource = negocio.filtrarEstado(ddlEstadoProveedores.SelectedItem.ToString());
                rptProveedores.DataBind();

               
                txtFiltroProveedores.Text = string.Empty;
                ddlEstadoProveedores.SelectedValue = "Todos";

              
                chkFiltroNombre.Checked = false;
                chkFiltroEstado.Checked = false;

                
                txtFiltroProveedores.Enabled = false;
                ddlEstadoProveedores.Enabled = false;
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
            cargarProveedores();
            
            txtFiltroAvanzado.Text = string.Empty;

 
            ddlCampo.SelectedValue = "CUIT";

            ddlCampo_SelectedIndexChanged(sender, e);

    
            ddlCriterio.SelectedValue = "Igual a";

       
            ddlEstadoProveedores.SelectedValue = "Todos";
        }

        [System.Web.Services.WebMethod]
        public static string FiltrarProveedores(string filtro)
        {
            try
            {
                
                ProveedorNegocio negocio = new ProveedorNegocio();

                List<Proveedor> listaFiltrada;

                if (string.IsNullOrEmpty(filtro)) 
                {
                    listaFiltrada = negocio.listar2();
                }
                else
                {
                    
                    listaFiltrada = negocio.listar2()
                        .Where(x => x.Nombre.ToLower().Contains(filtro.ToLower())) 
                        .ToList();
                }

                // Generar el HTML para la tabla
                string resultadoHtml = "";
                foreach (var proveedor in listaFiltrada)
                {
                    resultadoHtml += $"<tr>" +
                                        $"<th scope='row'>{proveedor.Id}</th>" +
                                        $"<td>{proveedor.CUIT}</td>" +
                                        $"<td>{proveedor.Siglas}</td>" +
                                        $"<td>{proveedor.Nombre}</td>" +
                                        $"<td>{proveedor.Direccion}</td>" +
                                        $"<td>{proveedor.Correo}</td>" +
                                        $"<td>{proveedor.Telefono}</td>" +
                                        $"<td>{(proveedor.Activo ? "Sí" : "No")}</td>" +
                                        $"<td>" +
                                            $"<button type='button' class='btn btn-primary btn-acciones btn-sm' data-bs-toggle='modal' data-bs-target='#modalModificarProveedor' " +
                                            $"onclick='cargarDatosModal({proveedor.Id}, \"{proveedor.CUIT}\", \"{proveedor.Siglas}\", \"{proveedor.Nombre}\", \"{proveedor.Direccion}\", \"{proveedor.Correo}\", \"{proveedor.Telefono}\", \"{proveedor.Activo}\")'>"
 +
                                                $"Modificar" +
                                            $"</button>" +
                                            $"<asp:Button ID='btnEliminar' runat='server' CssClass='btn btn-danger btn-acciones btn-sm' Text='Inactivar' OnClientClick='return confirm(\"¿Estás seguro de que deseas eliminar este proveedor?\");' />" +
                                            $"<asp:Button ID='btnActivar' runat='server' CssClass='btn btn-success btn-acciones btn-sm' Text='Activar' OnClientClick='return confirm(\"¿Estás seguro de que deseas activar este proveedor?\");' />" +
                                        $"</td>" +
                                     $"</tr>";
                }

                return resultadoHtml; // Devolver el HTML generado
            }
            catch (Exception ex)
            {
                return "Error al filtrar los proveedores: " + ex.Message;
            }
        }

        protected void btnGuardarProveedor_Click(object sender, EventArgs e)
        {
            ProveedorNegocio negocio = new ProveedorNegocio();

            if (!string.IsNullOrEmpty(txtCUITProveedor.Text) && !string.IsNullOrEmpty(txtNombreProveedor.Text))
            {
                // Validar que todos los campos estén llenos
                if (string.IsNullOrEmpty(txtCUITProveedor.Text) ||
                    string.IsNullOrEmpty(txtSiglasProveedor.Text) ||
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

