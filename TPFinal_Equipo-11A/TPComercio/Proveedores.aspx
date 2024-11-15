<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="TPComercio.Proveedores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <div class="containerProveedores">
        <h2 class="h2listado">Listado de Proveedores</h2>

        <!-- Botón Agregar Proveedor -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarProveedor">
            Agregar Proveedor       
        </button>
    </div>

    <!-- Container Filtro Avanzado -->
<div class="containerFiltroAvanzado">
    <!-- Filtro Básico -->
    <div class="row">
        <div class="col-6">
            <div class="mb-3">
                <asp:Label Text="Filtrar por nombre:" runat="server" />
                <asp:TextBox runat="server" ID="txtFiltroProveedores" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtFiltroProveedores_TextChanged" />
            </div>
        </div>
        <div class="col-6" style="display: flex; flex-direction: column; justify-content: flex-end;">
            <div class="mb-3">
                <asp:CheckBox Text="Filtro Avanzado" runat="server" CssClass="" ID="chkAvanzado" AutoPostBack="true" OnCheckedChanged="chkAvanzado_CheckedChanged" />
            </div>
        </div>
    </div>

    <!-- Filtro Avanzado -->
    <% if (FiltroAvanzado) { %>
    <div class="row">
        <div class="col-3">
            <div class="mb-3">
                <asp:Label Text="Campo" ID="lCampo" runat="server" />
                <asp:DropDownList runat="server" AutoPostBack="true" CssClass="form-control" ID="ddlCampo" OnSelectedIndexChanged="ddlCampo_SelectedIndexChanged">
                    <asp:ListItem Text="CUIT" />
                    <asp:ListItem Text="Siglas" />
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
        <div class="col-3">
            <div class="mb-3">
                <asp:Label Text="Estado" runat="server" />
                <asp:DropDownList runat="server" ID="ddlEstado" CssClass="form-control">
                    <asp:ListItem Text="Todos" />
                    <asp:ListItem Text="Activo" />
                    <asp:ListItem Text="Inactivo" />
                </asp:DropDownList>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-3">
            <div class="mb-3">
                <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary" ID="btnBuscar" OnClick="btnBuscar_Click" />
                <asp:Button Text="Limpiar" runat="server" CssClass="btn btn-primary" ID="btnLimpiar" OnClick="btnLimpiar_Click" />
            </div>
        </div>
    </div>
    <% } %>
