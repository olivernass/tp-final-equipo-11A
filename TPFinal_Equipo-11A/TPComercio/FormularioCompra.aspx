<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="FormularioCompra.aspx.cs" Inherits="TPComercio.FormularioCompra" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Repeater ID="rptDetalleCompra" runat="server">
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
                <td><%# Eval("Producto.Id") %></td>
                <td><%# Eval("Producto.Nombre") %></td>
                <td><%# Eval("Precio_Compra_Unitario", "{0:C}") %></td>
                <td><%# Eval("Producto.StockActual") %></td>
                <td><%# Eval("Producto.StockMinimo") %></td>
                <td>
                    <asp:TextBox ID="txtCantidad" runat="server" />
                </td>
                <td><%# Eval("Subtotal", "{0:C}") %></td>
            </tr>
        </ItemTemplate>

        <FooterTemplate>
                </tbody>
            </table>
        </FooterTemplate>
    </asp:Repeater>
</asp:Content>
