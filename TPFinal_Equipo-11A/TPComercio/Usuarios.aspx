<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="TPComercio.Usuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="containerUsuarios">
        <h2 class="h2listado">Listado de Usuarios</h2>

        <!-- Sección de Filtro -->
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


        <!-- Botón Agregar Usuario -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarUsuario">
            Agregar Usuario      
        </button>
    </div>

    <!-- Tabla de Usuarios -->
    <table class="table tableUsuarios table-hover mt-3">
        <thead>
            <tr>
                <th scope="col">ID</th>
                <th scope="col">Nombre Usuario</th>
                <th scope="col">Contraseña</th>
                <th scope="col">Tipo de permisos</th>
                <th scope="col">Activo</th>
                <th scope="col">Nombre</th>
                <th scope="col">Apellido</th>
                <th scope="col">Correo Electrónico</th>
                <th scope="col">Teléfono</th>
                <th scope="col">Imagen</th>
                <th scope="col" class="acciones">Acciones</th>
            </tr>
        </thead>
        <tbody>
            <asp:Repeater ID="rptUsuarios" runat="server" OnItemCommand="rptUsuarios_ItemCommand">
                <ItemTemplate>
                    <tr>
                        <th scope="row"><%# Eval("Id") %></th>
                        <td><%# Eval("NombreUsuario") %></td>
                        <td><%# Eval("Contrasenia") %></td>
                        <td><%# Eval("Permiso.NombrePermiso") %></td>
                        <td><%# Eval("Activo") %></td>
                        <td><%# Eval("Nombre") %></td>
                        <td><%# Eval("Apellido") %></td>
                        <td><%# Eval("CorreoElectronico") %></td>
                        <td><%# Eval("Telefono") %></td>
                        <td>
                            <img src='<%# Eval("Imagen.ImagenUrl") %>' alt="Imagen Usuario" style="width: 50px; height: auto;" />
                        </td>
                        <td>
                            <!-- Botón Modificar -->
                            <button type="button" class="btn btn-info btn-acciones btn-sm" data-bs-toggle="modal" data-bs-target="#modalModificarUsuario"
                                onclick="cargarDatosModal('<%# Eval("Id") %>', '<%# Eval("NombreUsuario") %>', '<%# Eval("Contrasenia") %>', '<%# Eval("Permiso.Id") %>', '<%# Eval("Activo") %>', '<%# Eval("Nombre") %>', '<%# Eval("Apellido") %>', '<%# Eval("CorreoElectronico") %>', '<%# Eval("Telefono") %>', '<%# Eval("Imagen.ImagenUrl") %>')">
                                Modificar                           
                            </button>

                            <!-- Botón Eliminar -->
                            <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-danger btn-acciones btn-sm" Text="Eliminar"
                                OnClientClick="return confirm('¿Estás seguro de que deseas eliminar este usuario?');"
                                CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>' />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
    </table>


    <!-- Modal Agregar Usuario -->
    <div class="modal fade" id="modalAgregarUsuario" tabindex="-1" aria-labelledby="modalAgregarUsuarioLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAgregarUsuarioLabel">Agregar Nuevo Usuario</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control mb-2" placeholder="Nombre"></asp:TextBox>
                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control mb-2" placeholder="Apellido"></asp:TextBox>
                    <asp:TextBox ID="txtCorreoElectronico" runat="server" CssClass="form-control mb-2" placeholder="Correo Electrónico"></asp:TextBox>
                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control mb-2" placeholder="Teléfono"></asp:TextBox>

                    <!-- TextBox para ingresar la URL de la imagen -->
                    <asp:TextBox ID="txtImagenURL" runat="server" CssClass="form-control mb-2" placeholder="URL de la Imagen"></asp:TextBox>

                    <asp:TextBox ID="txtNombreUsuario" runat="server" CssClass="form-control mb-2" placeholder="Nombre de Usuario"></asp:TextBox>
                    <asp:TextBox ID="txtContraseniaUsuario" runat="server" CssClass="form-control mb-2" placeholder="Contraseña" TextMode="Password"></asp:TextBox>
                    <asp:DropDownList ID="ddlPermisoUsuario" runat="server" CssClass="form-control mb-2"></asp:DropDownList>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalAgregarUsuario');">Cerrar</button>
                    <asp:Button ID="btnGuardarUsuario" runat="server" CssClass="btn btn-primary" Text="Guardar Usuario" OnClick="btnGuardarUsuario_Click" />
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

                    <asp:TextBox ID="txtNombreUsuarioMod" runat="server" CssClass="form-control mb-2" placeholder="Nombre de Usuario"></asp:TextBox>
                    <asp:TextBox ID="txtContraseniaUsuarioMod" runat="server" CssClass="form-control mb-2" placeholder="Contraseña" TextMode="Password"></asp:TextBox>

                    <asp:TextBox ID="txtNombreMod" runat="server" CssClass="form-control mb-2" placeholder="Nombre"></asp:TextBox>
                    <asp:TextBox ID="txtApellidoMod" runat="server" CssClass="form-control mb-2" placeholder="Apellido"></asp:TextBox>
                    <asp:TextBox ID="txtCorreoElectronicoMod" runat="server" CssClass="form-control mb-2" placeholder="Correo Electrónico"></asp:TextBox>
                    <asp:TextBox ID="txtTelefonoMod" runat="server" CssClass="form-control mb-2" placeholder="Teléfono"></asp:TextBox>

                    <!-- TextBox para ingresar la URL de la imagen -->
                    <asp:TextBox ID="txtImagenURLMod" runat="server" CssClass="form-control mb-2" placeholder="URL de la Imagen"></asp:TextBox>

                    <asp:DropDownList ID="ddlPermisoUsuarioMod" runat="server" CssClass="form-control mb-2"></asp:DropDownList>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalModificarUsuario');">Cerrar</button>
                    <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-primary" Text="Guardar Cambios" OnClick="btnGuardarCambios_Click" />
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
