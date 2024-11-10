<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ConfigProducto.aspx.cs" Inherits="TPComercio.ConfigProducto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display: flex; flex-direction: row; padding: 20px; font-family: Arial, sans-serif;">
        <div style="flex: 0 0 auto; margin-right: 20px;">
            <strong>Imagen del Producto:</strong><br>
            <img src="<%= producto.Imagen.ImagenUrl %>" alt="Imagen del Producto" style="max-width: 300px; height: auto;">
        </div>
        <div style="flex: 1; text-align: left;">
            <p style="font-size: 20px; margin: 5px 0;"><strong>Codigo:</strong>
            <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </p>

            <p style="font-size: 18px; margin: 5px 0;"><strong>Título del Artículo:</strong>
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
            </p>

            <p style="font-size: 16px; margin: 5px 0;"><strong>Descripción:</strong>
                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control"></asp:TextBox>
            </p>
            <p style="font-size: 16px; margin: 5px 0;"><strong>Marca:</strong>
            <asp:DropDownList ID="ddlMarca" runat="server"></asp:DropDownList>
            <p style="font-size: 16px; margin: 5px 0;"><strong>Categoria:</strong>
            <asp:DropDownList ID="ddlCategoria" runat="server"></asp:DropDownList>

            <p style="font-size: 16px; margin: 5px 0;"><strong>Stock actual:</strong>
                <asp:TextBox ID="txtStockActual" runat="server" CssClass="form-control" OnKeyPress="return isNumberKey(event)"></asp:TextBox>
            </p>

            <p style="font-size: 16px; margin: 5px 0;"><strong>Stock minimo:</strong>
                <asp:TextBox ID="txtStockMinimo" runat="server" CssClass="form-control" OnKeyPress="return isNumberKey(event)"></asp:TextBox>
            </p>

            <p style="font-size: 16px; margin: 5px 0;"><strong>Precio compra:</strong>
                <asp:TextBox ID="txtPrecioCompra" runat="server" CssClass="form-control" OnKeyPress="return isNumberKey(event)"></asp:TextBox>
            </p>

            <p style="font-size: 16px; margin: 5px 0;"><strong>Precio venta:</strong>
                <asp:TextBox ID="txtPrecioVenta" runat="server" CssClass="form-control" OnKeyPress="return isNumberKey(event)"></asp:TextBox>
            </p>

            <p style="font-size: 16px; margin: 5px 0;"><strong>Porcentaje ganancia:</strong>
                <asp:TextBox ID="txtPorcentajeGanancia" runat="server" CssClass="form-control" OnKeyPress="return isNumberKey(event)"></asp:TextBox>
            </p>
            <h5>Proveedores:</h5>
            <asp:DropDownList ID="ddlProveedorProducto" runat="server" CssClass="form-control mb-2">
            </asp:DropDownList>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarProveedor"
                data-id="<%= producto.Id %>" onclick="guardarIdProductoEnModal(this)">
                Agregar Proveedor
            </button>
            <asp:Button ID="btnModificar" class="btn btn-primary" runat="server" Text="Modificar producto" Onclick="btnModificar_Click" />
        </div>
    </div>

    <!-- Modal de agregar proveedor -->
    <div class="modal fade" id="modalAgregarProveedor" tabindex="-1" aria-labelledby="modalAgregarProveedorLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAgregarProveedorLabel">Agregar Proveedor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Aquí puedes tener otros campos para agregar proveedor -->
                    <asp:DropDownList ID="ddlProveedorNuevo" runat="server" CssClass="form-control mb-2">
                    </asp:DropDownList>
                    <!-- Campo oculto para almacenar el ID del producto -->
                    <asp:HiddenField ID="hfIdProducto" runat="server" />
                </div>
                <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <!-- Botón para guardar el proveedor y usar el ID del producto -->
                <asp:Button ID="btnGuardarProveedor" runat="server" CssClass="btn btn-primary" Text="Guardar proveedor"
                    OnClientClick="return guardarIdProductoEnModal();"
                    OnClick="btnGuardarProveedor_Click" />
                </div>
            </div>
        </div>
    </div>

    <script>
        function guardarIdProductoEnModal(button) {
            var idProducto = button.getAttribute('data-id');
            document.getElementById('<%= hfIdProducto.ClientID %>').value = idProducto;
        }
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
    </script>
</asp:Content>
