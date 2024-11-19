<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Ventas.aspx.cs" Inherits="TPComercio.Ventas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Label Text="Ingrese el documento del cliente" runat="server" />
    <asp:TextBox runat="server" />

    <asp:Button Text="Facturar" runat="server" />

    

</asp:Content>
