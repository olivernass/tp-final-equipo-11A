<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="FormularioCompra.aspx.cs" Inherits="TPComercio.FormularioCompra" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:Repeater ID="rptDetalleCompra" runat="server" OnItemDataBound="rptDetalleCompra_ItemDataBound" >
        <HeaderTemplate>
            <table class="table">
                <thead>
                    <tr>
                        <th>Codigo producto</th>
                        <th>Nombre</th>
                        <th>Precio de compra</th>
                        <th>Stock actual</th>
                        <th>Stock minimo</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
        </HeaderTemplate>

        <ItemTemplate>
            <tr> 
                <td><asp:Label ID="lblProductoId" runat="server" Text='<%# Eval("Producto.Id") %>'></asp:Label></td>
                <td><asp:Label ID="lblProductoNombre" runat="server" Text='<%# Eval("Producto.Nombre") %>'></asp:Label></td>
                <td><asp:Label ID="lblProductoPrecioCompra" runat="server" Text='<%# Eval("Producto.Precio_Compra", "{0:C}") %>'></asp:Label></td>
                <td><asp:Label ID="lblProductoStockActual" runat="server" Text='<%# Eval("Producto.StockActual") %>'></asp:Label></td>
                <td><asp:Label ID="lblProductoStockMinimo" runat="server" Text='<%# Eval("Producto.StockMinimo") %>'></asp:Label></td>
                <td>
                <asp:TextBox 
                    ID="txtCantidad" 
                    runat="server" 
                    Text='<%# Eval("Cantidad") %>' 
                    oninput="validarCantidad(this)" />
                </td>
                <span id="error-msg" style="color: red;"></span>
                <td><asp:Label ID="lblSubtotal" runat="server" Text='<%# Eval("Subtotal", "{0:C}") %>'></asp:Label></td>
            </tr>
        </ItemTemplate>


        <FooterTemplate>
                </tbody>
            </table>
        </FooterTemplate>
    </asp:Repeater>
        <asp:Button ID="btnActualizar" runat="server" Text="Actualizar cantidades" OnClick="btnActualizar_Click" />
        <asp:Button ID="btnNuevaOC" runat="server" Text="Nueva OC" OnClick="btnNuevaOC_Click" />
        <asp:Button ID="btnConfirmarDescarga" runat="server" Text="Confirmar descarga" OnClick="btnConfirmarDescarga_Click" />
        <asp:Button ID="btnVolver" runat="server" Text="Volver" OnClick="btnVolver_Click"/>


<script>
    function validarCantidad(input) {
        const value = input.value.trim();
        const errorMsg = document.getElementById("error-msg");
        const btnActualizar = document.getElementById("<%= btnActualizar.ClientID %>");

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
            btnActualizar.disabled = true;
        } else {
            errorMsg.textContent = "";
            input.style.borderColor = "";
            btnActualizar.disabled = false;
        }
    }
</script>


</asp:Content>
