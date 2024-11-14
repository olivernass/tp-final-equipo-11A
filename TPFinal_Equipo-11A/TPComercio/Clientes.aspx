<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="TPComercio.Clientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="containerClientes">
        <h2 class="h2listado">Listado de Clientes</h2>

        <!-- Botón Agregar Cliente -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarCliente">
            Agregar Cliente       
        </button>

        <!-- Sección de Filtro -->
        <div class="col-6">
            <!-- Inserta el código del filtro aquí -->
            <div class="mb-3">
                    <asp:Label Text="Filtrar por nombre:" runat="server" />
                    <asp:CheckBox ID="chkFiltroNombre" runat="server" AutoPostBack="false" OnClick="toggleFiltro('nombre')" />
                <div class="d-flex">
                    <asp:TextBox runat="server" ID="txtFiltroClientes" CssClass="form-control" AutoPostBack="false" OnTextChanged="txtFiltroClientes_TextChanged" />
                    <asp:Button Text="Borrar" runat="server" CssClass="btn btn-primary" ID="btnBorrar" OnClick="btnBorrar_Click"/>
                    </div>
                </div>
            
            

                <!-- Filtro por estado -->
            <asp:Label Text="Filtrar por estado:" runat="server" />
            <asp:CheckBox ID="chkFiltroEstado" runat="server" AutoPostBack="false" OnClick="toggleFiltro('estado')" />
            <asp:DropDownList runat="server" ID="ddlEstadoClientes" CssClass="form-control" Enabled="false">
                <asp:ListItem Text="Todos" />
                <asp:ListItem Text="Activo" />
                <asp:ListItem Text="Inactivo" />
            </asp:DropDownList>

            <!-- Botón Buscar, que solo se activa con el filtro de estado -->
            <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary" ID="Button1" OnClick="btnBuscarEstado_Click" Enabled="false"/>
        </div>


            <div class="col-6" style="display: flex; flex-direction: column; justify-content: flex-end;">
                <div class="mb-3">
                    <asp:CheckBox Text="Filtro Avanzado" runat="server" CssClass="" ID="chkAvanzado" AutoPostBack="true" OnCheckedChanged="chkAvanzado_CheckedChanged" OnClick="toggleFiltro('avanzado')"/>
                </div>
            </div>


            <% if (FiltroAvanzado) { %>
            <div class="col-6">
                <div class="mb-3">
                    <div class="d-flex">
                        <asp:Label Text="Campo" ID="lCampo" runat="server" />
                        <asp:DropDownList runat="server" AutoPostBack="true" CssClass="form-control" ID="ddlCampo" OnSelectedIndexChanged="ddlCampo_SelectedIndexChanged">
                            <asp:ListItem Text="DNI" />
                            <asp:ListItem Text="Apellido" />
                            <asp:ListItem Text="Correo" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-3">
                    <div class="mb-3">
                        <asp:Label Text="Criterio" runat="server" />
                        <asp:DropDownList runat="server" ID="ddlCriterio" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div>
                <div class="col-3">
                    <div class="mb-3">
                        <asp:Label Text="Filtro" runat="server" />
                        <asp:TextBox runat="server" ID="txtFiltroAvanzado" CssClass="form-control" />
                    </div>
                </div>
                <%--<div class="col-3">
                    <div class="mb-3">
                        <asp:Label Text="Estado" runat="server" />
                        <asp:DropDownList runat="server" ID="ddlEstado" CssClass="form-control">
                            <asp:ListItem Text="Todos" />
                            <asp:ListItem Text="Activo" />
                            <asp:ListItem Text="Inactivo" />
                        </asp:DropDownList>
                    </div>
                </div>--%>
            </div>
            <div class="row">
                <div class="col-3">
                    <div class="mb-3">
                        <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary" ID="btnBuscar" OnClick="btnBuscar_Click" />
                        <asp:Button Text="Limpiar" runat="server" CssClass="btn btn-primary" ID="btnLimpiar" OnClick="btnLimpiar_Click"/>
                    </div>
                </div>
            </div>
            <% } %>
        

        
 

    <!-- Tabla de Clientes -->
    <table class="table tableClientes table-hover mt-3">
        <thead>
            <tr>
                <th scope="col">ID</th>
                <th scope="col">DNI</th>
                <th scope="col">Nombre</th>
                <th scope="col">Apellido</th>
                <th scope="col">Direccion</th>
                <th scope="col">Telefono</th>
                <th scope="col">Correo</th>
                <th scope="col">Fecha de Registro</th>
                <th scope="col">Activo</th>
                <th scope="col" class="acciones">Acciones</th>
            </tr>
        </thead>
        <tbody>
            <asp:Repeater ID="rptClientes" runat="server" OnItemCommand="rptClientes_ItemCommand">
                <ItemTemplate>
                    <tr>
                        <th scope="row"><%# Eval("Id") %></th>
                        <td><%# Eval("DNI") %></td>
                        <td><%# Eval("Nombre") %></td>
                        <td><%# Eval("Apellido") %></td>
                        <td><%# Eval("Direccion") %></td>
                        <td><%# Eval("Telefono") %></td>
                        <td><%# Eval("Correo") %></td>
                        <td><%# Eval("Fecha_Alta", "{0:dd/MM/yyyy HH:mm}") %></td>
                        <td><%# (bool)Eval("Activo") ? "Sí" : "No"%></td>
                        <td>
                            <!-- Botón Modificar -->
                            <button type="button" class="btn btn-info btn-acciones btn-sm" data-bs-toggle="modal" data-bs-target="#modalModificarCliente"
                                onclick="cargarDatosModal('<%# Eval("Id") %>', '<%# Eval("DNI") %>', '<%# Eval("Nombre") %>', '<%# Eval("Apellido") %>', '<%# Eval("Direccion") %>', '<%# Eval("Telefono") %>', '<%# Eval("Correo") %>', '<%# Eval("Activo") %>')">
                                Modificar                           
                            </button>

                           <%-- <!-- Botón Eliminar -->
                            <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-danger btn-acciones btn-sm" Text="Eliminar"
                                OnClientClick="return confirm('¿Estás seguro de que deseas eliminar este cliente?');"
                                CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>' />--%>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
    </table>

    <!-- Modal Agregar Cliente -->
    <div class="modal fade" id="modalAgregarCliente" tabindex="-1" aria-labelledby="modalAgregarClienteLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAgregarClienteLabel">Agregar Nuevo Cliente</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">

                    <span class="error-message" id="errorDNI"></span>
                    <asp:TextBox ID="txtDNICliente" runat="server" CssClass="form-control mb-2 validar-DNI" placeholder="DNI"></asp:TextBox>

                    <span class="error-message" id="errorNombre"></span>
                    <asp:TextBox ID="txtNombreCliente" runat="server" CssClass="form-control mb-2 validar-nombre" placeholder="Nombre"></asp:TextBox>

                    <span class="error-message" id="errorApellido"></span>
                    <asp:TextBox ID="txtApellidoCliente" runat="server" CssClass="form-control mb-2 validar-apellido" placeholder="Apellido"></asp:TextBox>

                    <span class="error-message" id="errorDireccion"></span>
                    <asp:TextBox ID="txtDireccionCliente" runat="server" CssClass="form-control mb-2 validar-direccion" placeholder="Dirección"></asp:TextBox>

                    <span class="error-message" id="errorTelefono"></span>
                    <asp:TextBox ID="txtTelefonoCliente" runat="server" CssClass="form-control mb-2 validar-telefono" placeholder="Teléfono"></asp:TextBox>

                    <span class="error-message" id="errorCorreo"></span>
                    <asp:TextBox ID="txtCorreoCliente" runat="server" CssClass="form-control mb-2 validar-correo" placeholder="Correo"></asp:TextBox>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalAgregarCliente');">Cerrar</button>
                    <asp:Button ID="btnGuardarCliente" runat="server" CssClass="btn btn-primary" Text="Guardar Cliente" OnClientClick="return validarAgregarCliente();" OnClick="btnGuardarCliente_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Modificar Cliente -->
    <div class="modal fade" id="modalModificarCliente" tabindex="-1" aria-labelledby="modalModificarClienteLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalModificarClienteLabel">Modificar Cliente</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hdnIdCliente" runat="server" />
                    <asp:HiddenField ID="hdnEstadoCliente" runat="server" />

                    <span class="error-message" id="errorDNIMod"></span>
                    <asp:TextBox ID="txtDNIClienteMod" runat="server" CssClass="form-control mb-2 validar-DNI-mod" placeholder="DNI"></asp:TextBox>

                    <span class="error-message" id="errorNombreMod"></span>
                    <asp:TextBox ID="txtNombreClienteMod" runat="server" CssClass="form-control mb-2 validar-nombre-mod" placeholder="Nombre del Cliente"></asp:TextBox>

                    <span class="error-message" id="errorApellidoMod"></span>
                    <asp:TextBox ID="txtApellidoClienteMod" runat="server" CssClass="form-control mb-2 validar-apellido-mod" placeholder="Apellido del Cliente"></asp:TextBox>

                    <span class="error-message" id="errorDireccionMod"></span>
                    <asp:TextBox ID="txtDireccionClienteMod" runat="server" CssClass="form-control mb-2 validar-direccion-mod" placeholder="Dirección del Cliente"></asp:TextBox>

                    <span class="error-message" id="errorTelefonoMod"></span>
                    <asp:TextBox ID="txtTelefonoClienteMod" runat="server" CssClass="form-control mb-2 validar-telefono-mod" placeholder="Teléfono del Cliente"></asp:TextBox>

                    <span class="error-message" id="errorCorreoMod"></span>
                    <asp:TextBox ID="txtCorreoClienteMod" runat="server" CssClass="form-control mb-2 validar-correo-mod" placeholder="Correo del Cliente"></asp:TextBox>

                    <!-- Botones Activar e Inactivar dentro del Modal -->

                <asp:Button ID="btnInactivarModal" runat="server" CssClass="btn btn-danger" Text="Inactivar"
                            OnClientClick="return confirm('¿Estás seguro de que deseas inactivar este cliente?');" OnClick="btnInactivarModal_Click" />
                <asp:Button ID="btnActivarModal" runat="server" CssClass="btn btn-success" Text="Activar"
                            OnClientClick="return confirm('¿Estás seguro de que deseas activar este cliente?');" OnClick="btnActivarModal_Click" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalModificarCliente');">Cerrar</button>
                    <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-primary" Text="Guardar Cambios" OnClientClick="return validarModificarCliente();" OnClick="btnGuardarCambios_Click" />
                </div>
            </div>
        </div>
    </div>
        </div>


    <script type="text/javascript">
        function cargarDatosModal(id, DNI, nombre, apellido, direccion, telefono, correo, estado) {
            document.getElementById('<%= hdnIdCliente.ClientID %>').value = id;
            document.getElementById('<%= txtDNIClienteMod.ClientID %>').value = DNI;
            document.getElementById('<%= txtNombreClienteMod.ClientID %>').value = nombre;
            document.getElementById('<%= txtApellidoClienteMod.ClientID %>').value = apellido;
            document.getElementById('<%= txtDireccionClienteMod.ClientID %>').value = direccion;
            document.getElementById('<%= txtTelefonoClienteMod.ClientID %>').value = telefono;
            document.getElementById('<%= txtCorreoClienteMod.ClientID %>').value = correo;
            document.getElementById('<%= hdnEstadoCliente.ClientID %>').value = estado;

            // Obtener referencias a los botones
            const btnInactivar = document.getElementById('<%= btnInactivarModal.ClientID %>');
            const btnActivar = document.getElementById('<%= btnActivarModal.ClientID %>');

            // Log para verificar el estado que llega a la función
            console.log("Estado del cliente:", estado);
            console.log("id del cliente:", id);
            console.log("nombre del cliente:", nombre);

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

    <%--<script type="text/javascript">
        function toggleFiltro(filtro) {
            var chkFiltroNombre = document.getElementById('<%= chkFiltroNombre.ClientID %>');
        var txtFiltroClientes = document.getElementById('<%= txtFiltroClientes.ClientID %>');
        var chkFiltroEstado = document.getElementById('<%= chkFiltroEstado.ClientID %>');
    var ddlEstadoClientes = document.getElementById('<%= ddlEstadoClientes.ClientID %>');
    var btnBuscar = document.getElementById('<%= btnBuscar.ClientID %>');

            if (filtro === 'nombre') {
                // Activar el filtro por nombre y desactivar el de estado
                txtFiltroClientes.disabled = !chkFiltroNombre.checked;
                ddlEstadoClientes.disabled = chkFiltroNombre.checked;
                btnBuscar.disabled = chkFiltroNombre.checked;

                if (chkFiltroNombre.checked) {
                    ddlEstadoClientes.selectedIndex = 0; // Restablecer el filtro de estado a "Todos"
                    chkFiltroEstado.checked = false; // Desmarcar la casilla de estado
                }
            } else if (filtro === 'estado') {
                // Activar el filtro por estado y desactivar el de nombre
                ddlEstadoClientes.disabled = !chkFiltroEstado.checked;
                txtFiltroClientes.disabled = chkFiltroEstado.checked;
                btnBuscar.disabled = !chkFiltroEstado.checked;

                if (chkFiltroEstado.checked) {
                    txtFiltroClientes.value = ''; // Limpiar el campo de texto de filtro de nombre
                    chkFiltroNombre.checked = false; // Desmarcar la casilla de nombre
                }
            }
        }
    </script>--%>


    <script type="text/javascript">
        function toggleFiltro(filtro) {
            var chkFiltroNombre = document.getElementById('<%= chkFiltroNombre.ClientID %>');
        var txtFiltroClientes = document.getElementById('<%= txtFiltroClientes.ClientID %>');
        var chkFiltroEstado = document.getElementById('<%= chkFiltroEstado.ClientID %>');
        var ddlEstadoClientes = document.getElementById('<%= ddlEstadoClientes.ClientID %>');
        var btnBuscar = document.getElementById('<%= btnBuscar.ClientID %>');
        var chkFiltroAvanzado = document.getElementById('<%= chkAvanzado.ClientID %>'); // Checkbox del filtro avanzado

            if (filtro === 'nombre') {
                txtFiltroClientes.disabled = !chkFiltroNombre.checked;
                ddlEstadoClientes.disabled = chkFiltroNombre.checked;
                btnBuscar.disabled = chkFiltroNombre.checked;

                if (chkFiltroNombre.checked) {
                    ddlEstadoClientes.selectedIndex = 0;
                    chkFiltroEstado.checked = false;
                    chkAvanzado.checked = false; // Desmarcar filtro avanzado
                }
            } else if (filtro === 'estado') {
                ddlEstadoClientes.disabled = !chkFiltroEstado.checked;
                txtFiltroClientes.disabled = chkFiltroEstado.checked;
                btnBuscar.disabled = !chkFiltroEstado.checked;

                if (chkFiltroEstado.checked) {
                    txtFiltroClientes.value = '';
                    chkFiltroNombre.checked = false;
                    chkAvanzado.checked = false; // Desmarcar filtro avanzado
                }
            } else if (filtro === 'avanzado') {
                btnBuscar.disabled = !chkAvanzado.checked;

                if (chkAvanzado.checked) {
                    chkFiltroNombre.checked = false;
                    chkFiltroEstado.checked = false;
                    txtFiltroClientes.disabled = true; // Desactivar el campo de texto de nombre
                    ddlEstadoClientes.disabled = true; // Desactivar el dropdown de estado
                }
            }
        }
    </script>


    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= txtFiltroClientes.ClientID %>').on('keyup', function () {
            var filtro = $(this).val(); // Obtener el texto que el usuario escribió en el campo de búsqueda

            $.ajax({
                type: "POST",
                url: "Clientes.aspx/FiltrarClientes", // Asegúrate de poner la URL correcta
                data: JSON.stringify({ filtro: filtro }), // Enviar el filtro al servidor
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // Actualizar el contenido del cuerpo de la tabla con los resultados filtrados
                    $('tbody', '.tableClientes').html(response.d); // response.d contiene el nuevo HTML generado
                },
                error: function (error) {
                    console.log("Error al filtrar los clientes:", error);
                }
            });
        });
    });
    </script>

</asp:Content>
