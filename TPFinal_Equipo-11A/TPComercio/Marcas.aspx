<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Marcas.aspx.cs" Inherits="TPComercio.Marcas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="containerCategorias">
        <h2 class="h2listado">Listado de Marcas</h2>
        <!-- Botón Agregar Marca -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarMarca">
            Agregar Marca
        </button>
    </div>

    <!-- Sección de Filtro -->
    <div class="containerFiltroAv">
        <div class="row align-items-center">
            <!-- Filtro por nombre -->
            <div class="col-auto mb-3">
                <asp:Label Text="Filtrar por nombre:" runat="server" />
                <asp:CheckBox ID="chkFiltroNombre" runat="server" AutoPostBack="false" OnClick="toggleFiltro('nombre')" class="ms-2" />
            </div>
            <div class="col-auto mb-3 d-flex align-items-center">
                <asp:TextBox runat="server" ID="txtFiltroMarcas" CssClass="form-control me-2" AutoPostBack="false" OnTextChanged="txtFiltroMarcas_TextChanged" Enabled="false" oninput="filtrarMarcas()" />
                <asp:Button Text="Borrar" runat="server" CssClass="btn btn-primary" ID="btnBorrar" OnClick="btnBorrar_Click" />
            </div>

            <!-- Filtro por estado -->
            <div class="col-auto mb-3">
                <asp:Label Text="Filtrar por estado:" runat="server" />
                <asp:CheckBox ID="chkFiltroEstado" runat="server" AutoPostBack="false" OnClick="toggleFiltro('estado')" class="ms-2" />
            </div>
            <div class="col-auto mb-3 d-flex align-items-center">
                <asp:DropDownList runat="server" ID="ddlEstadoMarcas" CssClass="form-control me-2" Enabled="false">
                    <asp:ListItem Text="Todos" />
                    <asp:ListItem Text="Activo" />
                    <asp:ListItem Text="Inactivo" />
                </asp:DropDownList>
                <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary" ID="btnBuscar" OnClick="btnBuscar_Click" Enabled="false" />
            </div>
        </div>
    </div>

    <!-- Tabla de Marcas -->
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
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
                                    <td><%# (bool)Eval("Activo") ? "Sí" : "No" %></td>
                                    <td>
                                        <!-- Botón Modificar -->
                                        <button type="button" class="btn btn-info btn-acciones btn-sm" data-bs-toggle="modal" data-bs-target="#modalModificarMarca"
                                            onclick="cargarDatosModal('<%# Eval("Id") %>', '<%# Eval("NombreMarca") %>', '<%# Eval("Activo") %>')">
                                            Modificar
                                        </button>

                                        <%--<!-- Botón Eliminar -->
                                    <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-danger btn-acciones btn-sm" Text="Inactivar"
                                        OnClientClick="return confirm('¿Estás seguro de que deseas eliminar esta marca?');"
                                        CommandName="Inactivar" CommandArgument='<%# Eval("Id") %>' />

                                    <!-- Botón Activar -->
                                    <asp:Button ID="btnActivar" runat="server" CssClass="btn btn-success btn-acciones btn-sm" Text="Activar"
                                        OnClientClick="return confirm('¿Estás seguro de que deseas activar esta marca?');"
                                        CommandName="Activar" CommandArgument='<%# Eval("Id") %>' />--%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>
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
                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtNombreMarca" runat="server" CssClass="form-control validar-nombre" placeholder="Nombre de la Marca"></asp:TextBox>
                        <div class="invalid-feedback">El nombre de la marca es obligatorio.</div>
                        <div class="valid-feedback">Nombre de marca válido.</div>
                    </div>
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
                    <asp:HiddenField ID="hdnEstadoMarca" runat="server" />

                    <div class="mb-3 has-danger has-success">
                        <asp:TextBox ID="txtNombreMarcaMod" runat="server" CssClass="form-control validar-nombre-mod" placeholder="Nombre de la Marca"></asp:TextBox>
                        <div class="invalid-feedback">El nombre de la marca es obligatorio.</div>
                        <div class="valid-feedback">Nombre de marca válido.</div>
                    </div>

                    <!-- Botones Activar e Inactivar dentro del Modal -->
                    <asp:Button ID="btnInactivarModal" runat="server" CssClass="btn btn-danger" Text="Inactivar"
                        OnClientClick="return confirm('¿Estás seguro de que deseas inactivar esta marca?');" OnClick="btnInactivarModal_Click" />
                    <asp:Button ID="btnActivarModal" runat="server" CssClass="btn btn-success" Text="Activar"
                        OnClientClick="return confirm('¿Estás seguro de que deseas activar esta marca?');" OnClick="btnActivarModal_Click" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalModificarMarca');">Cerrar</button>
                    <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-primary" Text="Guardar Cambios"
                        OnClientClick="return validarModificarMarca();" OnClick="btnGuardarCambios_Click" />
                </div>
            </div>
        </div>
    </div>


    <%--<script type="text/javascript">
        function cargarDatosModal(id, nombre) {
            document.getElementById('<%= hdnIdMarca.ClientID %>').value = id;
            document.getElementById('<%= txtNombreMarcaMod.ClientID %>').value = nombre;
        }
    </script>--%>

    <%--<script type="text/javascript">
        function cargarDatosModal(id, nombre, estado) {
            // Establecer el ID y el nombre en los elementos ocultos y en el campo de texto
            document.getElementById('<%= hdnIdMarca.ClientID %>').value = id;
        document.getElementById('<%= txtNombreMarcaMod.ClientID %>').value = nombre;
        
        // Configurar la visibilidad de los botones según el estado
        const btnInactivar = document.getElementById('<%= btnInactivarModal.ClientID %>');
        const btnActivar = document.getElementById('<%= btnActivarModal.ClientID %>');

            if (estado == "Activo") {
                btnInactivar.style.display = 'none';
                btnActivar.style.display = 'block';
                
            } else if (estado == "Inactivo"){
                btnInactivar.style.display = 'block';
                btnActivar.style.display = 'none';
            }
        }
    </script>--%>


    <script type="text/javascript">
        function cargarDatosModal(id, nombre, estado) {
            document.getElementById('<%= hdnIdMarca.ClientID %>').value = id;
            document.getElementById('<%= txtNombreMarcaMod.ClientID %>').value = nombre;
            document.getElementById('<%= hdnEstadoMarca.ClientID %>').value = estado;

            // Obtener referencias a los botones
            const btnInactivar = document.getElementById('<%= btnInactivarModal.ClientID %>');
            const btnActivar = document.getElementById('<%= btnActivarModal.ClientID %>');

            // Log para verificar el estado que llega a la función
            console.log("Estado de la marca:", estado);
            console.log("id de la marca:", id);
            console.log("nombre de la marca:", nombre);

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
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= txtFiltroMarcas.ClientID %>').on('keyup', function () {
                var filtro = $(this).val(); // Obtener el texto que el usuario escribió en el campo de búsqueda

                $.ajax({
                    type: "POST",
                    url: "Marcas.aspx/FiltrarMarcas", // Asegúrate de poner la URL correcta
                    data: JSON.stringify({ filtro: filtro }), // Enviar el filtro al servidor
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        // Actualizar el contenido del cuerpo de la tabla con los resultados filtrados
                        $('tbody', '.tableMarcas').html(response.d); // response.d contiene el nuevo HTML generado
                    },
                    error: function (error) {
                        console.log("Error al filtrar las marcas:", error);
                    }
                });
            });
        });
    </script>



</asp:Content>
