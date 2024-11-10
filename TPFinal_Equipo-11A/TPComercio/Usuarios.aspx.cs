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
    public partial class Usuarios : System.Web.UI.Page
    {
        public bool FiltroAvanzado { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            FiltroAvanzado = chkAvanzado.Checked;

            if (!IsPostBack)
            {
                cargarUsuarios();
                cargarPermisos(ddlPermisoUsuario);      
                cargarPermisos(ddlPermisoUsuarioMod);    
            }
        }

        // Cargar la lista de Usuarios
        private void cargarUsuarios()
        {
            UsuarioNegocio negocio = new UsuarioNegocio();
            List<Usuario> listaUsuarios = negocio.listarConPermisos(); 
            Session.Add("listaUsuarios", listaUsuarios);
            rptUsuarios.DataSource = listaUsuarios;
            rptUsuarios.DataBind();
        }

        // Limpiar campos del modal
        private void limpiarCampos()
        {
            txtNombreUsuario.Text = string.Empty;
            txtContraseniaUsuario.Text = string.Empty;
            ddlPermisoUsuario.SelectedIndex = 0; // Restablece el DropDownList al primer elemento
        }

        private void limpiarCamposModificacion()
        {
            txtNombreUsuarioMod.Text = string.Empty;
            txtContraseniaUsuarioMod.Text = string.Empty;
            ddlPermisoUsuarioMod.SelectedIndex = 0;
            hdnIdUsuario.Value = string.Empty;
        }

        // Agregar un nuevo Usuario
        protected void btnGuardarUsuario_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtNombreUsuario.Text) ||
                string.IsNullOrEmpty(txtContraseniaUsuario.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Todos los campos son obligatorios.');", true);
                return;
            }

            Usuario nuevoUsuario = new Usuario
            {
                NombreUsuario = txtNombreUsuario.Text,
                Contrasenia = txtContraseniaUsuario.Text,
                Permiso = new Permiso { Id = int.Parse(ddlPermisoUsuario.SelectedValue) },
                Activo = true 
            };

            UsuarioNegocio negocio = new UsuarioNegocio();
            negocio.agregar(nuevoUsuario);
            cargarUsuarios();
            limpiarCampos();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModal", "$('#modalAgregarUsuario').modal('hide');", true);
        }

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtNombreUsuarioMod.Text) ||
                string.IsNullOrEmpty(txtContraseniaUsuarioMod.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Todos los campos son obligatorios.');", true);
                return;
            }

            int idUsuario = Convert.ToInt32(hdnIdUsuario.Value);

            Usuario usuarioModificado = new Usuario
            {
                Id = idUsuario,
                NombreUsuario = txtNombreUsuarioMod.Text,
                Contrasenia = txtContraseniaUsuarioMod.Text,
                Permiso = new Permiso { Id = int.Parse(ddlPermisoUsuarioMod.SelectedValue) }
            };

            UsuarioNegocio negocio = new UsuarioNegocio();
            negocio.modificar(usuarioModificado);
            cargarUsuarios();
            limpiarCamposModificacion();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarUsuario').modal('hide');", true);
        }

        // Eliminar un Usuario
        protected void rptUsuarios_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int idUsuario = Convert.ToInt32(e.CommandArgument);
                Usuario usuarioAEliminar = new Usuario
                {
                    Id = idUsuario
                };
                UsuarioNegocio negocio = new UsuarioNegocio();
                negocio.eliminarL(usuarioAEliminar);
                cargarUsuarios();
            }
        }

        protected void txtFiltroUsuarios_TextChanged(object sender, EventArgs e)
        {
            List<Usuario> lista = (List<Usuario>)Session["listaUsuarios"];
            List<Usuario> listaFiltrada = lista.FindAll(x => x.NombreUsuario.ToUpper().Contains(txtFiltroUsuarios.Text.ToUpper()));
            rptUsuarios.DataSource = listaFiltrada;
            rptUsuarios.DataBind();
        }

        protected void chkAvanzado_CheckedChanged(object sender, EventArgs e)
        {
            FiltroAvanzado = chkAvanzado.Checked;
            txtFiltroUsuarios.Enabled = !FiltroAvanzado;
        }

        protected void ddlCampo_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCriterio.Items.Clear();

            if (ddlCampo.SelectedItem.ToString() == "IDPermiso")
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
                UsuarioNegocio negocio = new UsuarioNegocio();
                rptUsuarios.DataSource = negocio.filtrar(ddlCampo.SelectedItem.ToString(), ddlCriterio.SelectedItem.ToString(), txtFiltroAvanzado.Text, ddlEstado.SelectedItem.ToString());
                rptUsuarios.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex);
                throw;
            }
        }

        private void cargarPermisos(DropDownList ddl)
        {
            PermisoNegocio permisoNegocio = new PermisoNegocio();
            List<Permiso> permisos = permisoNegocio.listar(); // Método que devuelve la lista de permisos
            ddl.DataSource = permisos;
            ddl.DataTextField = "NombrePermiso";
            ddl.DataValueField = "Id";
            ddl.DataBind();
        }
    }
}