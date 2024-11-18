<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Compras.aspx.cs" Inherits="TPComercio.Compras" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

            <asp:DropDownList ID="ddlProveedor" runat="server" CssClass="form-control mb-2" 
                              AutoPostBack="true" OnSelectedIndexChanged="ddlProveedor_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:Label ID="lblMensajeProveedor" runat="server" Text="Label" Visible="False"></asp:Label>
            <br />
            <asp:Repeater ID="rptCompras" runat="server">
                <HeaderTemplate>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Recibo</th>
                                <th>Fecha</th>
                                <th>Total</th>
                                <th>Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>

                <ItemTemplate>
                    <tr>
                        <td><%# Eval("Recibo") %></td>
                        <td><%# Eval("FechaCompra", "{0:dd/MM/yyyy}") %></td>
                        <td><%# Eval("PrecioTotal", "{0:C}") %></td>
                        <td><asp:LinkButton ID="lnkSeleccionar" runat="server" Text="Ver detalle" CommandArgument='<%# Eval("Id") %>' OnCommand="lnkSeleccionar_Command"></asp:LinkButton></td>
                    </tr>
                </ItemTemplate>

                <FooterTemplate>
                        </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <br />
            <asp:Button ID="btnGenerarCompra" runat="server" Text="Generar nueva compra" OnClick="btnGenerarCompra_Click"/>
        
</asp:Content>
