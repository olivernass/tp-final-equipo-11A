<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="TPComercio.Proveedores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <div class="containerClientes">
        <h2 class="h2listado">Listado de Proveedores</h2>

        <!-- Botón Agregar Proveedor -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarProveedor">
            Agregar Proveedor       
        </button>
    </div>

    <div class="containerFiltroAv">
        <!-- Filtro Básico -->
        <div class="col-6">
            <div class="mb-3">
                <asp:Label Text="Filtrar por nombre:" runat="server" />
                <asp:CheckBox ID="chkFiltroNombre" runat="server" AutoPostBack="false" OnClick="toggleFiltro('nombre')" />
                <div class="d-flex espacioFiltro">
                    <asp:TextBox runat="server" ID="txtFiltroProveedores" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtFiltroProveedores_TextChanged" />
                    <asp:Button Text="Borrar" runat="server" CssClass="btn btn-primary ms-2" ID="btnBorrar" OnClick="btnBorrar_Click" />
                </div>
            </div>

            <div class="mb-3">
                <asp:Label Text="Filtrar por estado:" runat="server" />
                <asp:CheckBox ID="chkFiltroEstado" runat="server" AutoPostBack="false" OnClick="toggleFiltro('estado')" />
                <div class="d-flex align-items-center">
                    <asp:DropDownList runat="server" ID="ddlEstadoProveedores" CssClass="form-control me-4" Enabled="false">
                        <asp:ListItem Text="Todos" />
                        <asp:ListItem Text="Activo" />
                        <asp:ListItem Text="Inactivo" />
                    </asp:DropDownList>
                    <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary" ID="Button1" OnClick="btnBuscarEstado_Click" Enabled="false" />
                </div>
            </div>

            <div class="col-6" style="display: flex; flex-direction: column; justify-content: flex-end;">
                <div class="mb-3 d-flex align-items-center">
                    <asp:CheckBox Text="" runat="server" CssClass="me-2" ID="chkAvanzado" AutoPostBack="true" OnCheckedChanged="chkAvanzado_CheckedChanged" OnClick="toggleFiltro('avanzado')" />
                    <label for="chkAvanzado">Filtro Avanzado</label>
                </div>
            </div>
        </div>

        <% if (FiltroAvanzado)
            { %>
        <div class="d-flex align-items-center gap-2 mt-3">
            <!-- Campo -->
            <div class="d-flex align-items-center">
                <asp:Label Text="Campo:" ID="lCampo" runat="server" class="me-1" />
                <asp:DropDownList runat="server" AutoPostBack="true" CssClass="form-control me-2" ID="ddlCampo" OnSelectedIndexChanged="ddlCampo_SelectedIndexChanged">
                    <asp:ListItem Text="CUIT" />
                    <asp:ListItem Text="Siglas" />
                    <asp:ListItem Text="Correo" />
                </asp:DropDownList>
            </div>

            <!-- Criterio -->
            <div class="d-flex align-items-center">
                <asp:Label Text="Criterio:" ID="lblCriterio" runat="server" class="me-1" />
                <asp:DropDownList runat="server" CssClass="form-control me-2" ID="ddlCriterio"></asp:DropDownList>
            </div>

            <!-- Filtro -->
            <div class="d-flex align-items-center">
                <asp:Label Text="Filtro:" ID="lblFiltro" runat="server" class="me-1" />
                <asp:TextBox runat="server" ID="txtFiltroAvanzado" CssClass="form-control me-2" />
            </div>

            <!-- Botones -->
            <div class="d-flex align-items-center">
                <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary me-1" ID="btnBuscar" OnClick="btnBuscar_Click" />
                <asp:Button Text="Limpiar" runat="server" CssClass="btn btn-secondary" ID="btnLimpiar" OnClick="btnLimpiar_Click" />
            </div>
        </div>
        <% } %>
    </div>


    <!-- Tabla de Proveedores -->
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <table class="table tableProveedores table-hover mt-3">
                    <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">CUIT</th>
                            <th scope="col">Siglas</th>
                            <th scope="col">Nombre</th>
                            <th scope="col">Direccion</th>
                            <th scope="col">Correo</th>
                            <th scope="col">Telefono</th>
                            <th scope="col">Activo</th>
                            <th scope="col" class="acciones">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptProveedores" runat="server" OnItemCommand="rptProveedores_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <th scope="row"><%# Eval("Id") %></th>
                                    <td><%# Eval("CUIT") %></td>
                                    <td><%# Eval("Siglas") %></td>
                                    <td><%# Eval("Nombre") %></td>
                                    <td><%# Eval("Direccion") %></td>
                                    <td><%# Eval("Correo") %></td>
                                    <td><%# Eval("Telefono") %></td>
                                    <td><%# (bool)Eval("Activo") ? "Sí" : "No" %></td>
                                    <td>
                                        <!-- Botón Modificar -->
                                        <button type="button" class="btn btn-info btn-acciones btn-sm" data-bs-toggle="modal" data-bs-target="#modalModificarProveedores"
                                            onclick="cargarDatosModal('<%# Eval("Id") %>', '<%# Eval("CUIT") %>', '<%# Eval("Siglas") %>', '<%# Eval("Nombre") %>', '<%# Eval("Direccion") %>', '<%# Eval("Correo") %>', '<%# Eval("Telefono") %>', '<%# Eval("Activo") %>')">
                                            Modificar
                                        </button>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>
    </div>


    <!-- Modal Agregar Proveedor -->
    <div class="modal fade" id="modalAgregarProveedor" tabindex="-1" aria-labelledby="modalAgregarProveedorLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAgregarProveedorLabel">Agregar Nuevo Proveedor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtCUITProveedor" runat="server" CssClass="form-control validar-CUIT" placeholder="CUIT"></asp:TextBox>
                        <div class="invalid-feedback">El CUIT es obligatorio y solo debe contener números.</div>
                        <div class="valid-feedback">CUIT válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtSiglasProveedor" runat="server" CssClass="form-control validar-siglas" placeholder="Siglas"></asp:TextBox>
                        <div class="invalid-feedback">Las siglas son obligatorias.</div>
                        <div class="valid-feedback">Siglas válidas.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtNombreProveedor" runat="server" CssClass="form-control validar-nombre" placeholder="Nombre"></asp:TextBox>
                        <div class="invalid-feedback">El nombre es obligatorio.</div>
                        <div class="valid-feedback">Nombre válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtDireccionProveedor" runat="server" CssClass="form-control validar-direccion" placeholder="Dirección"></asp:TextBox>
                        <div class="invalid-feedback">La dirección es obligatoria.</div>
                        <div class="valid-feedback">Dirección válida.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtCorreoProveedor" runat="server" CssClass="form-control validar-correo" placeholder="Correo"></asp:TextBox>
                        <div class="invalid-feedback">Ingresa un correo válido.</div>
                        <div class="valid-feedback">Correo válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtTelefonoProveedor" runat="server" CssClass="form-control validar-telefono" placeholder="Teléfono"></asp:TextBox>
                        <div class="invalid-feedback">El teléfono es obligatorio y solo debe contener números.</div>
                        <div class="valid-feedback">Teléfono válido.</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalAgregarProveedor');">Cerrar</button>
                    <asp:Button ID="btnGuardarProveedor" runat="server" CssClass="btn btn-primary" Text="Guardar Proveedor" OnClientClick="return validarAgregarProveedor();" OnClick="btnGuardarProveedor_Click" />
                </div>
            </div>
        </div>
    </div>


    <!-- Modal Modificar Proveedor -->
    <div class="modal fade" id="modalModificarProveedores" tabindex="-1" aria-labelledby="modalModificarProveedores" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalModificarProveedorLabel">Modificar Proveedor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hdnIdProveedor" runat="server" />
                    <asp:HiddenField ID="hdnEstadoProveedor" runat="server" />

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtCUITProveedorMod" runat="server" CssClass="form-control validar-CUIT-mod" placeholder="CUIT"></asp:TextBox>
                        <div class="invalid-feedback">El CUIT es obligatorio y solo debe contener números.</div>
                        <div class="valid-feedback">CUIT válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtSiglasProveedorMod" runat="server" CssClass="form-control validar-siglas-mod" placeholder="Siglas"></asp:TextBox>
                        <div class="invalid-feedback">Las siglas son obligatorias.</div>
                        <div class="valid-feedback">Siglas válidas.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtNombreProveedorMod" runat="server" CssClass="form-control validar-nombre-mod" placeholder="Nombre"></asp:TextBox>
                        <div class="invalid-feedback">El nombre es obligatorio.</div>
                        <div class="valid-feedback">Nombre válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtDireccionProveedorMod" runat="server" CssClass="form-control validar-direccion-mod" placeholder="Dirección"></asp:TextBox>
                        <div class="invalid-feedback">La dirección es obligatoria.</div>
                        <div class="valid-feedback">Dirección válida.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtCorreoProveedorMod" runat="server" CssClass="form-control validar-correo-mod" placeholder="Correo"></asp:TextBox>
                        <div class="invalid-feedback">Ingresa un correo válido.</div>
                        <div class="valid-feedback">Correo válido.</div>
                    </div>

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtTelefonoProveedorMod" runat="server" CssClass="form-control validar-telefono-mod" placeholder="Teléfono"></asp:TextBox>
                        <div class="invalid-feedback">El teléfono es obligatorio y solo debe contener números.</div>
                        <div class="valid-feedback">Teléfono válido.</div>
                    </div>

                    <!-- Botones Activar e Inactivar dentro del Modal -->
                    <asp:Button ID="btnInactivarModal" runat="server" CssClass="btn btn-danger" Text="Inactivar"
                        OnClientClick="return confirm('¿Estás seguro de que deseas inactivar este proveedor?');" OnClick="btnInactivarModal_Click" />
                    <asp:Button ID="btnActivarModal" runat="server" CssClass="btn btn-success" Text="Activar"
                        OnClientClick="return confirm('¿Estás seguro de que deseas activar este proveedor?');" OnClick="btnActivarModal_Click" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalModificarProveedor');">Cerrar</button>
                    <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-primary" Text="Guardar Cambios" OnClientClick="return validarModificarProveedor();" OnClick="btnGuardarCambios_Click" />
                </div>
            </div>
        </div>
    </div>



    <script type="text/javascript">
        function cargarDatosModal(id, CUIT, siglas, nombre, direccion, correo, telefono, estado) {
            document.getElementById('<%= hdnIdProveedor.ClientID %>').value = id;
            document.getElementById('<%= txtCUITProveedorMod.ClientID %>').value = CUIT;
            document.getElementById('<%= txtSiglasProveedorMod.ClientID %>').value = siglas;
            document.getElementById('<%= txtNombreProveedorMod.ClientID %>').value = nombre;
            document.getElementById('<%= txtDireccionProveedorMod.ClientID %>').value = direccion;
            document.getElementById('<%= txtCorreoProveedorMod.ClientID %>').value = correo;
            document.getElementById('<%= txtTelefonoProveedorMod.ClientID %>').value = telefono;
            document.getElementById('<%= hdnEstadoProveedor.ClientID %>').value = estado;

            // Obtener referencias a los botones
            const btnInactivar = document.getElementById('<%= btnInactivarModal.ClientID %>');
            const btnActivar = document.getElementById('<%= btnActivarModal.ClientID %>');

            // Log para verificar el estado que llega a la función
            console.log("Estado del proveedor:", estado);
            console.log("id del proveedor:", id);
            console.log("nombre del proveedor:", nombre);

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
            // Obtener referencias a los elementos de filtro y sus checkboxes
            var chkFiltroNombre = document.getElementById('<%= chkFiltroNombre.ClientID %>');
            var txtFiltroProveedores = document.getElementById('<%= txtFiltroProveedores.ClientID %>');
            var chkFiltroEstado = document.getElementById('<%= chkFiltroEstado.ClientID %>');
            var ddlEstadoProveedores = document.getElementById('<%= ddlEstadoProveedores.ClientID %>');
            var btnBuscar = document.getElementById('<%= Button1.ClientID %>'); // Botón de búsqueda por estado
            var chkAvanzado = document.getElementById('<%= chkAvanzado.ClientID %>');

            // Desactivar todos los filtros inicialmente
            txtFiltroProveedores.disabled = true;
            ddlEstadoProveedores.disabled = true;
            btnBuscar.disabled = true;

            // Activar solo el filtro seleccionado
            if (filtro === 'nombre') {
                // Activar el filtro por nombre y desactivar los otros
                txtFiltroProveedores.disabled = !chkFiltroNombre.checked;
                ddlEstadoProveedores.disabled = chkFiltroNombre.checked;
                if (!chkAvanzado.checked) {
                    btnBuscar.disabled = chkFiltroNombre.checked;  // Solo deshabilitar el botón si el filtro avanzado no está activado
                }

                // Si el filtro por nombre está activado, desmarcar otros filtros
                if (chkFiltroNombre.checked) {
                    ddlEstadoProveedores.selectedIndex = 0; // Restablecer el filtro de estado a "Todos"
                    chkFiltroEstado.checked = false; // Desmarcar la casilla de estado
                    chkAvanzado.checked = false; // Desmarcar filtro avanzado
                }
            } else if (filtro === 'estado') {
                // Activar el filtro por estado y desactivar los otros
                ddlEstadoProveedores.disabled = !chkFiltroEstado.checked;
                txtFiltroProveedores.disabled = chkFiltroEstado.checked;
                btnBuscar.disabled = !chkFiltroEstado.checked;

                // Si el filtro por estado está activado, desmarcar el filtro por nombre
                if (chkFiltroEstado.checked) {
                    txtFiltroProveedores.value = ''; // Limpiar el campo de texto de filtro de nombre
                    chkFiltroNombre.checked = false; // Desmarcar el filtro por nombre
                    chkAvanzado.checked = false; // Desmarcar filtro avanzado
                }
            } else if (filtro === 'avanzado') {
                // Activar el filtro avanzado y desactivar los otros
                if (chkAvanzado.checked) {
                    chkFiltroNombre.checked = false; // Desmarcar filtro por nombre
                    chkFiltroEstado.checked = false; // Desmarcar filtro por estado
                }
                // El botón de búsqueda siempre permanece habilitado cuando el filtro avanzado está activado
                btnBuscar.disabled = false;
            }
        }
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= txtFiltroProveedores.ClientID %>').on('keyup', function () {
                var filtro = $(this).val(); // Obtener el texto que el usuario escribió en el campo de búsqueda

                $.ajax({
                    type: "POST",
                    url: "Proveedores.aspx/FiltrarProveedores", // Asegúrate de poner la URL correcta
                    data: JSON.stringify({ filtro: filtro }), // Enviar el filtro al servidor
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        // Actualizar el contenido del cuerpo de la tabla con los resultados filtrados
                        $('tbody', '.tableProveedores').html(response.d); // response.d contiene el nuevo HTML generado
                    },
                    error: function (error) {
                        console.log("Error al filtrar los proveedores:", error);
                    }
                });
            });
        });
    </script>

</asp:Content>
