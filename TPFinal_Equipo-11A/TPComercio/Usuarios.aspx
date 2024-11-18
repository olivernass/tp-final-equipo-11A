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
            <!-- Filtro por nombre -->
            <div class="col-6">
                <div class="mb-3">
                    <asp:Label Text="Filtrar por nombre de usuario:" runat="server" />
                    <asp:CheckBox ID="chkFiltroNombre" runat="server" AutoPostBack="false" OnClick="toggleFiltro('nombre')" class="ms-2" />
                </div>
            </div>
            <div class="col-auto mb-3 d-flex align-items-center">
            <asp:TextBox runat="server" ID="txtFiltroUsuarios" CssClass="form-control" AutoPostBack="false" OnTextChanged="txtFiltroUsuarios_TextChanged" Enabled="false" oninput="filtrarUsuarios()"/>
            <asp:Button Text="Borrar" runat="server" CssClass="btn btn-primary" ID="btnBorrar" OnClick="btnBorrar_Click" />
        </div>

                    <!-- Filtro por estado -->
        <div class="col-auto mb-3">
            <asp:Label Text="Filtrar por estado:" runat="server" />
            <asp:CheckBox ID="chkFiltroEstado" runat="server" AutoPostBack="false" OnClick="toggleFiltro('estado')" class="ms-2" />
        </div>
        <div class="col-auto mb-3 d-flex align-items-center">
            <asp:DropDownList runat="server" ID="ddlEstadoUsuarios" CssClass="form-control me-2" Enabled="false">
                <asp:ListItem Text="Todos" />
                <asp:ListItem Text="Activo" />
                <asp:ListItem Text="Inactivo" />
            </asp:DropDownList>
            <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary" ID="btnBuscar" OnClick="btnBuscar_Click" Enabled="false" />
        </div>
    </div>