</div>


    <%--<!-- Filtro -->
    <div class="col-6">
            <div class="mb-3">
                <asp:Label Text="Filtrar por nombre:" runat="server" />
                <asp:TextBox runat="server" ID="txtFiltroProveedores" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtFiltroProveedores_TextChanged" />
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
                        <asp:ListItem Text="CUIT" />
                        <asp:ListItem Text="Siglas" />
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
            <div class="col-3">
                <div class="mb-3">
                    <asp:Label Text="Estado" runat="server" />
                    <asp:DropDownList runat="server" ID="ddlEstado" CssClass="form-control">
                        <asp:ListItem Text="Todos" />
                        <asp:ListItem Text="Activo" />
                        <asp:ListItem Text="Inactivo" />
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-3">
                <div class="mb-3">
                    <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary" ID="btnBuscar" OnClick="btnBuscar_Click" />
                    <asp:Button Text="Limpiar" runat="server" CssClass="btn btn-primary" ID="btnLimpiar" OnClick="btnLimpiar_Click" />
                </div>
            </div>
        </div>
        <% } %>--%>


    <!-- Tabla de Proveedores -->
    <table class="table tableClientes table-hover mt-3">
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
                            <button type="button" class="btn btn-secondary btn-acciones btn-sm" data-bs-toggle="modal" data-bs-target="#modalModificarProveedores"
                                onclick="cargarDatosModal('<%# Eval("Id") %>', '<%# Eval("CUIT") %>', '<%# Eval("Siglas") %>', '<%# Eval("Nombre") %>', '<%# Eval("Direccion") %>', '<%# Eval("Correo") %>', '<%# Eval("Telefono") %>')">
                                <img src="Content/Iconos/settings.png" alt="Detalle">
                            </button>

                            <!-- Botón Eliminar -->
                            <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-danger btn-acciones btn-sm" Text="Inactivar"
                                OnClientClick="return confirm('¿Estás seguro de que deseas inactivar este Proveedor?');"
                                CommandName="Inactivar" CommandArgument='<%# Eval("Id") %>' />

                            <!-- Se deben bloquear uno o el otro al momento de estar ya inactivos o activos -->

                            <!-- Botón Activar -->
                            <asp:Button ID="btnActivar" runat="server" CssClass="btn btn-success btn-acciones btn-sm" Text="Activar"
                                OnClientClick="return confirm('¿Estás seguro de que deseas activar este proveedor?');"
                                CommandName="Activar" CommandArgument='<%# Eval("Id") %>' />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
    </table>

    <!-- Modal Agregar Proveedor -->
    <div class="modal fade" id="modalAgregarProveedor" tabindex="-1" aria-labelledby="modalAgregarProveedor" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAgregarProveedorLabel">Agregar Nuevo Proveedor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <span class="error-message" id="errorCUIT"></span>
                    <asp:TextBox ID="txtCUITProveedor" runat="server" CssClass="form-control mb-2 validar-CUIT" placeholder="CUIT"></asp:TextBox>

                    <span class="error-message" id="errorSiglas"></span>
                    <asp:TextBox ID="txtSiglasProveedor" runat="server" CssClass="form-control mb-2 validar-siglas" placeholder="Siglas"></asp:TextBox>

                    <span class="error-message" id="errorNombre"></span>
                    <asp:TextBox ID="txtNombreProveedor" runat="server" CssClass="form-control mb-2 validar-nombre" placeholder="Nombre"></asp:TextBox>

                    <span class="error-message" id="errorDireccion"></span>
                    <asp:TextBox ID="txtDireccionProveedor" runat="server" CssClass="form-control mb-2 validar-direccion" placeholder="Dirección"></asp:TextBox>

                    <span class="error-message" id="errorCorreo"></span>
                    <asp:TextBox ID="txtCorreoProveedor" runat="server" CssClass="form-control mb-2 validar-correo" placeholder="Correo"></asp:TextBox>

                    <span class="error-message" id="errorTelefono"></span>
                    <asp:TextBox ID="txtTelefonoProveedor" runat="server" CssClass="form-control mb-2 validar-telefono" placeholder="Teléfono"></asp:TextBox>
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

                    <span class="error-message" id="errorCUITMod"></span>
                    <asp:TextBox ID="txtCUITProveedorMod" runat="server" CssClass="form-control mb-2 validar-CUIT-mod" placeholder="CUIT"></asp:TextBox>

                    <span class="error-message" id="errorSiglasMod"></span>
                    <asp:TextBox ID="txtSiglasProveedorMod" runat="server" CssClass="form-control mb-2 validar-siglas-mod" placeholder="Siglas"></asp:TextBox>

                    <span class="error-message" id="errorNombreMod"></span>
                    <asp:TextBox ID="txtNombreProveedorMod" runat="server" CssClass="form-control mb-2 validar-nombre-mod" placeholder="Nombre"></asp:TextBox>

                    <span class="error-message" id="errorDireccionMod"></span>
                    <asp:TextBox ID="txtDireccionProveedorMod" runat="server" CssClass="form-control mb-2 validar-direccion-mod" placeholder="Dirección"></asp:TextBox>

                    <span class="error-message" id="errorCorreoMod"></span>
                    <asp:TextBox ID="txtCorreoProveedorMod" runat="server" CssClass="form-control mb-2 validar-correo-mod" placeholder="Correo"></asp:TextBox>

                    <span class="error-message" id="errorTelefonoMod"></span>
                    <asp:TextBox ID="txtTelefonoProveedorMod" runat="server" CssClass="form-control mb-2 validar-telefono-mod" placeholder="Teléfono"></asp:TextBox>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="limpiarModal('modalModificarProveedor');">Cerrar</button>
                    <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-primary" Text="Guardar Cambios" OnClientClick="return validarModificarProveedor();" OnClick="btnGuardarCambios_Click" />
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function cargarDatosModal(id, CUIT, siglas, nombre, direccion, correo, telefono) {
            document.getElementById('<%= hdnIdProveedor.ClientID %>').value = id;
            document.getElementById('<%= txtCUITProveedorMod.ClientID %>').value = CUIT;
            document.getElementById('<%= txtSiglasProveedorMod.ClientID %>').value = siglas;
            document.getElementById('<%= txtNombreProveedorMod.ClientID %>').value = nombre;
            document.getElementById('<%= txtDireccionProveedorMod.ClientID %>').value = direccion;
            document.getElementById('<%= txtCorreoProveedorMod.ClientID %>').value = correo;
            document.getElementById('<%= txtTelefonoProveedorMod.ClientID %>').value = telefono;
        }
    </script>

</asp:Content>
