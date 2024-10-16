<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Categorias.aspx.cs" Inherits="TPComercio.Categorias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="containerCategorias">
    <asp:GridView ID="gvCategorias" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table">
        <columns>
            <asp:BoundField DataField="Id" HeaderText="ID" />
            <asp:BoundField DataField="NombreCategoria" HeaderText="NombreCategoria" />
        </columns>
    </asp:GridView>
 </div>

</asp:Content>
