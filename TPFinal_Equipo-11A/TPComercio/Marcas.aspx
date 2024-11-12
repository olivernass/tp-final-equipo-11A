<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Marcas.aspx.cs" Inherits="TPComercio.Marcas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="containerMarcas">
        <h2 class="h2listado">Listado de Marcas</h2>

        <!-- Botón Agregar Marca -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarMarca">
            Agregar Marca       
        </button>

        <!-- Filtro -->
        <%--<div class="col-6">
            <div class="mb-3">
                <asp:Label Text="Filtrar por nombre:" runat="server" />
                <div class="d-flex">
                <asp:TextBox runat="server" ID="txtFiltroMarcas" CssClass="form-control me-2" AutoPostBack="true" OnTextChanged="txtFiltroMarcas_TextChanged" />
                    <asp:Button Text="Borrar" runat="server" CssClass="btn btn-primary" ID="btnBorrar" OnClick="btnBorrar_Click"/>
                </div>
            </div>
            <asp:Label Text="Filtrar por estado:" runat="server" />
            <%--<asp:DropDownList runat="server" ID="ddlEstadoMarcas" CssClass="form-control" OnSelectedIndexChanged="ddlEstadoMarcas_SelectedIndexChanged" />
                <asp:ListItem Text="Todos" />
                <asp:ListItem Text="Activo" />
                <asp:ListItem Text="Inactivo" />
            </asp:DropDownList>--%>
            <%--<asp:DropDownList runat="server" ID="ddlEstadoMarcas" CssClass="form-control" >
                <asp:ListItem Text="Todos" />
                <asp:ListItem Text="Activo" />
                <asp:ListItem Text="Inactivo" />
            </asp:DropDownList>
        </div>
        
            <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary" ID="btnBuscar" OnClick="btnBuscar_Click"/>--%>

