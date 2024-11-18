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
                <td><asp:TextBox ID="txtCantidad" runat="server" AutoPostBack="false" Text='<%# Eval("Cantidad") %>' /></td>
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

</asp:Content>
