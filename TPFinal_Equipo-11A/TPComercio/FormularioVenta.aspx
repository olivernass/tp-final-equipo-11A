<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="FormularioVenta.aspx.cs" Inherits="TPComercio.FormularioVenta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />
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
            </tr>
        </ItemTemplate>


        <FooterTemplate>
            </tbody>
          </table>
        </FooterTemplate>
    </asp:Repeater>
    <asp:Button ID="btnVolver" runat="server" Text="Volver" OnClick="btnVolver_Click"/>

    <script>
        function validarCantidad(input) {
            const value = input.value.trim();
            const errorMsg = document.getElementById("error-msg");


            if (value === "" || isNaN(value) || parseInt(value, 10) < 0) {
                errorMsg.textContent = "La cantidad debe ser un número positivo y no estar vacío.";
                input.style.borderColor = "red";

            } else {
                errorMsg.textContent = "";
                input.style.borderColor = "";

            }
        }
    </script>

</asp:Content>
