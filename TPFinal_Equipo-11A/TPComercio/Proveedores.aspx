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

        <!-- Tabla de Proveedores -->
        <table class="table tableClientes table-hover mt-3">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Siglas</th>
                    <th scope="col">Nombre</th>
                    <th scope="col">Direccion</th>
                    <th scope="col">Correo</th>
                    <th scope="col">Telefono</th>
                    <%--<th scope="col">Fecha de Registro</th>--%>
                    <th scope="col">Activo</th>
                    <th scope="col" class="acciones">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptProveedores" runat="server" OnItemCommand="rptProveedores_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <th scope="row"><%# Eval("Id") %></th>
                            <td><%# Eval("Siglas") %></td>
                            <td><%# Eval("Nombre") %></td>
                            <td><%# Eval("Direccion") %></td>
                            <td><%# Eval("Correo") %></td>
                            <td><%# Eval("Telefono") %></td>
                            <%--<td><%# Eval("Fecha_Alta", "{0:dd/MM/yyyy HH:mm}") %></td>--%>
                            <td><%# (bool)Eval("Activo") ? "Sí" : "No" %></td>
                            <td>
                                <!-- Botón Modificar -->
                                <button type="button" class="btn btn-info btn-acciones btn-sm" data-bs-toggle="modal" data-bs-target="#modalModificarProveedores"
                                    onclick="cargarDatosModal('<%# Eval("Id") %>', '<%# Eval("Siglas") %>', '<%# Eval("Nombre") %>', '<%# Eval("Direccion") %>', '<%# Eval("Correo") %>', '<%# Eval("Telefono") %>'<%--, '<%# Eval("Activo") %>'--%>)">
                                    Modificar
                                </button>

                                <!-- Botón Eliminar -->
                                <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-danger btn-acciones btn-sm" Text="Eliminar"
                                    OnClientClick="return confirm('¿Estás seguro de que deseas eliminar este Proveedor?');"
                                    CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>

    <!-- Modal Agregar Proveedor -->
    <div class="modal fade" id="modalAgregarProveedor" tabindex="-1" aria-labelledby="modalAgregarProveedor" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAgregarProveedorLabel">Agregar Nuevo Proveedor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:TextBox ID="txtSiglasProveedor" runat="server" CssClass="form-control mb-2" placeholder="Siglas"></asp:TextBox>
                    <asp:TextBox ID="txtNombreProveedor" runat="server" CssClass="form-control mb-2" placeholder="Nombre"></asp:TextBox>
                    <asp:TextBox ID="txtDireccionProveedor" runat="server" CssClass="form-control mb-2" placeholder="Dirección"></asp:TextBox>
                    <asp:TextBox ID="txtCorreoProveedor" runat="server" CssClass="form-control mb-2" placeholder="Correo"></asp:TextBox>
                    <asp:TextBox ID="txtTelefonoProveedor" runat="server" CssClass="form-control mb-2" placeholder="Teléfono"></asp:TextBox>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <asp:Button ID="btnGuardarProveedor" runat="server" CssClass="btn btn-primary" Text="Guardar Proveedor" OnClick="btnGuardarProveedor_Click" />
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
                    <asp:TextBox ID="txtSiglasProveedorMod" runat="server" CssClass="form-control mb-2" placeholder="Siglas"></asp:TextBox>
                    <asp:TextBox ID="txtNombreProveedorMod" runat="server" CssClass="form-control mb-2" placeholder="Nombre"></asp:TextBox>
                    <asp:TextBox ID="txtDireccionProveedorMod" runat="server" CssClass="form-control mb-2" placeholder="Dirección"></asp:TextBox>
                    <asp:TextBox ID="txtCorreoProveedorMod" runat="server" CssClass="form-control mb-2" placeholder="Correo"></asp:TextBox>
                    <asp:TextBox ID="txtTelefonoProveedorMod" runat="server" CssClass="form-control mb-2" placeholder="Teléfono"></asp:TextBox>
                    <%--<div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="chkActivoProveedorMod" runat="server" />
                        <label class="form-check-label" for="chkActivoProveedorMod">Activo</label>
                    </div>--%>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-primary" Text="Guardar Cambios" OnClick="btnGuardarCambios_Click" />
                </div>
            </div>
        </div>
    </div>



    <script type="text/javascript">
            function cargarDatosModal(id, siglas, nombre, direccion, correo, telefono) {
            document.getElementById('<%= hdnIdProveedor.ClientID %>').value = id;
            document.getElementById('<%= txtSiglasProveedorMod.ClientID %>').value = siglas;
            document.getElementById('<%= txtNombreProveedorMod.ClientID %>').value = nombre;;
            document.getElementById('<%= txtDireccionProveedorMod.ClientID %>').value = direccion;
            document.getElementById('<%= txtCorreoProveedorMod.ClientID %>').value = correo;
            document.getElementById('<%= txtTelefonoProveedorMod.ClientID %>').value = telefono;
            /*document.getElementById('chkActivoProveedorMod').checked = activo === 'True' || activo === '1' || activo === true;*/
            }
    </script>

</asp:Content>
