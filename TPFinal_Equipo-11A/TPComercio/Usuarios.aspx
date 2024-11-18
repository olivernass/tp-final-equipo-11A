<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="TPComercio.Usuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="containerClientes">
        <h2 class="h2listado">Listado de Usuarios</h2>
        <!-- Botón Agregar Usuario -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarUsuario">
            Agregar Usuario      
        </button>
    </div>

    <!-- Sección de Filtro -->
    <div class="containerFiltroAv">
        <div class="row">
            <!-- Inserta el código del filtro aquí -->
            <div class="col-6">
                <div class="mb-3">
                    <asp:Label Text="Filtrar por nombre de usuario:" runat="server" />
                    <asp:TextBox runat="server" ID="txtFiltroUsuarios" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtFiltroUsuarios_TextChanged" />
                </div>
            </div>
            <div class="col-6" style="display: flex; flex-direction: column; justify-content: flex-end;">
                <div class="mb-3">
                    <asp:CheckBox Text="Filtro Avanzado" runat="server" CssClass="" ID="chkAvanzado" AutoPostBack="true" OnCheckedChanged="chkAvanzado_CheckedChanged" />
                </div>
            </div>

            <% if (FiltroAvanzado)
                { %>
            <div class="row">
                <div class="col-3">
                    <div class="mb-3">
                        <asp:Label Text="Campo" ID="lCampo" runat="server" />
                        <asp:DropDownList runat="server" AutoPostBack="true" CssClass="form-control" ID="ddlCampo" OnSelectedIndexChanged="ddlCampo_SelectedIndexChanged">
                            <asp:ListItem Text="NombreUsuario" />
                            <asp:ListItem Text="Contrasenia" />
                            <asp:ListItem Text="IDPermiso" />
                            <asp:ListItem Text="Activo" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-3">
                    <div class="mb-3">
                        <asp:Label Text="Criterio" runat="server" />
                        <asp:DropDownList runat="server" ID="ddlCriterio" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-3">
                    <div class="mb-3">
                        <asp:Label Text="Filtro" runat="server" />
                        <asp:TextBox runat="server" ID="txtFiltroAvanzado" CssClass="form-control" />
                    </div>
                </div>
                <div class="col-3">
                    <div class="mb-3">
                        <asp:Label Text="Estado" runat="server" />
                        <asp:DropDownList runat="server" ID="ddlEstado" CssClass="form-control">
                            <asp:ListItem Text="Todos" Value="Todos" />
                            <asp:ListItem Text="Activo" Value="true" />
                            <asp:ListItem Text="Inactivo" Value="false" />
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-3">
                    <div class="mb-3">
                        <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary" ID="btnBuscar" OnClick="btnBuscar_Click" />
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>

    <div class="containerUsuariosCard">
        <div class="row g-0">
            <asp:Repeater ID="rptUsuarios" runat="server" OnItemCommand="rptUsuarios_ItemCommand">
                <ItemTemplate>
                    <div class="containerTarjetas">
                        <div class="card user-card">
                            <!-- Imagen del usuario -->
                            <div class="card-header p-0">
                                <img src='<%# Eval("Imagen.ImagenUrl") %>' class="card-img-top user-img" alt="Imagen Usuario">
                            </div>
                            <!-- Información del usuario -->
                            <div class="card-body">
                                <h5 class="card-title mb-1"><%# Eval("Nombre") %> <%# Eval("Apellido") %></h5>
                                <p class="card-subtitle text-muted mb-2"><%# Eval("NombreUsuario") %></p>
                                <p class="card-text mb-1">
                                    <i class="bi bi-envelope"></i><%# Eval("CorreoElectronico") %><br>
                                    <i class="bi bi-telephone"></i><%# Eval("Telefono") %>
                                </p>
                                <!-- Etiquetas (roles o estados) -->
                                <div class="tags">
                                    <span class='<%# Convert.ToBoolean(Eval("Activo")) ? "badge bg-success" : "badge bg-danger" %>'>
                                        <%# Convert.ToBoolean(Eval("Activo")) ? "Activo" : "Inactivo" %>
                                    </span>
                                    <span class="badge bg-secondary"><%# Eval("Permiso.NombrePermiso") %></span>
                                </div>

                            </div>
                            <!-- Acciones -->
                            <div class="card-footer d-flex justify-content-between">
                                <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#modalModificarUsuario"
                                    onclick="cargarDatosModal('<%# Eval("Id") %>', '<%# Eval("NombreUsuario") %>', '<%# Eval("Contrasenia") %>', '<%# Eval("Permiso.Id") %>', '<%# Eval("Activo") %>', '<%# Eval("Nombre") %>', '<%# Eval("Apellido") %>', '<%# Eval("CorreoElectronico") %>', '<%# Eval("Telefono") %>', '<%# Eval("Imagen.ImagenUrl") %>')">
                                    Modificar
                                </button>
                                <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-danger btn-sm" Text="Eliminar"
                                    OnClientClick="return confirm('¿Estás seguro de que deseas eliminar este usuario?');"
                                    CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>' />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <!-- Modal Agregar Usuario -->
    <div class="modal fade" id="modalAgregarUsuario" tabindex="-1" aria-labelledby="modalAgregarUsuarioLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAgregarUsuarioLabel">Agregar Nuevo Usuario</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control validar-nombre" placeholder="Nombre"></asp:TextBox>
                        <div class="invalid-feedback">El nombre es obligatorio.</div>
                        <div class="valid-feedback">Nombre válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control validar-apellido" placeholder="Apellido"></asp:TextBox>
                        <div class="invalid-feedback">El apellido es obligatorio.</div>
                        <div class="valid-feedback">Apellido válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtCorreoElectronico" runat="server" CssClass="form-control validar-correo" placeholder="Correo Electrónico"></asp:TextBox>
                        <div class="invalid-feedback">Ingresa un correo electrónico válido.</div>
                        <div class="valid-feedback">Correo válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control validar-telefono" placeholder="Teléfono"></asp:TextBox>
                        <div class="invalid-feedback">El teléfono es obligatorio y solo debe contener números.</div>
                        <div class="valid-feedback">Teléfono válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtImagenURL" runat="server" CssClass="form-control validar-imagen" placeholder="URL de la Imagen"></asp:TextBox>
                        <div class="invalid-feedback">Ingresa una URL válida para la imagen.</div>
                        <div class="valid-feedback">URL válida.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtNombreUsuario" runat="server" CssClass="form-control validar-username" placeholder="Nombre de Usuario"></asp:TextBox>
                        <div class="invalid-feedback">El nombre de usuario es obligatorio.</div>
                        <div class="valid-feedback">Nombre de usuario válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtContraseniaUsuario" runat="server" CssClass="form-control validar-password" placeholder="Contraseña" TextMode="Password"></asp:TextBox>
                        <div class="invalid-feedback">La contraseña es obligatoria y debe tener al menos 8 caracteres.</div>
                        <div class="valid-feedback">Contraseña válida.</div>
                    </div>

                    <div class="mb-3">
                        <asp:DropDownList ID="ddlPermisoUsuario" runat="server" CssClass="form-control validar-permisos"></asp:DropDownList>
                        <div class="invalid-feedback">Selecciona un permiso válido.</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalAgregarUsuario');">Cerrar</button>
                    <asp:Button ID="btnGuardarUsuario" runat="server" CssClass="btn btn-primary" Text="Guardar Usuario" OnClientClick="return validarAgregarUsuario();" OnClick="btnGuardarUsuario_Click" />
                </div>
            </div>
        </div>
    </div>




    <!-- Modal Modificar Usuario -->
    <div class="modal fade" id="modalModificarUsuario" tabindex="-1" aria-labelledby="modalModificarUsuarioLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalModificarUsuarioLabel">Modificar Usuario</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hdnIdUsuario" runat="server" />

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtNombreUsuarioMod" runat="server" CssClass="form-control validar-username-mod" placeholder="Nombre de Usuario"></asp:TextBox>
                        <div class="invalid-feedback">El nombre de usuario es obligatorio.</div>
                        <div class="valid-feedback">Nombre de usuario válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtContraseniaUsuarioMod" runat="server" CssClass="form-control validar-password-mod" placeholder="Contraseña" TextMode="Password"></asp:TextBox>
                        <div class="invalid-feedback">La contraseña es obligatoria y debe tener al menos 8 caracteres.</div>
                        <div class="valid-feedback">Contraseña válida.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtNombreMod" runat="server" CssClass="form-control validar-nombre-mod" placeholder="Nombre"></asp:TextBox>
                        <div class="invalid-feedback">El nombre es obligatorio.</div>
                        <div class="valid-feedback">Nombre válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtApellidoMod" runat="server" CssClass="form-control validar-apellido-mod" placeholder="Apellido"></asp:TextBox>
                        <div class="invalid-feedback">El apellido es obligatorio.</div>
                        <div class="valid-feedback">Apellido válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtCorreoElectronicoMod" runat="server" CssClass="form-control validar-correo-mod" placeholder="Correo Electrónico"></asp:TextBox>
                        <div class="invalid-feedback">Ingresa un correo electrónico válido.</div>
                        <div class="valid-feedback">Correo válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtTelefonoMod" runat="server" CssClass="form-control validar-telefono-mod" placeholder="Teléfono"></asp:TextBox>
                        <div class="invalid-feedback">El teléfono es obligatorio y solo debe contener números.</div>
                        <div class="valid-feedback">Teléfono válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtImagenURLMod" runat="server" CssClass="form-control validar-imagen-mod" placeholder="URL de la Imagen"></asp:TextBox>
                        <div class="invalid-feedback">Ingresa una URL válida para la imagen.</div>
                        <div class="valid-feedback">URL válida.</div>
                    </div>

                    <div class="mb-3">
                        <asp:DropDownList ID="ddlPermisoUsuarioMod" runat="server" CssClass="form-control validar-permisos-mod"></asp:DropDownList>
                        <div class="invalid-feedback">Selecciona un permiso válido.</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalModificarUsuario');">Cerrar</button>
                    <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-primary" Text="Guardar Cambios"
                        OnClientClick="return validarModificarUsuario();" OnClick="btnGuardarCambios_Click" />
                </div>
            </div>
        </div>
    </div>






    <script type="text/javascript">
        function cargarDatosModal(id, nombreUsuario, contrasenia, idPermiso, activo, nombre, apellido, correoElectronico, telefono, imagenURL) {
            // Asignar valores a los campos ocultos y de entrada en el modal de modificación
            document.getElementById('<%= hdnIdUsuario.ClientID %>').value = id;
            document.getElementById('<%= txtNombreUsuarioMod.ClientID %>').value = nombreUsuario;
            document.getElementById('<%= txtContraseniaUsuarioMod.ClientID %>').value = contrasenia;
            document.getElementById('<%= ddlPermisoUsuarioMod.ClientID %>').value = idPermiso;

            // Asignar valores a los nuevos campos adicionales
            document.getElementById('<%= txtNombreMod.ClientID %>').value = nombre;
            document.getElementById('<%= txtApellidoMod.ClientID %>').value = apellido;
            document.getElementById('<%= txtCorreoElectronicoMod.ClientID %>').value = correoElectronico;
            document.getElementById('<%= txtTelefonoMod.ClientID %>').value = telefono;
            document.getElementById('<%= txtImagenURLMod.ClientID %>').value = imagenURL;
        }
    </script>
</asp:Content>
