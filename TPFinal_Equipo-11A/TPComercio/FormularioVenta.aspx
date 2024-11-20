<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="FormularioVenta.aspx.cs" Inherits="TPComercio.FormularioVenta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Label ID="lblCodigosStock" runat="server" Text="Articulos a pedir stock:" Visible="false"></asp:Label>
    <asp:Repeater ID="rptDetalleVenta" runat="server" OnItemDataBound="rptDetalleVenta_ItemDataBound">
        <HeaderTemplate>
            <table class="table">
                <thead>
                    <tr>
                        <th>Codigo producto</th>
                        <th>Nombre</th>
                        <th>Precio de venta</th>
                        <th>Stock actual</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
        </HeaderTemplate>

        <ItemTemplate>
            <tr>
                <td>
                    <asp:Label ID="lblProductoId" runat="server" Text='<%# Eval("Producto.Id") %>'></asp:Label></td>
                <td>
                    <asp:Label ID="lblProductoNombre" runat="server" Text='<%# Eval("Producto.Nombre") %>'></asp:Label></td>
                <td>
                    <asp:Label ID="lblProductoPrecioVenta" runat="server" Text='<%# Eval("Producto.Precio_Venta", "{0:C}") %>'></asp:Label></td>
                <td>
                    <asp:Label ID="lblProductoStockActual" runat="server" Text='<%# Eval("Producto.StockActual") %>'></asp:Label></td>
                <td>   
                    <asp:TextBox
                        ID="txtCantidad"
                        runat="server"
                        Text='<%# Eval("Cantidad") %>'
                        oninput="validarCantidad(this)" />
                </td>
                <span id="error-msg" style="color: red;"></span>
                <td>
                    <asp:Label ID="lblSubtotal" runat="server" Text='<%# Eval("Subtotal", "{0:C}") %>'></asp:Label></td>
                <asp:Label ID="lblProductoStockMinimo" runat="server" Text='<%# Eval("Producto.StockMinimo") %>' Visible="false"></asp:Label></td>       
            </tr>
        </ItemTemplate>


        <FooterTemplate>
            </tbody>
          </table>
        </FooterTemplate>
    </asp:Repeater>
    <asp:Button ID="btnVolver" runat="server" Text="Volver" OnClick="btnVolver_Click"/>
    <asp:Button ID="btnActualizarMontos" runat="server" Text="Actualizar montos" OnClick="btnActualizarMontos_Click"/>
    <asp:Button ID="btnGenerarVenta" runat="server" Text="Generar Venta" OnClick="btnGenerarVenta_Click" Visible="false"/>

    <script>
        function validarCantidad(input) {
            const value = input.value.trim();
            const errorMsg = document.getElementById("error-msg");
            const btnActualizarMontos = document.getElementById("<%= btnActualizarMontos.ClientID %>");

            // Validar que el valor no esté vacío, sea un número positivo, y no comience con 0
            if (value === "" || isNaN(value) || parseInt(value, 10) < 0 || /^0\d+/.test(value)) {
                if (value === "" || isNaN(value)) {
                    errorMsg.textContent = "La cantidad debe ser un número válido y no estar vacío.";
                } else if (parseInt(value, 10) < 0) {
                    errorMsg.textContent = "La cantidad debe ser un número positivo.";
                } else if (/^0\d+/.test(value)) {
                    errorMsg.textContent = "La cantidad no puede comenzar con un 0.";
                }

                input.style.borderColor = "red";
                btnActualizarMontos.disabled = true;
            } else {
                errorMsg.textContent = "";
                input.style.borderColor = "";
                btnActualizarMontos.disabled = false;
            }
        }
    </script>

</asp:Content>
