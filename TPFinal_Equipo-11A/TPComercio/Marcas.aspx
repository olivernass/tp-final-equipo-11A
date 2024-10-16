<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Marcas.aspx.cs" Inherits="TPComercio.Marcas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="containerMarcas">
        <asp:GridView ID="gvMarcas" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table">
            <columns>
                <asp:BoundField DataField="Id" HeaderText="ID" />
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            </columns>
        </asp:GridView>
     </div>
    <div>
        <asp:TextBox ID="txtNombre" runat="server"></asp:TextBox>
        <asp:Button ID="txtAltaMarca" onclick="txtAltaMarca_Click" runat="server" Text="Button" />
    </div>      

</asp:Content>
