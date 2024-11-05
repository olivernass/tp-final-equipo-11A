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

        <!-- Filtro -->
        <div class="col-6">
            <div class="mb-3">
                <asp:Label Text="Filtrar por nombre:" runat="server" />
                 <div class="d-flex">
                <asp:TextBox runat="server" ID="txtFiltroCategoria" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtFiltroCategoria_TextChanged" />
                <asp:Button Text="Borrar" runat="server" CssClass="btn btn-primary" ID="btnBorrar" OnClick="btnBorrar_Click"/>
                     </div>
            </div>
        </div>

        <!-- Tabla de Categorias -->
        <table class="table tableCategorias table-hover mt-3">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Categoria</th>
                    <th scope="col" class="acciones">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptCategorias" runat="server" OnItemCommand="rptCategorias_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <th scope="row"><%# Eval("Id") %></th>
                            <td><%# Eval("NombreCategoria") %></td>
                            <td>
                                <!-- Botón Modificar -->
                                <button type="button" class="btn btn-info btn-acciones btn-sm" data-bs-toggle="modal" data-bs-target="#modalModificarCategoria"
                                    onclick="cargarDatosModal('<%# Eval("Id") %>', '<%# Eval("NombreCategoria") %>')">
                                    Modificar
                                </button>

                                <!-- Botón Eliminar -->
                                <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-danger btn-acciones btn-sm" Text="Eliminar"
                                    OnClientClick="return confirm('¿Estás seguro de que deseas eliminar esta categoria?');"
                                    CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>

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
    </div>

    <script type="text/javascript">
        function cargarDatosModal(id, nombre) {
            document.getElementById('<%= hdnIdCategoria.ClientID %>').value = id;
            document.getElementById('<%= txtNombreCategoriaMod.ClientID %>').value = nombre;
        }
    </script>

</asp:Content>
