using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.IO;
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
            Session["listaUsuarios"] = listaUsuarios;
            rptUsuarios.DataSource = listaUsuarios;
            rptUsuarios.DataBind();
        }

        // Limpiar campos del modal
        private void limpiarCampos()
        {
            txtNombre.Text = txtApellido.Text = txtCorreoElectronico.Text = txtTelefono.Text = txtImagenURL.Text = string.Empty;
            txtNombreUsuario.Text = txtContraseniaUsuario.Text = string.Empty;
            ddlPermisoUsuario.SelectedIndex = 0;
        }

        private void limpiarCamposModificacion()
        {
            txtNombreMod.Text = txtApellidoMod.Text = txtCorreoElectronicoMod.Text = txtTelefonoMod.Text = txtImagenURLMod.Text = string.Empty;
            txtNombreUsuarioMod.Text = txtContraseniaUsuarioMod.Text = string.Empty;
            ddlPermisoUsuarioMod.SelectedIndex = 0;
            hdnIdUsuario.Value = string.Empty;
        }

        // Agregar un nuevo Usuario
        protected void btnGuardarUsuario_Click(object sender, EventArgs e)
        {
            if (!validarImagen(txtImagenURL.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('La URL de la imagen debe tener una extensión válida.');", true);
                return;
            }

            Usuario nuevoUsuario = new Usuario
            {
                NombreUsuario = txtNombreUsuario.Text,
                Contrasenia = txtContraseniaUsuario.Text,
                Nombre = txtNombre.Text,
                Apellido = txtApellido.Text,
                CorreoElectronico = txtCorreoElectronico.Text,
                Telefono = txtTelefono.Text,
                Imagen = new Imagen { ImagenUrl = txtImagenURL.Text },
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
            if (!validarImagen(txtImagenURLMod.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('La URL de la imagen debe tener una extensión válida.');", true);
                return;
            }

            Usuario usuarioModificado = new Usuario
            {
                Id = Convert.ToInt32(hdnIdUsuario.Value),
                NombreUsuario = txtNombreUsuarioMod.Text,
                Contrasenia = txtContraseniaUsuarioMod.Text,
                Nombre = txtNombreMod.Text,
                Apellido = txtApellidoMod.Text,
                CorreoElectronico = txtCorreoElectronicoMod.Text,
                Telefono = txtTelefonoMod.Text,
                Imagen = new Imagen { ImagenUrl = txtImagenURLMod.Text },
                Permiso = new Permiso { Id = int.Parse(ddlPermisoUsuarioMod.SelectedValue) },
                Activo = true
            };

            UsuarioNegocio negocio = new UsuarioNegocio();
            negocio.modificar(usuarioModificado);
            cargarUsuarios();
            limpiarCamposModificacion();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "cerrarModalModificar", "$('#modalModificarUsuario').modal('hide');", true);
        }

        private bool validarImagen(string imagenUrl)
        {
            if (string.IsNullOrWhiteSpace(imagenUrl))
                return false;

            string[] imagenExtensionesValidas = { ".jpg", ".jpeg", ".png", ".gif", ".bmp", ".tiff" };
            string extensionImagen = Path.GetExtension(imagenUrl).ToLower();
            return imagenExtensionesValidas.Contains(extensionImagen);
        }

        // Eliminar un Usuario
        protected void rptUsuarios_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int idUsuario = Convert.ToInt32(e.CommandArgument);
                Usuario usuarioAEliminar = new Usuario { Id = idUsuario };
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
            List<Permiso> permisos = permisoNegocio.listar();
            ddl.DataSource = permisos;
            ddl.DataTextField = "NombrePermiso";
            ddl.DataValueField = "Id";
            ddl.DataBind();
        }


    }
}