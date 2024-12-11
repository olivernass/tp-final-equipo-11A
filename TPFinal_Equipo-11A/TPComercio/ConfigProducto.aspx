<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ConfigProducto.aspx.cs" Inherits="TPComercio.ConfigProducto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display: flex; flex-direction: row; padding: 20px; font-family: Arial, sans-serif;">
        <!-- Imagen del Producto -->
        <div style="flex: 0 0 auto; margin-right: 20px;">
            <strong>Imagen del Producto:</strong><br>
            <img src="<%= producto.Imagen.ImagenUrl %>" alt="Imagen del Producto" style="max-width: 300px; height: auto;">
        </div>
        <!-- Detalles del Producto -->
        <div style="flex: 1; text-align: left;">
            <p style="font-size: 20px; margin: 5px 0;">
                <strong>Código:</strong>
                <asp:TextBox ID="txtCodigo" style="max-width: 100px;" runat="server" CssClass="form-control" ReadOnly="true" Enabled="False"></asp:TextBox>
            </p>
            <!-- Estado del Producto -->
            <div class="badge text-bg-primary text-wrap" style="width: 6rem;">
              <asp:Label ID="lblActivo" style="max-width: 100px;" runat="server" Text="" Visible="True"></asp:Label>
            </div>

            <p style="font-size: 18px; margin: 5px 0;">
                <strong>Título del Artículo:</strong>
                <asp:TextBox ID="txtNombre" style="max-width: 300px;" runat="server" CssClass="form-control"></asp:TextBox>
            </p>

            <p style="font-size: 16px; margin: 5px 0;">
                <strong>Descripción:</strong>
                <asp:TextBox ID="txtDescripcion" style="max-width: 300px;" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
            </p>

            <p style="font-size: 16px; margin: 5px 0;">
                <strong>Marca:</strong>
                <asp:DropDownList ID="ddlMarca" style="max-width: 200px;" runat="server"></asp:DropDownList>
            </p>

            <p style="font-size: 16px; margin: 5px 0;">
                <strong>Categoría:</strong>
                <asp:DropDownList ID="ddlCategoria" style="max-width: 200px;" runat="server"></asp:DropDownList>
            </p>

            <p style="font-size: 16px; margin: 5px 0;">
                <strong>Stock actual:</strong>
                <asp:TextBox ID="txtStockActual" style="max-width: 100px;" runat="server" CssClass="form-control" OnKeyPress="return isNumberKey(event)" Enabled="False"></asp:TextBox>
            </p>

            <p style="font-size: 16px; margin: 5px 0;">
                <strong>Stock mínimo:</strong>
                <asp:TextBox ID="txtStockMinimo" style="max-width: 100px;" runat="server" CssClass="form-control" OnKeyPress="return isNumberKey(event)"></asp:TextBox>
            </p>

            <p style="font-size: 16px; margin: 5px 0;">
                <strong>Precio compra:</strong>
                <asp:TextBox ID="txtPrecioCompra" style="max-width: 100px;" runat="server" CssClass="form-control" OnKeyPress="return isNumberKey(event)" OnTextChanged="txtPrecioCompra_TextChanged" AutoPostBack="True"></asp:TextBox>
            </p>

            <p style="font-size: 16px; margin: 5px 0;">
                <strong>Porcentaje ganancia:</strong>
                <asp:TextBox ID="txtPorcentajeGanancia" style="max-width: 100px;" runat="server" CssClass="form-control" OnKeyPress="return isNumberKey(event)" OnTextChanged="txtPorcentajeGanancia_TextChanged" AutoPostBack="True"></asp:TextBox>
            </p>

            <p style="font-size: 16px; margin: 5px 0;">
                <strong>Precio venta:</strong>
                <asp:TextBox ID="txtPrecioVenta" style="max-width: 100px;" runat="server" CssClass="form-control" OnKeyPress="return isNumberKey(event)" Enabled="False"></asp:TextBox>
            </p>

            <!-- Proveedores -->
            <h5>Proveedores:</h5>
            <asp:DropDownList ID="ddlProveedorProducto" style="max-width: 100px;" runat="server" CssClass="form-control mb-2"></asp:DropDownList>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarProveedor" data-id="<%= producto.Id %>" onclick="guardarIdProductoEnModal(this)">
                Agregar Proveedor
            </button>

            <!-- Botones de acción -->
            <asp:Button ID="btnModificar" class="btn btn-primary" runat="server" Text="Modificar producto" OnClick="btnModificar_Click" />
            <asp:Button ID="btnInactivarActivar" class="btn btn-primary" runat="server" Text="Inactivar" OnClick="btnInactivarActivar_Click" />
            <asp:Button ID="btnVolver" class="btn btn-primary" runat="server" Text="Volver" OnClick="btnVolver_Click" />
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
