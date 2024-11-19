using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPComercio
{
    public partial class Usuarios : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {


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

            // Cargar todas las marcas
            cargarUsuarios();

            // Limpiar los controles de filtro
            txtFiltroUsuarios.Text = string.Empty;
            ddlEstadoUsuarios.SelectedValue = "Todos";

            // Restablecer los estados de los filtros
            chkFiltroNombre.Checked = false;
            chkFiltroEstado.Checked = false;

            // Desactivar los controles de filtro
            txtFiltroUsuarios.Enabled = false;
            ddlEstadoUsuarios.Enabled = false;
            btnBuscar.Enabled = false;
        }

        private bool validarImagen(string imagenUrl)
        {
            if (string.IsNullOrWhiteSpace(imagenUrl))
                return false;

            string[] imagenExtensionesValidas = { ".jpg", ".jpeg", ".png", ".gif", ".bmp", ".tiff" };
            string extensionImagen = Path.GetExtension(imagenUrl).ToLower();
            return imagenExtensionesValidas.Contains(extensionImagen);
        }

        //// Eliminar un Usuario
        //protected void rptUsuarios_ItemCommand(object source, RepeaterCommandEventArgs e)
        //{
        //    if (e.CommandName == "Eliminar")
        //    {
        //        int idUsuario = Convert.ToInt32(e.CommandArgument);
        //        Usuario usuarioAEliminar = new Usuario { Id = idUsuario };
        //        UsuarioNegocio negocio = new UsuarioNegocio();
        //        negocio.eliminarL(usuarioAEliminar);
        //        cargarUsuarios();
        //    }
        //}

        protected void rptUsuarios_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int idUsuario = Convert.ToInt32(e.CommandArgument);
            UsuarioNegocio negocio = new UsuarioNegocio();

            if (e.CommandName == "Inactivar")
            {


                // Proceder con la inactivación si no hay productos activos asociados
                Usuario usuarioEliminar = new Usuario { Id = idUsuario };
                negocio.eliminarL(usuarioEliminar);
                cargarUsuarios();
            }
            else if (e.CommandName == "Activar")
            {
                Usuario usuarioActivar = new Usuario { Id = idUsuario };
                negocio.activar(usuarioActivar);
                cargarUsuarios();
            }
        }

        protected void btnInactivarModal_Click(object sender, EventArgs e)
        {
            int idUsuario = Convert.ToInt32(hdnIdUsuario.Value);
            UsuarioNegocio negocio = new UsuarioNegocio();



            Usuario usuarioEliminar = new Usuario { Id = idUsuario };
            negocio.eliminarL(usuarioEliminar);
            cargarUsuarios(); // Actualizar la lista de marcas

            // Limpiar los controles de filtro
            txtFiltroUsuarios.Text = string.Empty;
            ddlEstadoUsuarios.SelectedValue = "Todos";

            // Restablecer los estados de los filtros
            chkFiltroNombre.Checked = false;
            chkFiltroEstado.Checked = false;

            // Desactivar los controles de filtro
            txtFiltroUsuarios.Enabled = false;
            ddlEstadoUsuarios.Enabled = false;
            btnBuscar.Enabled = false;
        }

        protected void btnActivarModal_Click(object sender, EventArgs e)
        {
            int idUsuario = Convert.ToInt32(hdnIdUsuario.Value);
            UsuarioNegocio negocio = new UsuarioNegocio();

            Usuario usuarioActivar = new Usuario { Id = idUsuario };
            negocio.activar(usuarioActivar);
            cargarUsuarios(); // Actualizar la lista de marcas

            // Limpiar los controles de filtro
            txtFiltroUsuarios.Text = string.Empty;
            ddlEstadoUsuarios.SelectedValue = "Todos";

            // Restablecer los estados de los filtros
            chkFiltroNombre.Checked = false;
            chkFiltroEstado.Checked = false;

            // Desactivar los controles de filtro
            txtFiltroUsuarios.Enabled = false;
            ddlEstadoUsuarios.Enabled = false;
            btnBuscar.Enabled = false;
        }

        protected void txtFiltroUsuarios_TextChanged(object sender, EventArgs e)
        {
            List<Usuario> lista = (List<Usuario>)Session["listaUsuarios"];
            List<Usuario> listaFiltrada = lista.FindAll(x => x.NombreUsuario.ToUpper().Contains(txtFiltroUsuarios.Text.ToUpper()));
            rptUsuarios.DataSource = listaFiltrada;
            rptUsuarios.DataBind();
        }

        protected void btnBorrar_Click(object sender, EventArgs e)
        {

            //cargarMarcas();
            //txtFiltroMarcas.Text = string.Empty;
            //ddlEstadoMarcas.SelectedValue = "Todos";

            // Cargar todas las marcas
            cargarUsuarios();

            // Limpiar los controles de filtro
            txtFiltroUsuarios.Text = string.Empty;
            ddlEstadoUsuarios.SelectedValue = "Todos";

            // Restablecer los estados de los filtros
            chkFiltroNombre.Checked = false;
            chkFiltroEstado.Checked = false;

            // Desactivar los controles de filtro
            txtFiltroUsuarios.Enabled = false;
            ddlEstadoUsuarios.Enabled = false;
            btnBuscar.Enabled = false;

        }

        //protected void ddlCampo_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    ddlCriterio.Items.Clear();

        //    if (ddlCampo.SelectedItem.ToString() == "IDPermiso")
        //    {
        //        ddlCriterio.Items.Add("Igual a");
        //        ddlCriterio.Items.Add("Menor a");
        //        ddlCriterio.Items.Add("Mayor a");
        //    }
        //    else
        //    {
        //        ddlCriterio.Items.Add("Contiene");
        //        ddlCriterio.Items.Add("Comienza con");
        //        ddlCriterio.Items.Add("Termina con");
        //    }
        //}

        //protected void btnBuscar_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        UsuarioNegocio negocio = new UsuarioNegocio();
        //        rptUsuarios.DataSource = negocio.filtrar(ddlCampo.SelectedItem.ToString(), ddlCriterio.SelectedItem.ToString(), txtFiltroAvanzado.Text, ddlEstado.SelectedItem.ToString());
        //        rptUsuarios.DataBind();
        //    }
        //    catch (Exception ex)
        //    {
        //        Session.Add("Error", ex);
        //        throw;
        //    }
        //}

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                UsuarioNegocio negocio = new UsuarioNegocio();
                rptUsuarios.DataSource = negocio.filtrar(ddlEstadoUsuarios.SelectedItem.ToString());
                rptUsuarios.DataBind();

                // Limpiar los controles de filtro
                txtFiltroUsuarios.Text = string.Empty;
                ddlEstadoUsuarios.SelectedValue = "Todos";

                // Restablecer los estados de los filtros
                chkFiltroNombre.Checked = false;
                chkFiltroEstado.Checked = false;

                // Desactivar los controles de filtro
                txtFiltroUsuarios.Enabled = false;
                ddlEstadoUsuarios.Enabled = false;
                btnBuscar.Enabled = false;
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                throw;
            }
        }

        //       [System.Web.Services.WebMethod]
        //       public static string FiltrarUsuarios(string filtro)
        //       {
        //           try
        //           {
        //               // Crear la instancia de MarcaNegocio
        //               UsuarioNegocio negocio = new UsuarioNegocio();

        //               List<Usuario> listaFiltrada;

        //               if (string.IsNullOrEmpty(filtro)) // Si el filtro está vacío, devolver toda la lista
        //               {
        //                   listaFiltrada = negocio.listarConPermisos();
        //               }
        //               else
        //               {
        //                   // Filtrar la lista de marcas basándonos en el texto ingresado
        //                   listaFiltrada = negocio.listarConPermisos()
        //                       .Where(x => x.NombreUsuario.ToLower().Contains(filtro.ToLower())) // Filtrar por nombre
        //                       .ToList();
        //               }

        //               // Generar el HTML para la tabla
        //               string resultadoHtml = "";
        //               foreach (var usuario in listaFiltrada)
        //               {
        //                   resultadoHtml += $"<tr>" +
        //                                       $"<th scope='row'>{usuario.Id}</th>" +
        //                                       $"<td>{usuario.NombreUsuario}</td>" +
        //                                       $"<td>{(usuario.Activo ? "Sí" : "No")}</td>" +
        //                                       $"<td>" +
        //                                           $"<button type='button' class='btn btn-primary btn-acciones btn-sm' data-bs-toggle='modal' data-bs-target='#modalModificarUsuario' " +
        //                                           $"onclick='cargarDatosModal({usuario.Id}, \"{usuario.Permiso.Id}\", \"{usuario.NombreUsuario}\", \"{usuario.Contrasenia}\", \"{usuario.Nombre}\", \"{usuario.Apellido}\", \"{usuario.CorreoElectronico}\", \"{usuario.Telefono}\", \"{usuario.Imagen.ID}\", \"{usuario.FechaCreacion:yyyy-MM-dd}\", \"{usuario.Activo}\")'>"
        //+
        //                                               $"Modificar" +
        //                                           $"</button>" +
        //                                           $"<asp:Button ID='btnEliminar' runat='server' CssClass='btn btn-danger btn-acciones btn-sm' Text='Inactivar' OnClientClick='return confirm(\"¿Estás seguro de que deseas eliminar este usuario?\");' />" +
        //                                           $"<asp:Button ID='btnActivar' runat='server' CssClass='btn btn-success btn-acciones btn-sm' Text='Activar' OnClientClick='return confirm(\"¿Estás seguro de que deseas activar este usuario?\");' />" +
        //                                       $"</td>" +
        //                                    $"</tr>";
        //               }

        //               return resultadoHtml; // Devolver el HTML generado
        //           }
        //           catch (Exception ex)
        //           {
        //               return "Error al filtrar los usuarios: " + ex.Message;
        //           }
        //       }

        [System.Web.Services.WebMethod]
        public static string FiltrarUsuarios(string filtro)
        {
            try
            {
                // Crear la instancia de UsuarioNegocio
                UsuarioNegocio negocio = new UsuarioNegocio();

                List<Usuario> listaFiltrada;

                if (string.IsNullOrEmpty(filtro)) // Si el filtro está vacío, devolver toda la lista
                {
                    listaFiltrada = negocio.listarConPermisos();
                }
                else
                {
                    // Filtrar la lista de usuarios basándonos en el texto ingresado
                    listaFiltrada = negocio.listarConPermisos()
                        .Where(x => x.NombreUsuario.ToLower().Contains(filtro.ToLower())) // Filtrar por nombre de usuario
                        .ToList();
                }

                // Generar el HTML para las tarjetas de usuario

                string resultadoHtml = "<div>" +
                               "<div id='contenedorUsuarios'>" +
                               "<div class='row g-0'>";

                foreach (var usuario in listaFiltrada)
                {
                    resultadoHtml += $"<div class='containerTarjetas'>" +
                        $"<div class='card user-card'>" +
                                $"<div class='card-header p-0'>" +
                                    $"<img src='{usuario.Imagen.ImagenUrl}' class='card-img-top user-img' alt='Imagen Usuario'>" +
                                $"</div>" +
                                $"<div class='card-body'>" +
                                    $"<h5 class='card-title mb-1'>{usuario.Nombre} {usuario.Apellido}</h5>" +
                                    $"<p class='card-subtitle text-muted mb-2'>{usuario.NombreUsuario}</p>" +
                                    $"<p class='card-text mb-1'>" +
                                        $"<i class='bi bi-envelope'></i>{usuario.CorreoElectronico}<br>" +
                                        $"<i class='bi bi-telephone'></i>{usuario.Telefono}" +
                                    $"</p>" +
                                    $"<div class='tags'>" +
                                        $"<span class='{(usuario.Activo ? "badge bg-success" : "badge bg-danger")}'>" +
                                            $"{(usuario.Activo ? "Activo" : "Inactivo")}" +
                                        $"</span>" +
                                        $"<span class='badge bg-secondary'>{usuario.Permiso.NombrePermiso}</span>" +
                                    $"</div>" +
                                $"</div>" +
                                $"<div class='card-footer d-flex justify-content-between'>" +
                                    $"<button type='button' class='btn btn-info btn-sm' data-bs-toggle='modal' data-bs-target='#modalModificarUsuario'" +
                                    $"onclick='cargarDatosModal({usuario.Id}, \"{usuario.Permiso.Id}\", \"{usuario.NombreUsuario}\", \"{usuario.Contrasenia}\", \"{usuario.Nombre}\", \"{usuario.Apellido}\", \"{usuario.CorreoElectronico}\", \"{usuario.Telefono}\", \"{usuario.Imagen.ImagenUrl}\", \"{usuario.Activo}\")'>" +
                                        $"Modificar" +
                                    $"</button>" +
                                $"</div>" +
                                $"</div>" +
                              $"</div>";

                }

                resultadoHtml += "</div>" +
                          "</div>" + 
                          "</div>";

                return resultadoHtml;
            }
            catch (Exception ex)
            {
                return "Error al filtrar los usuarios: " + ex.Message;
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