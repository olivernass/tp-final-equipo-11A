<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Marcas.aspx.cs" Inherits="TPComercio.Marcas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="containerMarcas">
        <asp:GridView ID="gvMarcas" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table">
            <columns>
                <asp:BoundField DataField="Id" HeaderText="ID" />
                <asp:BoundField DataField="NombreMarca" HeaderText="NombreMarca" />
            </columns>
        </asp:GridView>
     </div>    

</asp:Content>