<%--        <!-- Filtro -->
        <div class="col-6">
            <!-- Filtro por nombre -->
            <div class="mb-3">
                <asp:Label Text="Filtrar por nombre:" runat="server" />
                <asp:CheckBox ID="chkFiltroNombre" runat="server" AutoPostBack="false" OnClick="toggleFiltro('nombre')" />
                <div class="d-flex">
                    <asp:TextBox runat="server" ID="txtFiltroMarcas" CssClass="form-control me-2" AutoPostBack="true" OnTextChanged="txtFiltroMarcas_TextChanged" Enabled="false" />
                    <asp:Button Text="Borrar" runat="server" CssClass="btn btn-primary" ID="btnBorrar" OnClick="btnBorrar_Click"/>
                </div>
            </div>
    
            <!-- Filtro por estado -->
            <asp:Label Text="Filtrar por estado:" runat="server" />
            <asp:CheckBox ID="chkFiltroEstado" runat="server" AutoPostBack="false" OnClick="toggleFiltro('estado')" />
            <asp:DropDownList runat="server" ID="ddlEstadoMarcas" CssClass="form-control" Enabled="false">
                <asp:ListItem Text="Todos" />
                <asp:ListItem Text="Activo" />
                <asp:ListItem Text="Inactivo" />
            </asp:DropDownList>

            <!-- Botón Buscar, que solo se activa con el filtro de estado -->
            <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary" ID="btnBuscar" OnClick="btnBuscar_Click" Enabled="false"/>
        </div>--%>


        <!-- Filtro -->
        <div class="col-6">
            <!-- Filtro por nombre -->
            <div class="mb-3">
                <asp:Label Text="Filtrar por nombre:" runat="server" />
                <asp:CheckBox ID="chkFiltroNombre" runat="server" AutoPostBack="false" OnClick="toggleFiltro('nombre')" />
                <div class="d-flex">
                    <asp:TextBox runat="server" ID="txtFiltroMarcas" CssClass="form-control me-2" AutoPostBack="true" OnTextChanged="txtFiltroMarcas_TextChanged" Enabled="false" />
                    <asp:Button Text="Borrar" runat="server" CssClass="btn btn-primary" ID="btnBorrar" OnClick="btnBorrar_Click"/>
                </div>
            </div>
    
            <!-- Filtro por estado -->
            <asp:Label Text="Filtrar por estado:" runat="server" />
            <asp:CheckBox ID="chkFiltroEstado" runat="server" AutoPostBack="false" OnClick="toggleFiltro('estado')" />
            <asp:DropDownList runat="server" ID="ddlEstadoMarcas" CssClass="form-control" Enabled="false">
                <asp:ListItem Text="Todos" />
                <asp:ListItem Text="Activo" />
                <asp:ListItem Text="Inactivo" />
            </asp:DropDownList>

            <!-- Botón Buscar, que solo se activa con el filtro de estado -->
            <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary" ID="btnBuscar" OnClick="btnBuscar_Click" Enabled="false"/>
        </div>




        <!-- Tabla de Marcas -->
        <table class="table tableMarcas table-hover mt-3">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Marca</th>
                    <th scope="col">Activo</th>
                    <th scope="col" class="acciones">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptMarcas" runat="server" OnItemCommand="rptMarcas_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <th scope="row"><%# Eval("Id") %></th>
                            <td><%# Eval("NombreMarca") %></td>
                            <td><%# (bool)Eval("Activo") ? "Sí" : "No"%></td>
                            <td>
                                <!-- Botón Modificar -->
                                <button type="button" class="btn btn-secondary btn-acciones btn-sm" data-bs-toggle="modal" data-bs-target="#modalModificarMarca"
                                    onclick="cargarDatosModal('<%# Eval("Id") %>', '<%# Eval("NombreMarca") %>')">
                                    <img src="Content/Iconos/settings.png" alt="Detalle">
                                </button>

                                <!-- Botón Inactivar -->
                                <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-danger btn-acciones btn-sm" Text="Inactivar"
                                    OnClientClick="return confirm('¿Estás seguro de que deseas eliminar esta marca?');"
                                    CommandName="Inactivar" CommandArgument='<%# Eval("Id") %>' />

                                <!-- Se deben bloquear uno o el otro al momento de estar ya inactivos o activos -->

                                <!-- Botón Activar -->
                                <asp:Button ID="btnActivar" runat="server" CssClass="btn btn-success btn-acciones btn-sm" Text="Activar"
                                    OnClientClick="return confirm('¿Estás seguro de que deseas activar este marca?');"
                                    CommandName="Activar" CommandArgument='<%# Eval("Id") %>' />

                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>

    <!-- Modal Agregar Marca -->
    <div class="modal fade" id="modalAgregarMarca" tabindex="-1" aria-labelledby="modalAgregarMarcaLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAgregarMarcaLabel">Agregar Nueva Marca</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <span class="error-message" id="errorNombreMarca"></span>
                    <asp:TextBox ID="txtNombreMarca" runat="server" CssClass="form-control validar-nombre" placeholder="Nombre de la Marca"></asp:TextBox>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalAgregarMarca');">Cerrar</button>
                    <asp:Button ID="btnGuardarMarca" runat="server" CssClass="btn btn-primary" Text="Guardar Marca"
                        OnClientClick="return validarAgregarMarca();" OnClick="btnGuardarMarca_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Modificar Marca -->
    <div class="modal fade" id="modalModificarMarca" tabindex="-1" aria-labelledby="modalModificarMarcaLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalModificarMarcaLabel">Modificar Marca</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hdnIdMarca" runat="server" />
                    <span class="error-message" id="errorNombreMarcaMod"></span>
                    <asp:TextBox ID="txtNombreMarcaMod" runat="server" CssClass="form-control validar-nombre-mod" placeholder="Nombre de la Marca"></asp:TextBox>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalModificarMarca');">Cerrar</button>
                    <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-primary" Text="Guardar Cambios"
                        OnClientClick="return validarModificarMarca();" OnClick="btnGuardarCambios_Click" />
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function cargarDatosModal(id, nombre) {
            document.getElementById('<%= hdnIdMarca.ClientID %>').value = id;
            document.getElementById('<%= txtNombreMarcaMod.ClientID %>').value = nombre;
        }
    </script>

    <%--<script type="text/javascript">
        function toggleFiltro(filtro) {
            var chkFiltroNombre = document.getElementById('<%= chkFiltroNombre.ClientID %>');
        var txtFiltroMarcas = document.getElementById('<%= txtFiltroMarcas.ClientID %>');
        var chkFiltroEstado = document.getElementById('<%= chkFiltroEstado.ClientID %>');
        var ddlEstadoMarcas = document.getElementById('<%= ddlEstadoMarcas.ClientID %>');
        var btnBuscar = document.getElementById('<%= btnBuscar.ClientID %>');

            if (filtro === 'nombre') {
                txtFiltroMarcas.disabled = !chkFiltroNombre.checked;
                ddlEstadoMarcas.disabled = chkFiltroNombre.checked;
                btnBuscar.disabled = chkFiltroNombre.checked; // Deshabilita "Buscar" cuando se selecciona el filtro por nombre
                chkFiltroEstado.checked = false; // Desmarcar la casilla de estado si se activa el filtro de nombre
            } else if (filtro === 'estado') {
                ddlEstadoMarcas.disabled = !chkFiltroEstado.checked;
                txtFiltroMarcas.disabled = chkFiltroEstado.checked;
                btnBuscar.disabled = !chkFiltroEstado.checked; // Habilita "Buscar" solo cuando el filtro de estado está seleccionado
                chkFiltroNombre.checked = false; // Desmarcar la casilla de nombre si se activa el filtro de estado
            }
        }
    </script>--%>


    <script type="text/javascript">
        function toggleFiltro(filtro) {
            var chkFiltroNombre = document.getElementById('<%= chkFiltroNombre.ClientID %>');
        var txtFiltroMarcas = document.getElementById('<%= txtFiltroMarcas.ClientID %>');
        var chkFiltroEstado = document.getElementById('<%= chkFiltroEstado.ClientID %>');
        var ddlEstadoMarcas = document.getElementById('<%= ddlEstadoMarcas.ClientID %>');
        var btnBuscar = document.getElementById('<%= btnBuscar.ClientID %>');

            if (filtro === 'nombre') {
                // Activar el filtro por nombre y desactivar el de estado
                txtFiltroMarcas.disabled = !chkFiltroNombre.checked;
                ddlEstadoMarcas.disabled = chkFiltroNombre.checked;
                btnBuscar.disabled = chkFiltroNombre.checked;

                if (chkFiltroNombre.checked) {
                    ddlEstadoMarcas.selectedIndex = 0; // Restablecer el filtro de estado a "Todos"
                    chkFiltroEstado.checked = false; // Desmarcar la casilla de estado
                }
            } else if (filtro === 'estado') {
                // Activar el filtro por estado y desactivar el de nombre
                ddlEstadoMarcas.disabled = !chkFiltroEstado.checked;
                txtFiltroMarcas.disabled = chkFiltroEstado.checked;
                btnBuscar.disabled = !chkFiltroEstado.checked;

                if (chkFiltroEstado.checked) {
                    txtFiltroMarcas.value = ''; // Limpiar el campo de texto de filtro de nombre
                    chkFiltroNombre.checked = false; // Desmarcar la casilla de nombre
                }
            }
        }
    </script>



</asp:Content>
