<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Marcas.aspx.cs" Inherits="TPComercio.Marcas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="containerMarcas">
        <asp:GridView ID="gvMarcas" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-active custom-grid" OnRowCommand="gvMarcas_RowCommand" OnRowDataBound="gvMarcas_RowDataBound">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="ID" />
                <asp:BoundField DataField="NombreMarca" HeaderText="Nombre de la Marca" />

                <asp:TemplateField HeaderText="">
                    <ItemTemplate>
                        <div class="acciones">
                            <asp:Button ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument='<%# Eval("Id") %>' Text="Modificar" CssClass="btn btn-info btn-mod" />
                            <asp:Button ID="btnEliminar" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>' Text="Eliminar" CssClass="btn btn-danger btn-mod" OnClientClick="return confirm('¿Está seguro de eliminar esta marca?');" />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <script>
        // Codiguito JS para mostrar botones de acción al pasar el mouse sobre una fila
        document.querySelectorAll(".table tr").forEach(function (row) {
            row.addEventListener("mouseover", function () {
                this.querySelector(".acciones").style.visibility = "visible";
            });
            row.addEventListener("mouseout", function () {
                this.querySelector(".acciones").style.visibility = "hidden";
            });
        });
</script>

    <div class="btn-add-m">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarMarca">Agregar</button>
    </div>

    <div class="modal" id="modalAgregarMarca" tabindex="-1" aria-labelledby="modalAgregarMarcaLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAgregarMarcaLabel">Agregar nueva marca</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:Panel ID="PanelAgregarMarca" runat="server" DefaultButton="btnGuardarMarca">
                        <div class="mb-3">
                            <label for="NombreMarca" class="form-label">Nombre de la Marca</label>
                            <asp:TextBox ID="txtNombreMarca" runat="server" CssClass="form-control" />
                        </div>
                    </asp:Panel>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <asp:Button ID="btnGuardarMarca" runat="server" CssClass="btn btn-primary" Text="Guardar" OnClick="btnGuardarMarca_Click" />
                </div>
            </div>
        </div>
    </div>




</asp:Content>