</div>

    <div class="containerUsuariosCard">
        <div id="contenedorUsuarios">
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
                                    onclick="cargarDatosModal('<%# Eval("Id") %>', '<%# Eval("NombreUsuario") %>', '<%# Eval("Contrasenia") %>', '<%# Eval("Permiso.Id") %>', '<%# Eval("Nombre") %>', '<%# Eval("Apellido") %>', '<%# Eval("CorreoElectronico") %>', '<%# Eval("Telefono") %>', '<%# Eval("Imagen.ImagenUrl") %>', '<%# Eval("Activo") %>')">
                                    Modificar
                                </button>
                                
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
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
                    <asp:HiddenField ID="hdnEstadoUsuario" runat="server" />

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

                    <!-- Botones Activar e Inactivar dentro del Modal -->
                    <asp:Button ID="btnInactivarModal" runat="server" CssClass="btn btn-danger" Text="Inactivar"
                        OnClientClick="return confirm('¿Estás seguro de que deseas inactivar este usuario?');" OnClick="btnInactivarModal_Click" />
                    <asp:Button ID="btnActivarModal" runat="server" CssClass="btn btn-success" Text="Activar"
                        OnClientClick="return confirm('¿Estás seguro de que deseas activar este usuario?');" OnClick="btnActivarModal_Click" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalModificarUsuario');">Cerrar</button>
                    <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-primary" Text="Guardar Cambios"
                        OnClientClick="return validarModificarUsuario();" OnClick="btnGuardarCambios_Click" />
                </div>
            </div>
        </div>
    </div>






    <%--<script type="text/javascript">
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
    </script>--%>

    <script type="text/javascript">
        function cargarDatosModal(id, nombreUsuario, contrasenia, idPermiso, nombre, apellido, correoElectronico, telefono, imagenURL, estado) {
            // Asignar valores a los campos ocultos y de entrada en el modal de modificación
            document.getElementById('<%= hdnIdUsuario.ClientID %>').value = id;
            document.getElementById('<%= txtNombreUsuarioMod.ClientID %>').value = nombreUsuario;
            document.getElementById('<%= txtContraseniaUsuarioMod.ClientID %>').value = contrasenia;
            document.getElementById('<%= ddlPermisoUsuarioMod.ClientID %>').value = idPermiso;
            document.getElementById('<%= txtNombreMod.ClientID %>').value = nombre;
            document.getElementById('<%= txtApellidoMod.ClientID %>').value = apellido;
            document.getElementById('<%= txtCorreoElectronicoMod.ClientID %>').value = correoElectronico;
            document.getElementById('<%= txtTelefonoMod.ClientID %>').value = telefono;
            document.getElementById('<%= txtImagenURLMod.ClientID %>').value = imagenURL;
            document.getElementById('<%= hdnEstadoUsuario.ClientID %>').value = estado;

        // Obtener referencias a los botones
        const btnInactivar = document.getElementById('<%= btnInactivarModal.ClientID %>');
        const btnActivar = document.getElementById('<%= btnActivarModal.ClientID %>');

            // Log para verificar el estado que llega a la función
            console.log("Estado del usuario:", estado);
            console.log("id del usuario:", id);
            console.log("nombre del usuario:", nombre);

            // Mostrar/ocultar botones según el estado
            if (estado === "True") {
                btnInactivar.style.display = 'block';
                btnActivar.style.display = 'none';
            } else if (estado === "False") {
                btnInactivar.style.display = 'none';
                btnActivar.style.display = 'block';
            } else {
                console.warn("Estado desconocido:", estado);
            }
        }
    </script>

    <script type="text/javascript">
        function toggleFiltro(filtro) {
            var chkFiltroNombre = document.getElementById('<%= chkFiltroNombre.ClientID %>');
        var txtFiltroUsuarios = document.getElementById('<%= txtFiltroUsuarios.ClientID %>');
        var chkFiltroEstado = document.getElementById('<%= chkFiltroEstado.ClientID %>');
        var ddlEstadoUsuarios = document.getElementById('<%= ddlEstadoUsuarios.ClientID %>');
        var btnBuscar = document.getElementById('<%= btnBuscar.ClientID %>');

            if (filtro === 'nombre') {
                // Activar el filtro por nombre y desactivar el de estado
                txtFiltroUsuarios.disabled = !chkFiltroNombre.checked;
                ddlEstadoUsuarios.disabled = chkFiltroNombre.checked;
                btnBuscar.disabled = chkFiltroNombre.checked;

                if (chkFiltroNombre.checked) {
                    ddlEstadoUsuarios.selectedIndex = 0; // Restablecer el filtro de estado a "Todos"
                    chkFiltroEstado.checked = false; // Desmarcar la casilla de estado
                }
            } else if (filtro === 'estado') {
                // Activar el filtro por estado y desactivar el de nombre
                ddlEstadoUsuarios.disabled = !chkFiltroEstado.checked;
                txtFiltroUsuarios.disabled = chkFiltroEstado.checked;
                btnBuscar.disabled = !chkFiltroEstado.checked;

                if (chkFiltroEstado.checked) {
                    txtFiltroUsuarios.value = ''; // Limpiar el campo de texto de filtro de nombre
                    chkFiltroNombre.checked = false; // Desmarcar la casilla de nombre
                }
            }
        }
    </script>

    <%--<script type="text/javascript">
        $(document).ready(function () {
            $('#<%= txtFiltroUsuarios.ClientID %>').on('keyup', function () {
            var filtro = $(this).val(); // Obtener el texto que el usuario escribió en el campo de búsqueda

            $.ajax({
                type: "POST",
                url: "Usuarios.aspx/FiltrarUsuarios", // Asegúrate de poner la URL correcta
                data: JSON.stringify({ filtro: filtro }), // Enviar el filtro al servidor
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // Actualizar el contenido del cuerpo de la tabla con los resultados filtrados
                    $('tbody', '.tableUsuarios').html(response.d); // response.d contiene el nuevo HTML generado
                },
                error: function (error) {
                    console.log("Error al filtrar los usuarios:", error);
                }
            });
        });
    });
    </script>--%>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= txtFiltroUsuarios.ClientID %>').on('keyup', function () {
            var filtro = $(this).val(); // Obtener el texto que el usuario escribió en el campo de búsqueda

            $.ajax({
                type: "POST",
                url: "Usuarios.aspx/FiltrarUsuarios", // Asegúrate de poner la URL correcta
                data: JSON.stringify({ filtro: filtro }), // Enviar el filtro al servidor
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // Actualizar el contenedor de tarjetas con los resultados filtrados
                    $('#contenedorUsuarios').html(response.d); // Actualiza el contenedor donde se muestran las tarjetas
                },
                error: function (error) {
                    console.log("Error al filtrar los usuarios:", error);
                }
            });
        });
    });
    </script>


</asp:Content>
