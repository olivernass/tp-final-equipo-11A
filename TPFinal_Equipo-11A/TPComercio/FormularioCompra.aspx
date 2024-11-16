<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="FormularioCompra.aspx.cs" Inherits="TPComercio.FormularioCompra" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="gvProductos" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" SortExpression="Id" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="StockActual" HeaderText="Stock Actual" SortExpression="StockActual" />
                        <asp:BoundField DataField="StockMinimo" HeaderText="Stock Mínimo" SortExpression="StockMinimo" />
                        <asp:BoundField DataField="Precio_Compra" HeaderText="Precio Compra" SortExpression="Precio_Compra" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="Cantidad_Requerida" HeaderText="Cantidad requerida"/>
                        <asp:CheckBoxField DataField="Activo" HeaderText="Activo" SortExpression="Activo" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>
