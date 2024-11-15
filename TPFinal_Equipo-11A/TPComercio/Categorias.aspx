<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Categorias.aspx.cs" Inherits="TPComercio.Categorias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="containerCategorias">
        <h2 class="h2listado">Listado de Categorias</h2>

        <!-- Botón Agregar Categoria -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarCategoria">
            Agregar Categoria       
        </button>

        <%--<!-- Filtro -->
        <div class="col-6">
            <div class="mb-3">
                <asp:Label Text="Filtrar por nombre:" runat="server" />
                <div class="d-flex">
                    <asp:TextBox runat="server" ID="txtFiltroCategoria" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtFiltroCategoria_TextChanged" />
                    <asp:Button Text="Borrar" runat="server" CssClass="btn btn-primary" ID="btnBorrar" OnClick="btnBorrar_Click" />
                </div>
            </div>
        

            <asp:Label Text="Filtrar por estado:" runat="server" />
            <asp:DropDownList runat="server" ID="ddlEstadoCategorias" CssClass="form-control">
                <asp:ListItem Text="Todos" />
                <asp:ListItem Text="Activo" />
                <asp:ListItem Text="Inactivo" />
            </asp:DropDownList>
        </div>

        <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary" ID="btnBuscar" OnClick="btnBuscar_Click" />--%>

        <!-- Filtro -->
        <div class="col-6">
            <!-- Filtro por nombre -->
            <div class="mb-3">
                <asp:Label Text="Filtrar por nombre:" runat="server" />
                <asp:CheckBox ID="chkFiltroNombre" runat="server" AutoPostBack="false" OnClick="toggleFiltro('nombre')" />
                <div class="d-flex">
                    <asp:TextBox runat="server" ID="txtFiltroCategoria" CssClass="form-control me-2" AutoPostBack="false" OnTextChanged="txtFiltroCategoria_TextChanged" Enabled="false" oninput="filtrarCategorias()"/>
                    <asp:Button Text="Borrar" runat="server" CssClass="btn btn-primary" ID="btnBorrar" OnClick="btnBorrar_Click"/>
                </div>
            </div>
    
            <!-- Filtro por estado -->
            <asp:Label Text="Filtrar por estado:" runat="server" />
            <asp:CheckBox ID="chkFiltroEstado" runat="server" AutoPostBack="false" OnClick="toggleFiltro('estado')" />
            <asp:DropDownList runat="server" ID="ddlEstadoCategorias" CssClass="form-control" Enabled="false">
                <asp:ListItem Text="Todos" />
                <asp:ListItem Text="Activo" />
                <asp:ListItem Text="Inactivo" />
            </asp:DropDownList>

            <!-- Botón Buscar, que solo se activa con el filtro de estado -->
            <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary" ID="btnBuscar" OnClick="btnBuscar_Click" Enabled="false"/>
        </div>

    <!-- Tabla de Categorias -->
    <table class="table tableCategorias table-hover mt-3">
        <thead>
            <tr>
                <th scope="col">ID</th>
                <th scope="col">Categoria</th>
                <th scope="col">Activo</th>
                <th scope="col" class="acciones">Acciones</th>
            </tr>
        </thead>
        <tbody>
            <asp:Repeater ID="rptCategorias" runat="server" OnItemCommand="rptCategorias_ItemCommand">
                <ItemTemplate>
                    <tr>
                        <th scope="row"><%# Eval("Id") %></th>
                        <td><%# Eval("NombreCategoria") %></td>
                        <td><%# (bool)Eval("Activo") ? "Sí" : "No" %></td>
                        <td>
                            <!-- Botón Modificar -->
                            <button type="button" class="btn btn-primary btn-acciones btn-sm" data-bs-toggle="modal" data-bs-target="#modalModificarCategoria"
                                onclick="cargarDatosModal('<%# Eval("Id") %>', '<%# Eval("NombreCategoria") %>', '<%# Eval("Activo") %>')">
                                Modificar
                            </button>

                            <%--<!-- Botón Eliminar -->
                            <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-danger btn-acciones btn-sm" Text="Inactivar"
                                OnClientClick="return confirm('¿Estás seguro de que deseas eliminar esta categoria?');"
                                CommandName="Inactivar" CommandArgument='<%# Eval("Id") %>' />

                            <!-- Se deben bloquear uno o el otro al momento de estar ya inactivos o activos -->

                            <!-- Botón Activar -->
                            <asp:Button ID="btnActivar" runat="server" CssClass="btn btn-success btn-acciones btn-sm" Text="Activar"
                                OnClientClick="return confirm('¿Estás seguro de que deseas activar este categoria?');"
                                CommandName="Activar" CommandArgument='<%# Eval("Id") %>' />--%>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
    </table>

    <!-- Modal Agregar Categoria -->
    <div class="modal fade" id="modalAgregarCategoria" tabindex="-1" aria-labelledby="modalAgregarCategoriaLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAgregarCategoriaLabel">Agregar Nueva Categoria</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <span class="error-message" id="errorNombreCategoria"></span>
                    <asp:TextBox ID="txtNombreCategoria" runat="server" CssClass="form-control validar-nombre" placeholder="Nombre de la Categoria"></asp:TextBox>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalAgregarCategoria');">Cerrar</button>
                    <asp:Button ID="btnGuardarCategoria" runat="server" CssClass="btn btn-primary" Text="Guardar Categoria"
                        OnClientClick="return validarAgregarCategoria();" OnClick="btnGuardarCategoria_Click" />
                </div>
            </div>
        </div>
    </div>

    <%--<!-- Modal Modificar Categoria -->
    <div class="modal fade" id="modalModificarCategoria" tabindex="-1" aria-labelledby="modalModificarCategoriaLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalModificarCategoriaLabel">Modificar Categoria</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hdnIdCategoria" runat="server" />
                    <span class="error-message" id="errorNombreCategoriaMod"></span>
                    <asp:TextBox ID="txtNombreCategoriaMod" runat="server" CssClass="form-control validar-nombre-mod" placeholder="Nombre de la Categoria"></asp:TextBox>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalModificarCategoria');">Cerrar</button>
                    <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-primary" Text="Guardar Cambios"
                        OnClientClick="return validarModificarCategoria();" OnClick="btnGuardarCambios_Click" />
                </div>
            </div>
        </div>
    </div>--%>

            <!-- Modal Modificar Categoria -->
            <div class="modal fade" id="modalModificarCategoria" tabindex="-1" aria-labelledby="modalModificarCategoriaLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalModificarCategoriaLabel">Modificar Categoria</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <asp:HiddenField ID="hdnIdCategoria" runat="server" />
                            <asp:HiddenField ID="hdnEstadoCategoria" runat="server" />

                            <span class="error-message" id="errorNombreMarcaMod"></span>
                            <asp:TextBox ID="txtNombreCategoriaMod" runat="server" CssClass="form-control validar-nombre-mod" placeholder="Nombre de la Categoria"></asp:TextBox>
                            <!-- Botones Activar e Inactivar dentro del Modal -->
                
                            <asp:Button ID="btnInactivarModal" runat="server" CssClass="btn btn-danger" Text="Inactivar"
                                        OnClientClick="return confirm('¿Estás seguro de que deseas inactivar esta categoria?');" OnClick="btnInactivarModal_Click" />
                            <asp:Button ID="btnActivarModal" runat="server" CssClass="btn btn-success" Text="Activar"
                                        OnClientClick="return confirm('¿Estás seguro de que deseas activar esta categoria?');" OnClick="btnActivarModal_Click" />
                    
                        </div>
                        <div class="modal-footer">
                
                
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalModificarCategoria');">Cerrar</button>
                            <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-primary" Text="Guardar Cambios"
                                OnClientClick="return validarModificarCategoria();" OnClick="btnGuardarCambios_Click" />
                        </div>
                    </div>
                </div>
            </div>

    <script type="text/javascript">
        function cargarDatosModal(id, nombre, estado) {
            document.getElementById('<%= hdnIdCategoria.ClientID %>').value = id;
        document.getElementById('<%= txtNombreCategoriaMod.ClientID %>').value = nombre;
        document.getElementById('<%= hdnEstadoCategoria.ClientID %>').value = estado;

    // Obtener referencias a los botones
    const btnInactivar = document.getElementById('<%= btnInactivarModal.ClientID %>');
    const btnActivar = document.getElementById('<%= btnActivarModal.ClientID %>');

            // Log para verificar el estado que llega a la función
            console.log("Estado de la categoria:", estado);
            console.log("id de la categoria:", id);
            console.log("nombre de la categoria:", nombre);

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
        var txtFiltroCategorias = document.getElementById('<%= txtFiltroCategoria.ClientID %>');
        var chkFiltroEstado = document.getElementById('<%= chkFiltroEstado.ClientID %>');
    var ddlEstadoCategorias = document.getElementById('<%= ddlEstadoCategorias.ClientID %>');
    var btnBuscar = document.getElementById('<%= btnBuscar.ClientID %>');

                if (filtro === 'nombre') {
                    // Activar el filtro por nombre y desactivar el de estado
                    txtFiltroCategorias.disabled = !chkFiltroNombre.checked;
                    ddlEstadoCategorias.disabled = chkFiltroNombre.checked;
                    btnBuscar.disabled = chkFiltroNombre.checked;

                    if (chkFiltroNombre.checked) {
                        ddlEstadoCategorias.selectedIndex = 0; // Restablecer el filtro de estado a "Todos"
                        chkFiltroEstado.checked = false; // Desmarcar la casilla de estado
                    }
                } else if (filtro === 'estado') {
                    // Activar el filtro por estado y desactivar el de nombre
                    ddlEstadoCategorias.disabled = !chkFiltroEstado.checked;
                    txtFiltroCategorias.disabled = chkFiltroEstado.checked;
                    btnBuscar.disabled = !chkFiltroEstado.checked;

                    if (chkFiltroEstado.checked) {
                        txtFiltroCategorias.value = ''; // Limpiar el campo de texto de filtro de nombre
                        chkFiltroNombre.checked = false; // Desmarcar la casilla de nombre
                    }
                }
            }
        </script>

        <script type="text/javascript">
            $(document).ready(function () {
                $('#<%= txtFiltroCategoria.ClientID %>').on('keyup', function () {
            var filtro = $(this).val(); // Obtener el texto que el usuario escribió en el campo de búsqueda

            $.ajax({
                type: "POST",
                url: "Categorias.aspx/FiltrarCategorias", // Asegúrate de poner la URL correcta
                data: JSON.stringify({ filtro: filtro }), // Enviar el filtro al servidor
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // Actualizar el contenido del cuerpo de la tabla con los resultados filtrados
                    $('tbody', '.tableCategorias').html(response.d); // response.d contiene el nuevo HTML generado
                },
                error: function (error) {
                    console.log("Error al filtrar las categorias:", error);
                }
            });
        });
    });
        </script>

</asp:Content>
